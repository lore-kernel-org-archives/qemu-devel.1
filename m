Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6552FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0B123717
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMSAwxv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0B123717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BcT-0001G1-Lq
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMx-0001Fz-Qe
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMv-0003lj-A2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:23 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMv-0003lM-1F
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:21 -0400
Received: by mail-pg1-x534.google.com with SMTP id n4so9411799pgv.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TBrJ4fwJpIe+gZOg9ZyNwc8RtpSSy4H18j0+FDbhf/Q=;
 b=CMSAwxv+bxo5xWYEzCHsw2GeEI92+ogBaYgE/0OtZRU81sQjK3gApXCQGaOIDYy4Ad
 3wNnDGljTDcTUwcSjalbotoNVvUxsldsP1VaoYdf5XQ8awFdJ9SkWW+lIjWQKTQ75BC9
 J8IX3HUqoPhXJueS6EFirpEuCOSvg6SVY8octLXW7AKI8Qhmis4eFhfJ3v0ffie/ii5S
 fW+ffVn/FQEtXEhXbInubgzk4Q+b8oDQdA4NOAD9un/3Mt5NCXrFOtGFQcEg+7lC7gD0
 SuBaoQ+rwY8OLgvsh0pOz36zQWvCoKXB5ptn0y+xDxe+4D5yyuxiFW6THV7vWZU8sKHQ
 o2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TBrJ4fwJpIe+gZOg9ZyNwc8RtpSSy4H18j0+FDbhf/Q=;
 b=Bq4ykzwmXnlxLLQEL5lak6zr1gDI5Ku51+GBbPsKTxhkSCIAJnuLPxIQLDZcd+9pbj
 iX/PIxzq4nX9OS/gb4kjKUXtUnZuXcjr4oBty3Xq3rZC15x72v7wg+T1MbjBLR+8QIDw
 qi+qMm8x5DCHijRBbSRn6jA0ElCNsbTKS25ERU0raISNrKXvix6IszUzb0Xn1PSCLhR2
 s6iiHJ6+LHKcSh4+SfXJZTM8YFgCtNg62MOSxs5MFJMscCwkJDlitiX3dn+oImRi+ABE
 hul497PB19hEVpwQLu+TiMs2Z1xcjdG96ZSs3Wc/0nGmDUqqY+KEiknnWE1rnpf7yiWj
 VCJQ==
X-Gm-Message-State: APjAAAXEjurnUEh3iJvf9YL4SAxvctd7vEE5pVDJCZnaFLXAM71fQhtV
 YBzI4XRCs3OEai171qARTON9aOjJvxg=
X-Google-Smtp-Source: APXvYqy1W48WKRlb+JRT+Ybfyx4dkRnHuD47tUt8cl3O6sHELz+pthQBx2gwGkHyJNsCNyBl4jPfSw==
X-Received: by 2002:a63:5048:: with SMTP id q8mr30509174pgl.446.1567526959579; 
 Tue, 03 Sep 2019 09:09:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:37 -0700
Message-Id: <20190903160858.5296-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PATCH 15/36] cputlb: Replace size and endian operands
 for MemOp
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

Preparation for collapsing the two byte swaps adjust_endianness and
handle_bswap into the former.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <755b7104410956b743e1f1e9c34ab87db113360f.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h |   6 ++
 accel/tcg/cputlb.c   | 170 +++++++++++++++++++++----------------------
 2 files changed, 87 insertions(+), 89 deletions(-)

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
-- 
2.17.1


