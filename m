Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCk-0000tA-Gy
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCj-0006vu-98
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:13:38 +0100
Message-Id: <1491844419-12485-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 8/9] arm: Implement M profile exception
 return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On M profile, return from exceptions happen when code in Handler mode
executes one of the following function call return instructions:
 * POP or LDM which loads the PC
 * LDR to PC
 * BX register
and the new PC value is 0xFFxxxxxx.

QEMU tries to implement this by not treating the instruction
specially but then catching the attempt to execute from the magic
address value.  This is not ideal, because:
 * there are guest visible differences from the architecturally
   specified behaviour (for instance jumping to 0xFFxxxxxx via a
   different instruction should not cause an exception return but it
   will in the QEMU implementation)
 * we have to account for it in various places (like refusing to take
   an interrupt if the PC is at a magic value, and making sure that
   the MPU doesn't deny execution at the magic value addresses)

Drop these hacks, and instead implement exception return the way the
architecture specifies -- by having the relevant instructions check
for the magic value and raise the 'do an exception return' QEMU
internal exception immediately.

The effect on the generated code is minor:

 bx lr, old code (and new code for Thread mode):
  TCG:
   mov_i32 tmp5,r14
   movi_i32 tmp6,$0xfffffffffffffffe
   and_i32 pc,tmp5,tmp6
   movi_i32 tmp6,$0x1
   and_i32 tmp5,tmp5,tmp6
   st_i32 tmp5,env,$0x218
   exit_tb $0x0
   set_label $L0
   exit_tb $0x7f2aabd61993
  x86_64 generated code:
   0x7f2aabe87019:  mov    %ebx,%ebp
   0x7f2aabe8701b:  and    $0xfffffffffffffffe,%ebp
   0x7f2aabe8701e:  mov    %ebp,0x3c(%r14)
   0x7f2aabe87022:  and    $0x1,%ebx
   0x7f2aabe87025:  mov    %ebx,0x218(%r14)
   0x7f2aabe8702c:  xor    %eax,%eax
   0x7f2aabe8702e:  jmpq   0x7f2aabe7c016

 bx lr, new code when in Handler mode:
  TCG:
   mov_i32 tmp5,r14
   movi_i32 tmp6,$0xfffffffffffffffe
   and_i32 pc,tmp5,tmp6
   movi_i32 tmp6,$0x1
   and_i32 tmp5,tmp5,tmp6
   st_i32 tmp5,env,$0x218
   movi_i32 tmp5,$0xffffffffff000000
   brcond_i32 pc,tmp5,geu,$L1
   exit_tb $0x0
   set_label $L1
   movi_i32 tmp5,$0x8
   call exception_internal,$0x0,$0,env,tmp5
  x86_64 generated code:
   0x7fe8fa1264e3:  mov    %ebp,%ebx
   0x7fe8fa1264e5:  and    $0xfffffffffffffffe,%ebx
   0x7fe8fa1264e8:  mov    %ebx,0x3c(%r14)
   0x7fe8fa1264ec:  and    $0x1,%ebp
   0x7fe8fa1264ef:  mov    %ebp,0x218(%r14)
   0x7fe8fa1264f6:  cmp    $0xff000000,%ebx
   0x7fe8fa1264fc:  jae    0x7fe8fa126509
   0x7fe8fa126502:  xor    %eax,%eax
   0x7fe8fa126504:  jmpq   0x7fe8fa122016
   0x7fe8fa126509:  mov    %r14,%rdi
   0x7fe8fa12650c:  mov    $0x8,%esi
   0x7fe8fa126511:  mov    $0x56095dbeccf5,%r10
   0x7fe8fa12651b:  callq  *%r10

which is a difference of one cmp/branch-not-taken. This will
be lost in the noise of having to exit generated code and
look up the next TB anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h |  4 +++
 target/arm/translate.c | 66 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index f955174..0bbb95a 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -135,6 +135,10 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 #define DISAS_HVC 8
 #define DISAS_SMC 9
 #define DISAS_YIELD 10
+/* M profile branch which might be an exception return (and so needs
+ * custom end-of-TB code)
+ */
+#define DISAS_BX_EXCRET 11
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f980cda..1e8b0a8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -943,6 +943,51 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
     store_cpu_field(var, thumb);
 }
 
