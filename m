Received: from eggs.gnu.org ([2001:4830:134:3::10]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7T-0003zF-R0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0005KO-GB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:51 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:18675)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0005Jw-1Z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:48 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:56 +0100
Message-ID: <b551b2d487039c2e1165e9c732a9fa36bf6497f0.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 11/14] target/mips: Add segmentation control
 registers
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

The optional segmentation control registers CP0_SegCtl0, CP0_SegCtl1 &
CP0_SegCtl2 control the behaviour and required privilege of the legacy
virtual memory segments.

Add them to the CP0 interface so they can be read and written when
CP0_Config3.SC=1, and initialise them to describe the standard legacy
layout so they can be used in future patches regardless of whether they
are exposed to the guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Use ld_tl and ext32s_tl rather than ld32s_tl to avoid big endian host,
  MIPS64 target issues (Yongbok).
- Add missing break in DMFC0 CP0_SegCtl2 case.
---
 target/mips/cpu.h       | 30 ++++++++++++++-
 target/mips/helper.h    |  3 +-
 target/mips/machine.c   |  7 ++-
 target/mips/op_helper.c | 24 +++++++++++-
 target/mips/translate.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c24b1f64c685..74f6a5b09806 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -306,6 +306,36 @@ struct CPUMIPSState {
 #define CP0PG_XIE 30
 #define CP0PG_ELPA 29
 #define CP0PG_IEC 27
+    target_ulong CP0_SegCtl0;
+    target_ulong CP0_SegCtl1;
+    target_ulong CP0_SegCtl2;
+#define CP0SC_PA        9
+#define CP0SC_PA_MASK   (0x7FULL << CP0SC_PA)
+#define CP0SC_PA_1GMASK (0x7EULL << CP0SC_PA)
+#define CP0SC_AM        4
+#define CP0SC_AM_MASK   (0x7ULL << CP0SC_AM)
+#define CP0SC_AM_UK     0ULL
+#define CP0SC_AM_MK     1ULL
+#define CP0SC_AM_MSK    2ULL
+#define CP0SC_AM_MUSK   3ULL
+#define CP0SC_AM_MUSUK  4ULL
+#define CP0SC_AM_USK    5ULL
+#define CP0SC_AM_UUSK   7ULL
+#define CP0SC_EU        3
+#define CP0SC_EU_MASK   (1ULL << CP0SC_EU)
+#define CP0SC_C         0
+#define CP0SC_C_MASK    (0x7ULL << CP0SC_C)
+#define CP0SC_MASK      (CP0SC_C_MASK | CP0SC_EU_MASK | CP0SC_AM_MASK | \
+                         CP0SC_PA_MASK)
+#define CP0SC_1GMASK    (CP0SC_C_MASK | CP0SC_EU_MASK | CP0SC_AM_MASK | \
+                         CP0SC_PA_1GMASK)
+#define CP0SC0_MASK     (CP0SC_MASK | (CP0SC_MASK << 16))
+#define CP0SC1_XAM      59
+#define CP0SC1_XAM_MASK (0x7ULL << CP0SC1_XAM)
+#define CP0SC1_MASK     (CP0SC_MASK | (CP0SC_MASK << 16) | CP0SC1_XAM_MASK)
+#define CP0SC2_XR       56
+#define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
+#define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_XR_MASK)
     int32_t CP0_Wired;
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 60efa01194a0..5f492348ddfa 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -115,6 +115,9 @@ DEF_HELPER_2(mtc0_entrylo1, void, env, tl)
 DEF_HELPER_2(mtc0_context, void, env, tl)
 DEF_HELPER_2(mtc0_pagemask, void, env, tl)
 DEF_HELPER_2(mtc0_pagegrain, void, env, tl)
+DEF_HELPER_2(mtc0_segctl0, void, env, tl)
+DEF_HELPER_2(mtc0_segctl1, void, env, tl)
+DEF_HELPER_2(mtc0_segctl2, void, env, tl)
 DEF_HELPER_2(mtc0_wired, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf0, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf1, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 91e31a7c2fe8..898825de3b9c 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -211,8 +211,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 9,
-    .minimum_version_id = 9,
+    .version_id = 10,
+    .minimum_version_id = 10,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -252,6 +252,9 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
         VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index e3531b6e84b0..d0bf819fa9fd 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1320,6 +1320,30 @@ void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
     restore_pamask(env);
 }
 
