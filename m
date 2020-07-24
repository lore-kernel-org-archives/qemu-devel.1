Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E4CC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1167F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6O/w9gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1167F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz3jr-0000Wk-8q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 15:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xDsbXwMKCqcZJdNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--scw.bounces.google.com>)
 id 1jz3jF-0008R7-0N
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:51:37 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:39248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xDsbXwMKCqcZJdNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--scw.bounces.google.com>)
 id 1jz3jC-0005VH-Nn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:51:36 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id e196so7603112ybh.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=5kTldTUahb9hanRev110jm8tKPEE4Mv5hUBvGw1c6J4=;
 b=Q6O/w9gv3SSskvDZbygnRq9aa+MfX4k8VbxQah+/U7+26gt4gQKuknjY15+R6CPAew
 53NKHJsSCTKiOuNY/1D4wLYgo9Z7EXAFPJxSl16DlVa++JEF4/gEyUEnBFj3Xls/YQDI
 wdfWwcsT354b6zVpqi4w0t5klbuRufjw99ig4hFil4YTb04OLhIRP9Wk2XFDhcAG/Inu
 ramagqriXk2IPXzVr0c9U9o7lFcGaHHgnHhEAVbnfq6eLtu+DgZcyYXPte7c8s0wlQWK
 oJbfoMPzkx9BoR9WcZxFhghru+8Qj/Y6RjaXptqo20M9cRVDaW4vvFUpJZnc9dMDdx+u
 GJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=5kTldTUahb9hanRev110jm8tKPEE4Mv5hUBvGw1c6J4=;
 b=et6/UA5y0XrAwVD4mVYyN0uxZAmu93kLrqDm1UhuU21AXtb4w8+SscW+hN9btczMno
 21qucAaXm1blshtt0fRd6ySB7ZfxORPAagllWEYZsV0pMSALsrWfj1QTpNt00dHPbW/T
 03vjPtg+QPk//IGX0EhC4vmqZ7hELgaRVR8kDHtUg9tzZY6O9uOCEKqChOOA6oxEgJw4
 2cZ99Rn4t+aajvdZxJxqCPdZ98m28p0+Gfqy50t/nqs0GI4g8sPk4gZmnJ9jLeKfhHOI
 SFwCns0JUGTC1gk1lZfIx+j920zL0Y6MS/4pWjgVUZ2yqW+wvnJeCjZ9ht/35CtvpdI+
 s6vQ==
X-Gm-Message-State: AOAM531OgRl4AAZ9LnTG13m13h1kr4PLKg4QIoBO6D2ehxOWto02ZOwO
 TTcyxpwTcjoIPHT4RUZB65Fxco4=
X-Google-Smtp-Source: ABdhPJxJXPbq4AMHFRyrwkrNbEvQCzNTu4RUbyCC0UO0WTlvSmO9sJsIYj0m0+VxoR1DYSusZsUFFZU=
X-Received: by 2002:a25:7e84:: with SMTP id z126mr16774517ybc.73.1595620292553; 
 Fri, 24 Jul 2020 12:51:32 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:51:28 -0700
Message-Id: <20200724195128.2373212-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2] cputlb: Make store_helper less fragile to compiler
 optimizations
From: Shu-Chun Weng <scw@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org
Cc: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3xDsbXwMKCqcZJdNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change has no functional change.

There is a potential link error with "undefined symbol:
qemu_build_not_reached" due to how `store_helper` is structured.
This does not produce at current QEMU head, but was reproducible at
v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.

The current function structure is:

    inline QEMU_ALWAYSINLINE
    store_memop() {
        switch () {
            ...
        default:
            qemu_build_not_reached();
        }
    }
    inline QEMU_ALWAYSINLINE
    store_helper() {
        ...
        if (span_two_pages_or_io) {
            ...
            helper_rst_stb_mmu();
        }
        store_memop();
    }
    helper_rst_stb_mmu() {
        store_helper();
    }

