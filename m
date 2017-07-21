Received: from eggs.gnu.org ([2001:4830:134:3::10]:40035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNom-0003tJ-HQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNol-0007VU-81
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:28 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:53143)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNok-0007V9-Vq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:27 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:05 +0100
Message-ID: <1500604635-15027-5-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 04/14] target/mips: Add CP0_Ebase.WG (write
 gate) support
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

Add support for the CP0_EBase.WG bit, which allows upper bits to be
written (bits 31:30 on MIPS32, or bits 63:30 on MIPS64), along with the
CP0_Config5.CV bit to control whether the exception vector for Cache
Error exceptions is forced into KSeg1.

This is necessary on MIPS32 to support Segmentation Control and Enhanced
Virtual Addressing (EVA) extensions (where KSeg1 addresses may not
represent an unmapped uncached segment).

It is also useful on MIPS64 to allow the exception base to reside in
XKPhys, and possibly out of range of KSEG0 and KSEG1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
[yongbok.kim@imgtec.com:
  minor changes]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/cpu.h            |  5 ++++-
 target/mips/helper.c         | 14 ++++++++------
 target/mips/machine.c        |  6 +++---
 target/mips/op_helper.c      | 12 ++++++++++--
 target/mips/translate.c      |  8 +++++---
 target/mips/translate_init.c |  1 +
 6 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 4a4747a..2b699a0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -399,7 +399,9 @@ struct CPUMIPSState {
 #define CP0Ca_EC    2
     target_ulong CP0_EPC;
     int32_t CP0_PRid;
-    int32_t CP0_EBase;
+    target_ulong CP0_EBase;
+    target_ulong CP0_EBaseWG_rw_bitmask;
+#define CP0EBase_WG 11
     target_ulong CP0_CMGCRBase;
     int32_t CP0_Config0;
 #define CP0C0_M    31
@@ -447,6 +449,7 @@ struct CPUMIPSState {
 #define CP0C3_MSAP  28
 #define CP0C3_BP 27
 #define CP0C3_BI 26
+#define CP0C3_SC 25
 #define CP0C3_IPLW 21
 #define CP0C3_MMAR 18
 #define CP0C3_MCU  17
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 11d6a86..5b765cd 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -831,11 +831,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         goto set_EPC;
     case EXCP_CACHE:
         cause = 30;
-        if (env->CP0_Status & (1 << CP0St_BEV)) {
-            offset = 0x100;
-        } else {
-            offset = 0x20000100;
-        }
+        offset = 0x100;
  set_EPC:
         if (!(env->CP0_Status & (1 << CP0St_EXL))) {
             env->CP0_EPC = exception_resume_pc(env);
@@ -861,9 +857,15 @@ void mips_cpu_do_interrupt(CPUState *cs)
         env->hflags &= ~MIPS_HFLAG_BMASK;
         if (env->CP0_Status & (1 << CP0St_BEV)) {
             env->active_tc.PC = env->exception_base + 0x200;
+        } else if (cause == 30 && !(env->CP0_Config3 & (1 << CP0C3_SC) &&
+                                    env->CP0_Config5 & (1 << CP0C5_CV))) {
+            /* Force KSeg1 for cache errors */
+            env->active_tc.PC = (int32_t)KSEG1_BASE |
+                                (env->CP0_EBase & 0x1FFFF000);
         } else {
-            env->active_tc.PC = (int32_t)(env->CP0_EBase & ~0x3ff);
+            env->active_tc.PC = env->CP0_EBase & ~0xfff;
         }
+
         env->active_tc.PC += offset;
         set_hflags_for_handler(env);
         env->CP0_Cause = (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) | (cause << CP0Ca_EC);
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 38c8fe9..91e31a7 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -211,8 +211,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 8,
-    .minimum_version_id = 8,
+    .version_id = 9,
+    .minimum_version_id = 9,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -272,7 +272,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_INT32(env.CP0_Cause, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_EPC, MIPSCPU),
         VMSTATE_INT32(env.CP0_PRid, MIPSCPU),
-        VMSTATE_INT32(env.CP0_EBase, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_EBase, MIPSCPU),
         VMSTATE_INT32(env.CP0_Config0, MIPSCPU),
         VMSTATE_INT32(env.CP0_Config1, MIPSCPU),
         VMSTATE_INT32(env.CP0_Config2, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 091afd5..3b560d9 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1515,14 +1515,22 @@ target_ulong helper_mftc0_ebase(CPUMIPSState *env)
 
 void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
 {
-    env->CP0_EBase = (env->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x3FFFF000);
+    target_ulong mask = 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
+    if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
+        mask |= ~0x3FFFFFFF;
+    }
+    env->CP0_EBase = (env->CP0_EBase & ~mask) | (arg1 & mask);
 }
 
 void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
-    other->CP0_EBase = (other->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x3FFFF000);
+    target_ulong mask = 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
+    if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
+        mask |= ~0x3FFFFFFF;
+    }
+    other->CP0_EBase = (other->CP0_EBase & ~mask) | (arg1 & mask);
 }
 
 target_ulong helper_mftc0_configx(CPUMIPSState *env, target_ulong idx)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index db6e5b5..76dcc5e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5332,7 +5332,8 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_EBase));
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
+            tcg_gen_ext32s_tl(arg, arg);
             rn = "EBase";
             break;
         case 3:
@@ -6643,7 +6644,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_EBase));
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
             rn = "EBase";
             break;
         case 3:
@@ -20301,6 +20302,7 @@ void cpu_state_reset(CPUMIPSState *env)
     env->CP0_SRSConf4 = env->cpu_model->CP0_SRSConf4;
     env->CP0_PageGrain_rw_bitmask = env->cpu_model->CP0_PageGrain_rw_bitmask;
     env->CP0_PageGrain = env->cpu_model->CP0_PageGrain;
+    env->CP0_EBaseWG_rw_bitmask = env->cpu_model->CP0_EBaseWG_rw_bitmask;
     env->active_fpu.fcr0 = env->cpu_model->CP1_fcr0;
     env->active_fpu.fcr31_rw_bitmask = env->cpu_model->CP1_fcr31_rw_bitmask;
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
@@ -20351,7 +20353,7 @@ void cpu_state_reset(CPUMIPSState *env)
     if (kvm_enabled()) {
         env->CP0_EBase |= 0x40000000;
     } else {
-        env->CP0_EBase |= 0x80000000;
+        env->CP0_EBase |= (int32_t)0x80000000;
     }
     if (env->CP0_Config3 & (1 << CP0C3_CMGCR)) {
         env->CP0_CMGCRBase = 0x1fbf8000 >> 4;
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 6ae23e4..8f8196e 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -101,6 +101,7 @@ struct mips_def_t {
     int32_t CP0_SRSConf4;
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
+    target_ulong CP0_EBaseWG_rw_bitmask;
     int insn_flags;
     enum mips_mmu_types mmu_type;
 };
-- 
2.7.4
