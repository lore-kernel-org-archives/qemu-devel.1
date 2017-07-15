Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbn-0003yt-SZ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbm-0003Od-Ga
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:31 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbm-0003O7-A5
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:30 -0400
Received: by mail-pf0-x244.google.com with SMTP id z6so13727100pfk.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:28 -1000
Message-Id: <20170715094243.28371-20-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 19/34] target/arm: [tcg,
 a64] Port to init_disas_context
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
Message-Id: <150002340430.22386.10889954302345646107.stgit@frigg.lan>
[rth: Adjust for max_insns interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 57dbf8c..e9bea91 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11190,21 +11190,12 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     free_tmp_a64(s);
 }
 
-void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
-                               TranslationBlock *tb)
+static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
+                                         CPUState *cpu, int max_insns)
 {
-    CPUARMState *env = cs->env_ptr;
-    ARMCPU *cpu = arm_env_get_cpu(env);
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong next_page_start;
-    int max_insns;
-
-    dc->base.tb = tb;
-    dc->base.pc_first = dc->base.tb->pc;
-    dc->base.pc_next = dc->base.pc_first;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.num_insns = 0;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    CPUARMState *env = cpu->env_ptr;
+    ARMCPU *arm_cpu = arm_env_get_cpu(env);
 
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
@@ -11230,7 +11221,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
     dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
     dc->vec_len = 0;
     dc->vec_stride = 0;
-    dc->cp_regs = cpu->cp_regs;
+    dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
 
     /* Single step state. The code-generation logic here is:
@@ -11255,6 +11246,24 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
 
     init_tmp_a64_array(dc);
 
+    return max_insns;
+}
+
+void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
+                               TranslationBlock *tb)
+{
+    CPUARMState *env = cs->env_ptr;
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    target_ulong next_page_start;
+    int max_insns;
+
+    dc->base.tb = tb;
+    dc->base.pc_first = dc->base.tb->pc;
+    dc->base.pc_next = dc->base.pc_first;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.num_insns = 0;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+
     next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     max_insns = dc->base.tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -11263,6 +11272,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    max_insns = aarch64_tr_init_disas_context(&dc->base, cs, max_insns);
 
     gen_tb_start(tb);
 
-- 
2.9.4
