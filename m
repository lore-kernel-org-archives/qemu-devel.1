Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F342C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310B2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZqbA0JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7Gx-0003U5-Fr
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74t-00016f-5z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74n-00062l-SE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:38 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74n-0005wZ-Do
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:33 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 7so2013736pjo.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=35NWN1irvYiuaoiJYNZapdYKg3V0iP81B2LwiXyBGUY=;
 b=FZqbA0JUkwdhCxOIhLjbuQgHhmSCGJwX27BCr3k6fQE/42saBtMTFfrsnbGG4g6vFl
 0FRdORAVevp2wlHvlYNbjLasYWV7eVLTXPKdqpe89Ww2kkofb798WuPtcSKTKFhfpG66
 cUUUTIIZWIpff8lw+I4SlMM1VLWrxhMGoHhh11Jqeww6CqDzypOI4KeZ1TSu3MiF50DN
 iPVfZnDF0YZj9Z3Q/0gFy+4ELVqKGD5tpIo+OknxZzX76DZEO3egreqEC2byVpF9QrUF
 7Fwxb3vJB5A0RBOLBeYB3l49abdIicyMODqhyizvpTv6bknx1FpzXm4rAQ/HMJN4ZHqY
 APNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=35NWN1irvYiuaoiJYNZapdYKg3V0iP81B2LwiXyBGUY=;
 b=BNN9z+r4k/OoBHG2ieCsndYJjiIKClHY2tQB6SeHFfg2FJL31NpkuRLjrazjsrkG18
 vrqder0K6IxQNs3sY+SIz4LdxQms4YTio2P7anYnnXxJGIvOsFaA4OEptjTQu5Z9sVJt
 ezIS+KG70kIDfg+QLnMdV28ssoiLl2vwqj86jkHuINVTQ1fOjAWzvVHg4yt3cu1ofufX
 cZDKBnupaP0Np5/uo3+krby55DunIswtE7l1UDehWMYmzaQrXTdJj/WfVVWKst9bSQwY
 3jXXp9T4gXSackRXxGOkdXkqmfPRd1CgMjbsYRnzcq9at1TEoz9G7RawI4HIGsFe8Z2j
 kEUg==
X-Gm-Message-State: AGi0PuYJIYuBbi4s3YFLzw9M0qeAJlHQ6gX3zzqTu1gFNwdrXWAGLwZT
 QRGknZ+fG5/d7jZki1ahXR9PEDH3UF4=
X-Google-Smtp-Source: APiQypLLPMN9/m2M9SFflaRSi5HCk9D5GotViGTvYxiF1sLeRLpM+pXdQS/TaYH/E0ZOT0BQ87SlRg==
X-Received: by 2002:a17:90a:718c:: with SMTP id
 i12mr9646155pjk.142.1587530011413; 
 Tue, 21 Apr 2020 21:33:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/18] target/arm: Reuse sve_probe_page for gather
 first-fault loads
Date: Tue, 21 Apr 2020 21:33:06 -0700
Message-Id: <20200422043309.18430-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 323 ++++++++++++++++------------------------
 1 file changed, 127 insertions(+), 196 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9389c7c76d..6229ea65c0 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5250,231 +5250,162 @@ DO_LD1_ZPZ_D(dd_be, zd)
 
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
+                    (cpu_watchpoint_address_matches
+                     (env_cpu(env), addr, msize) & BP_MEM_READ)) {
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