+void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
+{
+    CPUState *cs = CPU(mips_env_get_cpu(env));
+
+    env->CP0_SegCtl0 = arg1 & CP0SC0_MASK;
+    tlb_flush(cs);
+}
+
+void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
+{
+    CPUState *cs = CPU(mips_env_get_cpu(env));
+
+    env->CP0_SegCtl1 = arg1 & CP0SC1_MASK;
+    tlb_flush(cs);
+}
+
+void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
+{
+    CPUState *cs = CPU(mips_env_get_cpu(env));
+
+    env->CP0_SegCtl2 = arg1 & CP0SC2_MASK;
+    tlb_flush(cs);
+}
+
 void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->insn_flags & ISA_MIPS32R6) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ac9023443112..5c39fddfc410 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1450,6 +1450,7 @@ typedef struct DisasContext {
     uint64_t PAMask;
     bool mvh;
     bool eva;
+    bool sc;
     int CP0_LLAddr_shift;
     bool ps;
     bool vp;
@@ -5226,6 +5227,24 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain));
             rn = "PageGrain";
             break;
+        case 2:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl0));
+            tcg_gen_ext32s_tl(arg, arg);
+            rn = "SegCtl0";
+            break;
+        case 3:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl1));
+            tcg_gen_ext32s_tl(arg, arg);
+            rn = "SegCtl1";
+            break;
+        case 4:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
+            tcg_gen_ext32s_tl(arg, arg);
+            rn = "SegCtl2";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -5880,6 +5899,21 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "PageGrain";
             ctx->bstate = BS_STOP;
             break;
+        case 2:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl0(cpu_env, arg);
+            rn = "SegCtl0";
+            break;
+        case 3:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl1(cpu_env, arg);
+            rn = "SegCtl1";
+            break;
+        case 4:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl2(cpu_env, arg);
+            rn = "SegCtl2";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6541,6 +6575,21 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain));
             rn = "PageGrain";
             break;
+        case 2:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl0));
+            rn = "SegCtl0";
+            break;
+        case 3:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl1));
+            rn = "SegCtl1";
+            break;
+        case 4:
+            CP0_CHECK(ctx->sc);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
+            rn = "SegCtl2";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7177,6 +7226,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_pagegrain(cpu_env, arg);
             rn = "PageGrain";
             break;
+        case 2:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl0(cpu_env, arg);
+            rn = "SegCtl0";
+            break;
+        case 3:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl1(cpu_env, arg);
+            rn = "SegCtl1";
+            break;
+        case 4:
+            CP0_CHECK(ctx->sc);
+            gen_helper_mtc0_segctl2(cpu_env, arg);
+            rn = "SegCtl2";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -20133,6 +20197,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
     ctx.PAMask = env->PAMask;
     ctx.mvh = (env->CP0_Config5 >> CP0C5_MVH) & 1;
     ctx.eva = (env->CP0_Config5 >> CP0C5_EVA) & 1;
+    ctx.sc = (env->CP0_Config3 >> CP0C3_SC) & 1;
     ctx.CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx.cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
@@ -20619,6 +20684,29 @@ void cpu_state_reset(CPUMIPSState *env)
             env->tcs[0].CP0_TCStatus = (1 << CP0TCSt_A);
         }
     }
+
+    /*
+     * Configure default legacy segmentation control. We use this regardless of
+     * whether segmentation control is presented to the guest.
+     */
+    /* KSeg3 (seg0 0xE0000000..0xFFFFFFFF) */
+    env->CP0_SegCtl0 =   (CP0SC_AM_MK << CP0SC_AM);
+    /* KSeg2 (seg1 0xC0000000..0xDFFFFFFF) */
+    env->CP0_SegCtl0 |= ((CP0SC_AM_MSK << CP0SC_AM)) << 16;
+    /* KSeg1 (seg2 0xA0000000..0x9FFFFFFF) */
+    env->CP0_SegCtl1 =   (0 << CP0SC_PA) | (CP0SC_AM_UK << CP0SC_AM) |
+                         (2 << CP0SC_C);
+    /* KSeg0 (seg3 0x80000000..0x9FFFFFFF) */
+    env->CP0_SegCtl1 |= ((0 << CP0SC_PA) | (CP0SC_AM_UK << CP0SC_AM) |
+                         (3 << CP0SC_C)) << 16;
+    /* USeg (seg4 0x40000000..0x7FFFFFFF) */
+    env->CP0_SegCtl2 =   (2 << CP0SC_PA) | (CP0SC_AM_MUSK << CP0SC_AM) |
+                         (1 << CP0SC_EU) | (2 << CP0SC_C);
+    /* USeg (seg5 0x00000000..0x3FFFFFFF) */
+    env->CP0_SegCtl2 |= ((0 << CP0SC_PA) | (CP0SC_AM_MUSK << CP0SC_AM) |
+                         (1 << CP0SC_EU) | (2 << CP0SC_C)) << 16;
+    /* XKPhys (note, SegCtl2.XR = 0, so XAM won't be used) */
+    env->CP0_SegCtl1 |= (CP0SC_AM_UK << CP0SC1_XAM);
 #endif
     if ((env->insn_flags & ISA_MIPS32R6) &&
         (env->active_fpu.fcr0 & (1 << FCR0_F64))) {
-- 
git-series 0.8.10
