Received: from eggs.gnu.org ([2001:4830:134:3::10]:38044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgif-0002Dy-A4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgic-0007kv-MB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:33 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgic-0007kp-H2
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:30 -0500
Received: by mail-pf0-x243.google.com with SMTP id 19so12927882pfo.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:41 -0800
Message-Id: <20170209045154.16868-10-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 09/22] target/openrisc: Put SR[OVE] in TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Removes a call at execution time for overflow exceptions.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h              |  4 ++--
 target/openrisc/exception_helper.c |  2 +-
 target/openrisc/translate.c        | 24 +++++++++++++++---------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 06d0e89..ef90e49 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -400,8 +400,8 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
 {
     *pc = env->pc;
     *cs_base = 0;
-    /* D_FLAG -- branch instruction exception */
-    *flags = (env->flags & D_FLAG);
+    /* D_FLAG -- branch instruction exception, OVE overflow trap enable.  */
+    *flags = (env->flags & D_FLAG) | (env->sr & SR_OVE);
 }
 
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 7e54c97..5147da6 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -32,7 +32,7 @@ void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 
 void HELPER(ove)(CPUOpenRISCState *env, target_ulong test)
 {
-    if (unlikely(test) && (env->sr & SR_OVE)) {
+    if (unlikely(test)) {
         OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
         CPUState *cs = CPU(cpu);
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7c6cd1c..b8116ba 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -132,8 +132,8 @@ static inline void wb_SR_F(void)
 static inline void gen_sync_flags(DisasContext *dc)
 {
     /* Sync the tb dependent flag between translate and runtime.  */
-    if (dc->tb_flags != dc->synced_flags) {
-        tcg_gen_movi_tl(env_flags, dc->tb_flags);
+    if ((dc->tb_flags ^ dc->synced_flags) & D_FLAG) {
+        tcg_gen_movi_tl(env_flags, dc->tb_flags & D_FLAG);
         dc->synced_flags = dc->tb_flags;
     }
 }
@@ -249,20 +249,26 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
 
 static void gen_ove_cy(DisasContext *dc, TCGv cy)
 {
-    gen_helper_ove(cpu_env, cy);
+    if (dc->tb_flags & SR_OVE) {
+        gen_helper_ove(cpu_env, cy);
+    }
 }
 
 static void gen_ove_ov(DisasContext *dc, TCGv ov)
 {
-    gen_helper_ove(cpu_env, ov);
+    if (dc->tb_flags & SR_OVE) {
+        gen_helper_ove(cpu_env, ov);
+    }
 }
 
 static void gen_ove_cyov(DisasContext *dc, TCGv cy, TCGv ov)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_or_tl(t0, cy, ov);
-    gen_helper_ove(cpu_env, t0);
-    tcg_temp_free(t0);
+    if (dc->tb_flags & SR_OVE) {
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_or_tl(t0, cy, ov);
+        gen_helper_ove(cpu_env, t0);
+        tcg_temp_free(t0);
+    }
 }
 
 static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
@@ -1606,7 +1612,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     dc->flags = cpu->env.cpucfgr;
     dc->mem_idx = cpu_mmu_index(&cpu->env, false);
     dc->synced_flags = dc->tb_flags = tb->flags;
-    dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
+    dc->delayed_branch = (dc->tb_flags & D_FLAG) != 0;
     dc->singlestep_enabled = cs->singlestep_enabled;
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-- 
2.9.3
