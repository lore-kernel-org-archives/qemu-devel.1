Received: from eggs.gnu.org ([2001:4830:134:3::10]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNop-0003uW-9M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoo-0007YF-4s
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:31 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:53199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNon-0007XT-Vd
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:30 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:10 +0100
Message-ID: <1500604635-15027-10-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 09/14] target/mips: Abstract mmu_idx from hflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/cpu.h       | 8 +++++++-
 target/mips/op_helper.c | 4 ++--
 target/mips/translate.c | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 2b699a0..3cf1676 100644
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
index 3b560d9..da1817e 100644
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
index 9787919..4fb8217 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20157,7 +20157,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #ifdef CONFIG_USER_ONLY
         ctx.mem_idx = MIPS_HFLAG_UM;
 #else
-        ctx.mem_idx = ctx.hflags & MIPS_HFLAG_KSU;
+        ctx.mem_idx = hflags_mmu_index(ctx.hflags);
 #endif
     ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
                                  MO_UNALN : MO_ALIGN;
-- 
2.7.4
