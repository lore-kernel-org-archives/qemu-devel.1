Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A21C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AB120873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPCy48Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AB120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvEh-0001yu-G1
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6h-0006SS-47
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6e-00022a-VV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:43 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6e-00022B-NE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id w12so604769pll.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x3t5PDoyjO7TC0DW2CC4BuCDJWVwgzq1cMlGkXCUhYU=;
 b=KPCy48BoRzZwRXMbdj1MeiGeFlCbpdtdfvqD8a6aYnpYkxsEFudnzhwI1zWvZqOGhl
 lG2fZwjmhLVCnB2tuuZoP1iFc8FHWmE5mnfpW2jL/pj3dwv4xoiAo1ZGbH7OTZCfpfbO
 LFS4r+MrmmSdOQUM6fDsWxhi7F3RR15G75YBsSA3wvbgnsMeVPpW2OcG4DyxhqZPPF4L
 iwglr61/imuf1IzXuAif8S2dbkKyeyh4LiLzJhm9GEzAc9yuaerZvAiBmCd1RmxxYyfU
 Doa9p59TmJZJR8pLW/QWDkcDeySVCD5lfJel8ehw/V+Bn/0x3pNT4YgY3TBUVyVZCnZm
 cNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x3t5PDoyjO7TC0DW2CC4BuCDJWVwgzq1cMlGkXCUhYU=;
 b=bw+zIG9tPJDNvddyr5zYMAFQoAcGvtf6YOfye5xrtH/6n7c8q8QSg2dakUkVIVxKT5
 UYr79Rn5+uF4V3v1XBJ8g95N2Y5JfkWilWGWtINvk2Y8xROzRW8bJy/567HxrXLjnyQm
 kyad9vjTUaYln79oTM3zq94IZOzalDcloycWUDDQk4SG4H+Wsaa9X+N20zpDxfvSsSfz
 VDRQxSbKjUjEwxfPvY0+6xT59kE5Fit+gT0MgOmWZfhpEiquRgNFXczBCGaeHdvICAI7
 Bp7mmOLsHYtW6BIEztMI506gVzV1K1K16OUSGdDAhpFe6RhLMq1lso+D3roPqJwDa9HH
 6DOA==
X-Gm-Message-State: ANhLgQ3Eeag16M2FVXI5pzTif0pZgXKp5fB16kbilR6QAUPvguzKWp9o
 o54VCzXKf3QIP0gEP8U2G9q3skFmcaU=
X-Google-Smtp-Source: ADFU+vu3vqHLKeiffIrUCl20F6oTly59rHVJ4JKw90gUT05XXNioPijPN5yFOknUzZXMDuG+JqEFIA==
X-Received: by 2002:a17:902:7c0a:: with SMTP id
 x10mr1641782pll.229.1583909079053; 
 Tue, 10 Mar 2020 23:44:39 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] target/arm: Reuse sve_probe_page for gather first-fault
 loads
Date: Tue, 10 Mar 2020 23:44:17 -0700
Message-Id: <20200311064420.30606-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This avoids the need for a separate set of helpers to implement
no-fault semantics, and will enable MTE in the future.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 323 ++++++++++++++++------------------------
 1 file changed, 127 insertions(+), 196 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index c6f22928d5..a33699adf8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5255,231 +5255,162 @@ DO_LD1_ZPZ_D(dd_be, zd)
 
 /* First fault loads with a vector index.  */
 
