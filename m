Received: from eggs.gnu.org ([2001:4830:134:3::10]:59276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVL-0008Id-Sk
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVF-0007qR-93
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:07 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVE-0007pc-VN
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so3309820otm.13
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:21 -0600
Message-Id: <20181207103631.28193-17-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/26] target/arm: Create ARMVAParameters and
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Split out functions to extract the virtual address parameters.
Let the functions choose T0 or T1 address space half, if present.
Extract (most of) the control bits that vary between EL or Tx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 274 ++++++++++++++++++++++++--------------------
 1 file changed, 147 insertions(+), 127 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index be8daefc46..99ceed2cab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9754,6 +9754,123 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
 
+typedef struct ARMVAParameters {
+    unsigned tsz    : 8;
+    unsigned select : 1;
+    bool tbi        : 1;
+    bool epd        : 1;
+    bool hpd        : 1;
+    bool ha         : 1;
+    bool hd         : 1;
+    bool using16k   : 1;
+    bool using64k   : 1;
+} ARMVAParameters;
+
+static ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                          ARMMMUIdx mmu_idx, bool data)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+    uint32_t el = regime_el(env, mmu_idx);
+    bool tbi, tbid, epd, hpd, ha, hd, using16k, using64k;
+    int select, tsz;
+
+    /* Bit 55 is always between the two regions, and is canonical for
+     * determining if address tagging is enabled.
+     */
+    select = extract64(va, 55, 1);
+
+    if (el > 1) {
+        tsz = extract32(tcr, 0, 6);
+        using64k = extract32(tcr, 14, 1);
+        using16k = extract32(tcr, 15, 1);
+        tbi = extract32(tcr, 20, 1);
+        ha = extract32(tcr, 21, 1);
+        hd = extract32(tcr, 22, 1);
+        hpd = extract32(tcr, 24, 1);
+        tbid = extract32(tcr, 29, 1);
+        epd = false;
+    } else if (!select) {
+        tsz = extract32(tcr, 0, 6);
+        epd = extract32(tcr, 7, 1);
+        using64k = extract32(tcr, 14, 1);
+        using16k = extract32(tcr, 15, 1);
+        tbi = extract64(tcr, 37, 1);
+        ha = extract64(tcr, 39, 1);
+        hd = extract64(tcr, 40, 1);
+        hpd = extract64(tcr, 41, 1);
+        tbid = extract64(tcr, 51, 1);
+    } else {
+        int tg = extract32(tcr, 30, 2);
+        using16k = tg == 1;
+        using64k = tg == 3;
+        tsz = extract32(tcr, 16, 6);
+        epd = extract32(tcr, 23, 1);
+        tbi = extract64(tcr, 38, 1);
+        ha = extract64(tcr, 39, 1);
+        hd = extract64(tcr, 40, 1);
+        hpd = extract64(tcr, 42, 1);
+        tbid = extract64(tcr, 52, 1);
+    }
+    tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
+    tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
+
+    return (ARMVAParameters) {
+        .tsz = tsz,
+        .select = select,
+        .tbi = tbi & (data | !tbid),
+        .epd = epd,
+        .hpd = hpd,
+        .ha = ha,
+        .hd = hd,
+        .using16k = using16k,
+        .using64k = using64k,
+    };
+}
+
+static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
+                                          ARMMMUIdx mmu_idx)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+    int select, tsz;
+    bool epd, hpd;
+
+    if (mmu_idx == ARMMMUIdx_S2NS) {
+        tsz = sextract32(tcr, 0, 4) + 8;
+        select = 0;
+        hpd = false;
+        epd = false;
+    } else {
+        int t0sz = extract32(tcr, 0, 3);
+        int t1sz = extract32(tcr, 16, 3);
+
+        if (t1sz == 0) {
+            select = va > (0xffffffffu >> t0sz);
+        } else {
+            /* Note that we will detect errors later.  */
+            select = va >= ~(0xffffffffu >> t1sz);
+        }
+
+        if (!select) {
+            tsz = t0sz;
+            epd = extract32(tcr, 7, 1);
+            hpd = extract64(tcr, 41, 1);
+        } else {
+            tsz = t1sz;
+            epd = extract32(tcr, 23, 1);
+            hpd = extract64(tcr, 42, 1);
+        }
+        /* For aarch32, hpd0 is not enabled without t2e as well.  */
+        hpd &= extract32(tcr, 6, 1);
+    }
+
+    return (ARMVAParameters) {
+        .tsz = tsz,
+        .select = select,
+        .epd = epd,
+        .hpd = hpd,
+    };
+}
+
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
@@ -9765,26 +9882,20 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     /* Read an LPAE long-descriptor translation table. */
     ARMFaultType fault_type = ARMFault_Translation;
     uint32_t level;
