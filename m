Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929CC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9A22070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUQ7OYQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9A22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCEu-0002ZW-N1
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC36-0001p1-F7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC33-0006Tm-GL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC32-0006RK-WD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id y25so35358pfn.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ITiSi2RLqhYUiFxJMkeBvHtUt4UbgRa64Bukhjjf9rQ=;
 b=oUQ7OYQVr9h4DuIc26x6QTqDM8AXAg7CQT/qY/Xc850OcxrA22pUGqDfbZRkZwNLXK
 EYnQ+fHQQ+wvBmRB8UBDL3zovey0xO34+m3GiybhgPK34tDDHD2v4yUIuAkJ7qko42D2
 3VZt1G2/vxr4uPmZ1Ezy2M5enuPCwY0mgcICHkOEHkLcWIMuhcQqrThboWudzX2E1J4r
 kD+kfNTwK8SrkdYCdOkXQ0bAH/+BDtPKx5j1UBI12bCOqnlT4IQ9enefGlf7FhPiVxgY
 nvmrwL/l7OUvbbTKoKcy0rrF9r2a8tf7Rmc6s2s3bdlwr2Lxam6cLLwWxRXzkdV5lMiF
 3qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ITiSi2RLqhYUiFxJMkeBvHtUt4UbgRa64Bukhjjf9rQ=;
 b=d9zKzfLHLfTaxEYtqTqH/wntRUDcUVb8WeiFm/DqLSAwYGT59lFxjVuK0m/bzydUu/
 LLSOzeyu1lPC4eCaqQfg5hTrbmIol16y/AreFbi3ewxhu1NsouJjqu4TyQt63QgS2u0A
 iw549OYLqLoOaqJYDLHTgd9gF7QpI76bHXw8Ar5uw1mJbdXZOEzsTwWcCZl56BmwDEdj
 a76wA3vU/ovKF1pYtf/VUfGhgcWvIUxYPGzRYxRszGvDssfLeIOAJzmNzAk4ET9sJggq
 NkHZyqoV2RvVh7dwBYQ9iuHeqXce/2qGlGcnUW+8BJNz0xckXlE8YRH1kEoW9ZOrx5u+
 pZcw==
X-Gm-Message-State: AGi0PubkiTQdOxZJOMM0o4Uh/RSCB5iwhHgLBJnUHlMPh9qgMxRsSz2t
 7GWUmvOn+Q9EH8emiGSoVbECrpi6o+s=
X-Google-Smtp-Source: APiQypKmFgQS3qFDqfImYPjNH3axnO/vetWUJZnI+ETAcmvS/Ps4Ms04DJuXOJBuxMotAbr2NHiDFA==
X-Received: by 2002:a63:de49:: with SMTP id y9mr3829010pgi.435.1588264106859; 
 Thu, 30 Apr 2020 09:28:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/18] target/arm: Add sve infrastructure for page lookup
Date: Thu, 30 Apr 2020 09:28:03 -0700
Message-Id: <20200430162813.17671-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For contiguous predicated memory operations, we want to
minimize the number of tlb lookups performed.  We have
open-coded this for sve_ld1_r, but for correctness with
MTE we will need this for all of the memory operations.

Create a structure that holds the bounds of active elements,
and metadata for two pages.  Add routines to find those
active elements, lookup the pages, and run watchpoints
for those pages.

Temporarily mark the functions unused to avoid Werror.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 263 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 261 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aad2c8c237..2f053a9152 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1630,7 +1630,7 @@ void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
     }
 }
 
-/* Big-endian hosts need to frob the byte indicies.  If the copy
+/* Big-endian hosts need to frob the byte indices.  If the copy
  * happens to be 8-byte aligned, then no frobbing necessary.
  */
 static void swap_memmove(void *vd, void *vs, size_t n)
