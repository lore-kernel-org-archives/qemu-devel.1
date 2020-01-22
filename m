Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C058B2087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyIBZv+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C058B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6HQ-00038o-Qw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65q-0005lZ-CH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65p-0002nN-4k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:10 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65o-0002n4-Vb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:09 -0500
Received: by mail-pf1-x444.google.com with SMTP id i6so2571918pfc.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wIDWcLu0KGxPWYY161PaG0CZqx2uLhbLjATvWFH7yr4=;
 b=DyIBZv+a0wSwNfD2qYdhk/N28TFeF53UIc5tH23bi/mH6J7Nr4P0skLOjrhctA9bAJ
 fgftI0nXoLQBQxNkJ8EVjszP08DYfHDKY3Q5EQZTW2/3uz+14vSMNezd6dnn+LBsm8xj
 N1yQIimcgfIUtfpQXZEqTwpr6mrjgDv6mOIxOjD0RqKlWjVdTBmBHaUARP9cRQisy2MI
 lQERy5UHG9joLFErETcqhU6GjoOiZzdDD3tpADDgZUkWxeNDs2L6oh2ZFmeK6H+msIl1
 ye7nrZLg+pQ26Q8eVO4SGjsx30c8XqF27Iw/2crNd410E84ZOc9yBGt6mHppxsmY1q9p
 DkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIDWcLu0KGxPWYY161PaG0CZqx2uLhbLjATvWFH7yr4=;
 b=lBejussY29YwME1SpFw5mbcLCamNiyfKIqP//3bC5pYtcyBc0ctqWCMzZ7q2Bnf0xQ
 ZyA5v+48JdMrtK++xrzac2QvoPXu2G0hH9z9va29mXJnw5ONjsXLm4XI/QD6/SpJk6qB
 fjWpc+R+tGq5Wh+2pzmOlplO7jTvtCXG1TgzLsMSUrp+d1pV3K37RSwRkrplYSS8C0cq
 mjlVFq/dhkRgI/LuRBe5kKLKoyQh4cA2rvVZq+8uy3nmwl49xlVAZiOl3W8YzFIU8cgf
 QWiIzV02+bc8PkJEFGDYaa0F+fQSQUjrAUD9aFYxYmsOdan5cfbYLMKRhARTXCN1tpvT
 mBFQ==
X-Gm-Message-State: APjAAAWIqhIrP/6AMqQL1we1HMCbx3Xxi7ia59zgZOxCbuUDN7NkFKjC
 xVBwgmO9sqJrj1qMDf1stZAXqXvOy9Q=
X-Google-Smtp-Source: APXvYqw5d0HjtBypkDc5Z6nJNZJYWv3GLsqwX6el4aYlHx7Ild43wb98FlLaxXKF4SKbsU/Y+i273Q==
X-Received: by 2002:a63:7d6:: with SMTP id 205mr9003533pgh.131.1579661407680; 
 Tue, 21 Jan 2020 18:50:07 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] cputlb: Hoist tlb portions in tlb_mmu_resize_locked
Date: Tue, 21 Jan 2020 16:49:40 -1000
Message-Id: <20200122024946.28484-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but the smaller expressions make
the code easier to read.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cc6f4c994b..5252bcb949 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -115,8 +115,8 @@ static void tlb_dyn_init(CPUArchState *env)
 
 /**
  * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
- * @env: CPU that owns the TLB
- * @mmu_idx: MMU index of the TLB
+ * @desc: The CPUTLBDesc portion of the TLB
+ * @fast: The CPUTLBDescFast portion of the same TLB
  *
  * Called with tlb_lock_held.
  *
@@ -153,10 +153,9 @@ static void tlb_dyn_init(CPUArchState *env)
  * high), since otherwise we are likely to have a significant amount of
  * conflict misses.
  */
-static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
+static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
-    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
+    size_t old_size = tlb_n_entries(fast);
     size_t rate;
     size_t new_size = old_size;
     int64_t now = get_clock_realtime();
@@ -198,14 +197,15 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
         return;
     }
 
-    g_free(env_tlb(env)->f[mmu_idx].table);
-    g_free(env_tlb(env)->d[mmu_idx].iotlb);
+    g_free(fast->table);
+    g_free(desc->iotlb);
 
     tlb_window_reset(desc, now, 0);
     /* desc->n_used_entries is cleared by the caller */
-    env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
-    env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
-    env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
+    fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+    fast->table = g_try_new(CPUTLBEntry, new_size);
+    desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
+
     /*
      * If the allocations fail, try smaller sizes. We just freed some
      * memory, so going back to half of new_size has a good chance of working.
@@ -213,25 +213,24 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
      * allocations to fail though, so we progressively reduce the allocation
      * size, aborting if we cannot even allocate the smallest TLB we support.
      */
-    while (env_tlb(env)->f[mmu_idx].table == NULL ||
-           env_tlb(env)->d[mmu_idx].iotlb == NULL) {
+    while (fast->table == NULL || desc->iotlb == NULL) {
         if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
             error_report("%s: %s", __func__, strerror(errno));
             abort();
         }
         new_size = MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
-        env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+        fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
 
-        g_free(env_tlb(env)->f[mmu_idx].table);
-        g_free(env_tlb(env)->d[mmu_idx].iotlb);
-        env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
-        env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
+        g_free(fast->table);
+        g_free(desc->iotlb);
+        fast->table = g_try_new(CPUTLBEntry, new_size);
+        desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
     }
 }
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
-    tlb_mmu_resize_locked(env, mmu_idx);
+    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
     env_tlb(env)->d[mmu_idx].n_used_entries = 0;
     env_tlb(env)->d[mmu_idx].large_page_addr = -1;
     env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-- 
2.20.1


