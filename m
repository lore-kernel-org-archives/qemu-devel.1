Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0XH-0000uq-Ij
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0XE-0004l1-TK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46682 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0XC-0004Sr-V8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:19 +0200
Message-Id: <1539362376-12010-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 11/28] target/mips: Add CPO PWCtl register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

Add PWCtl register (CP0 Register 5, Select 6).

The PWCtl register configures hardware page table walking for TLB
refills.

This register is required for the hardware page walker feature. It
exists only if Config3 PW bit is set to 1. It contains following
fields:

PWEn   (31)   - Hardware Page Table walker enable
DPH    (7)    - Dual Page format of Huge Page support
HugePg (6)    - Huge Page PTE supported in Directory levels
PSn    (5..0) - Bit position of PTEvld in Huge Page PTE

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  5 +++++
 target/mips/helper.h    |  1 +
 target/mips/machine.c   |  5 +++--
 target/mips/op_helper.c | 10 ++++++++++
 target/mips/translate.c | 20 ++++++++++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a6abd1f..5e45e97 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -304,6 +304,11 @@ struct CPUMIPSState {
 #define CP0PS_PTW  6     /* 11..6  */
 #define CP0PS_PTEW 0     /*  5..0  */
     int32_t CP0_Wired;
+    int32_t CP0_PWCtl;
+#define CP0PC_PWEN      31
+#define CP0PC_DPH       7
+#define CP0PC_HUGEPG    6
+#define CP0PC_PSN       0     /*  5..0  */
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
 #define CP0SRSC0_M	31
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 169890a..c23e4e5 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -129,6 +129,7 @@ DEF_HELPER_2(mtc0_srsconf2, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf3, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
+DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 3da891f..70a8909 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 14,
-    .minimum_version_id = 14,
+    .version_id = 15,
+    .minimum_version_id = 15,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -260,6 +260,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_PWField, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_PWSize, MIPSCPU),
         VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
+        VMSTATE_INT32(env.CP0_PWCtl, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf2, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 0986baf..e649bd0 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1524,6 +1524,16 @@ void helper_mtc0_srsconf4(CPUMIPSState *env, target_ulong arg1)
     env->CP0_SRSConf4 |= arg1 & env->CP0_SRSConf4_rw_bitmask;
 }
 
+void helper_mtc0_pwctl(CPUMIPSState *env, target_ulong arg1)
+{
+#ifdef TARGET_MIPS64
+    /* PWEn = 0. Hardware page table walking is not implemented. */
+    env->CP0_PWCtl = (env->CP0_PWCtl & 0x000000C0) | (arg1 & 0x5C00003F);
+#else
+    env->CP0_PWCtl = (arg1 & 0x800000FF);
+#endif
+}
+
 void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask = 0x0000000F;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ef38be9..f669d48 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5598,6 +5598,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
             rn = "SRSConf4";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
+            rn = "PWCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6314,6 +6319,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_srsconf4(cpu_env, arg);
             rn = "SRSConf4";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_helper_mtc0_pwctl(cpu_env, arg);
+            rn = "PWCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7039,6 +7049,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
             rn = "SRSConf4";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
+            rn = "PWCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7737,6 +7752,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_srsconf4(cpu_env, arg);
             rn = "SRSConf4";
             break;
+        case 6:
+            check_pw(ctx);
+            gen_helper_mtc0_pwctl(cpu_env, arg);
+            rn = "PWCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