+/* Set PC and Thumb state from var. var is marked as dead.
+ * For M-profile CPUs, include logic to detect exception-return
+ * branches and handle them. This is needed for Thumb POP/LDM to PC, LDR to PC,
+ * and BX reg, and no others, and happens only for code in Handler mode.
+ */
+static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
+{
+    /* Generate the same code here as for a simple bx, but flag via
+     * s->is_jmp that we need to do the rest of the work later.
+     */
+    gen_bx(s, var);
+    if (s->handler && arm_dc_feature(s, ARM_FEATURE_M)) {
+        s->is_jmp = DISAS_BX_EXCRET;
+    }
+}
+
+static inline void gen_bx_excret_final_code(DisasContext *s)
+{
+    /* Generate the code to finish possible exception return and end the TB */
+    TCGLabel *excret_label = gen_new_label();
+
+    /* Is the new PC value in the magic range indicating exception return? */
+    tcg_gen_brcondi_i32(TCG_COND_GEU, cpu_R[15], 0xff000000, excret_label);
+    /* No: end the TB as we would for a DISAS_JMP */
+    if (is_singlestepping(s)) {
+        gen_singlestep_exception(s);
+    } else {
+        tcg_gen_exit_tb(0);
+    }
+    gen_set_label(excret_label);
+    /* Yes: this is an exception return.
+     * At this point in runtime env->regs[15] and env->thumb will hold
+     * the exception-return magic number, which do_v7m_exception_exit()
+     * will read. Nothing else will be able to see those values because
+     * the cpu-exec main loop guarantees that we will always go straight
+     * from raising the exception to the exception-handling code.
+     *
+     * gen_ss_advance(s) does nothing on M profile currently but
+     * calling it is conceptually the right thing as we have executed
+     * this instruction (compare SWI, HVC, SMC handling).
+     */
+    gen_ss_advance(s);
+    gen_exception_internal(EXCP_EXCEPTION_EXIT);
+}
+
 /* Variant of store_reg which uses branch&exchange logic when storing
    to r15 in ARM architecture v7 and above. The source must be a temporary
    and will be marked as dead. */
@@ -962,7 +1007,7 @@ static inline void store_reg_bx(DisasContext *s, int reg, TCGv_i32 var)
 static inline void store_reg_from_load(DisasContext *s, int reg, TCGv_i32 var)
 {
     if (reg == 15 && ENABLE_ARCH_5) {
-        gen_bx(s, var);
+        gen_bx_excret(s, var);
     } else {
         store_reg(s, reg, var);
     }
@@ -9881,7 +9926,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
                         if (i == 15) {
-                            gen_bx(s, tmp);
+                            gen_bx_excret(s, tmp);
                         } else if (i == rn) {
                             loaded_var = tmp;
                             loaded_base = 1;
@@ -10913,7 +10958,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                 goto illegal_op;
             }
             if (rs == 15) {
-                gen_bx(s, tmp);
+                gen_bx_excret(s, tmp);
             } else {
                 store_reg(s, rs, tmp);
             }
@@ -11103,9 +11148,11 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
                     tmp2 = tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp2, val);
                     store_reg(s, 14, tmp2);
+                    gen_bx(s, tmp);
+                } else {
+                    /* Only BX works as exception-return, not BLX */
+                    gen_bx_excret(s, tmp);
                 }
-                /* already thumb, no need to check */
-                gen_bx(s, tmp);
                 break;
             }
             break;
@@ -12000,7 +12047,14 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (unlikely(is_singlestepping(dc))) {
+    if (dc->is_jmp == DISAS_BX_EXCRET) {
+        /* Exception return branches need some special case code at the
+         * end of the TB, which is complex enough that it has to
+         * handle the single-step vs not and the condition-failed
+         * insn codepath itself.
+         */
+        gen_bx_excret_final_code(dc);
+    } else if (unlikely(is_singlestepping(dc))) {
         /* Unconditional and "condition passed" instruction codepath. */
         switch (dc->is_jmp) {
         case DISAS_SWI:
-- 
2.7.4
