Received: from eggs.gnu.org ([209.51.188.92]:43137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbZ-0002pJ-3K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007My-MP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Ic-AW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id s12so15434757wrt.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:38 +0000
Message-Id: <20190118145805.6852-23-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/49] target/arm: Create ARMVAParameters and
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out functions to extract the virtual address parameters.
Let the functions choose T0 or T1 address space half, if present.
Extract (most of) the control bits that vary between EL or Tx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-19-richard.henderson@linaro.org
[PMM: fixed minor checkpatch comment nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  14 +++
 target/arm/helper.c    | 278 ++++++++++++++++++++++-------------------
 2 files changed, 164 insertions(+), 128 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 248fdf7a3c0..fdda2c866a3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -942,4 +942,18 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
+/*
+ * Parameters of a given virtual address, as extracted from the
+ * translation control register (TCR) for a given regime.
+ */
+typedef struct ARMVAParameters {
+    unsigned tsz    : 8;
+    unsigned select : 1;
+    bool tbi        : 1;
+    bool epd        : 1;
+    bool hpd        : 1;
+    bool using16k   : 1;
+    bool using64k   : 1;
+} ARMVAParameters;
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 35bbc7f1091..f09404e931f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9744,6 +9744,124 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
 
+static ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                          ARMMMUIdx mmu_idx, bool data)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+    uint32_t el = regime_el(env, mmu_idx);
+    bool tbi, epd, hpd, using16k, using64k;
+    int select, tsz;
+
+    /*
+     * Bit 55 is always between the two regions, and is canonical for
+     * determining if address tagging is enabled.
+     */
+    select = extract64(va, 55, 1);
+
+    if (el > 1) {
+        tsz = extract32(tcr, 0, 6);
+        using64k = extract32(tcr, 14, 1);
+        using16k = extract32(tcr, 15, 1);
+        if (mmu_idx == ARMMMUIdx_S2NS) {
+            /* VTCR_EL2 */
+            tbi = hpd = false;
+        } else {
+            tbi = extract32(tcr, 20, 1);
+            hpd = extract32(tcr, 24, 1);
+        }
+        epd = false;
+    } else if (!select) {
+        tsz = extract32(tcr, 0, 6);
+        epd = extract32(tcr, 7, 1);
+        using64k = extract32(tcr, 14, 1);
+        using16k = extract32(tcr, 15, 1);
+        tbi = extract64(tcr, 37, 1);
+        hpd = extract64(tcr, 41, 1);
+    } else {
+        int tg = extract32(tcr, 30, 2);
+        using16k = tg == 1;
+        using64k = tg == 3;
+        tsz = extract32(tcr, 16, 6);
+        epd = extract32(tcr, 23, 1);
+        tbi = extract64(tcr, 38, 1);
+        hpd = extract64(tcr, 42, 1);
+    }
+    tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
+    tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
+
+    return (ARMVAParameters) {
+        .tsz = tsz,
+        .select = select,
+        .tbi = tbi,
+        .epd = epd,
+        .hpd = hpd,
+        .using16k = using16k,
+        .using64k = using64k,
+    };
+}
+
+static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
+                                          ARMMMUIdx mmu_idx)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+    uint32_t el = regime_el(env, mmu_idx);
+    int select, tsz;
+    bool epd, hpd;
+
+    if (mmu_idx == ARMMMUIdx_S2NS) {
+        /* VTCR */
+        bool sext = extract32(tcr, 4, 1);
+        bool sign = extract32(tcr, 3, 1);
+
+        /*
+         * If the sign-extend bit is not the same as t0sz[3], the result
+         * is unpredictable. Flag this as a guest error.
+         */
+        if (sign != sext) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "AArch32: VTCR.S / VTCR.T0SZ[3] mismatch\n");
+        }
+        tsz = sextract32(tcr, 0, 4) + 8;
+        select = 0;
+        hpd = false;
+        epd = false;
+    } else if (el == 2) {
+        /* HTCR */
+        tsz = extract32(tcr, 0, 3);
+        select = 0;
+        hpd = extract64(tcr, 24, 1);
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
@@ -9755,26 +9873,20 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
-    target_ulong page_size;
+    target_ulong page_size, top_bits;
     uint32_t attrs;
-    int32_t stride = 9;
-    int32_t addrsize;
-    int inputsize;
-    int32_t tbi = 0;
+    int32_t stride;
+    int addrsize, inputsize;
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
@@ -9783,91 +9895,44 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
+        ttbr1_valid = (el < 2);
+        addrsize = 64 - 8 * param.tbi;
+        inputsize = 64 - param.tsz;
     } else {
+        param = aa32_va_parameters(env, address, mmu_idx);
         level = 1;
-        addrsize = 32;
         /* There is no TTBR1 for EL2 */
-        if (el == 2) {
-            ttbr1_valid = false;
-        }
+        ttbr1_valid = (el != 2);
+        addrsize = (mmu_idx == ARMMMUIdx_S2NS ? 40 : 32);
+        inputsize = addrsize - param.tsz;
     }
 
-    /* Determine whether this address is in the region controlled by
-     * TTBR0 or TTBR1 (or if it is in neither region and should fault).
-     * This is a Non-secure PL0/1 stage 1 translation, so controlled by
-     * TTBCR/TTBR0/TTBR1 in accordance with ARM ARM DDI0406C table B-32:
+    /*
+     * We determined the region when collecting the parameters, but we
+     * have not yet validated that the address is valid for the region.
+     * Extract the top bits and verify that they all match select.
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
+    top_bits = sextract64(address, inputsize, addrsize - inputsize);
+    if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
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
@@ -9875,56 +9940,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -10037,7 +10059,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
-        if (hpd) {
+        if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
         }
-- 
2.20.1