-    uint32_t epd = 0;
-    int32_t t0sz, t1sz;
-    uint32_t tg;
+    ARMVAParameters param;
     uint64_t ttbr;
-    int ttbr_select;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
     target_ulong page_size;
     uint32_t attrs;
-    int32_t stride = 9;
-    int32_t addrsize;
-    int inputsize;
-    int32_t tbi = 0;
+    int32_t stride;
+    int top_bit, inputsize;
     TCR *tcr = regime_tcr(env, mmu_idx);
     int ap, ns, xn, pxn;
     uint32_t el = regime_el(env, mmu_idx);
-    bool ttbr1_valid = true;
+    bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
-    bool hpd = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -9793,91 +9904,43 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
      * support for those page table walks.
      */
     if (aarch64) {
+        param = aa64_va_parameters(env, address, mmu_idx,
+                                   access_type != MMU_INST_FETCH);
         level = 0;
-        addrsize = 64;
-        if (el > 1) {
-            if (mmu_idx != ARMMMUIdx_S2NS) {
-                tbi = extract64(tcr->raw_tcr, 20, 1);
-            }
-        } else {
-            if (extract64(address, 55, 1)) {
-                tbi = extract64(tcr->raw_tcr, 38, 1);
-            } else {
-                tbi = extract64(tcr->raw_tcr, 37, 1);
-            }
-        }
-        tbi *= 8;
-
         /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mark it
          * invalid.
          */
-        if (el > 1) {
-            ttbr1_valid = false;
-        }
+        ttbr1_valid = (el < 1);
     } else {
+        param = aa32_va_parameters(env, address, mmu_idx);
         level = 1;
-        addrsize = 32;
         /* There is no TTBR1 for EL2 */
-        if (el == 2) {
-            ttbr1_valid = false;
-        }
+        ttbr1_valid = (el != 2);
     }
 
-    /* Determine whether this address is in the region controlled by
-     * TTBR0 or TTBR1 (or if it is in neither region and should fault).
-     * This is a Non-secure PL0/1 stage 1 translation, so controlled by
-     * TTBCR/TTBR0/TTBR1 in accordance with ARM ARM DDI0406C table B-32:
+    top_bit = (aarch64 ? 64 : 32);
+    inputsize = top_bit - param.tsz;
+    top_bit -= 8 * param.tbi;
+
+    /* We determined the region when collecting the parameters, but we
+     * have not yet validated that the address is valid for the region.
      */