-/* Load one element into VD+REG_OFF from (ENV,VADDR) without faulting.
- * The controlling predicate is known to be true.  Return true if the
- * load was successful.
- */
-typedef bool sve_ld1_nf_fn(CPUARMState *env, void *vd, intptr_t reg_off,
-                           target_ulong vaddr, int mmu_idx);
-
-#ifdef CONFIG_SOFTMMU
-#define DO_LD_NF(NAME, H, TYPEE, TYPEM, HOST) \
-static bool sve_ld##NAME##_nf(CPUARMState *env, void *vd, intptr_t reg_off, \
-                              target_ulong addr, int mmu_idx)               \
-{                                                                           \
-    target_ulong next_page = -(addr | TARGET_PAGE_MASK);                    \
-    if (likely(next_page - addr >= sizeof(TYPEM))) {                        \
-        void *host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);  \
-        if (likely(host)) {                                                 \
-            TYPEM val = HOST(host);                                         \
-            *(TYPEE *)(vd + H(reg_off)) = val;                              \
-            return true;                                                    \
-        }                                                                   \
-    }                                                                       \
-    return false;                                                           \
-}
-#else
-#define DO_LD_NF(NAME, H, TYPEE, TYPEM, HOST) \
-static bool sve_ld##NAME##_nf(CPUARMState *env, void *vd, intptr_t reg_off, \
-                            target_ulong addr, int mmu_idx)                 \
-{                                                                           \
-    if (likely(page_check_range(addr, sizeof(TYPEM), PAGE_READ))) {         \
-        TYPEM val = HOST(g2h(addr));                                        \
-        *(TYPEE *)(vd + H(reg_off)) = val;                                  \
-        return true;                                                        \
-    }                                                                       \
-    return false;                                                           \
-}
-#endif
-
-DO_LD_NF(bsu, H1_4, uint32_t, uint8_t, ldub_p)
-DO_LD_NF(bss, H1_4, uint32_t,  int8_t, ldsb_p)
-DO_LD_NF(bdu,     , uint64_t, uint8_t, ldub_p)
-DO_LD_NF(bds,     , uint64_t,  int8_t, ldsb_p)
-
-DO_LD_NF(hsu_le, H1_4, uint32_t, uint16_t, lduw_le_p)
-DO_LD_NF(hss_le, H1_4, uint32_t,  int16_t, ldsw_le_p)
-DO_LD_NF(hsu_be, H1_4, uint32_t, uint16_t, lduw_be_p)
-DO_LD_NF(hss_be, H1_4, uint32_t,  int16_t, ldsw_be_p)
-DO_LD_NF(hdu_le,     , uint64_t, uint16_t, lduw_le_p)
-DO_LD_NF(hds_le,     , uint64_t,  int16_t, ldsw_le_p)
-DO_LD_NF(hdu_be,     , uint64_t, uint16_t, lduw_be_p)
-DO_LD_NF(hds_be,     , uint64_t,  int16_t, ldsw_be_p)
-
-DO_LD_NF(ss_le,  H1_4, uint32_t, uint32_t, ldl_le_p)
-DO_LD_NF(ss_be,  H1_4, uint32_t, uint32_t, ldl_be_p)
-DO_LD_NF(sdu_le,     , uint64_t, uint32_t, ldl_le_p)
-DO_LD_NF(sds_le,     , uint64_t,  int32_t, ldl_le_p)
-DO_LD_NF(sdu_be,     , uint64_t, uint32_t, ldl_be_p)
-DO_LD_NF(sds_be,     , uint64_t,  int32_t, ldl_be_p)
-
-DO_LD_NF(dd_le,      , uint64_t, uint64_t, ldq_le_p)
-DO_LD_NF(dd_be,      , uint64_t, uint64_t, ldq_be_p)
-
 /*
- * Common helper for all gather first-faulting loads.
+ * Common helpers for all gather first-faulting loads.
  */
-static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
-                                target_ulong base, uint32_t desc, uintptr_t ra,
-                                zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn,
-                                sve_ld1_nf_fn *nonfault_fn)
+
+static inline QEMU_ALWAYS_INLINE
+void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+                 target_ulong base, uint32_t desc, uintptr_t retaddr,
+                 const int esz, const int msz, zreg_off_fn *off_fn,
+                 sve_ldst1_host_fn *host_fn,
+                 sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
-    const int mmu_idx = get_mmuidx(oi);
+    const int mmu_idx = cpu_mmu_index(env, false);
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t reg_off, reg_max = simd_oprsz(desc);
-    target_ulong addr;
+    const int esize = 1 << esz;
+    const int msize = 1 << msz;
+    const intptr_t reg_max = simd_oprsz(desc);
+    intptr_t reg_off;
+    SVEHostPage info;
+    target_ulong addr, in_page;
 
     /* Skip to the first true predicate.  */
-    reg_off = find_next_active(vg, 0, reg_max, MO_32);
-    if (likely(reg_off < reg_max)) {
-        /* Perform one normal read, which will fault or not.  */
-        addr = off_fn(vm, reg_off);
-        addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, ra);
-
-        /* The rest of the reads will be non-faulting.  */
+    reg_off = find_next_active(vg, 0, reg_max, esz);
+    if (unlikely(reg_off >= reg_max)) {
+        /* The entire predicate was false; no load occurs.  */
+        memset(vd, 0, reg_max);
+        return;
     }
 
