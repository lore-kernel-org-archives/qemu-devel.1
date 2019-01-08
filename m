Received: from eggs.gnu.org ([209.51.188.92]:52881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvH-0000RG-Qa
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvH-00050K-0g
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:35 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvG-0004zS-QW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:34 -0500
Received: by mail-pf1-x441.google.com with SMTP id c123so2630570pfb.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:20 +1000
Message-Id: <20190108223129.5570-23-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 22/31] target/arm: Decode TBID from TCR
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

Use TBID in aa64_va_parameters depending on the data parameter.
This automatically updates all existing users of the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/helper.c    | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index acd99b579c..a6fd4582b2 100644
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
index 28322ae109..cc3c0d47c8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9749,7 +9749,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-    bool tbi, epd, hpd, using16k, using64k;
+    bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
     /* Bit 55 is always between the two regions, and is canonical for
@@ -9763,10 +9763,11 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
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
@@ -9776,6 +9777,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         tbi = extract64(tcr, 37, 1);
         hpd = extract64(tcr, 41, 1);
+        tbid = extract64(tcr, 51, 1);
     } else {
         int tg = extract32(tcr, 30, 2);
         using16k = tg == 1;
@@ -9784,6 +9786,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         epd = extract32(tcr, 23, 1);
         tbi = extract64(tcr, 38, 1);
         hpd = extract64(tcr, 42, 1);
+        tbid = extract64(tcr, 52, 1);
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
@@ -9792,6 +9795,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         .tsz = tsz,
         .select = select,
         .tbi = tbi,
+        .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
         .using16k = using16k,
@@ -9802,7 +9806,11 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
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
2.17.2
