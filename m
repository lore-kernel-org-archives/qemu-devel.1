Received: from eggs.gnu.org ([209.51.188.92]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbV-0002mV-Gt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007NB-OW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007L6-Ha
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m22so4809794wml.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:42 +0000
Message-Id: <20190118145805.6852-27-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/49] target/arm: Decode TBID from TCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Use TBID in aa64_va_parameters depending on the data parameter.
This automatically updates all existing users of the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/helper.c    | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index acd99b579cd..a6fd4582b2b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -950,6 +950,7 @@ typedef struct ARMVAParameters {
     unsigned tsz    : 8;
     unsigned select : 1;
     bool tbi        : 1;
+    bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
     bool using16k   : 1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 75a6004decd..d9b580e3316 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9749,7 +9749,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-    bool tbi, epd, hpd, using16k, using64k;
+    bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
     /*
@@ -9764,10 +9764,11 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_S2NS) {
             /* VTCR_EL2 */
-            tbi = hpd = false;
+            tbi = tbid = hpd = false;
         } else {
             tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
+            tbid = extract32(tcr, 29, 1);
         }
         epd = false;
     } else if (!select) {
@@ -9777,6 +9778,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         tbi = extract64(tcr, 37, 1);
         hpd = extract64(tcr, 41, 1);
+        tbid = extract64(tcr, 51, 1);
     } else {
         int tg = extract32(tcr, 30, 2);
         using16k = tg == 1;
@@ -9785,6 +9787,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         epd = extract32(tcr, 23, 1);
         tbi = extract64(tcr, 38, 1);
         hpd = extract64(tcr, 42, 1);
+        tbid = extract64(tcr, 52, 1);
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
@@ -9793,6 +9796,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         .tsz = tsz,
         .select = select,
         .tbi = tbi,
+        .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
         .using16k = using16k,
@@ -9803,7 +9807,11 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data)
 {
-    return aa64_va_parameters_both(env, va, mmu_idx);
+    ARMVAParameters ret = aa64_va_parameters_both(env, va, mmu_idx);
+
+    /* Present TBI as a composite with TBID.  */
+    ret.tbi &= (data || !ret.tbid);
+    return ret;
 }
 
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
-- 
2.20.1