Both `store_memop` and `store_helper` need to be inlined and allow
constant propogations to eliminate the `qemu_build_not_reached` call.
QEMU_ALWAYSINLINE is a valiant effort to make that happen, but it's
still not guaranteed to be inlined. What happens with the failing
combination is that the compiler decided to inline the
`helper_rst_stb_mmu` call inside `store_helper`, making the latter
self-recursive, thus prevents constant propagations.

The new structure is:

    inline QEMU_ALWAYSINLINE
    store_memop() {
        switch () {
            ...
        default:
            qemu_build_not_reached();
        }
    }
    inline QEMU_ALWAYSINLINE
    store_helper_size_aligned()() {
        ...
        if (span_two_pages_or_io) {
            return false;
        }
        store_memoop();
        return true;
    }
    inline QEMU_ALWAYSINLINE
    store_helper() {
        if (store_helper_size_aligned() {
            return;
        }
        helper_rst_stb_mmu();
    }
    helper_rst_stb_mmu() {
        store_helper_size_aligned()();
    }

Since a byte store cannot span across more than one page, this is a
no-op. Moreover, there is no more recursion making it more robust
against potential optimizations.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v1: https://patchew.org/QEMU/20200318062057.224953-1-scw@google.com/

v1 -> v2:
  Restructure the function instead of marking `helper_rst_stb_mmu` noinline.

 accel/tcg/cputlb.c | 158 ++++++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 66 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d370aedb47..14324f08d2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2010,9 +2010,10 @@ store_memop(void *haddr, uint64_t val, MemOp op)
     }
 }
 
-static inline void QEMU_ALWAYS_INLINE
-store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
+/* Returns false if the store is not size-aligned and no store is done. */
+static inline bool QEMU_ALWAYS_INLINE
+store_helper_size_aligned(CPUArchState *env, target_ulong addr, uint64_t val,
+                          TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -2048,7 +2049,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         /* For anything that is unaligned, recurse through byte stores.  */
         if ((addr & (size - 1)) != 0) {
-            goto do_unaligned_access;
+            return false;
         }
 
         iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
@@ -2066,12 +2067,12 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         if (tlb_addr & TLB_MMIO) {
             io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                       op ^ (need_swap * MO_BSWAP));
-            return;
+            return true;
         }
 
         /* Ignore writes to ROM.  */
         if (unlikely(tlb_addr & TLB_DISCARD_WRITE)) {
-            return;
+            return true;
         }
 
         /* Handle clean RAM pages.  */
@@ -2091,82 +2092,107 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         } else {
             store_memop(haddr, val, op);
         }
-        return;
+        return true;
     }
 
-    /* Handle slow unaligned access (it spans two pages or IO).  */
     if (size > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                      >= TARGET_PAGE_SIZE)) {
-        int i;
-        uintptr_t index2;
-        CPUTLBEntry *entry2;
-        target_ulong page2, tlb_addr2;
-        size_t size2;
+        /* Slow unaligned access (it spans two pages or IO).  */
+        return false;
+    }
 
-    do_unaligned_access:
-        /*
-         * Ensure the second page is in the TLB.  Note that the first page
-         * is already guaranteed to be filled, and that the second page
-         * cannot evict the first.
-         */
-        page2 = (addr + size) & TARGET_PAGE_MASK;
-        size2 = (addr + size) & ~TARGET_PAGE_MASK;
-        index2 = tlb_index(env, mmu_idx, page2);
-        entry2 = tlb_entry(env, mmu_idx, page2);
-        tlb_addr2 = tlb_addr_write(entry2);
-        if (!tlb_hit_page(tlb_addr2, page2)) {
-            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
-                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
-                         mmu_idx, retaddr);
-                index2 = tlb_index(env, mmu_idx, page2);
-                entry2 = tlb_entry(env, mmu_idx, page2);
-            }
-            tlb_addr2 = tlb_addr_write(entry2);
-        }
+    haddr = (void *)((uintptr_t)addr + entry->addend);
+    store_memop(haddr, val, op);
+    return true;
+}
 
