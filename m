Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A49CC49ED7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065862171F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AM2oLPzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065862171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ria-000314-KO
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 21:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rft-0001ge-BH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rfr-0000aV-MF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:01 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i7rfr-0000aO-Hf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:43:59 -0400
Received: by mail-qk1-x742.google.com with SMTP id i78so19150355qke.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AczcJRqBhC9vS3T7GY2+tfCrph33Cek/6CQ4pFa7LNE=;
 b=AM2oLPzgBVP/F3VK5PreEaT1RH0Q5Iilv3uwuwiFzwRi+sI7mH0Y8Z3GD/YsDaOvtO
 jgHtuA+vYjXoBXXsoUZ7srJkR9/5CUYPizDX7I+x3rMF8qObvaNvr5900KxUrgPY4crs
 +PP4eB3AROkctmQAmsbRHI+biZkAT9s1Qpuc7SiWLUXDXcSNsMN7cyra3BBOF0jb/fNU
 RYdp2gSB2fy9pFOeuNchUsZY4142Nv0fRqBBykAyBkBNiYFrBvC3x2D5QaKr1gBBq5A/
 ugNVYGUfC7CpM0ee5xHPoVTaV5P66KUBZZYSKag0ud/08/GsVAHfNxxtnHKv2eDQhbYY
 4OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AczcJRqBhC9vS3T7GY2+tfCrph33Cek/6CQ4pFa7LNE=;
 b=b0WSdvXrwrEgqmlSkxHmsJ9JLpShxX+2WrXw7lmXkEX7a1wg5Lj5IZ1FBzGSCtNj/n
 cJgr0Yuug31kp4LlYPIcA+T6Byy9SLFPd8l4gMZeka8Hq/PRTBnj+7XyjwNr9OGniGbD
 IhmQ7S5NqT5+qwWmI/OcbWpMRgqbjq2tIGgvHTWHY1N4qKEZuH3BNpv/+9PEaD6/nWt8
 Qy8JsxVTOmE4swSHd/6vwcMnwQUCxIRE5CI2hyLDBahO82qwaFfua2jODPJtY19/SH8C
 KuRsuTbZuvOg2t2MNDdRZ9gT1rGiT50KV8izLQ9DqyNUsUltLi5cLMqw8kRUBWS4kA9D
 493A==
X-Gm-Message-State: APjAAAVi/1Crjk8V7qHG0v4br72rZt6jqR1JgBA6uMmw3AmzaMTowBvB
 6h5RJ1jDSnmhjgwN2VX6HNEohimdRIkbqw==
X-Google-Smtp-Source: APXvYqwJSbjmkUzyszq1BNXFCqSMnAtiSAezFObJYfERwgpvX1Ip52P3lbrk0yqP1yAs7h3dn+N1zw==
X-Received: by 2002:a05:620a:530:: with SMTP id
 h16mr33670016qkh.396.1568166238573; 
 Tue, 10 Sep 2019 18:43:58 -0700 (PDT)
Received: from localhost.localdomain
 (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca. [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id a14sm10074676qkg.59.2019.09.10.18.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 18:43:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 21:43:52 -0400
Message-Id: <20190911014353.5926-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH 2/3] cputlb: Replace switches in
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function parameter to perform the actual load/store to ram.
With optimization, this results in identical code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 157 +++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 76 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 909f01ebcc..e6229d100a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1292,11 +1292,37 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
+typedef uint64_t DirectLoadHelper(const void *);
+
+static inline uint64_t direct_ldub(const void *haddr)
+{
+    return *(uint8_t *)haddr;
+}
+
+static inline uint64_t direct_lduw_be(const void *haddr)
+{
+    return lduw_be_p(haddr);
+}
+
+static inline uint64_t direct_lduw_le(const void *haddr)
+{
+    return lduw_le_p(haddr);
+}
+
+static inline uint64_t direct_ldul_be(const void *haddr)
+{
+    return (uint32_t)ldl_be_p(haddr);
+}
+
+static inline uint64_t direct_ldul_le(const void *haddr)
+{
+    return (uint32_t)ldl_le_p(haddr);
+}
 
 static inline uint64_t ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
-            FullLoadHelper *full_load)
+            FullLoadHelper *full_load, DirectLoadHelper *direct)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1385,33 +1411,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
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
@@ -1427,7 +1427,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
+    return load_helper(env, addr, oi, retaddr, MO_UB, false,
+                       full_ldub_mmu, direct_ldub);
 }
 
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1440,7 +1441,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
-                       full_le_lduw_mmu);
+                       full_le_lduw_mmu, direct_lduw_le);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1453,7 +1454,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
-                       full_be_lduw_mmu);
+                       full_be_lduw_mmu, direct_lduw_be);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
@@ -1466,7 +1467,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
-                       full_le_ldul_mmu);
+                       full_le_ldul_mmu, direct_ldul_le);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1479,7 +1480,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
-                       full_be_ldul_mmu);
+                       full_be_ldul_mmu, direct_ldul_be);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
@@ -1492,14 +1493,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
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
@@ -1542,9 +1543,37 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
+typedef void DirectStoreHelper(void *, uint64_t);
+
+static inline void direct_stb(void *haddr, uint64_t val)
+{
+    *(uint8_t *)haddr = val;
+}
+
+static inline void direct_stw_be(void *haddr, uint64_t val)
+{
+    stw_be_p(haddr, val);
+}
+
+static inline void direct_stw_le(void *haddr, uint64_t val)
+{
+    stw_le_p(haddr, val);
+}
+
+static inline void direct_stl_be(void *haddr, uint64_t val)
+{
+    stl_be_p(haddr, val);
+}
+
+static inline void direct_stl_le(void *haddr, uint64_t val)
+{
+    stl_le_p(haddr, val);
+}
+
 static inline void ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
+             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
+             DirectStoreHelper *direct)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1669,74 +1698,49 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
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
+    store_helper(env, addr, val, oi, retaddr, MO_UB, direct_stb);
 }
 
 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW, direct_stw_le);
 }
 
 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW, direct_stw_be);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL, direct_stl_le);
 }
 
 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL, direct_stl_be);
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
@@ -1801,7 +1805,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true,
+                       full_ldub_cmmu, direct_ldub);
 }
 
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1814,7 +1819,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu);
+                       full_le_lduw_cmmu, direct_lduw_le);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1827,7 +1832,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu);
+                       full_be_lduw_cmmu, direct_lduw_be);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
@@ -1840,7 +1845,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu);
+                       full_le_ldul_cmmu, direct_ldul_le);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1853,7 +1858,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu);
+                       full_be_ldul_cmmu, direct_ldul_be);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
@@ -1866,12 +1871,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
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


