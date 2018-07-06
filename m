Received: from eggs.gnu.org ([2001:4830:134:3::10]:40766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fbPs7-0002xM-GD
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fbPs3-0003qv-0c
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:29:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59229 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fbPs2-0003oz-Jr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:29:54 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  6 Jul 2018 13:48:50 +0200
Message-Id: <1530877732-26557-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 6/8] target/mips: Amend CP0 WatchHi register
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

WatchHi is extended by the field MemoryMapID with the GINVT instruction.
The field is accessible by MTHC0/MFHC0 in 32-bit architectures and DMTC0/
DMFC0 in 64-bit architectures.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  2 +-
 target/mips/helper.h    |  3 +++
 target/mips/machine.c   |  6 +++---
 target/mips/op_helper.c | 23 +++++++++++++++++++++--
 target/mips/translate.c | 28 +++++++++++++++++++++++++++-
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 4cd918b..1206dc3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -503,7 +503,7 @@ struct CPUMIPSState {
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
     target_ulong CP0_WatchLo[8];
-    int32_t CP0_WatchHi[8];
+    uint64_t CP0_WatchHi[8];
 #define CP0WH_ASID 16
     target_ulong CP0_XContext;
     int32_t CP0_Framemask;
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5f49234..151441a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -74,6 +74,7 @@ DEF_HELPER_1(mfc0_maar, tl, env)
 DEF_HELPER_1(mfhc0_maar, tl, env)
 DEF_HELPER_2(mfc0_watchlo, tl, env, i32)
 DEF_HELPER_2(mfc0_watchhi, tl, env, i32)
+DEF_HELPER_2(mfhc0_watchhi, tl, env, i32)
 DEF_HELPER_1(mfc0_debug, tl, env)
 DEF_HELPER_1(mftc0_debug, tl, env)
 #ifdef TARGET_MIPS64
@@ -85,6 +86,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
 DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
+DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
 #endif /* TARGET_MIPS64 */
 
 DEF_HELPER_2(mtc0_index, void, env, tl)
@@ -148,6 +150,7 @@ DEF_HELPER_2(mthc0_maar, void, env, tl)
 DEF_HELPER_2(mtc0_maari, void, env, tl)
 DEF_HELPER_3(mtc0_watchlo, void, env, tl, i32)
 DEF_HELPER_3(mtc0_watchhi, void, env, tl, i32)
+DEF_HELPER_3(mthc0_watchhi, void, env, tl, i32)
 DEF_HELPER_2(mtc0_xcontext, void, env, tl)
 DEF_HELPER_2(mtc0_framemask, void, env, tl)
 DEF_HELPER_2(mtc0_debug, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 5ba78ac..5e9c559 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -288,7 +288,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
         VMSTATE_UINT64(env.lladdr, MIPSCPU),
         VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
-        VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
         VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
         VMSTATE_INT32(env.CP0_Framemask, MIPSCPU),
         VMSTATE_INT32(env.CP0_Debug, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 41d3634..0b8ec7d 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -893,7 +893,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 
 target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 {
-    return env->CP0_WatchHi[sel];
+    return (int32_t) env->CP0_WatchHi[sel];
+}
+
+target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
+{
+    return env->CP0_WatchHi[sel] >> 32;
 }
 
 target_ulong helper_mfc0_debug(CPUMIPSState *env)
@@ -961,6 +966,11 @@ target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchLo[sel];
 }
+
+target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
+{
+    return env->CP0_WatchHi[sel];
+}
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1662,11 +1672,20 @@ void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 
 void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
-    int mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
+    uint64_t mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
+    if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
+        mask |= 0xFFFFFFFF00000000ULL; /* MMID */
+    }
     env->CP0_WatchHi[sel] = arg1 & mask;
     env->CP0_WatchHi[sel] &= ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
 }
 
+void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+{
+    env->CP0_WatchHi[sel] = ((uint64_t) (arg1) << 32) |
+                            (env->CP0_WatchHi[sel] & 0x00000000ffffffffULL);
+}
+
 void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong mask = (1ULL << (env->SEGBITS - 7)) - 1;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 00154d2..7721ed7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1458,6 +1458,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool mi;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -4923,6 +4924,18 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case 19:
+        switch (sel) {
+        case 0 ...7:
+            /* upper 32 bits are only available when Config5MI != 0 */
+            CP0_CHECK(ctx->mi);
+            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_WatchHi[sel]), 0);
+            rn = "WatchHi";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case 28:
         switch (sel) {
         case 0:
@@ -4995,6 +5008,18 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case 19:
+        switch (sel) {
+        case 0 ...7:
+            /* upper 32 bits are only available when Config5MI != 0 */
+            CP0_CHECK(ctx->mi);
+            gen_helper_0e1i(mthc0_watchhi, arg, sel);
+            rn = "WatchHi";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case 28:
         switch (sel) {
         case 0:
@@ -6935,7 +6960,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
-            gen_helper_1e0i(mfc0_watchhi, arg, sel);
+            gen_helper_1e0i(dmfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
         default:
@@ -20403,6 +20428,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
2.7.4
