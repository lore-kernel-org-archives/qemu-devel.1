Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC528C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E8F216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB/fBMNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E8F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SNx-0005I9-O8
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFz-0002la-AO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFw-0003YV-Va
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFw-0003X9-N6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so1618326pfn.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yh4+pYyrUqOitbNmc4ujx23BfCcUHWXYnoAJLZrV5M8=;
 b=DB/fBMNzbde6iusNirkelNV+jHESWzqCuHq/q3PaIreQR82kGwNn4mNJ1dsqEYpK65
 bnBuUB3EIKRDXe1oNeN37mnLj0ahwFuRNb7U3bYFneyXgzH8dLdUGple43Ej6yXOpkm7
 7LCsbx6TerN+vW/lBhR3d8iUNWdko6nwbKEJxb5BIpubLduZrJUW6h/KErNdEb73UlOI
 kizkJZ6nRpy45EnEPuP5owFNo496zGxnmGp7EaZ2RnM02WEmMdJiZeHQ7w/qUugxQ6Vy
 3I0WQH+UiWP5/JqBa1f4XnxQQrwRCQivSTKEV/T9SAytInnNhAtVHxEsghEnyDCEDTkc
 5Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yh4+pYyrUqOitbNmc4ujx23BfCcUHWXYnoAJLZrV5M8=;
 b=I79TGv/NXFhGLDuPWKKpGCkowCU5ouV3yoXT7AMG1F9ESxKLv3qgk/eZsOHl3XbgIP
 ugO2VEgpQilAKJHiQF37eV6E41YHfdDuTn0OYAEzVKQp8QNlv3beOpyF9nb/RbOZW1/4
 tMFNqu5SQ9Nl3QHnkgiKVgV2flEWVBBx9nR0MElD2m2Y+4QQu0uRJIVeoILxRKC+PlbX
 43SH1IQRiUMBnz3uPXRJoJ8OzOFNZXCaVric9FKgrF+5QG0zM4Eb2zUsJwvIGyPZ2w/L
 LO++bTKdYomapcWKnTa89R+96lx7UFSbcBh0HS+lvfq4oeclqwVnL7dQcaXvKqTTOkPS
 FmxA==
X-Gm-Message-State: APjAAAXS4LYViFcMcxgqeI+GtxeceRK8iGfk/cI/tKGu2ox/hzoau3gt
 p9opx4hhdtkqWFbTR9L+sqHIZFvuvAI=
X-Google-Smtp-Source: APXvYqzfcvVyczoKH8zKG/ftAAzKMwqS1jNhbTkVl0vR8rCMxRO4gMwHhwpFspfI+ZNrTN74pWCKhA==
X-Received: by 2002:a62:7e11:: with SMTP id z17mr6662712pfc.211.1566400235177; 
 Wed, 21 Aug 2019 08:10:35 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:34 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:10 +1000
Message-Id: <1492f15eb5fea5a01e50f4aa8bf8eccc482abd0a.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v8 16/21] cputlb: Replace size and endian
 operands for MemOp
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for collapsing the two byte swaps adjust_endianness and
handle_bswap into the former.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c   | 170 +++++++++++++++++++++----------------------
 include/exec/memop.h |   6 ++
 2 files changed, 87 insertions(+), 89 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f64c6b1c75..5c12eef292 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
 
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx, target_ulong addr, uintptr_t retaddr,
-                         MMUAccessType access_type, int size)
+                         MMUAccessType access_type, MemOp op)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -906,15 +906,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, mr_offset, &val,
-                                    size_memop(size) | MO_TE,
-                                    iotlbentry->attrs);
+    r = memory_region_dispatch_read(mr, mr_offset, &val, op, iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
             section->offset_within_region;
 
-        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
+        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op), access_type,
                                mmu_idx, iotlbentry->attrs, r, retaddr);
     }
     if (locked) {
@@ -926,7 +924,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+                      uintptr_t retaddr, MemOp op)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -948,16 +946,15 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, mr_offset, val,
-                                     size_memop(size) | MO_TE,
-                                     iotlbentry->attrs);
+    r = memory_region_dispatch_write(mr, mr_offset, val, op, iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
             section->offset_within_region;
 
-        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,
-                               mmu_idx, iotlbentry->attrs, r, retaddr);
+        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op),
+                               MMU_DATA_STORE, mmu_idx, iotlbentry->attrs, r,
+                               retaddr);
     }
     if (locked) {
         qemu_mutex_unlock_iothread();
@@ -1218,14 +1215,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
  * access type.
  */
 
-static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
+static inline uint64_t handle_bswap(uint64_t val, MemOp op)
 {
-    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {
-        switch (size) {
-        case 1: return val;
-        case 2: return bswap16(val);
-        case 4: return bswap32(val);
-        case 8: return bswap64(val);
+    if ((memop_big_endian(op) && NEED_BE_BSWAP) ||
+        (!memop_big_endian(op) && NEED_LE_BSWAP)) {
+        switch (op & MO_SIZE) {
+        case MO_8: return val;
+        case MO_16: return bswap16(val);
+        case MO_32: return bswap32(val);
+        case MO_64: return bswap64(val);
         default:
             g_assert_not_reached();
         }
@@ -1248,7 +1246,7 @@ typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
 
 static inline uint64_t __attribute__((always_inline))
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-            uintptr_t retaddr, size_t size, bool big_endian, bool code_read,
+            uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
@@ -1262,6 +1260,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     void *haddr;
     uint64_t res;
+    size_t size = memop_size(op);
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1309,8 +1308,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
         /* TODO: Merge bswap into io_readx -> memory_region_dispatch_read.  */
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, size);
-        return handle_bswap(res, size, big_endian);
+                       mmu_idx, addr, retaddr, access_type, op);
+        return handle_bswap(res, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1327,7 +1326,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         r2 = full_load(env, addr2, oi, retaddr);
         shift = (addr & (size - 1)) * 8;
 
-        if (big_endian) {
+        if (memop_big_endian(op)) {
             /* Big-endian combine.  */
             res = (r1 << shift) | (r2 >> ((size * 8) - shift));
         } else {
@@ -1339,30 +1338,27 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (size) {
-    case 1:
+    switch (op) {
+    case MO_UB:
         res = ldub_p(haddr);
         break;
-    case 2:
-        if (big_endian) {
-            res = lduw_be_p(haddr);
-        } else {
-            res = lduw_le_p(haddr);
-        }
+    case MO_BEUW:
+        res = lduw_be_p(haddr);
         break;
-    case 4:
-        if (big_endian) {
-            res = (uint32_t)ldl_be_p(haddr);
-        } else {
-            res = (uint32_t)ldl_le_p(haddr);
-        }
+    case MO_LEUW:
+        res = lduw_le_p(haddr);
         break;
-    case 8:
-        if (big_endian) {
-            res = ldq_be_p(haddr);
-        } else {
-            res = ldq_le_p(haddr);
-        }
+    case MO_BEUL:
+        res = (uint32_t)ldl_be_p(haddr);
+        break;
+    case MO_LEUL:
+        res = (uint32_t)ldl_le_p(haddr);
+        break;
+    case MO_BEQ:
+        res = ldq_be_p(haddr);
+        break;
+    case MO_LEQ:
+        res = ldq_le_p(haddr);
         break;
     default:
         g_assert_not_reached();
@@ -1384,8 +1380,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, false,
-                       full_ldub_mmu);
+    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1397,7 +1392,7 @@ tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
                        full_le_lduw_mmu);
 }
 
@@ -1410,7 +1405,7 @@ tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
                        full_be_lduw_mmu);
 }
 
@@ -1423,7 +1418,7 @@ tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
                        full_le_ldul_mmu);
 }
 
@@ -1436,7 +1431,7 @@ tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
                        full_be_ldul_mmu);
 }
 
