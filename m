Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7S-0003xy-HJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7O-0005JZ-Re
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:50 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:48521)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7O-0005JC-IV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:46 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:55 +0100
Message-ID: <34b839029829b3b63887a8a3a5937f475ba1d7aa.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/14] target/mips: Add an MMU mode for ERL
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

The segmentation control feature allows a legacy memory segment to
become unmapped uncached at error level (according to CP0_Status.ERL),
and in fact the user segment is already treated in this way by QEMU.

Add a new MMU mode for this state so that QEMU's mappings don't persist
between ERL=0 and ERL=1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Add ERL case to log output where cpu_mmu_index() is now used in
  op_helper.c
---
 target/mips/cpu.h       | 17 +++++++++++++----
 target/mips/op_helper.c |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3cf167611599..c24b1f64c685 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -134,7 +134,7 @@ struct CPUMIPSFPUContext {
 #define FP_UNIMPLEMENTED  32
 };
 
-#define NB_MMU_MODES 3
+#define NB_MMU_MODES 4
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
 typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
@@ -551,7 +551,7 @@ struct CPUMIPSState {
 #define EXCP_INST_NOTAVAIL 0x2 /* No valid instruction word for BadInstr */
     uint32_t hflags;    /* CPU State */
     /* TMASK defines different execution modes */
-#define MIPS_HFLAG_TMASK  0xF5807FF
+#define MIPS_HFLAG_TMASK  0x1F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
     /* The KSU flags must be the lowest bits in hflags. The flag order
        must be the same as defined for CP0 Status. This allows to use
@@ -601,6 +601,7 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_FRE   0x2000000 /* FRE enabled */
 #define MIPS_HFLAG_ELPA  0x4000000
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
+#define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
@@ -698,11 +699,16 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 #define MMU_MODE0_SUFFIX _kernel
 #define MMU_MODE1_SUFFIX _super
 #define MMU_MODE2_SUFFIX _user
+#define MMU_MODE3_SUFFIX _error
 #define MMU_USER_IDX 2
 
 static inline int hflags_mmu_index(uint32_t hflags)
 {
-    return hflags & MIPS_HFLAG_KSU;
+    if (hflags & MIPS_HFLAG_ERL) {
+        return 3; /* ERL */
+    } else {
+        return hflags & MIPS_HFLAG_KSU;
+    }
 }
 
 static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
@@ -971,7 +977,10 @@ static inline void compute_hflags(CPUMIPSState *env)
                      MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
                      MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
                      MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
-                     MIPS_HFLAG_ELPA);
+                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
+    if (env->CP0_Status & (1 << CP0St_ERL)) {
+        env->hflags |= MIPS_HFLAG_ERL;
+    }
     if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
         !(env->CP0_Status & (1 << CP0St_ERL)) &&
         !(env->hflags & MIPS_HFLAG_DM)) {
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 94172bcfe32a..e3531b6e84b0 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -67,6 +67,7 @@ static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
     case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
     default:                                                            \
     case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);     \
+    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);    \
     }                                                                   \
 }
 #endif
@@ -94,6 +95,7 @@ static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
     case 1: cpu_##insn##_super_ra(env, addr, val, retaddr); break;      \
     default:                                                            \
     case 2: cpu_##insn##_user_ra(env, addr, val, retaddr); break;       \
+    case 3: cpu_##insn##_error_ra(env, addr, val, retaddr); break;      \
     }                                                                   \
 }
 #endif
@@ -1451,6 +1453,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
                 val, val & env->CP0_Cause & CP0Ca_IP_mask,
                 env->CP0_Cause);
         switch (cpu_mmu_index(env, false)) {
+        case 3: qemu_log(", ERL\n"); break;
         case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
@@ -2245,6 +2248,7 @@ static void debug_post_eret(CPUMIPSState *env)
         if (env->hflags & MIPS_HFLAG_DM)
             qemu_log(" DEPC " TARGET_FMT_lx, env->CP0_DEPC);
         switch (cpu_mmu_index(env, false)) {
+        case 3: qemu_log(", ERL\n"); break;
         case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
         case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
         case MIPS_HFLAG_KM: qemu_log("\n"); break;
-- 
git-series 0.8.10
