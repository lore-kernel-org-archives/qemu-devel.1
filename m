Received: from eggs.gnu.org ([209.51.188.92]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wS8-0006Jd-7q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wRz-0004SS-Vf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:56 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wRx-0004Kv-1o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:54 -0500
Received: by mail-pf1-x443.google.com with SMTP id s22so11895406pfh.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:04:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:20 -0800
Message-Id: <20190307170440.3113-3-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 02/22] target/arm: Extract TCMA with
 ARMVAParameters
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 1 +
 target/arm/helper.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6c018e773c..2922324f63 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -959,6 +959,7 @@ typedef struct ARMVAParameters {
     bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
+    bool tcma       : 1;
     bool using16k   : 1;
     bool using64k   : 1;
 } ARMVAParameters;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90d15578ca..ab8006291b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10599,7 +10599,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-    bool tbi, tbid, epd, hpd, using16k, using64k;
+    bool tbi, tbid, epd, hpd, tcma, using16k, using64k;
     int select, tsz;
 
     /*
@@ -10614,11 +10614,12 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_S2NS) {
             /* VTCR_EL2 */
-            tbi = tbid = hpd = false;
+            tbi = tbid = hpd = tcma = false;
         } else {
             tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
             tbid = extract32(tcr, 29, 1);
+            tcma = extract32(tcr, 30, 1);
         }
         epd = false;
     } else if (!select) {
@@ -10629,6 +10630,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tbi = extract64(tcr, 37, 1);
         hpd = extract64(tcr, 41, 1);
         tbid = extract64(tcr, 51, 1);
+        tcma = extract64(tcr, 57, 1);
     } else {
         int tg = extract32(tcr, 30, 2);
         using16k = tg == 1;
@@ -10638,6 +10640,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tbi = extract64(tcr, 38, 1);
         hpd = extract64(tcr, 42, 1);
         tbid = extract64(tcr, 52, 1);
+        tcma = extract64(tcr, 58, 1);
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
@@ -10649,6 +10652,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
+        .tcma = tcma,
         .using16k = using16k,
         .using64k = using64k,
     };
-- 
2.17.2
