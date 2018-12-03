Received: from eggs.gnu.org ([2001:4830:134:3::10]:42410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzb-000687-5q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuza-0005sz-7V
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuza-0005sF-2t
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so12231279oia.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:38 -0600
Message-Id: <20181203203839.757-10-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/10] target/arm: Implement the ARMv8.1-HPD
 extension
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

Since the TCR_*.HPD bits were RES0 in ARMv8.0, we can simply
interpret the bits as if ARMv8.1-HPD is present without checking.
We will need a slightly different check for hpd for aarch32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c  |  1 +
 target/arm/helper.c | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index aac6283018..1d57be0c91 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -325,6 +325,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64pfr0 = t;
 
         t = cpu->isar.id_aa64mmfr1;
+        t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         cpu->isar.id_aa64mmfr1 = t;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0ee1fbc5a..9bb3e364d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9776,6 +9776,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid = true;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool hpd = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -9890,6 +9891,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 2) { /* 16KB pages */
             stride = 11;
         }
+        if (aarch64) {
+            if (el > 1) {
+                hpd = extract64(tcr->raw_tcr, 24, 1);
+            } else {
+                hpd = extract64(tcr->raw_tcr, 41, 1);
+            }
+        }
     } else {
         /* We should only be here if TTBR1 is valid */
         assert(ttbr1_valid);
@@ -9905,6 +9913,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 1) { /* 16KB pages */
             stride = 11;
         }
+        if (aarch64) {
+            hpd = extract64(tcr->raw_tcr, 42, 1);
+        }
     }
 
     /* Here we should have set up all the parameters for the translation:
@@ -9998,7 +10009,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         descaddr = descriptor & descaddrmask;
 
         if ((descriptor & 2) && (level < 3)) {
-            /* Table entry. The top five bits are attributes which  may
+            /* Table entry. The top five bits are attributes which may
              * propagate down through lower levels of the table (and
              * which are all arranged so that 0 means "no effect", so
              * we can gather them up by ORing in the bits at each level).
@@ -10023,15 +10034,17 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
             break;
         }
         /* Merge in attributes from table descriptors */
-        attrs |= extract32(tableattrs, 0, 2) << 11; /* XN, PXN */
-        attrs |= extract32(tableattrs, 3, 1) << 5; /* APTable[1] => AP[2] */
+        attrs |= nstable << 3; /* NS */
+        if (hpd) {
+            /* HPD disables all the table attributes except NSTable.  */
+            break;
+        }
+        attrs |= extract32(tableattrs, 0, 2) << 11;     /* XN, PXN */
         /* The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
          * means "force PL1 access only", which means forcing AP[1] to 0.
          */
-        if (extract32(tableattrs, 2, 1)) {
-            attrs &= ~(1 << 4);
-        }
-        attrs |= nstable << 3; /* NS */
+        attrs &= ~(extract32(tableattrs, 2, 1) << 4);   /* !APT[0] => AP[1] */
+        attrs |= extract32(tableattrs, 3, 1) << 5;      /* APT[1] => AP[2] */
         break;
     }
     /* Here descaddr is the final physical address, and attributes
-- 
2.17.2
