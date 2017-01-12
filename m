Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYl-0007hj-Ep
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYk-0006ha-It
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:15 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYk-0006hR-EK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:14 -0500
Received: by mail-qt0-x242.google.com with SMTP id a29so841119qtb.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:14 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:38 -0800
Message-Id: <20170112025606.27332-3-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 02/30] target-sparc: store cpu super- and
 hypervisor flags in TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <f03daff3e16d6ab6a9a0610f1006de7b506a5f58.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h       | 17 +++++++++++++++++
 target/sparc/translate.c | 24 +++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index e0b2806..68e39bc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -667,6 +667,11 @@ static inline int cpu_supervisor_mode(CPUSPARCState *env1)
 {
     return env1->pstate & PS_PRIV;
 }
+#else
+static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+{
+    return env1->psrs;
+}
 #endif
 
 static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
@@ -733,6 +738,8 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_MMU_MASK     7
 #define TB_FLAG_FPU_ENABLED  (1 << 4)
 #define TB_FLAG_AM_ENABLED   (1 << 5)
+#define TB_FLAG_SUPER        (1 << 6)
+#define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, target_ulong *pc,
@@ -742,7 +749,17 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = env->npc;
     flags = cpu_mmu_index(env, false);
+#ifndef CONFIG_USER_ONLY
+    if (cpu_supervisor_mode(env)) {
+        flags |= TB_FLAG_SUPER;
+    }
+#endif
 #ifdef TARGET_SPARC64
+#ifndef CONFIG_USER_ONLY
+    if (cpu_hypervisor_mode(env)) {
+        flags |= TB_FLAG_HYPER;
+    }
+#endif
     if (env->pstate & PS_AM) {
         flags |= TB_FLAG_AM_ENABLED;
     }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2205f89..0b0cde1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,9 +72,16 @@ typedef struct DisasContext {
     target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
     int is_br;
     int mem_idx;
-    int fpu_enabled;
-    int address_mask_32bit;
-    int singlestep;
+    bool fpu_enabled;
+    bool address_mask_32bit;
+    bool singlestep;
+#ifndef CONFIG_USER_ONLY
+    bool supervisor;
+#ifdef TARGET_SPARC64
+    bool hypervisor;
+#endif
+#endif
+
     uint32_t cc_op;  /* current CC operation */
     struct TranslationBlock *tb;
     sparc_def_t *def;
@@ -283,10 +290,11 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 #define hypervisor(dc) 0
 #endif
 #else
-#define supervisor(dc) (dc->mem_idx >= MMU_KERNEL_IDX)
 #ifdef TARGET_SPARC64
-#define hypervisor(dc) (dc->mem_idx == MMU_HYPV_IDX)
+#define hypervisor(dc) (dc->hypervisor)
+#define supervisor(dc) (dc->supervisor | dc->hypervisor)
 #else
+#define supervisor(dc) (dc->supervisor)
 #endif
 #endif
 
@@ -5710,9 +5718,15 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
     dc->fpu_enabled = tb_fpu_enabled(tb->flags);
     dc->address_mask_32bit = tb_am_enabled(tb->flags);
     dc->singlestep = (cs->singlestep_enabled || singlestep);
+#ifndef CONFIG_USER_ONLY
+    dc->supervisor = (tb->flags & TB_FLAG_SUPER) != 0;
+#endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
     dc->asi = (tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
+#ifndef CONFIG_USER_ONLY
+    dc->hypervisor = (tb->flags & TB_FLAG_HYPER) != 0;
+#endif
 #endif
 
     num_insns = 0;
-- 
2.9.3