-    /* After any fault, zero the leading predicated false elements.  */
+    /*
+     * Probe the first element, allowing faults.
+     */
+    addr = base + (off_fn(vm, reg_off) << scale);
+    tlb_fn(env, vd, reg_off, addr, retaddr);
+
+    /* After any fault, zero the other elements. */
     swap_memzero(vd, reg_off);
+    reg_off += esize;
+    swap_memzero(vd + reg_off, reg_max - reg_off);
 
-    while (likely((reg_off += 4) < reg_max)) {
-        uint64_t pg = *(uint64_t *)(vg + (reg_off >> 6) * 8);
-        if (likely((pg >> (reg_off & 63)) & 1)) {
-            addr = off_fn(vm, reg_off);
-            addr = base + (addr << scale);
-            if (!nonfault_fn(env, vd, reg_off, addr, mmu_idx)) {
-                record_fault(env, reg_off, reg_max);
-                break;
+    /*
+     * Probe the remaining elements, not allowing faults.
+     */
+    while (reg_off < reg_max) {
+        uint64_t pg = vg[reg_off >> 6];
+        do {
+            if (likely((pg >> (reg_off & 63)) & 1)) {
+                addr = base + (off_fn(vm, reg_off) << scale);
+                in_page = -(addr | TARGET_PAGE_MASK);
+
+                if (unlikely(in_page < msize)) {
+                    /* Stop if the element crosses a page boundary. */
+                    goto fault;
+                }
+
+                sve_probe_page(&info, true, env, addr, 0, MMU_DATA_LOAD,
+                               mmu_idx, retaddr);
+                if (unlikely(info.flags & (TLB_INVALID_MASK | TLB_MMIO))) {
+                    goto fault;
+                }
+                if (unlikely(info.flags & TLB_WATCHPOINT) &&
+                    cpu_probe_watchpoint(env_cpu(env), addr, msize,
+                                         BP_MEM_READ)) {
+                    goto fault;
+                }
+                /* TODO: MTE check. */
+
+                host_fn(vd, reg_off, info.host);
             }
-        } else {
-            *(uint32_t *)(vd + H1_4(reg_off)) = 0;
-        }
+            reg_off += esize;
+        } while (reg_off & 63);
     }
+    return;
+
+ fault:
+    record_fault(env, reg_off, reg_max);
 }
 
-static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
-                                target_ulong base, uint32_t desc, uintptr_t ra,
-                                zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn,
-                                sve_ld1_nf_fn *nonfault_fn)
-{
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
-    const int mmu_idx = get_mmuidx(oi);
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t reg_off, reg_max = simd_oprsz(desc);
-    target_ulong addr;
-
-    /* Skip to the first true predicate.  */
-    reg_off = find_next_active(vg, 0, reg_max, MO_64);
-    if (likely(reg_off < reg_max)) {
-        /* Perform one normal read, which will fault or not.  */
-        addr = off_fn(vm, reg_off);
-        addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, ra);
-
-        /* The rest of the reads will be non-faulting.  */
-    }
-
-    /* After any fault, zero the leading predicated false elements.  */
-    swap_memzero(vd, reg_off);
-
-    while (likely((reg_off += 8) < reg_max)) {
-        uint8_t pg = *(uint8_t *)(vg + H1(reg_off >> 3));
-        if (likely(pg & 1)) {
-            addr = off_fn(vm, reg_off);
-            addr = base + (addr << scale);
-            if (!nonfault_fn(env, vd, reg_off, addr, mmu_idx)) {
-                record_fault(env, reg_off, reg_max);
-                break;
-            }
-        } else {
-            *(uint64_t *)(vd + reg_off) = 0;
-        }
-    }
+#define DO_LDFF1_ZPZ_S(MEM, OFS, MSZ) \
+void HELPER(sve_ldff##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                   void *vm, target_ulong base, uint32_t desc) \
+{                                                                              \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), MO_32, MSZ,              \
+                off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LDFF1_ZPZ_S(MEM, OFS) \
-void HELPER(sve_ldff##MEM##_##OFS)                                      \
-    (CPUARMState *env, void *vd, void *vg, void *vm,                    \
-     target_ulong base, uint32_t desc)                                  \
-{                                                                       \
-    sve_ldff1_zs(env, vd, vg, vm, base, desc, GETPC(),                  \
-                 off_##OFS##_s, sve_ld1##MEM##_tlb, sve_ld##MEM##_nf);  \
+#define DO_LDFF1_ZPZ_D(MEM, OFS, MSZ) \
+void HELPER(sve_ldff##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                   void *vm, target_ulong base, uint32_t desc) \
+{                                                                              \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), MO_64, MSZ,              \
+                off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LDFF1_ZPZ_D(MEM, OFS) \
-void HELPER(sve_ldff##MEM##_##OFS)                                      \
-    (CPUARMState *env, void *vd, void *vg, void *vm,                    \
-     target_ulong base, uint32_t desc)                                  \
-{                                                                       \
-    sve_ldff1_zd(env, vd, vg, vm, base, desc, GETPC(),                  \
-                 off_##OFS##_d, sve_ld1##MEM##_tlb, sve_ld##MEM##_nf);  \
-}
+DO_LDFF1_ZPZ_S(bsu, zsu, MO_8)
+DO_LDFF1_ZPZ_S(bsu, zss, MO_8)
+DO_LDFF1_ZPZ_D(bdu, zsu, MO_8)
+DO_LDFF1_ZPZ_D(bdu, zss, MO_8)
+DO_LDFF1_ZPZ_D(bdu, zd, MO_8)
 
-DO_LDFF1_ZPZ_S(bsu, zsu)
-DO_LDFF1_ZPZ_S(bsu, zss)
-DO_LDFF1_ZPZ_D(bdu, zsu)
-DO_LDFF1_ZPZ_D(bdu, zss)
-DO_LDFF1_ZPZ_D(bdu, zd)
+DO_LDFF1_ZPZ_S(bss, zsu, MO_8)
+DO_LDFF1_ZPZ_S(bss, zss, MO_8)
+DO_LDFF1_ZPZ_D(bds, zsu, MO_8)
+DO_LDFF1_ZPZ_D(bds, zss, MO_8)
+DO_LDFF1_ZPZ_D(bds, zd, MO_8)
 
-DO_LDFF1_ZPZ_S(bss, zsu)
-DO_LDFF1_ZPZ_S(bss, zss)
-DO_LDFF1_ZPZ_D(bds, zsu)
-DO_LDFF1_ZPZ_D(bds, zss)
-DO_LDFF1_ZPZ_D(bds, zd)
+DO_LDFF1_ZPZ_S(hsu_le, zsu, MO_16)
+DO_LDFF1_ZPZ_S(hsu_le, zss, MO_16)
+DO_LDFF1_ZPZ_D(hdu_le, zsu, MO_16)
+DO_LDFF1_ZPZ_D(hdu_le, zss, MO_16)
+DO_LDFF1_ZPZ_D(hdu_le, zd, MO_16)
 
-DO_LDFF1_ZPZ_S(hsu_le, zsu)
-DO_LDFF1_ZPZ_S(hsu_le, zss)
-DO_LDFF1_ZPZ_D(hdu_le, zsu)
-DO_LDFF1_ZPZ_D(hdu_le, zss)
-DO_LDFF1_ZPZ_D(hdu_le, zd)
+DO_LDFF1_ZPZ_S(hsu_be, zsu, MO_16)
+DO_LDFF1_ZPZ_S(hsu_be, zss, MO_16)
+DO_LDFF1_ZPZ_D(hdu_be, zsu, MO_16)
+DO_LDFF1_ZPZ_D(hdu_be, zss, MO_16)
+DO_LDFF1_ZPZ_D(hdu_be, zd, MO_16)
 
-DO_LDFF1_ZPZ_S(hsu_be, zsu)
-DO_LDFF1_ZPZ_S(hsu_be, zss)
-DO_LDFF1_ZPZ_D(hdu_be, zsu)
-DO_LDFF1_ZPZ_D(hdu_be, zss)
-DO_LDFF1_ZPZ_D(hdu_be, zd)
+DO_LDFF1_ZPZ_S(hss_le, zsu, MO_16)
+DO_LDFF1_ZPZ_S(hss_le, zss, MO_16)
+DO_LDFF1_ZPZ_D(hds_le, zsu, MO_16)
+DO_LDFF1_ZPZ_D(hds_le, zss, MO_16)
+DO_LDFF1_ZPZ_D(hds_le, zd, MO_16)
 
-DO_LDFF1_ZPZ_S(hss_le, zsu)
-DO_LDFF1_ZPZ_S(hss_le, zss)
-DO_LDFF1_ZPZ_D(hds_le, zsu)
-DO_LDFF1_ZPZ_D(hds_le, zss)
-DO_LDFF1_ZPZ_D(hds_le, zd)
+DO_LDFF1_ZPZ_S(hss_be, zsu, MO_16)
+DO_LDFF1_ZPZ_S(hss_be, zss, MO_16)
+DO_LDFF1_ZPZ_D(hds_be, zsu, MO_16)
+DO_LDFF1_ZPZ_D(hds_be, zss, MO_16)
+DO_LDFF1_ZPZ_D(hds_be, zd, MO_16)
 
-DO_LDFF1_ZPZ_S(hss_be, zsu)
-DO_LDFF1_ZPZ_S(hss_be, zss)
-DO_LDFF1_ZPZ_D(hds_be, zsu)
-DO_LDFF1_ZPZ_D(hds_be, zss)
-DO_LDFF1_ZPZ_D(hds_be, zd)
+DO_LDFF1_ZPZ_S(ss_le,  zsu, MO_32)
+DO_LDFF1_ZPZ_S(ss_le,  zss, MO_32)
+DO_LDFF1_ZPZ_D(sdu_le, zsu, MO_32)
+DO_LDFF1_ZPZ_D(sdu_le, zss, MO_32)
+DO_LDFF1_ZPZ_D(sdu_le, zd, MO_32)
 
-DO_LDFF1_ZPZ_S(ss_le,  zsu)
-DO_LDFF1_ZPZ_S(ss_le,  zss)
-DO_LDFF1_ZPZ_D(sdu_le, zsu)
-DO_LDFF1_ZPZ_D(sdu_le, zss)
-DO_LDFF1_ZPZ_D(sdu_le, zd)
+DO_LDFF1_ZPZ_S(ss_be,  zsu, MO_32)
+DO_LDFF1_ZPZ_S(ss_be,  zss, MO_32)
+DO_LDFF1_ZPZ_D(sdu_be, zsu, MO_32)
+DO_LDFF1_ZPZ_D(sdu_be, zss, MO_32)
+DO_LDFF1_ZPZ_D(sdu_be, zd, MO_32)
 
-DO_LDFF1_ZPZ_S(ss_be,  zsu)
-DO_LDFF1_ZPZ_S(ss_be,  zss)
-DO_LDFF1_ZPZ_D(sdu_be, zsu)
-DO_LDFF1_ZPZ_D(sdu_be, zss)
-DO_LDFF1_ZPZ_D(sdu_be, zd)
+DO_LDFF1_ZPZ_D(sds_le, zsu, MO_32)
+DO_LDFF1_ZPZ_D(sds_le, zss, MO_32)
+DO_LDFF1_ZPZ_D(sds_le, zd, MO_32)
 
-DO_LDFF1_ZPZ_D(sds_le, zsu)
-DO_LDFF1_ZPZ_D(sds_le, zss)
-DO_LDFF1_ZPZ_D(sds_le, zd)
+DO_LDFF1_ZPZ_D(sds_be, zsu, MO_32)
+DO_LDFF1_ZPZ_D(sds_be, zss, MO_32)
+DO_LDFF1_ZPZ_D(sds_be, zd, MO_32)
 
-DO_LDFF1_ZPZ_D(sds_be, zsu)
-DO_LDFF1_ZPZ_D(sds_be, zss)
-DO_LDFF1_ZPZ_D(sds_be, zd)
+DO_LDFF1_ZPZ_D(dd_le, zsu, MO_64)
+DO_LDFF1_ZPZ_D(dd_le, zss, MO_64)
+DO_LDFF1_ZPZ_D(dd_le, zd, MO_64)
 
-DO_LDFF1_ZPZ_D(dd_le, zsu)
-DO_LDFF1_ZPZ_D(dd_le, zss)
-DO_LDFF1_ZPZ_D(dd_le, zd)
-
-DO_LDFF1_ZPZ_D(dd_be, zsu)
-DO_LDFF1_ZPZ_D(dd_be, zss)
-DO_LDFF1_ZPZ_D(dd_be, zd)
+DO_LDFF1_ZPZ_D(dd_be, zsu, MO_64)
+DO_LDFF1_ZPZ_D(dd_be, zss, MO_64)
+DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 
 /* Stores with a vector index.  */
 
-- 
2.20.1


