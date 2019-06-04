Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBBF2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvFhHb3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBBF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYG9x-00026z-0J
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:35:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG86-0000uf-Pl
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG85-0003xs-L3
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:33:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG85-0003xQ-GK
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:33:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id m206so1328480oib.12
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=SsD841efZqo7uciuvvdZgxC3XyiWIUZWbge19pY103g=;
	b=KvFhHb3SAShtgHAUjH5dqVDJqyjIl8If/pMPiuRNI9c8DBuTUIonor4lXyQHWwUvzI
	jJ16f3R+Si68LJPYUARZ5kis6dOukRny8PmscbO4vlQ5kcww4ze6dEKZ4MOawxoieHmd
	7AJ6iJlIjh9fdzY/XIQnU8Y12e4wFqtWeI91Ah1x78HNM6iwzr43Waz398KZr7WsT63G
	rgTkc/8y2NeAKNme8m5bl0VtJrFEfoSjGRTDYzWTcvK6iKMwFED+lkfWUWHAbjBXXWrx
	Udt0m0py2GYJWhJ1awF/VrsrlLMs8bv1rjsdwAjgbtCAfK72S4i2cPsiCREzqAq8VjMq
	oRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SsD841efZqo7uciuvvdZgxC3XyiWIUZWbge19pY103g=;
	b=GttKA2EL+DItZ09Sq3fAg9kHT25jeUWoExtzbhoq5dLLFBj4Tb6C6FXJ2ZkCwxzlgK
	ttkOUpVKveDXgfaTlmppEDS5pjxNo1JkEIoqpPN1SQpNt2Rhy+2SPmF8yx9pSszUodF9
	rkL0Rux4Yjfa0Dto+yl37ARlqv/Ydj4JvWxoTblm2MuqQiGWvIYLt4Iaz9K8g/X/kD/W
	8qc5GykRK2dmSrYy0kwWflpOYd5dUVD4cnlGibtWQEnXoD0pDDAd/8UlD5SM3vXd2UJS
	dgjqcsbHklIcNsZVSun3/0jZpOkBrHjm3XiReWZPgQRkFwBOX3MMipf9wL1k+jl0bd4r
	OxAA==
X-Gm-Message-State: APjAAAXq4uNtFiza7eAFj1X98CedApAzj1T9n7Xu31S2kFuppteoKqFs
	0DBemvLkCJaHtXr6E8hDqarlTazXispYwg==
X-Google-Smtp-Source: APXvYqx6X1YmYVinTn4WPjQRdsjrBsWOrrsHldQ+RN0PhZfeX3Rc/3AfKYarTGqgsKKRH8XRiNTykA==
X-Received: by 2002:aca:5b57:: with SMTP id p84mr5549475oib.4.1559680436510;
	Tue, 04 Jun 2019 13:33:56 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.33.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:33:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:13 -0500
Message-Id: <20190604203351.27778-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v4 01/39] tcg: Fold CPUTLBWindow into CPUTLBDesc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both structures are allocated once per mmu_idx.
There is no reason for them to be separate.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 17 ++++-------------
 accel/tcg/cputlb.c      | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 8f2a848bf5..52d150aaf1 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -127,18 +127,6 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
-/**
- * struct CPUTLBWindow
- * @begin_ns: host time (in ns) at the beginning of the time window
- * @max_entries: maximum number of entries observed in the window
- *
- * See also: tlb_mmu_resize_locked()
- */
-typedef struct CPUTLBWindow {
-    int64_t begin_ns;
-    size_t max_entries;
-} CPUTLBWindow;
-
 typedef struct CPUTLBDesc {
     /*
      * Describe a region covering all of the large pages allocated
@@ -148,9 +136,12 @@ typedef struct CPUTLBDesc {
      */
     target_ulong large_page_addr;
     target_ulong large_page_mask;
+    /* host time (in ns) at the beginning of the time window */
+    int64_t window_begin_ns;
+    /* maximum number of entries observed in the window */
+    size_t window_max_entries;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
-    CPUTLBWindow window;
     size_t n_used_entries;
 } CPUTLBDesc;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdcc377102..41f2296f93 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -79,11 +79,11 @@ static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
     return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
 }
 
-static void tlb_window_reset(CPUTLBWindow *window, int64_t ns,
+static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
                              size_t max_entries)
 {
-    window->begin_ns = ns;
-    window->max_entries = max_entries;
+    desc->window_begin_ns = ns;
+    desc->window_max_entries = max_entries;
 }
 
 static void tlb_dyn_init(CPUArchState *env)
@@ -94,7 +94,7 @@ static void tlb_dyn_init(CPUArchState *env)
         CPUTLBDesc *desc = &env->tlb_d[i];
         size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
 
-        tlb_window_reset(&desc->window, get_clock_realtime(), 0);
+        tlb_window_reset(desc, get_clock_realtime(), 0);
         desc->n_used_entries = 0;
         env->tlb_mask[i] = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
         env->tlb_table[i] = g_new(CPUTLBEntry, n_entries);
@@ -151,18 +151,18 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
     int64_t now = get_clock_realtime();
     int64_t window_len_ms = 100;
     int64_t window_len_ns = window_len_ms * 1000 * 1000;
-    bool window_expired = now > desc->window.begin_ns + window_len_ns;
+    bool window_expired = now > desc->window_begin_ns + window_len_ns;
 
-    if (desc->n_used_entries > desc->window.max_entries) {
-        desc->window.max_entries = desc->n_used_entries;
+    if (desc->n_used_entries > desc->window_max_entries) {
+        desc->window_max_entries = desc->n_used_entries;
     }
-    rate = desc->window.max_entries * 100 / old_size;
+    rate = desc->window_max_entries * 100 / old_size;
 
     if (rate > 70) {
         new_size = MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);
     } else if (rate < 30 && window_expired) {
-        size_t ceil = pow2ceil(desc->window.max_entries);
-        size_t expected_rate = desc->window.max_entries * 100 / ceil;
+        size_t ceil = pow2ceil(desc->window_max_entries);
+        size_t expected_rate = desc->window_max_entries * 100 / ceil;
 
         /*
          * Avoid undersizing when the max number of entries seen is just below
@@ -182,7 +182,7 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
 
     if (new_size == old_size) {
         if (window_expired) {
-            tlb_window_reset(&desc->window, now, desc->n_used_entries);
+            tlb_window_reset(desc, now, desc->n_used_entries);
         }
         return;
     }
@@ -190,7 +190,7 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
     g_free(env->tlb_table[mmu_idx]);
     g_free(env->iotlb[mmu_idx]);
 
-    tlb_window_reset(&desc->window, now, 0);
+    tlb_window_reset(desc, now, 0);
     /* desc->n_used_entries is cleared by the caller */
     env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
     env->tlb_table[mmu_idx] = g_try_new(CPUTLBEntry, new_size);
-- 
2.17.1


