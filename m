Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhp-0007C5-AD
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhn-0007PG-9H
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIZhl-0007Bp-Nh
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id r63-v6so2031566wma.4
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:41:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 13:41:11 +0000
Message-Id: <20181102134112.26370-4-richard.henderson@linaro.org>
In-Reply-To: <20181102134112.26370-1-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 3/4] target/arm: Implement the
 ARMv8.1-HPD extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Since the TCR_*.HPD bits were RES0 in ARMv8.0, we can simply
interpret the bits as if ARMv8.1-HPD is present without checking.
We will need a slightly different check for hpd for aarch32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c  |  1 +
 target/arm/helper.c | 29 +++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

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
index 758ddac5e9..312d3e6f02 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9682,6 +9682,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid = true;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool hpd = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -9796,6 +9797,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -9811,6 +9819,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 1) { /* 16KB pages */
             stride = 11;
         }
+        if (aarch64) {
+            hpd = extract64(tcr->raw_tcr, 42, 1);
+        }
     }
 
     /* Here we should have set up all the parameters for the translation:
@@ -9904,7 +9915,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         descaddr = descriptor & descaddrmask;
 
         if ((descriptor & 2) && (level < 3)) {
-            /* Table entry. The top five bits are attributes which  may
+            /* Table entry. The top five bits are attributes which may
              * propagate down through lower levels of the table (and
              * which are all arranged so that 0 means "no effect", so
              * we can gather them up by ORing in the bits at each level).
@@ -9928,14 +9939,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
-        /* Merge in attributes from table descriptors */
-        attrs |= extract32(tableattrs, 0, 2) << 11; /* XN, PXN */
-        attrs |= extract32(tableattrs, 3, 1) << 5; /* APTable[1] => AP[2] */
-        /* The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
-         * means "force PL1 access only", which means forcing AP[1] to 0.
+        /*
+         * Merge in attributes from table descriptors, if the
+         * Hierarchical Permission Disable bit is not set.
          */
-        if (extract32(tableattrs, 2, 1)) {
-            attrs &= ~(1 << 4);
+        if (!hpd) {
+            attrs |= extract32(tableattrs, 0, 2) << 11; /* XN, PXN */
+            /* !APTable[0] => AP[1].  */
+            attrs &= ~(extract32(tableattrs, 2, 1) << 4);
+            /* APTable[1] => AP[2] */
+            attrs |= extract32(tableattrs, 3, 1) << 5;
         }
         attrs |= nstable << 3; /* NS */
         break;
-- 
2.17.2
