Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56633208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMDmqTEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56633208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeOO-0007DM-7v
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI7-0001zg-Ox
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI5-0000Rn-Up
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAeI5-0000RO-Lk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id y72so470757pfb.12
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3cfrqeC7LyJB/ROXN1SmwKtiOawGwvTqMSrbdq/eHoM=;
 b=rMDmqTEgtsk7zVSCslbphhy6+8evakesTNdLdxDMljXF9O24DEjuHvazZGHJLRMZSm
 Ss3pD5Sz3T2a9vHlpT/zytApIz1+f5/qnJY8CUVLBgsBV23oEetbrMmF1gp4mlkFpOiL
 pRCuN4NrTxYEu54HQrJp5CzUOzNiye+dxumMid5vUcw7PXDy3QPxyMaxlC459vU5xZMK
 YK/e1l8X1vGM8TD/hY/kzWEFaPbjf3Y52R0j1H9u7ZYb/p185nhNZljuVCUJim2YkxMO
 z9mVxTtvBq6AH+7ZlNlRcsjJ1Zn7qLZs0e2Ez88n/N8gXVjxabzJZIfCpyJMpz4Jy8VY
 T42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3cfrqeC7LyJB/ROXN1SmwKtiOawGwvTqMSrbdq/eHoM=;
 b=HpMIc7LiLSZDDw7FqHBiht1X/oDtQZPyPH78KLjHe7mY0GgPdDRIwTS+sVaUFuHw02
 yHCsEhRvQ5WiUBQE0T4ch4tVuN4+a5EkKmbt0H8wfyHvLTLZPCqRWLQ+zr2Ml2eXn6b0
 CZR7u3ZtDP1c6Y8DSzRCgC9Ho48EykuF1TCmRTpyidRbawXxv2HXHySSmrqgO03ZGC7Z
 0E9xK90RIyNMARJFvEq4xcD2C9wBWG1h5Ppj8cGuFRHyNjcZAnipR3D2rEtAVPFCfm6V
 R2W6gsxDEj4d5+Yvy9UVQ/ObjGk8o+ycu9j8suuCchqNlR0XiBcvl372++spf726fln+
 rRfg==
X-Gm-Message-State: APjAAAXIGnQ+ZShuAAIyAn4ab1ndpcnzhQOfuq1tX2B0l1UIKktS/mq4
 ndZiQ01QDsthzPN3g257S04LesYKS08=
X-Google-Smtp-Source: APXvYqzsoQCugEJErcw3TD9yOUmLcITA53WIVuVhoFiHvqoOaHqDE72+qCXQg4UrRiS1S0ExEBPUsA==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr5159576pgr.206.1568829776074; 
 Wed, 18 Sep 2019 11:02:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm13319518pfb.54.2019.09.18.11.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 11:02:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 11:02:48 -0700
Message-Id: <20190918180251.32003-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918180251.32003-1-richard.henderson@linaro.org>
References: <20190918180251.32003-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [RFC v2 2/5] cputlb: Replace switches in
 load/store_helper with callback
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

Add a function parameter to perform the actual load/store to ram.
With optimization, this results in identical code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 159 +++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 76 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2222b87764..b4a63d3928 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1280,11 +1280,38 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
+typedef uint64_t LoadHelper(const void *);
+
+/* Wrap the unaligned load helpers to that they have a common signature.  */
+static inline uint64_t wrap_ldub(const void *haddr)
+{
+    return ldub_p(haddr);
+}
+
+static inline uint64_t wrap_lduw_be(const void *haddr)
+{
+    return lduw_be_p(haddr);
+}
+
+static inline uint64_t wrap_lduw_le(const void *haddr)
+{
+    return lduw_le_p(haddr);
+}
+
+static inline uint64_t wrap_ldul_be(const void *haddr)
+{
+    return (uint32_t)ldl_be_p(haddr);
+}
+
+static inline uint64_t wrap_ldul_le(const void *haddr)
+{
+    return (uint32_t)ldl_le_p(haddr);
+}
 
 static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
