Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E030BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3B12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngvvf0m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3B12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFgm-0002c3-Bn
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFeg-0000ma-Q2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFef-0003t6-Ge
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:46 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:39046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFef-0003rX-9k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:45 -0500
Received: by mail-pg1-x529.google.com with SMTP id b137so431722pga.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L1jHeOFQAeKhXPKxXaTdBBGGRizQ9egD6BUcKiL091Y=;
 b=ngvvf0m12phzezTxO2R/YcUIPZttTSx5rUZkNwmrZd9CJvyXaHKmSBwFwasG6yS2Kx
 VC2iXGzvqnwiKw9gs1BrFMXn23Um0XPlAnOKXghBpCsLoA5+74taJcyfE5ZBqhXY5ARO
 S2lqnlFdACthxnPyotpgsjLaJwQrvJfJ000vxUdHHrze3Y9cyoBl1FZmz4PTHZxudcLa
 tPxONjESayKzV1v+og8bZt33DEV3LzKORVBOlTfLjXNeXwCZ+PfpoIAX750aEHT0Lh/q
 Ao6y5Y3TEcTrbuvaBPJgvt2cn3G2CmmwII/jAzB7QC4W6OyZyAFoB0yXgmv7fr3YKlaf
 K5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1jHeOFQAeKhXPKxXaTdBBGGRizQ9egD6BUcKiL091Y=;
 b=JS/r/SAR8rCg+Hp86akag03Xd7wddhZzlPG8jpxpXIsOgVgagCqQLZ2z2ztAo0VMci
 5YddoJIFtSF9Gy7aNHew6IiSqSCcEtK+TBQRyyQzp5Heo2uQoZmzVBOp/QTPNLp7fyGg
 o4D37J1pUy3BaDcbQwN0SY2R81noi/XbwzD1Q7adgeKJo/5+QvM2ybaakcrgo5dpDGmG
 Q+ni/2HSneSPuPAuR5oWyiMW/i2Pp3bwYPExsn05JzUmQ6Z+6ncWN/PxlKM1eyoW0mYl
 Z8o1hNYSVbyHfJlNIiLTbA45Co0nzC+CqGFFlhM5J27SX65d331NUr9ayyaekNt8I55e
 ZPvg==
X-Gm-Message-State: APjAAAUP+PRF+BNhSIzO3nl0H9QZ2HDkfEmEEOL9XzU8mmWd3rS+Ks6T
 9Qcp91HXC758eDm8jioOJGxuPjc47zU=
X-Google-Smtp-Source: APXvYqxfaCQmHRuuKkF75x9C41n5WRwksRRQxPLZEG91AdQdn8RrfmRZRbPasXReMJKEsTWo0wyDxw==
X-Received: by 2002:a62:7c54:: with SMTP id x81mr7370703pfc.180.1576123243988; 
 Wed, 11 Dec 2019 20:00:43 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/28] cputlb: Use trace_mem_get_info instead of
 trace_mem_build_info
Date: Wed, 11 Dec 2019 20:00:13 -0800
Message-Id: <20191212040039.26546-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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

In the cpu_ldst templates, we already require a MemOp, and it
is cleaner and clearer to pass that instead of 3 separate
arguments describing the memory operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_template.h          | 22 +++++++++++-----------
 include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 54b5e858ce..0ad5de3ef9 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -86,9 +86,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     RES_TYPE res;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
+    MemOp op = MO_TE | SHIFT;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx);
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -96,9 +96,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
-                                                            oi, retaddr);
+                                                               oi, retaddr);
     } else {
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
@@ -125,9 +125,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     int res;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx);
+    MemOp op = MO_TE | MO_SIGN | SHIFT;
+#ifndef SOFTMMU_CODE_ACCESS
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -135,7 +135,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op & ~MO_SIGN, mmu_idx);
         res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
                                MMUSUFFIX)(env, addr, oi, retaddr);
     } else {
@@ -167,9 +167,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
+    MemOp op = MO_TE | SHIFT;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx);
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, true);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -177,7 +177,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(tlb_addr_write(entry) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
                                                      retaddr);
     } else {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index dbdc7a845d..e5a3d1983a 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -70,8 +70,8 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
 #else
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
@@ -102,8 +102,8 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
 #else
-    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | MO_SIGN | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
@@ -131,8 +131,8 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, true);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-- 
2.20.1


