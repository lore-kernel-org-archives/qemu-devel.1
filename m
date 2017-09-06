Received: from eggs.gnu.org ([2001:4830:134:3::10]:41658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqX-0008SC-7u
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqQ-0001p8-WD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:33 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:33605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqQ-0001oG-NQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:26 -0400
Received: by mail-pg0-x231.google.com with SMTP id t3so16078080pgt.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:48 -0700
Message-Id: <20170906160612.22769-9-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] target/i386: [tcg] Port to
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002122448.22386.16854673576827449259.stgit@frigg.lan>
[rth: Adjust for max_insns interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3a3d91c4d7..4281e9bc56 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8377,20 +8377,13 @@ void tcg_x86_init(void)
     }
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
+                                      int max_insns)
 {
-    CPUX86State *env = cs->env_ptr;
-    DisasContext dc1, *dc = &dc1;
-    uint32_t flags;
-    target_ulong cs_base;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    dc->base.pc_first = tb->pc;
-    cs_base = tb->cs_base;
-    flags = tb->flags;
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUX86State *env = cpu->env_ptr;
+    uint32_t flags = dc->base.tb->flags;
+    target_ulong cs_base = dc->base.tb->cs_base;
 
     dc->pe = (flags >> HF_PE_SHIFT) & 1;
     dc->code32 = (flags >> HF_CS32_SHIFT) & 1;
@@ -8401,11 +8394,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->cpl = (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl = (flags >> IOPL_SHIFT) & 3;
     dc->tf = (flags >> TF_SHIFT) & 1;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_dirty = false;
     dc->cs_base = cs_base;
-    dc->base.tb = tb;
     dc->popl_esp_hack = 0;
     /* select memory access functions */
     dc->mem_index = 0;
@@ -8423,7 +8414,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->code64 = (flags >> HF_CS64_SHIFT) & 1;
 #endif
     dc->flags = flags;
-    dc->jmp_opt = !(dc->tf || cs->singlestep_enabled ||
+    dc->jmp_opt = !(dc->tf || dc->base.singlestep_enabled ||
                     (flags & HF_INHIBIT_IRQ_MASK));
     /* Do not optimize repz jumps at all in icount mode, because
        rep movsS instructions are execured with different paths
@@ -8435,7 +8426,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=0 when icount is enabled.
      */
-    dc->repz_opt = !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt = !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOUNT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
@@ -8455,9 +8446,24 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_ptr1 = tcg_temp_new_ptr();
     cpu_cc_srcT = tcg_temp_local_new();
 
+    return max_insns;
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    CPUX86State *env = cs->env_ptr;
+    DisasContext dc1, *dc = &dc1;
+    int num_insns;
+    int max_insns;
+
+    /* generate intermediate code */
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    dc->base.tb = tb;
     dc->base.is_jmp = DISAS_NEXT;
+    dc->base.pc_first = tb->pc;
     dc->base.pc_next = dc->base.pc_first;
-    num_insns = 0;
+
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -8465,7 +8471,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    max_insns = i386_tr_init_disas_context(&dc->base, cs, max_insns);
 
+    num_insns = 0;
     gen_tb_start(tb);
     for(;;) {
         tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
@@ -8498,7 +8506,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
            the flag and abort the translation to give the irqs a
            change to be happen */
         if (dc->tf || dc->base.singlestep_enabled ||
-            (flags & HF_INHIBIT_IRQ_MASK)) {
+            (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
-- 
2.13.5
