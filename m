Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbV-0003kH-BR
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbU-0003H7-DY
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:13 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbU-0003Gx-4o
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:12 -0400
Received: by mail-pf0-x243.google.com with SMTP id c24so13735174pfe.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:19 -1000
Message-Id: <20170715094243.28371-11-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 10/34] target/i386: [tcg] Port to
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002122448.22386.16854673576827449259.stgit@frigg.lan>
[rth: Adjust for max_insns interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7825593..651abca 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8376,20 +8376,13 @@ void tcg_x86_init(void)
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
@@ -8400,11 +8393,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -8422,7 +8413,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->code64 = (flags >> HF_CS64_SHIFT) & 1;
 #endif
     dc->flags = flags;
-    dc->jmp_opt = !(dc->tf || cs->singlestep_enabled ||
+    dc->jmp_opt = !(dc->tf || dc->base.singlestep_enabled ||
                     (flags & HF_INHIBIT_IRQ_MASK));
     /* Do not optimize repz jumps at all in icount mode, because
        rep movsS instructions are execured with different paths
@@ -8434,7 +8425,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=0 when icount is enabled.
      */
-    dc->repz_opt = !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt = !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOUNT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
@@ -8454,9 +8445,24 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -8464,7 +8470,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    max_insns = i386_tr_init_disas_context(&dc->base, cs, max_insns);
 
+    num_insns = 0;
     gen_tb_start(tb);
     for(;;) {
         tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
@@ -8497,7 +8505,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
            the flag and abort the translation to give the irqs a
            change to be happen */
         if (dc->tf || dc->base.singlestep_enabled ||
-            (flags & HF_INHIBIT_IRQ_MASK)) {
+            (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
-- 
2.9.4
