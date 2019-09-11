Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D368C49ED7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426082171F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+B1gpXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426082171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7rk6-0005JM-F9
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 21:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rfu-0001hy-SW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rft-0000an-0q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:02 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:33845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i7rfs-0000ah-Sz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:00 -0400
Received: by mail-qt1-x82a.google.com with SMTP id j1so10539268qth.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qkRCAeXLj1zdLXAh0jGTAmz2ec7MpixYWyKmhPy98CA=;
 b=S+B1gpXJcX9THwqSInhb8HygS2+r9ISU9zOMVNsCe0AZXjxun8igYsL2jyI2T++QAX
 sP7+HS0vDEcNotHcrfjkBqYnkVByDtEkipngiRjuvZFu3rn5x6Vh2qyABnC/Sb5N4rmz
 3jaj3Tgm9FohZFwAjLvfFPZjVeSGEKOLUcuNAimzMatwJWpoO0ZmDZnPTCIy+dx19wKt
 bwYm7gz5HdQNvo5QH4TkVRFm2wu0L/hGqP9SptEzTyWUIQymsm6rAqBKVnRyPUgd4VJX
 OJnrapiZQbBlctV1PZfByBEWeZqk7ISBtlcMV0pEGegDwBmShEk7PysDodDgETxyXjo1
 8hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qkRCAeXLj1zdLXAh0jGTAmz2ec7MpixYWyKmhPy98CA=;
 b=lj1RgD9C2gPBOrzQuzhDSXewP6tkK/XbpHfl7GqXvQbC8fxn0IncXu8HEPIDwRDhp5
 sriDnHvoktbsJ68k6fBk0QUASZKXu6u7RmjN2O25f2hyAI5pkQhNkoa5bZcF2QTHRLn9
 mM1PCAH4+eveeYv9DjSc89qgTOlYDN3mN07aWPo4OwHjpNCH1J2YYx4yTCHdADCOyU01
 VoGgY8zj0QZcGQJ7EV/4mpFWPxc/6LFVzmIz5T+G5LeIiyZkm94eokiC/GVXjhTsFfuB
 7oHIICWIXP6+wHJ47IfzzIVX0bumHu+zRVvzvdQhjPGb64UU/+Agq+u/h6uCn6Cu2u0a
 hU5Q==
X-Gm-Message-State: APjAAAWP2/qbrcfaWi0Amv6Ttsc03/RVbVNsxySB57g6towGMremNLoR
 BauOw6vtyas8yFywPltuQ1FVnhgfPrExUA==
X-Google-Smtp-Source: APXvYqyGJ0r6MpZ+nXRkEB3NXu1nHf/R7PfQxYj6ZAPXIzvW4bLEKMQX/MpmWK5hPs4gIRzfW42ooA==
X-Received: by 2002:a0c:9352:: with SMTP id e18mr19909925qve.33.1568166239889; 
 Tue, 10 Sep 2019 18:43:59 -0700 (PDT)
Received: from localhost.localdomain
 (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca. [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id a14sm10074676qkg.59.2019.09.10.18.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 18:43:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 21:43:53 -0400
Message-Id: <20190911014353.5926-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82a
Subject: [Qemu-devel] [PATCH 3/3] cputlb: Introduce TLB_BSWAP
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle bswap on ram directly in load/store_helper.  This fixes a
bug with the previous implementation in that one cannot use the
I/O path for RAM.

Fixes: a26fc6f5152b47f1
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |   2 +
 accel/tcg/cputlb.c     | 118 ++++++++++++++++++++---------------------
 2 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2d443c4f9..3928edab9a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -331,6 +331,8 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS - 5))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e6229d100a..eace6c82e3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -737,8 +737,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         address |= TLB_INVALID_MASK;
     }
     if (attrs.byte_swap) {
-        /* Force the access through the I/O slow path.  */
-        address |= TLB_MMIO;
+        address |= TLB_BSWAP;
     }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
@@ -901,10 +900,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -947,10 +942,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1322,7 +1313,8 @@ static inline uint64_t direct_ldul_le(const void *haddr)
 static inline uint64_t ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
-            FullLoadHelper *full_load, DirectLoadHelper *direct)
+            FullLoadHelper *full_load, DirectLoadHelper *direct,
+            DirectLoadHelper *direct_swap)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1372,26 +1364,27 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_READ, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
         /* Handle I/O access.  */
-        return io_readx(env, iotlbentry, mmu_idx, addr,
-                        retaddr, access_type, op);
-    }
+        if (likely(tlb_addr & TLB_MMIO)) {
+            return io_readx(env, iotlbentry, mmu_idx, addr,
+                            retaddr, access_type,
+                            op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
+        }
 
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (size > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
-                    >= TARGET_PAGE_SIZE)) {
+        if (unlikely(tlb_addr & TLB_BSWAP)) {
+            haddr = (void *)((uintptr_t)addr + entry->addend);
+            return direct_swap(haddr);
+        }
+    } else if (size > 1
+               && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                           >= TARGET_PAGE_SIZE)) {
+        /* Handle slow unaligned access (it spans two pages or IO).  */
         target_ulong addr1, addr2;
         uint64_t r1, r2;
         unsigned shift;
+
     do_unaligned_access:
         addr1 = addr & ~((target_ulong)size - 1);
         addr2 = addr1 + size;
@@ -1409,7 +1402,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     return direct(haddr);
 }
