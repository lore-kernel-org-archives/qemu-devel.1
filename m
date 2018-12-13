Received: from eggs.gnu.org ([2001:4830:134:3::10]:36053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOX-0004Ux-K5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOS-0007bD-1d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOR-0007J5-Dl
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOF-0007Mw-T0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:41 +0000
Message-Id: <20181213145445.17935-34-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/37] target/arm: Implement the ARMv8.1-HPD
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

From: Richard Henderson <richard.henderson@linaro.org>

Since the TCR_*.HPD bits were RES0 in ARMv8.0, we can simply
interpret the bits as if ARMv8.1-HPD is present without checking.
We will need a slightly different check for hpd for aarch32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181203203839.757-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c  |  4 ++++
 target/arm/helper.c | 27 ++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0babe483ac2..1a4289c9dda 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -324,6 +324,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
         cpu->isar.id_aa64pfr0 = t;
 
+        t = cpu->isar.id_aa64mmfr1;
+        t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
+        cpu->isar.id_aa64mmfr1 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1dad277804f..57af6b77a1b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9636,6 +9636,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid = true;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool hpd = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -9750,6 +9751,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -9765,6 +9773,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 1) { /* 16KB pages */
             stride = 11;
         }
+        if (aarch64) {
+            hpd = extract64(tcr->raw_tcr, 42, 1);
+        }
     }
 
     /* Here we should have set up all the parameters for the translation:
@@ -9858,7 +9869,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         descaddr = descriptor & descaddrmask;
 
         if ((descriptor & 2) && (level < 3)) {
-            /* Table entry. The top five bits are attributes which  may
+            /* Table entry. The top five bits are attributes which may
              * propagate down through lower levels of the table (and
              * which are all arranged so that 0 means "no effect", so
              * we can gather them up by ORing in the bits at each level).
@@ -9883,15 +9894,17 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
2.19.2