@@ -3974,7 +3974,7 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
 /*
  * Load elements into @vd, controlled by @vg, from @host + @mem_ofs.
  * Memory is valid through @host + @mem_max.  The register element
- * indicies are inferred from @mem_ofs, as modified by the types for
+ * indices are inferred from @mem_ofs, as modified by the types for
  * which the helper is built.  Return the @mem_ofs of the first element
  * not loaded (which is @mem_max if they are all loaded).
  *
@@ -4133,6 +4133,265 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
     return MIN(split, mem_max - mem_off) + mem_off;
 }
 
+/*
+ * Resolve the guest virtual address to info->host and info->flags.
+ * If @nofault, return false if the page is invalid, otherwise
+ * exit via page fault exception.
+ */
+
+typedef struct {
+    void *host;
+    int flags;
+    MemTxAttrs attrs;
+} SVEHostPage;
+
+static bool sve_probe_page(SVEHostPage *info, bool nofault,
+                           CPUARMState *env, target_ulong addr,
+                           int mem_off, MMUAccessType access_type,
+                           int mmu_idx, uintptr_t retaddr)
+{
+    int flags;
+
+    addr += mem_off;
+    flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
+                               &info->host, retaddr);
+    info->flags = flags;
+
+    if (flags & TLB_INVALID_MASK) {
+        g_assert(nofault);
+        return false;
+    }
+
+    /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
+    info->host -= mem_off;
+
+#ifdef CONFIG_USER_ONLY
+    memset(&info->attrs, 0, sizeof(info->attrs));
+#else
+    /*
+     * Find the iotlbentry for addr and return the transaction attributes.
+     * This *must* be present in the TLB because we just found the mapping.
+     */
+    {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+
+# ifdef CONFIG_DEBUG_TCG
+        CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+        target_ulong comparator = (access_type == MMU_DATA_LOAD
+                                   ? entry->addr_read
+                                   : tlb_addr_write(entry));
+        g_assert(tlb_hit(comparator, addr));
+# endif
+
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+        info->attrs = iotlbentry->attrs;
+    }
+#endif
+
+    return true;
+}
+
+
+/*
+ * Analyse contiguous data, protected by a governing predicate.
+ */
+
+typedef enum {
+    FAULT_NO,
+    FAULT_FIRST,
+    FAULT_ALL,
+} SVEContFault;
+
+typedef struct {
+    /*
+     * First and last element wholly contained within the two pages.
+     * mem_off_first[0] and reg_off_first[0] are always set >= 0.
+     * reg_off_last[0] may be < 0 if the first element crosses pages.
+     * All of mem_off_first[1], reg_off_first[1] and reg_off_last[1]
+     * are set >= 0 only if there are complete elements on a second page.
+     *
+     * The reg_off_* offsets are relative to the internal vector register.
+     * The mem_off_first offset is relative to the memory address; the
+     * two offsets are different when a load operation extends, a store
+     * operation truncates, or for multi-register operations.
+     */
+    int16_t mem_off_first[2];
+    int16_t reg_off_first[2];
+    int16_t reg_off_last[2];
+
+    /*
+     * One element that is misaligned and spans both pages,
+     * or -1 if there is no such active element.
+     */
+    int16_t mem_off_split;
+    int16_t reg_off_split;
+
+    /*
+     * The byte offset at which the entire operation crosses a page boundary.
+     * Set >= 0 if and only if the entire operation spans two pages.
+     */
+    int16_t page_split;
+
+    /* TLB data for the two pages. */
+    SVEHostPage page[2];
+} SVEContLdSt;
+
+/*
+ * Find first active element on each page, and a loose bound for the
+ * final element on each page.  Identify any single element that spans
+ * the page boundary.  Return true if there are any active elements.
+ */
+static bool __attribute__((unused))
+sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
+                       intptr_t reg_max, int esz, int msize)
+{
+    const int esize = 1 << esz;
+    const uint64_t pg_mask = pred_esz_masks[esz];
+    intptr_t reg_off_first = -1, reg_off_last = -1, reg_off_split;
+    intptr_t mem_off_last, mem_off_split;
+    intptr_t page_split, elt_split;
+    intptr_t i;
+
+    /* Set all of the element indices to -1, and the TLB data to 0. */
+    memset(info, -1, offsetof(SVEContLdSt, page));
+    memset(info->page, 0, sizeof(info->page));
+
+    /* Gross scan over the entire predicate to find bounds. */
+    i = 0;
+    do {
+        uint64_t pg = vg[i] & pg_mask;
+        if (pg) {
+            reg_off_last = i * 64 + 63 - clz64(pg);
+            if (reg_off_first < 0) {
+                reg_off_first = i * 64 + ctz64(pg);
+            }
+        }
+    } while (++i * 64 < reg_max);
+
+    if (unlikely(reg_off_first < 0)) {
+        /* No active elements, no pages touched. */
+        return false;
+    }
+    tcg_debug_assert(reg_off_last >= 0 && reg_off_last < reg_max);
+
+    info->reg_off_first[0] = reg_off_first;
+    info->mem_off_first[0] = (reg_off_first >> esz) * msize;
+    mem_off_last = (reg_off_last >> esz) * msize;
+
+    page_split = -(addr | TARGET_PAGE_MASK);
+    if (likely(mem_off_last + msize <= page_split)) {
+        /* The entire operation fits within a single page. */
+        info->reg_off_last[0] = reg_off_last;
+        return true;
+    }
+
+    info->page_split = page_split;
+    elt_split = page_split / msize;
+    reg_off_split = elt_split << esz;
+    mem_off_split = elt_split * msize;
+
+    /*
+     * This is the last full element on the first page, but it is not
+     * necessarily active.  If there is no full element, i.e. the first
+     * active element is the one that's split, this value remains -1.
+     * It is useful as iteration bounds.
+     */
+    if (elt_split != 0) {
+        info->reg_off_last[0] = reg_off_split - esize;
+    }
+
+    /* Determine if an unaligned element spans the pages.  */
+    if (page_split % msize != 0) {
+        /* It is helpful to know if the split element is active. */
+        if ((vg[reg_off_split >> 6] >> (reg_off_split & 63)) & 1) {
+            info->reg_off_split = reg_off_split;
+            info->mem_off_split = mem_off_split;
+
+            if (reg_off_split == reg_off_last) {
+                /* The page crossing element is last. */
+                return true;
+            }
+        }
+        reg_off_split += esize;
+        mem_off_split += msize;
+    }
+
+    /*
+     * We do want the first active element on the second page, because
+     * this may affect the address reported in an exception.
+     */
+    reg_off_split = find_next_active(vg, reg_off_split, reg_max, esz);
+    tcg_debug_assert(reg_off_split <= reg_off_last);
+    info->reg_off_first[1] = reg_off_split;
+    info->mem_off_first[1] = (reg_off_split >> esz) * msize;
+    info->reg_off_last[1] = reg_off_last;
+    return true;
+}
+
+/*
+ * Resolve the guest virtual addresses to info->page[].
+ * Control the generation of page faults with @fault.  Return false if
+ * there is no work to do, which can only happen with @fault == FAULT_NO.
+ */
+static bool __attribute__((unused))
+sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault, CPUARMState *env,
+                    target_ulong addr, MMUAccessType access_type,
+                    uintptr_t retaddr)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    int mem_off = info->mem_off_first[0];
+    bool nofault = fault == FAULT_NO;
+    bool have_work = true;
+
+    if (!sve_probe_page(&info->page[0], nofault, env, addr, mem_off,
+                        access_type, mmu_idx, retaddr)) {
+        /* No work to be done. */
+        return false;
+    }
+
+    if (likely(info->page_split < 0)) {
+        /* The entire operation was on the one page. */
+        return true;
+    }
+
+    /*
+     * If the second page is invalid, then we want the fault address to be
+     * the first byte on that page which is accessed.
+     */
+    if (info->mem_off_split >= 0) {
+        /*
+         * There is an element split across the pages.  The fault address
+         * should be the first byte of the second page.
+         */
+        mem_off = info->page_split;
+        /*
+         * If the split element is also the first active element
+         * of the vector, then:  For first-fault we should continue
+         * to generate faults for the second page.  For no-fault,
+         * we have work only if the second page is valid.
+         */
+        if (info->mem_off_first[0] < info->mem_off_split) {
+            nofault = FAULT_FIRST;
+            have_work = false;
+        }
+    } else {
+        /*
+         * There is no element split across the pages.  The fault address
+         * should be the first active element on the second page.
+         */
+        mem_off = info->mem_off_first[1];
+        /*
+         * There must have been one active element on the first page,
+         * so we're out of first-fault territory.
+         */
+        nofault = fault != FAULT_ALL;
+    }
+
+    have_work |= sve_probe_page(&info->page[1], nofault, env, addr, mem_off,
+                                access_type, mmu_idx, retaddr);
+    return have_work;
+}
+
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
  * which is always non-null.  Elide the useless test.
-- 
2.20.1