-        /*
-         * Handle watchpoints.  Since this may trap, all checks
-         * must happen before any store.
-         */
-        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
-                                 env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                                 BP_MEM_WRITE, retaddr);
-        }
-        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
-            cpu_check_watchpoint(env_cpu(env), page2, size2,
-                                 env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
-                                 BP_MEM_WRITE, retaddr);
-        }
+static inline void QEMU_ALWAYS_INLINE
+store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
+{
+    uintptr_t mmu_idx;
+    uintptr_t index;
+    CPUTLBEntry *entry;
+    target_ulong tlb_addr;
+    const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
+    size_t size;
+    int i;
+    uintptr_t index2;
+    CPUTLBEntry *entry2;
+    target_ulong page2, tlb_addr2;
+    size_t size2;
 
-        /*
-         * XXX: not efficient, but simple.
-         * This loop must go in the forward direction to avoid issues
-         * with self-modifying code in Windows 64-bit.
-         */
-        for (i = 0; i < size; ++i) {
-            uint8_t val8;
-            if (memop_big_endian(op)) {
-                /* Big-endian extract.  */
-                val8 = val >> (((size - 1) * 8) - (i * 8));
-            } else {
-                /* Little-endian extract.  */
-                val8 = val >> (i * 8);
-            }
-            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
-        }
+    if (store_helper_size_aligned(env, addr, val, oi, retaddr, op)) {
         return;
     }
 
-    haddr = (void *)((uintptr_t)addr + entry->addend);
-    store_memop(haddr, val, op);
+    mmu_idx = get_mmuidx(oi);
+
+    size = memop_size(op);
+    index = tlb_index(env, mmu_idx, addr);
+    entry = tlb_entry(env, mmu_idx, addr);
+    tlb_addr = tlb_addr_write(entry);
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    /*
+     * Ensure the second page is in the TLB.  Note that the first page
+     * is already guaranteed to be filled, and that the second page
+     * cannot evict the first.
+     */
+    page2 = (addr + size) & TARGET_PAGE_MASK;
+    size2 = (addr + size) & ~TARGET_PAGE_MASK;
+    index2 = tlb_index(env, mmu_idx, page2);
+    entry2 = tlb_entry(env, mmu_idx, page2);
+    tlb_addr2 = tlb_addr_write(entry2);
+    if (!tlb_hit_page(tlb_addr2, page2)) {
+        if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
+            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index2 = tlb_index(env, mmu_idx, page2);
+            entry2 = tlb_entry(env, mmu_idx, page2);
+        }
+        tlb_addr2 = tlb_addr_write(entry2);
+    }
+
+    /*
+     * Handle watchpoints.  Since this may trap, all checks
+     * must happen before any store.
+     */
+    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
+        cpu_check_watchpoint(env_cpu(env), addr, size - size2,
+                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
+                             BP_MEM_WRITE, retaddr);
+    }
+    if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
+        cpu_check_watchpoint(env_cpu(env), page2, size2,
+                             env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
+                             BP_MEM_WRITE, retaddr);
+    }
+
+    /*
+     * XXX: not efficient, but simple.
+     * This loop must go in the forward direction to avoid issues
+     * with self-modifying code in Windows 64-bit.
+     */
+    for (i = 0; i < size; ++i) {
+        uint8_t val8;
+        if (memop_big_endian(op)) {
+            /* Big-endian extract.  */
+            val8 = val >> (((size - 1) * 8) - (i * 8));
+        } else {
+            /* Little-endian extract.  */
+            val8 = val >> (i * 8);
+        }
+        helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
+    }
 }
 
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_UB);
+    /* Byte store is always size-aligned. */
+    store_helper_size_aligned(env, addr, val, oi, retaddr, MO_UB);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-- 
2.28.0.rc0.142.g3c755180ce-goog