@@ -1449,14 +1444,14 @@ tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
 uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
                        helper_le_ldq_mmu);
 }
 
 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
                        helper_be_ldq_mmu);
 }
 
@@ -1502,7 +1497,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
 
 static inline void __attribute__((always_inline))
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-             TCGMemOpIdx oi, uintptr_t retaddr, size_t size, bool big_endian)
+             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1511,6 +1506,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     void *haddr;
+    size_t size = memop_size(op);
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1558,8 +1554,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         /* TODO: Merge bswap into io_writex -> memory_region_dispatch_write.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  handle_bswap(val, size, big_endian),
-                  addr, retaddr, size);
+                  handle_bswap(val, op),
+                  addr, retaddr, op);
         return;
     }
 
@@ -1595,7 +1591,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
          */
         for (i = 0; i < size; ++i) {
             uint8_t val8;
-            if (big_endian) {
+            if (memop_big_endian(op)) {
                 /* Big-endian extract.  */
                 val8 = val >> (((size - 1) * 8) - (i * 8));
             } else {
@@ -1609,30 +1605,27 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (size) {
-    case 1:
+    switch (op) {
+    case MO_UB:
         stb_p(haddr, val);
         break;
-    case 2:
-        if (big_endian) {
-            stw_be_p(haddr, val);
-        } else {
-            stw_le_p(haddr, val);
-        }
+    case MO_BEUW:
+        stw_be_p(haddr, val);
         break;
-    case 4:
-        if (big_endian) {
-            stl_be_p(haddr, val);
-        } else {
-            stl_le_p(haddr, val);
-        }
+    case MO_LEUW:
+        stw_le_p(haddr, val);
         break;
-    case 8:
-        if (big_endian) {
-            stq_be_p(haddr, val);
-        } else {
-            stq_le_p(haddr, val);
-        }
+    case MO_BEUL:
+        stl_be_p(haddr, val);
+        break;
+    case MO_LEUL:
+        stl_le_p(haddr, val);
+        break;
+    case MO_BEQ:
+        stq_be_p(haddr, val);
+        break;
+    case MO_LEQ:
+        stq_le_p(haddr, val);
         break;
     default:
         g_assert_not_reached();
@@ -1643,43 +1636,43 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 1, false);
+    store_helper(env, addr, val, oi, retaddr, MO_UB);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 2, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
 }
 
 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 2, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 4, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
 }
 
 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 4, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
 }
 
 void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 8, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEQ);
 }
 
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 8, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEQ);
 }
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
@@ -1744,8 +1737,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, true,
-                       full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
 }
 
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1757,7 +1749,7 @@ uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
                        full_le_lduw_cmmu);
 }
 
@@ -1770,7 +1762,7 @@ uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
                        full_be_lduw_cmmu);
 }
 
@@ -1783,7 +1775,7 @@ uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
                        full_le_ldul_cmmu);
 }
 
@@ -1796,7 +1788,7 @@ uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
 static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
                        full_be_ldul_cmmu);
 }
 
@@ -1809,13 +1801,13 @@ uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
                        helper_le_ldq_cmmu);
 }
 
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
                        helper_be_ldq_cmmu);
 }
diff --git a/include/exec/memop.h b/include/exec/memop.h
index 0a610b75d9..529d07b02d 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -125,4 +125,10 @@ static inline MemOp size_memop(unsigned size)
     return ctz32(size);
 }
 
+/* Big endianness from MemOp.  */
+static inline bool memop_big_endian(MemOp op)
+{
+    return (op & MO_BSWAP) == MO_BE;
+}
+
 #endif
-- 
2.23.0


