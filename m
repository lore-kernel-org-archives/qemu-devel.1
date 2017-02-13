Received: from eggs.gnu.org ([2001:4830:134:3::10]:45189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8S-0004df-G0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8P-0001Hk-Ve
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:12 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8P-0001HW-Pu
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:09 -0500
Received: by mail-qt0-x242.google.com with SMTP id h53so15005449qth.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:09 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:18 +1100
Message-Id: <20170213212536.31871-7-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/24] target/openrisc: Implement lwa, swa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.c              |  1 +
 target/openrisc/cpu.h              |  3 ++
 target/openrisc/interrupt.c        |  1 +
 target/openrisc/interrupt_helper.c |  1 +
 target/openrisc/machine.c          | 24 ++++++++++------
 target/openrisc/mmu.c              |  1 +
 target/openrisc/translate.c        | 58 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 422139d..7fd2b9a 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -48,6 +48,7 @@ static void openrisc_cpu_reset(CPUState *s)
 
     cpu->env.pc = 0x100;
     cpu->env.sr = SR_FO | SR_SM;
+    cpu->env.lock_addr = -1;
     s->exception_index = -1;
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 231c163..06d0e89 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -296,6 +296,9 @@ typedef struct CPUOpenRISCState {
     uint32_t fpcsr;           /* Float register */
     float_status fp_status;
 
+    target_ulong lock_addr;
+    target_ulong lock_value;
+
     uint32_t flags;           /* cpu_flags, we only use it for exception
                                  in solt so far.  */
     uint32_t btaken;          /* the SR_F bit */
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index a243eb2..a981638 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -62,6 +62,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->sr &= ~SR_TEE;
     env->tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
     env->tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
+    env->lock_addr = -1;
 
     if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
         env->pc = (cs->exception_index << 8);
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index 0ed5146..a6d4df3 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -34,6 +34,7 @@ void HELPER(rfe)(CPUOpenRISCState *env)
     cpu->env.pc = cpu->env.epcr;
     cpu->env.npc = cpu->env.epcr;
     cpu->env.sr = cpu->env.esr;
+    cpu->env.lock_addr = -1;
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->env.sr & SR_DME) {
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 17b0c77..d0b47ef 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,18 +26,26 @@
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(gpr, CPUOpenRISCState, 32),
+        VMSTATE_UINTTL_ARRAY(gpr, CPUOpenRISCState, 32),
+        VMSTATE_UINTTL(pc, CPUOpenRISCState),
+        VMSTATE_UINTTL(npc, CPUOpenRISCState),
+        VMSTATE_UINTTL(ppc, CPUOpenRISCState),
+        VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
+        VMSTATE_UINTTL(lock_addr, CPUOpenRISCState),
+        VMSTATE_UINTTL(lock_value, CPUOpenRISCState),
+        VMSTATE_UINTTL(epcr, CPUOpenRISCState),
+        VMSTATE_UINTTL(eear, CPUOpenRISCState),
         VMSTATE_UINT32(sr, CPUOpenRISCState),
-        VMSTATE_UINT32(epcr, CPUOpenRISCState),
-        VMSTATE_UINT32(eear, CPUOpenRISCState),
+        VMSTATE_UINT32(vr, CPUOpenRISCState),
+        VMSTATE_UINT32(upr, CPUOpenRISCState),
+        VMSTATE_UINT32(cpucfgr, CPUOpenRISCState),
+        VMSTATE_UINT32(dmmucfgr, CPUOpenRISCState),
+        VMSTATE_UINT32(immucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(esr, CPUOpenRISCState),
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
-        VMSTATE_UINT32(pc, CPUOpenRISCState),
-        VMSTATE_UINT32(npc, CPUOpenRISCState),
-        VMSTATE_UINT32(ppc, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 505dcdc..56b11d3 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -174,6 +174,7 @@ static void cpu_openrisc_raise_mmu_exception(OpenRISCCPU *cpu,
 
     cs->exception_index = exception;
     cpu->env.eear = address;
+    cpu->env.lock_addr = -1;
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 03fa7db..c207875 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -61,6 +61,8 @@ static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_npc;
 static TCGv cpu_ppc;
 static TCGv_i32 env_btaken;    /* bf/bnf , F flag taken */
+static TCGv cpu_lock_addr;
+static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv machi, maclo;
 static TCGv fpmaddhi, fpmaddlo;
@@ -95,6 +97,12 @@ void openrisc_translate_init(void)
     env_btaken = tcg_global_mem_new_i32(cpu_env,
                                         offsetof(CPUOpenRISCState, btaken),
                                         "btaken");
+    cpu_lock_addr = tcg_global_mem_new(cpu_env,
+                                       offsetof(CPUOpenRISCState, lock_addr),
+                                       "lock_addr");
+    cpu_lock_value = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUOpenRISCState, lock_value),
+                                        "lock_value");
     fpcsr = tcg_global_mem_new_i32(cpu_env,
                                    offsetof(CPUOpenRISCState, fpcsr),
                                    "fpcsr");
@@ -265,6 +273,46 @@ static void gen_jump(DisasContext *dc, uint32_t imm, uint32_t reg, uint32_t op0)
 }
 
 
+static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
+{
+    TCGv ea = tcg_temp_new();
+
+    tcg_gen_addi_tl(ea, ra, ofs);
+    tcg_gen_qemu_ld_tl(rd, ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_mov_tl(cpu_lock_addr, ea);
+    tcg_gen_mov_tl(cpu_lock_value, rd);
+    tcg_temp_free(ea);
+}
+
+static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
+{
+    TCGv ea, val;
+    TCGLabel *lab_fail, *lab_done;
+
+    ea = tcg_temp_new();
+    tcg_gen_addi_tl(ea, ra, ofs);
+
+    lab_fail = gen_new_label();
+    lab_done = gen_new_label();
+    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
+    tcg_temp_free(ea);
+
+    val = tcg_temp_new();
+    tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
+                              rb, dc->mem_idx, MO_TEUL);
+    tcg_gen_setcond_tl(TCG_COND_EQ, env_btaken, val, cpu_lock_value);
+    tcg_temp_free(val);
+
+    tcg_gen_br(lab_done);
+
+    gen_set_label(lab_fail);
+    tcg_gen_movi_tl(env_btaken, 0);
+
+    gen_set_label(lab_done);
+    tcg_gen_movi_tl(cpu_lock_addr, -1);
+    wb_SR_F();
+}
+
 static void dec_calc(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0, op1, op2;
@@ -819,6 +867,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         }
         break;
 
+    case 0x1b: /* l.lwa */
+        LOG_DIS("l.lwa r%d, r%d, %d\n", rd, ra, I16);
+        gen_lwa(dc, cpu_R[rd], cpu_R[ra], I16);
+        break;
+
     case 0x1c:    /* l.cust1 */
         LOG_DIS("l.cust1\n");
         break;
@@ -1029,6 +1082,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         }
         break;
 
+    case 0x33: /* l.swa */
+        LOG_DIS("l.swa %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        gen_swa(dc, cpu_R[rb], cpu_R[ra], sign_extend(tmp, 16));
+        break;
+
 /* not used yet, open it when we need or64.  */
 /*#ifdef TARGET_OPENRISC64
     case 0x34:     l.sd
-- 
2.9.3