-    if (aarch64) {
-        /* AArch64 translation.  */
-        t0sz = extract32(tcr->raw_tcr, 0, 6);
-        t0sz = MIN(t0sz, 39);
-        t0sz = MAX(t0sz, 16);
-    } else if (mmu_idx != ARMMMUIdx_S2NS) {
-        /* AArch32 stage 1 translation.  */
-        t0sz = extract32(tcr->raw_tcr, 0, 3);
-    } else {
-        /* AArch32 stage 2 translation.  */
-        bool sext = extract32(tcr->raw_tcr, 4, 1);
-        bool sign = extract32(tcr->raw_tcr, 3, 1);
-        /* Address size is 40-bit for a stage 2 translation,
-         * and t0sz can be negative (from -8 to 7),
-         * so we need to adjust it to use the TTBR selecting logic below.
-         */
-        addrsize = 40;
-        t0sz = sextract32(tcr->raw_tcr, 0, 4) + 8;
-
-        /* If the sign-extend bit is not the same as t0sz[3], the result
-         * is unpredictable. Flag this as a guest error.  */
-        if (sign != sext) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "AArch32: VTCR.S / VTCR.T0SZ[3] mismatch\n");
-        }
-    }
-    t1sz = extract32(tcr->raw_tcr, 16, 6);
-    if (aarch64) {
-        t1sz = MIN(t1sz, 39);
-        t1sz = MAX(t1sz, 16);
-    }
-    if (t0sz && !extract64(address, addrsize - t0sz, t0sz - tbi)) {
-        /* there is a ttbr0 region and we are in it (high bits all zero) */
-        ttbr_select = 0;
-    } else if (ttbr1_valid && t1sz &&
-               !extract64(~address, addrsize - t1sz, t1sz - tbi)) {
-        /* there is a ttbr1 region and we are in it (high bits all one) */
-        ttbr_select = 1;
-    } else if (!t0sz) {
-        /* ttbr0 region is "everything not in the ttbr1 region" */
-        ttbr_select = 0;
-    } else if (!t1sz && ttbr1_valid) {
-        /* ttbr1 region is "everything not in the ttbr0 region" */
-        ttbr_select = 1;
-    } else {
-        /* in the gap between the two regions, this is a Translation fault */
+    if (param.select
+        ? extract64(~address, inputsize, top_bit - inputsize) || !ttbr1_valid
+        : extract64(address, inputsize, top_bit - inputsize)) {
+        /* In the gap between the two regions, this is a Translation fault */
         fault_type = ARMFault_Translation;
         goto do_fault;
     }
 
+    if (param.using64k) {
+        stride = 13;
+    } else if (param.using16k) {
+        stride = 11;
+    } else {
+        stride = 9;
+    }
+
     /* Note that QEMU ignores shareability and cacheability attributes,
      * so we don't need to do anything with the SH, ORGN, IRGN fields
      * in the TTBCR.  Similarly, TTBCR:A1 selects whether we get the
@@ -9885,56 +9948,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
      * implement any ASID-like capability so we can ignore it (instead
      * we will always flush the TLB any time the ASID is changed).
      */
-    if (ttbr_select == 0) {
-        ttbr = regime_ttbr(env, mmu_idx, 0);
-        if (el < 2) {
-            epd = extract32(tcr->raw_tcr, 7, 1);
-        }
-        inputsize = addrsize - t0sz;
-
-        tg = extract32(tcr->raw_tcr, 14, 2);
-        if (tg == 1) { /* 64KB pages */
-            stride = 13;
-        }
-        if (tg == 2) { /* 16KB pages */
-            stride = 11;
-        }
-        if (aarch64 && el > 1) {
-            hpd = extract64(tcr->raw_tcr, 24, 1);
-        } else {
-            hpd = extract64(tcr->raw_tcr, 41, 1);
-        }
-        if (!aarch64) {
-            /* For aarch32, hpd0 is not enabled without t2e as well.  */
-            hpd &= extract64(tcr->raw_tcr, 6, 1);
-        }
-    } else {
-        /* We should only be here if TTBR1 is valid */
-        assert(ttbr1_valid);
-
-        ttbr = regime_ttbr(env, mmu_idx, 1);
-        epd = extract32(tcr->raw_tcr, 23, 1);
-        inputsize = addrsize - t1sz;
-
-        tg = extract32(tcr->raw_tcr, 30, 2);
-        if (tg == 3)  { /* 64KB pages */
-            stride = 13;
-        }
-        if (tg == 1) { /* 16KB pages */
-            stride = 11;
-        }
-        hpd = extract64(tcr->raw_tcr, 42, 1);
-        if (!aarch64) {
-            /* For aarch32, hpd1 is not enabled without t2e as well.  */
-            hpd &= extract64(tcr->raw_tcr, 6, 1);
-        }
-    }
+    ttbr = regime_ttbr(env, mmu_idx, param.select);
 
     /* Here we should have set up all the parameters for the translation:
      * inputsize, ttbr, epd, stride, tbi
      */
 
-    if (epd) {
+    if (param.epd) {
         /* Translation table walk disabled => Translation fault on TLB miss
          * Note: This is always 0 on 64-bit EL2 and EL3.
          */
@@ -10047,7 +10067,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
-        if (hpd) {
+        if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
         }
-- 
2.17.2
