Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA8C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3BB20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPOEHmqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3BB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8VK9-0004lm-1Z
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8VFn-00014n-64
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8VFl-0005JS-BR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:43 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8VFl-0005JJ-6G
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:59:41 -0400
Received: by mail-qt1-x843.google.com with SMTP id j1so18385629qth.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3cfrqeC7LyJB/ROXN1SmwKtiOawGwvTqMSrbdq/eHoM=;
 b=xPOEHmqUwNDoV4uZBnI4rf2lRL/w4aaG/izxiSgujwOLkTQXVJXtbl5h0i4bjyj/pq
 jy92I9tdGZLk5aFvGeTRFxGJKnbkVoiM4g8dn3815rrjpMTE2GXFVed06yjejGtPoSp4
 Ylh/d/Kk+cFHRumzs/+CYZqlmX5hwXcbq8nGLWHi7zDfXjScdq6NIK4jGLR1H9o84QRf
 KUxmpjYdTR64eEqOJNs+G/7lBqQZLQtAqUz6ebGdsvPobxb+O9LCqChQ28zl+k9tQ6ll
 vf16pXzrVg1lhYZlo5shWorGs3yy3sinhlnu+hHtK7PNh/wtdZLERtR2BCRT59IhaERY
 fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3cfrqeC7LyJB/ROXN1SmwKtiOawGwvTqMSrbdq/eHoM=;
 b=fAuhllzMOYgSMi3Sf3GyOoqLjC5KJba9HfNmSwUaPkta18nCtA3qyL787GbU3kAAIG
 ckAA5XOC7lIBIx3w8txMBOrJxVKoefrBJH+S1Ud6nX7tsYTLL2etZGwn/SQP8W2fAD4b
 gdPsI3dEG2r+9e/5wkVdQaBEnpZDn9VKD5h8pdE4QtnQx4oQCga0PmoDwcUFEX1bCGLA
 jfyuelBAcp1TQ8/P3YtN1RjI7pDqsjEaTeyBBH0FnRiV6XwCRz2WYlPwGlgldAXOmCEq
 CDslQ8gXPgolGuSEUUfzOXP+ApT3LQlbIiGb8S6wjIw3gFvnPcENQczI9U5SSGU1KdNy
 0Mfg==
X-Gm-Message-State: APjAAAVbTC8N2bZeO2FJ4TNmYoZucdTvnyq0TZ7usAdyXcwcg3szcVQh
 C43rlopprbuTimvMs0Q1x7+YD00oWZ/lXQ==
X-Google-Smtp-Source: APXvYqwF1HIjbKmigmKxU7/d2td+HnoRMr9aJuC2ZpXJAeFiBt4gUZ6RCKjxUdCtPjyeCGu6+s7UOQ==
X-Received: by 2002:ac8:6b12:: with SMTP id w18mr42599227qts.209.1568318379993; 
 Thu, 12 Sep 2019 12:59:39 -0700 (PDT)
Received: from localhost.localdomain ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id k11sm11140897qtp.26.2019.09.12.12.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 12:59:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:59:33 -0400
Message-Id: <20190912195934.13502-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912195934.13502-1-richard.henderson@linaro.org>
References: <20190912195934.13502-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v2 2/3] cputlb: Replace switches in
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk
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


