Received: from eggs.gnu.org ([209.51.188.92]:45509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV7-0003YC-9J
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV5-00076k-9B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:13 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52910 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV3-0006pg-4B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:38 +0100
Message-Id: <1547830785-7079-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 05/12] target/mips: Provide R/W access to
 SAARI and SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Provide R/W access to SAARI and SAAR CP0 registers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/helper.h    |  6 +++++
 target/mips/internal.h  |  1 +
 target/mips/op_helper.c | 50 +++++++++++++++++++++++++++++++++++++
 target/mips/translate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1c2c682..185702d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -901,6 +901,7 @@ struct CPUMIPSState {
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
     uint64_t insn_flags; /* Supported instruction set */
+    int saarp;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/mips/helper.h b/target/mips/helper.h
index c23e4e5..8872c46 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -65,6 +65,8 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
 DEF_HELPER_1(mfc0_tcschefback, tl, env)
 DEF_HELPER_1(mftc0_tcschefback, tl, env)
 DEF_HELPER_1(mfc0_count, tl, env)
+DEF_HELPER_1(mfc0_saar, tl, env)
+DEF_HELPER_1(mfhc0_saar, tl, env)
 DEF_HELPER_1(mftc0_entryhi, tl, env)
 DEF_HELPER_1(mftc0_status, tl, env)
 DEF_HELPER_1(mftc0_cause, tl, env)
@@ -87,6 +89,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
 DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
+DEF_HELPER_1(dmfc0_saar, tl, env)
 #endif /* TARGET_MIPS64 */
 
 DEF_HELPER_2(mtc0_index, void, env, tl)
@@ -131,6 +134,9 @@ DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
+DEF_HELPER_2(mtc0_saari, void, env, tl)
+DEF_HELPER_2(mtc0_saar, void, env, tl)
+DEF_HELPER_2(mthc0_saar, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 8b1b245..8f6fc91 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -61,6 +61,7 @@ struct mips_def_t {
     target_ulong CP0_EBaseWG_rw_bitmask;
     uint64_t insn_flags;
     enum mips_mmu_types mmu_type;
+    int32_t SAARP;
 };
 
 extern const struct mips_def_t mips_defs[];
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index d1f1d1a..409c136 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -938,6 +938,22 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
     return count;
 }
 
+target_ulong helper_mfc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return (int32_t) env->CP0_SAAR[env->CP0_SAARI & 0x3f];
+    }
+    return 0;
+}
+
+target_ulong helper_mfhc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return env->CP0_SAAR[env->CP0_SAARI & 0x3f] >> 32;
+    }
+    return 0;
+}
+
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
@@ -1059,6 +1075,14 @@ target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchLo[sel];
 }
+
+target_ulong helper_dmfc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return env->CP0_SAAR[env->CP0_SAARI & 0x3f];
+    }
+    return 0;
+}
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1598,6 +1622,32 @@ void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
     qemu_mutex_unlock_iothread();
 }
 
+void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = arg1 & 0x3f;
+    if (target <= 1) {
+        env->CP0_SAARI = target;
+    }
+}
+
+void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = env->CP0_SAARI & 0x3f;
+    if (target < 2) {
+        env->CP0_SAAR[target] = arg1 & 0x00000ffffffff03fULL;
+    }
+}
+
+void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = env->CP0_SAARI & 0x3f;
+    if (target < 2) {
+        env->CP0_SAAR[target] =
+            (((uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
+            (env->CP0_SAAR[target] & 0x00000000ffffffffULL);
+    }
+}
+
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 827d0f7..00cbbf7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2537,6 +2537,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool saar;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -6592,6 +6593,17 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case CPO_REGISTER_09:
+        switch (sel) {
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mfhc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case CPO_REGISTER_17:
         switch (sel) {
         case 0:
@@ -6662,6 +6674,16 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case CPO_REGISTER_09:
+        switch (sel) {
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mthc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
     case CPO_REGISTER_17:
         switch (sel) {
         case 0:
@@ -7048,7 +7070,16 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mfc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7753,7 +7784,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(cpu_env, arg);
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saari(cpu_env, arg);
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -8498,7 +8538,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_dmfc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -9186,7 +9235,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(cpu_env, arg);
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saari(cpu_env, arg);
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
