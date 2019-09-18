Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A80EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BE0208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW6Pxapb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BE0208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeSQ-00024m-SB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeIC-00022R-MN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI7-0000SF-5T
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:02 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAeI6-0000S5-Ts
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:59 -0400
Received: by mail-pg1-x542.google.com with SMTP id x15so283375pgg.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6ZfbVwaLbCiGgpEw6rDTymD03FTM4V/YWYRYGaFUxL8=;
 b=xW6Pxapb4zhFSPriqaOFq5+JoB/3MzVaCDoku904vsV6YBnLN4Qv0r459FXGfSz74z
 +sj6VkGcrFNoipwbiVCwIeJiqrrpX/hd+bV8Mg0pLT5m6/s919OqRaItLUK4tFyqEIzj
 Q4lCorWDxtOsgikaC59FpsOD8lVAkgHirHReT3r8Otv21nQ8HIffZSqrUeNdX81/Gjsf
 +frDnS3OpQGYxoX3StqVLEDBa9C1aVBE6xLf9V92EP3VMXEjBnX4D2sTDUkDmQh0yjdf
 Go+AlUUBxseBbg+1c4bUBi/9xrU+Y4lNEhkr4AxksEeC042tqmEWn/8DA6FdFyAN4jKc
 TGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6ZfbVwaLbCiGgpEw6rDTymD03FTM4V/YWYRYGaFUxL8=;
 b=T4VkzmvitVaEd+eUCX3MqUSNQ7IwWhgtzLwi2dV6P94yJ9f+SHXJrBry+C8a6kyHIq
 sY/1TAai8Al0ECSA+aCQaMaS9cBSAJDZv9Xq1WNfSNPsIBK7bqxecNdVcDO7BsAeVFmY
 9PO35F6NfhiBwePXuQdWi4H5YgjM6+AdFcEnnLCH1Lzr1/FaB9FhbB9KJLkFJ16y6VNv
 ad24yZAURPzwyvkChxxanmQvmFMhqOG5S6tlNMmJdoIl3dgaeLdmDcENFXAOMxOStXoB
 FKtJnhMYZhSzhOuQlpIjR9yg/g8zBSK8VxNs4pZ0YdPiW6E562pw3JtkDveTbQPx/RVl
 lXKw==
X-Gm-Message-State: APjAAAVCsebKkPb4ioSSbk4ZBtBhq6K+KOpZFM17hzv8A0Jna/VnGJ3/
 VXyJnzbEPEkmxEXYi7SRzBrJM9d4My8=
X-Google-Smtp-Source: APXvYqyCj1ZISnK93TdUFK72LfcW6pUr7T+8PFJV86fBe/XtHtZLcoeU9TYhJn4PpPEtzNnMSSHsMw==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr2716710pgk.71.1568829777336; 
 Wed, 18 Sep 2019 11:02:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm13319518pfb.54.2019.09.18.11.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 11:02:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 11:02:49 -0700
Message-Id: <20190918180251.32003-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918180251.32003-1-richard.henderson@linaro.org>
References: <20190918180251.32003-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [RFC v2 3/5] cputlb: Introduce TLB_BSWAP
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
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
 accel/tcg/cputlb.c     | 105 +++++++++++++++++++++--------------------
 2 files changed, 57 insertions(+), 50 deletions(-)

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
index b4a63d3928..7301f9e699 100644
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
@@ -1311,7 +1302,8 @@ static inline uint64_t wrap_ldul_le(const void *haddr)
 static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
-            FullLoadHelper *full_load, LoadHelper *direct)
+            FullLoadHelper *full_load, LoadHelper *direct,
+            LoadHelper *direct_swap)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1361,17 +1353,22 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
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
+        if (likely(tlb_addr & TLB_MMIO)) {
+            return io_readx(env, iotlbentry, mmu_idx, addr,
+                            retaddr, access_type,
+                            op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        if (unlikely(tlb_addr & TLB_BSWAP)) {
+            return direct_swap(haddr);
+        } else {
+            return direct(haddr);
+        }
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1398,7 +1395,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     return direct(haddr);
 }
@@ -1417,7 +1413,7 @@ static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_UB, false,
-                       full_ldub_mmu, wrap_ldub);
+                       full_ldub_mmu, wrap_ldub, wrap_ldub);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1430,7 +1426,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
-                       full_le_lduw_mmu, wrap_lduw_le);
+                       full_le_lduw_mmu, wrap_lduw_le, wrap_lduw_be);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1443,7 +1439,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
-                       full_be_lduw_mmu, wrap_lduw_be);
+                       full_be_lduw_mmu, wrap_lduw_be, wrap_lduw_le);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1456,7 +1452,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
-                       full_le_ldul_mmu, wrap_ldul_le);
+                       full_le_ldul_mmu, wrap_ldul_le, wrap_ldul_be);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1469,7 +1465,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
-                       full_be_ldul_mmu, wrap_ldul_be);
+                       full_be_ldul_mmu, wrap_ldul_be, wrap_ldul_le);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1482,14 +1478,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
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
@@ -1563,7 +1559,7 @@ static inline void wrap_stl_le(void *haddr, uint64_t val)
 static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
-             StoreHelper *direct)
+             StoreHelper *direct, StoreHelper *direct_swap)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1608,16 +1604,22 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
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
+        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+            io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
+                      op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
+            return;
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        if (unlikely(tlb_addr & TLB_BSWAP)) {
+            direct_swap(haddr, val);
+        } else {
+            direct(haddr, val);
+        }
         return;
     }
 
@@ -1686,7 +1688,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     direct(haddr, val);
 }
@@ -1694,43 +1695,47 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_UB, wrap_stb);
+    store_helper(env, addr, val, oi, retaddr, MO_UB, wrap_stb, wrap_stb);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUW, wrap_stw_le);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW,
+                 wrap_stw_le, wrap_stw_be);
 }
 
 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUW, wrap_stw_be);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW,
+                 wrap_stw_be, wrap_stw_le);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUL, wrap_stl_le);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL,
+                 wrap_stl_le, wrap_stl_be);
 }
 
 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUL, wrap_stl_be);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL,
+                 wrap_stl_be, wrap_stl_le);
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
@@ -1796,7 +1801,7 @@ static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_8, true,
-                       full_ldub_cmmu, wrap_ldub);
+                       full_ldub_cmmu, wrap_ldub, wrap_ldub);
 }
 
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1809,7 +1814,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu, wrap_lduw_le);
+                       full_le_lduw_cmmu, wrap_lduw_le, wrap_lduw_be);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1822,7 +1827,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu, wrap_lduw_be);
+                       full_be_lduw_cmmu, wrap_lduw_be, wrap_lduw_le);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1835,7 +1840,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu, wrap_ldul_le);
+                       full_le_ldul_cmmu, wrap_ldul_le, wrap_ldul_be);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1848,7 +1853,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu, wrap_ldul_be);
+                       full_be_ldul_cmmu, wrap_ldul_be, wrap_ldul_le);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1861,12 +1866,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
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


