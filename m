Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0003vs-7j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7O-0005J6-3v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:48 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:10184)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7N-0005Iw-Tf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:46 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:54 +0100
Message-ID: <8d26921c05e90550a284f32ffa41d3134bf8a214.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 9/14] target/mips: Abstract mmu_idx from hflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

The MIPS mmu_idx is sometimes calculated from hflags without an env
pointer available as cpu_mmu_index() requires.

Create a common hflags_mmu_index() for the purpose of this calculation
which can operate on any hflags, not just with an env pointer, and
update cpu_mmu_index() itself and gen_intermediate_code() to use it.

Also update debug_post_eret() and helper_mtc0_status() to log the MMU
mode with the status change (SM, UM, or nothing for kernel mode) based
on cpu_mmu_index() rather than directly testing hflags.

This will also allow the logic to be more easily updated when a new MMU
mode is added.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Also convert reference to hflags & MIPS_HFLAG_KSU in op_helper.c to
  cpu_mmu_index (Yongbok).
---
 target/mips/cpu.h       | 8 +++++++-
 target/mips/op_helper.c | 4 ++--
 target/mips/translate.c | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 2b699a0e2456..3cf167611599 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -699,9 +699,15 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 #define MMU_MODE1_SUFFIX _super
 #define MMU_MODE2_SUFFIX _user
 #define MMU_USER_IDX 2
+
+static inline int hflags_mmu_index(uint32_t hflags)
+{
+    return hflags & MIPS_HFLAG_KSU;
+}
+
 static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
 {
-    return env->hflags & MIPS_HFLAG_KSU;
+    return hflags_mmu_index(env->hflags);
 }
 
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index ba8b159d3bac..94172bcfe32a 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1450,7 +1450,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
                 old, old & env->CP0_Cause & CP0Ca_IP_mask,
                 val, val & env->CP0_Cause & CP0Ca_IP_mask,
                 env->CP0_Cause);
-        switch (env->hflags & MIPS_HFLAG_KSU) {
+        switch (cpu_mmu_index(env, false)) {
         case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
@@ -2244,7 +2244,7 @@ static void debug_post_eret(CPUMIPSState *env)
             qemu_log(" ErrorEPC " TARGET_FMT_lx, env->CP0_ErrorEPC);
         if (env->hflags & MIPS_HFLAG_DM)
             qemu_log(" DEPC " TARGET_FMT_lx, env->CP0_DEPC);
-        switch (env->hflags & MIPS_HFLAG_KSU) {
+        switch (cpu_mmu_index(env, false)) {
         case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9b6963b4e64c..ac9023443112 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20148,7 +20148,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
 #ifdef CONFIG_USER_ONLY
         ctx.mem_idx = MIPS_HFLAG_UM;
 #else
-        ctx.mem_idx = ctx.hflags & MIPS_HFLAG_KSU;
+        ctx.mem_idx = hflags_mmu_index(ctx.hflags);
 #endif
     ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
                                  MO_UNALN : MO_ALIGN;
-- 
git-series 0.8.10
