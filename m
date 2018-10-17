Received: from eggs.gnu.org ([2001:4830:134:3::10]:44748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2w-0001yx-0i
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2t-0006uS-1j
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39486 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2s-0006fA-Ew
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:49 +0200
Message-Id: <1539779635-15445-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 21/27] target/mips: Add CP0 PWSize register
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

Add PWSize register (CP0 Register 5, Select 7).

The PWSize register configures hardware page table walking for TLB
refills.

This register is required for the hardware page walker feature. It
exists only if Config3 PW bit is set to 1. It contains following
fields:

BDW  (37..32) Base Directory index width (MIPS64 only)
GDW  (29..24) Global Directory index width
UDW  (23..18) Upper Directory index width
MDW  (17..12) Middle Directory index width
PTW  (11..6 ) Page Table index width
PTEW ( 5..0 ) Left shift applied to the Page Table index

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 10 ++++++++++
 target/mips/helper.h    |  1 +
 target/mips/machine.c   |  5 +++--
 target/mips/op_helper.c |  9 +++++++++
 target/mips/translate.c | 20 ++++++++++++++++++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 31c9583..3475b2f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -432,6 +432,16 @@ struct CPUMIPSState {
 #define CP0PF_PTW  6     /* 11..6  */
 #define CP0PF_PTEW 0     /*  5..0  */
 #endif
+    target_ulong CP0_PWSize;
+#if defined(TARGET_MIPS64)
+#define CP0PS_BDW  32    /* 37..32 */
+#endif
+#define CP0PS_PS   30
+#define CP0PS_GDW  24    /* 29..24 */
+#define CP0PS_UDW  18    /* 23..18 */
+#define CP0PS_MDW  12    /* 17..12 */
+#define CP0PS_PTW  6     /* 11..6  */
+#define CP0PS_PTEW 0     /*  5..0  */
 /*
  * CP0 Register 6
  */
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 6366f9b..169890a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -121,6 +121,7 @@ DEF_HELPER_2(mtc0_segctl0, void, env, tl)
 DEF_HELPER_2(mtc0_segctl1, void, env, tl)
 DEF_HELPER_2(mtc0_segctl2, void, env, tl)
 DEF_HELPER_2(mtc0_pwfield, void, env, tl)
+DEF_HELPER_2(mtc0_pwsize, void, env, tl)
 DEF_HELPER_2(mtc0_wired, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf0, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf1, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 7aa496c..3da891f 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 13,
-    .minimum_version_id = 13,
+    .version_id = 14,
+    .minimum_version_id = 14,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -258,6 +258,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_SegCtl2, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_PWBase, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_PWField, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_PWSize, MIPSCPU),
         VMSTATE_INT32(env.CP0_Wired, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf0, MIPSCPU),
         VMSTATE_INT32(env.CP0_SRSConf1, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 76be944..66881a2 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1507,6 +1507,15 @@ void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
 #endif
 }
 
+void helper_mtc0_pwsize(CPUMIPSState *env, target_ulong arg1)
+{
+#if defined(TARGET_MIPS64)
+    env->CP0_PWSize = arg1 & 0x3F7FFFFFFFULL;
+#else
+    env->CP0_PWSize = arg1 & 0x3FFFFFFF;
+#endif
+}
+
 void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->insn_flags & ISA_MIPS32R6) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index da12d8f..9e05c92 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6110,6 +6110,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWField));
             rn = "PWField";
             break;
+        case 7:
+            check_pw(ctx);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWSize));
+            rn = "PWSize";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6821,6 +6826,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_pwfield(cpu_env, arg);
             rn = "PWField";
             break;
+        case 7:
+            check_pw(ctx);
+            gen_helper_mtc0_pwsize(cpu_env, arg);
+            rn = "PWSize";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7541,6 +7551,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWField));
             rn = "PWField";
             break;
+        case 7:
+            check_pw(ctx);
+            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWSize));
+            rn = "PWSize";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -8234,6 +8249,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_pwfield(cpu_env, arg);
             rn = "PWField";
             break;
+        case 7:
+            check_pw(ctx);
+            gen_helper_mtc0_pwsize(cpu_env, arg);
+            rn = "PWSize";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