@@ -1428,7 +1420,7 @@ static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_UB, false,
-                       full_ldub_mmu, direct_ldub);
+                       full_ldub_mmu, direct_ldub, direct_ldub);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1441,7 +1433,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
-                       full_le_lduw_mmu, direct_lduw_le);
+                       full_le_lduw_mmu, direct_lduw_le, direct_lduw_be);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1454,7 +1446,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
-                       full_be_lduw_mmu, direct_lduw_be);
+                       full_be_lduw_mmu, direct_lduw_be, direct_lduw_le);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1467,7 +1459,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
-                       full_le_ldul_mmu, direct_ldul_le);
+                       full_le_ldul_mmu, direct_ldul_le, direct_ldul_be);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1480,7 +1472,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
-                       full_be_ldul_mmu, direct_ldul_be);
+                       full_be_ldul_mmu, direct_ldul_be, direct_ldul_le);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1493,14 +1485,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
-                       helper_le_ldq_mmu, ldq_le_p);
+                       helper_le_ldq_mmu, ldq_le_p, ldq_be_p);
 }
 
 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
-                       helper_be_ldq_mmu, ldq_be_p);
+                       helper_be_ldq_mmu, ldq_be_p, ldq_le_p);
 }
 
 /*
@@ -1573,7 +1565,7 @@ static inline void direct_stl_le(void *haddr, uint64_t val)
 static inline void ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
-             DirectStoreHelper *direct)
+             DirectStoreHelper *direct, DirectStoreHelper *direct_swap)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1618,23 +1610,24 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_WRITE, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
         /* Handle I/O access.  */
-        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
-        return;
-    }
+        if (likely(tlb_addr & TLB_MMIO)) {
+            io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
+                      op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
+            return;
+        }
 
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (size > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
-                     >= TARGET_PAGE_SIZE)) {
+        if (unlikely(tlb_addr & TLB_BSWAP)) {
+            haddr = (void *)((uintptr_t)addr + entry->addend);
+            direct_swap(haddr, val);
+            return;
+        }
+    } else if (size > 1
+               && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                            >= TARGET_PAGE_SIZE)) {
+        /* Handle slow unaligned access (it spans two pages or IO).  */
         int i;
         uintptr_t index2;
         CPUTLBEntry *entry2;
@@ -1696,7 +1689,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     direct(haddr, val);
 }
@@ -1704,43 +1696,47 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_UB, direct_stb);
+    store_helper(env, addr, val, oi, retaddr, MO_UB, direct_stb, direct_stb);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUW, direct_stw_le);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW,
+                 direct_stw_le, direct_stw_be);
 }
 
 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUW, direct_stw_be);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW,
+                 direct_stw_be, direct_stw_le);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUL, direct_stl_le);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL,
+                 direct_stl_le, direct_stl_be);
 }
 
 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUL, direct_stl_be);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL,
+                 direct_stl_be, direct_stl_le);
 }
 
 void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEQ, stq_le_p);
+    store_helper(env, addr, val, oi, retaddr, MO_LEQ, stq_le_p, stq_be_p);
 }
 
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEQ, stq_be_p);
+    store_helper(env, addr, val, oi, retaddr, MO_BEQ, stq_be_p, stq_le_p);
 }
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
@@ -1806,7 +1802,7 @@ static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_8, true,
-                       full_ldub_cmmu, direct_ldub);
+                       full_ldub_cmmu, direct_ldub, direct_ldub);
 }
 
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1819,7 +1815,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu, direct_lduw_le);
+                       full_le_lduw_cmmu, direct_lduw_le, direct_lduw_be);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1832,7 +1828,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu, direct_lduw_be);
+                       full_be_lduw_cmmu, direct_lduw_be, direct_lduw_le);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1845,7 +1841,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu, direct_ldul_le);
+                       full_le_ldul_cmmu, direct_ldul_le, direct_ldul_be);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1858,7 +1854,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu, direct_ldul_be);
+                       full_be_ldul_cmmu, direct_ldul_be, direct_ldul_le);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1871,12 +1867,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
-                       helper_le_ldq_cmmu, ldq_le_p);
+                       helper_le_ldq_cmmu, ldq_le_p, ldq_be_p);
 }
 
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
-                       helper_be_ldq_cmmu, ldq_be_p);
+                       helper_be_ldq_cmmu, ldq_be_p, ldq_le_p);
 }
-- 
2.17.1


