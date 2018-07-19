Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8ZG-0004OI-3v
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8W3-0006ks-AU
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57667 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8W2-0006k0-KY
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:43 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:58 +0200
Message-Id: <1532004912-13899-27-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 26/40] target/mips: Implement CP0 Config0.WR
 bit functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add testing Config0.WR bit into watch exception handling logic.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c    | 12 +++++++++++-
 target/mips/translate.c | 22 ++++++++++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 9535131..dc8f2a5 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -749,6 +749,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
         (env->hflags & MIPS_HFLAG_DM)) {
         cs->exception_index = EXCP_DINT;
     }
+
+    if ((cs->exception_index == EXCP_DWATCH ||
+        cs->exception_index == EXCP_DFWATCH ||
+        cs->exception_index == EXCP_IWATCH) &&
+        (env->CP0_Config1 & (1 << CP0C1_WR))) {
+        cs->exception_index = EXCP_NONE;
+    }
+
     offset = 0x180;
     switch (cs->exception_index) {
     case EXCP_DSS:
@@ -799,7 +807,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
         break;
     case EXCP_SRESET:
         env->CP0_Status |= (1 << CP0St_SR);
-        memset(env->CP0_WatchLo, 0, sizeof(env->CP0_WatchLo));
+        if (env->CP0_Config1 & (1 << CP0C1_WR)) {
+            memset(env->CP0_WatchLo, 0, sizeof(env->CP0_WatchLo));
+        }
         goto set_error_EPC;
     case EXCP_NMI:
         env->CP0_Status |= (1 << CP0St_NMI);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3f915e1..ec486bb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5622,6 +5622,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -5639,6 +5640,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6321,6 +6323,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6338,6 +6341,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -7024,6 +7028,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -7041,6 +7046,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -7705,6 +7711,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -7722,6 +7729,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -25281,14 +25289,16 @@ void cpu_state_reset(CPUMIPSState *env)
        no performance counters. */
     env->CP0_IntCtl = 0xe0000000;
     {
-        int i;
+        if (env->CP0_Config1 & (1 << CP0C1_WR)) {
+            int i;
 
-        for (i = 0; i < 7; i++) {
-            env->CP0_WatchLo[i] = 0;
-            env->CP0_WatchHi[i] = 0x80000000;
+            for (i = 0; i < 7; i++) {
+                env->CP0_WatchLo[i] = 0;
+                env->CP0_WatchHi[i] = 0x80000000;
+            }
+            env->CP0_WatchLo[7] = 0;
+            env->CP0_WatchHi[7] = 0;
         }
-        env->CP0_WatchLo[7] = 0;
-        env->CP0_WatchHi[7] = 0;
     }
     /* Count register increments in debug mode, EJTAG version 1 */
     env->CP0_Debug = (1 << CP0DB_CNT) | (0x1 << CP0DB_VER);
-- 
2.7.4