-            FullLoadHelper *full_load)
+            FullLoadHelper *full_load, LoadHelper *direct)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1373,33 +1400,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        res = ldub_p(haddr);
-        break;
-    case MO_BEUW:
-        res = lduw_be_p(haddr);
-        break;
-    case MO_LEUW:
-        res = lduw_le_p(haddr);
-        break;
-    case MO_BEUL:
-        res = (uint32_t)ldl_be_p(haddr);
-        break;
-    case MO_LEUL:
-        res = (uint32_t)ldl_le_p(haddr);
-        break;
-    case MO_BEQ:
-        res = ldq_be_p(haddr);
-        break;
-    case MO_LEQ:
-        res = ldq_le_p(haddr);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    return res;
+    return direct(haddr);
 }
 
 /*
@@ -1415,7 +1416,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
+    return load_helper(env, addr, oi, retaddr, MO_UB, false,
+                       full_ldub_mmu, wrap_ldub);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1428,7 +1430,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
-                       full_le_lduw_mmu);
+                       full_le_lduw_mmu, wrap_lduw_le);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1441,7 +1443,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
-                       full_be_lduw_mmu);
+                       full_be_lduw_mmu, wrap_lduw_be);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1454,7 +1456,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
-                       full_le_ldul_mmu);
+                       full_le_ldul_mmu, wrap_ldul_le);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1467,7 +1469,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
-                       full_be_ldul_mmu);
+                       full_be_ldul_mmu, wrap_ldul_be);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1480,14 +1482,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
-                       helper_le_ldq_mmu);
+                       helper_le_ldq_mmu, ldq_le_p);
 }
 
 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
-                       helper_be_ldq_mmu);
+                       helper_be_ldq_mmu, ldq_be_p);
 }
 
 /*
@@ -1530,9 +1532,38 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
+typedef void StoreHelper(void *, uint64_t);
+
+/* Wrap the unaligned store helpers to that they have a common signature.  */
+static inline void wrap_stb(void *haddr, uint64_t val)
+{
+    stb_p(haddr, val);
+}
+
+static inline void wrap_stw_be(void *haddr, uint64_t val)
+{
+    stw_be_p(haddr, val);
+}
+
+static inline void wrap_stw_le(void *haddr, uint64_t val)
+{
+    stw_le_p(haddr, val);
+}
+
+static inline void wrap_stl_be(void *haddr, uint64_t val)
+{
+    stl_be_p(haddr, val);
+}
+
+static inline void wrap_stl_le(void *haddr, uint64_t val)
+{
+    stl_le_p(haddr, val);
+}
+
 static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
+             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
+             StoreHelper *direct)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1657,74 +1688,49 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        stb_p(haddr, val);
-        break;
-    case MO_BEUW:
-        stw_be_p(haddr, val);
-        break;
-    case MO_LEUW:
-        stw_le_p(haddr, val);
-        break;
-    case MO_BEUL:
-        stl_be_p(haddr, val);
-        break;
-    case MO_LEUL:
-        stl_le_p(haddr, val);
-        break;
-    case MO_BEQ:
-        stq_be_p(haddr, val);
-        break;
-    case MO_LEQ:
-        stq_le_p(haddr, val);
-        break;
-    default:
-        g_assert_not_reached();
-        break;
-    }
+    direct(haddr, val);
 }
 
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_UB);
+    store_helper(env, addr, val, oi, retaddr, MO_UB, wrap_stb);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW, wrap_stw_le);
 }
 
 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW, wrap_stw_be);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL, wrap_stl_le);
 }
 
 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL, wrap_stl_be);
 }
 
 void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEQ);
+    store_helper(env, addr, val, oi, retaddr, MO_LEQ, stq_le_p);
 }
 
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEQ);
+    store_helper(env, addr, val, oi, retaddr, MO_BEQ, stq_be_p);
 }
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
@@ -1789,7 +1795,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true,
+                       full_ldub_cmmu, wrap_ldub);
 }
 
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1802,7 +1809,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu);
+                       full_le_lduw_cmmu, wrap_lduw_le);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1815,7 +1822,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu);
+                       full_be_lduw_cmmu, wrap_lduw_be);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1828,7 +1835,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu);
+                       full_le_ldul_cmmu, wrap_ldul_le);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1841,7 +1848,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu);
+                       full_be_ldul_cmmu, wrap_ldul_be);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1854,12 +1861,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
-                       helper_le_ldq_cmmu);
+                       helper_le_ldq_cmmu, ldq_le_p);
 }
 
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
-                       helper_be_ldq_cmmu);
+                       helper_be_ldq_cmmu, ldq_be_p);
 }
-- 
2.17.1


