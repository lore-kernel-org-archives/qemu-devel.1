Received: from eggs.gnu.org ([2001:4830:134:3::10]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2w-0001z7-1s
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2t-0006uw-4N
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39487 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2s-0006fB-HG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:48 +0200
Message-Id: <1539779635-15445-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 20/27] target/mips: Add CP0 PWField register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Add PWField register (CP0 Register 5, Select 6).

The PWField register configures hardware page table walking for TLB
refills.

This register is required for the hardware page walker feature. It
exists only if Config3 PW bit is set to 1. It contains following
fields:

MIPS64:
BDI  (37..32) - Base Directory index
GDI  (29..24) - Global Directory index
UDI  (23..18) - Upper Directory index
MDI  (17..12) - Middle Directory index
PTI  (11..6 ) - Page Table index
PTEI ( 5..0 ) - Page Table Entry shift

MIPS32:
GDW  (29..24) - Global Directory index
UDW  (23..18) - Upper Directory index
MDW  (17..12) - Middle Directory index
PTW  (11..6 ) - Page Table index
PTEW ( 5..0 ) - Page Table Entry shift

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 15 ++++++++++++
 target/mips/helper.h    |  1 +
 target/mips/machine.c   |  5 ++--
 target/mips/op_helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/translate.c | 20 ++++++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 9cbde99..31c9583 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -417,6 +417,21 @@ struct CPUMIPSState {
 #define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
 #define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_XR_MASK)
     target_ulong CP0_PWBase;
+    target_ulong CP0_PWField;
+#if defined(TARGET_MIPS64)
+#define CP0PF_BDI  32    /* 37..32 */
+#define CP0PF_GDI  24    /* 29..24 */
+#define CP0PF_UDI  18    /* 23..18 */
+#define CP0PF_MDI  12    /* 17..12 */
+#define CP0PF_PTI  6     /* 11..6  */
+#define CP0PF_PTEI 0     /*  5..0  */
+#else
+#define CP0PF_GDW  24    /* 29..24 */
+#define CP0PF_UDW  18    /* 23..18 */
+#define CP0PF_MDW  12    /* 17..12 */
+#define CP0PF_PTW  6     /* 11..6  */
+#define CP0PF_PTEW 0     /*  5..0  */
+#endif
 /*
  * CP0 Register 6
  */
diff --git a/target/mips/helper.h b/target/mips/helper.h
index b2a780a..6366f9b 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -120,6 +120,7 @@ DEF_HELPER_2(mtc0_pagegrain, void, env, tl)
 DEF_HELPER_2(mtc0_segctl0, void, env, tl)
 DEF_HELPER_2(mtc0_segctl1, void, env, tl)
 DEF_HELPER_2(mtc0_segctl2, void, env, tl)
+DEF_HELPER_2(mtc0_pwfield, void, env, tl)
 DEF_HELPER_2(mtc0_wired, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf0, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf1, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 3592bb7..7aa496c 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 12,
-    .minimum_version_id = 12,
+    .version_id = 13,
+    .minimum_version_id = 13,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -257,6 +257,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_PWBase, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_PWField, MIPSCPU),
         VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index c148b31..76be944 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1445,6 +1445,68 @@ void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
     tlb_flush(cs);
 }
 
+void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
+{
+#if defined(TARGET_MIPS64)
+    uint64_t mask = 0x3F3FFFFFFFULL;
+    uint32_t old_ptei = (env->CP0_PWField >> CP0PF_PTEI) & 0x3FULL;
+    uint32_t new_ptei = (arg1 >> CP0PF_PTEI) & 0x3FULL;
+
+    if ((env->insn_flags & ISA_MIPS32R6)) {
+        if (((arg1 >> CP0PF_BDI) & 0x3FULL) < 12) {
+            mask &= ~(0x3FULL << CP0PF_BDI);
+        }
+        if (((arg1 >> CP0PF_GDI) & 0x3FULL) < 12) {
+            mask &= ~(0x3FULL << CP0PF_GDI);
+        }
+        if (((arg1 >> CP0PF_UDI) & 0x3FULL) < 12) {
+            mask &= ~(0x3FULL << CP0PF_UDI);
+        }
+        if (((arg1 >> CP0PF_MDI) & 0x3FULL) < 12) {
+            mask &= ~(0x3FULL << CP0PF_MDI);
+        }
+        if (((arg1 >> CP0PF_PTI) & 0x3FULL) < 12) {
+            mask &= ~(0x3FULL << CP0PF_PTI);
+        }
+    }
+    env->CP0_PWField = arg1 & mask;
+
+    if ((new_ptei >= 32) ||
+            ((env->insn_flags & ISA_MIPS32R6) &&
+                    (new_ptei == 0 || new_ptei == 1))) {
+        env->CP0_PWField = (env->CP0_PWField & ~0x3FULL) |
+                (old_ptei << CP0PF_PTEI);
+    }
+#else
+    uint32_t mask = 0x3FFFFFFF;
+    uint32_t old_ptew = (env->CP0_PWField >> CP0PF_PTEW) & 0x3F;
+    uint32_t new_ptew = (arg1 >> CP0PF_PTEW) & 0x3F;
+
+    if ((env->insn_flags & ISA_MIPS32R6)) {
+        if (((arg1 >> CP0PF_GDW) & 0x3F) < 12) {
+            mask &= ~(0x3F << CP0PF_GDW);
+        }
+        if (((arg1 >> CP0PF_UDW) & 0x3F) < 12) {
+            mask &= ~(0x3F << CP0PF_UDW);
+        }
+        if (((arg1 >> CP0PF_MDW) & 0x3F) < 12) {
+            mask &= ~(0x3F << CP0PF_MDW);
+        }
+        if (((arg1 >> CP0PF_PTW) & 0x3F) < 12) {
+            mask &= ~(0x3F << CP0PF_PTW);
+        }
+    }
+    env->CP0_PWField = arg1 & mask;
+
+    if ((new_ptew >= 32) ||
+            ((env->insn_flags & ISA_MIPS32R6) &&
+                    (new_ptew == 0 || new_ptew == 1))) {
+        env->CP0_PWField = (env->CP0_PWField & ~0x3F) |
+                (old_ptew << CP0PF_PTEW);
+    }
+#endif
+}
+
 void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->insn_flags & ISA_MIPS32R6) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e166963..da12d8f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6105,6 +6105,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWBase));
             rn = "PWBase";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWField));
+            rn = "PWField";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6811,6 +6816,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_PWBase));
             rn = "PWBase";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_helper_mtc0_pwfield(cpu_env, arg);
+            rn = "PWField";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7526,6 +7536,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
             rn = "PWBase";
             break;
+        case 6:
+            check_pw(ctx);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWField));
+            rn = "PWField";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -8214,6 +8229,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
             rn = "PWBase";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_helper_mtc0_pwfield(cpu_env, arg);
+            rn = "PWField";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
