Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BABC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A859207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBAm1099"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A859207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9fz-0007Z4-OO
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9di-0005Zq-Ct
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dg-0001ZD-7g
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:26 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9dg-0001Yt-1X
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:24 -0400
Received: by mail-pg1-x543.google.com with SMTP id s27so4160181pgl.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SsD841efZqo7uciuvvdZgxC3XyiWIUZWbge19pY103g=;
 b=CBAm1099LtYSIKw0sl/uMXhR+PRHUjz7KHQV9pVsJXf1YGCNImXpZZahy/pLWNHMkK
 rdzw5H2ob1r6rOT3JBBUVwclbMxYVfWRQRVFfxUsF4EpYhHFfpMHrC0cgaZGY3TE3FaA
 FqtTU/A0yPJDFBwsPr9Hk2wHtYPJWrdBQ5Ea5tGYSDyGB2Eabsd9Lpqh7pfMb77y7kRO
 fOCPISv6Cn3b8dzZO3kUMojKDoXKEvxLE47L3Qd1pdUsSIGbExxDxQitYwebRODHFXZq
 s0OtoLhdtKPH3N9EI8dfbOjYEvBNr/4uW1SawJgbejOKrzIBbgAMOwZ68qc7tzrKa/in
 Uu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SsD841efZqo7uciuvvdZgxC3XyiWIUZWbge19pY103g=;
 b=kTJjDR2cGtj/wBB2yCbi5dOhAHAdYi3oHnIbhHmVnK39DwzZBD3IZ93BqTH86PS628
 pMOKKATarUyvj/QhnPW07NDXili8gTKMEIefeH28TDKIGTSWsRaBBMp2iKaf7aGz9XCI
 tJLSCDWNpahawld5G72mMdPqhUvM4sHVoZn1ZD7Ah1d4hSMlExwldA1Gsm1gu7S2GJm2
 sucwxzn/exZpogRqUOCDcnaU0Dq3xGVICpSHLLtCJo9TLzwWFCtszlOL+zlFBxNZhieU
 Ma5LFffG4FJYgRh5WSVig8s91kJ/wvHZwhujzADnOP2/B64zz3oYeEw/ZSvqoR+1j5bH
 2SDw==
X-Gm-Message-State: APjAAAVT9niqonjU0cJFgq0dps7s8rEuFTJHJJJCFTR0/Fro80nscA6D
 5S/YGtCq39vPoMo6kJmxpecs2rLBwD8=
X-Google-Smtp-Source: APXvYqxJbL5L+IsaVWHZ+SWvWFk4QO4gZkUVVYizGndzSkrJSVIEd2I7hpJDPLQjaabkrkvz6zQ2hw==
X-Received: by 2002:a65:6495:: with SMTP id e21mr13441057pgv.383.1560132142263; 
 Sun, 09 Jun 2019 19:02:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:40 -0700
Message-Id: <20190610020218.9228-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PULL 01/39] tcg: Fold CPUTLBWindow into CPUTLBDesc
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
Cc: peter.maydell@linaro.org
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


