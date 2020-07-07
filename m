Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A98020702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2iIUful"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A98020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshxZ-0000rq-U4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoU-00076y-Ub
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoS-0004vQ-Bo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id 22so42135429wmg.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WQFoNRo6TyQ2t2BXDRqFhlPss5nm1nW+xtYpQWhCpNM=;
 b=w2iIUfulOVmngzyazVWkARRyDYpTUf0QsupyXUuItaDjo6+kBI+6OIhvcW6HpvexsS
 AUsYlt1NaCbwKrUD2Nzk8kYukkCBjeAmPzpyJG1NWaJLlINIS3j1aZM8v1F3T/Mt3Hii
 KwTsqBfMuzEP0QsGlpN3+1+4kMB5qJlf3Z9X4V6mM9bY72hKorpCZmF6QeN6owTtz9ft
 cG7rXtGqZ2zCMMn8M1DsyinXSbXhiuyilbM/pVXGrRX7KDeDrpV+akqiwwfvTXRlEr9F
 YdSlw5iPhSqMRFE0PMrIb0BpEmJIJsHhnOSQH17VzZg7yAgU0l6x3cE3mwN20+43KYPW
 /Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WQFoNRo6TyQ2t2BXDRqFhlPss5nm1nW+xtYpQWhCpNM=;
 b=JvnPMfSWUk+nJZ5fVXb+EwGKEa3r9t5WuFDwT4rfFnjWWUysDwDWCFKej/LuumP2B+
 Ux3s16DvvmupZT3Wg56y3B4er5YR5+C1oe2uUY2CO7J4iB2lMFDPJf0TOWb9z0WBp5X6
 vySwU1zGsNMUtKvuFQ6ttS/JDFmCoxZjA7EL1HXEmFtOT4ih8q+TNQg9f3Mb19CT5PEW
 XsQfYDMFQZFgte6J5QYElufQJTZXlbEqtTmQTbBBNOXHlijYZnIe2oL8vxYWKGV98teL
 m6+ENdzHP93NBa93BT1Lj8hdGysC37Gm/cpN+Lbkylg2JL3ZRzbEE3vyjwEnRPzyzXxK
 zN5A==
X-Gm-Message-State: AOAM533KX0Ix0O+AhLbT4uY9OduF4q2EwR8J9Z6gtozTC/UFTmKXxVJf
 j9vmyjTUAHirfPLDQAMY9ST4bg==
X-Google-Smtp-Source: ABdhPJxrG4RboF9zdTlPHJSuxx2TOHqNcoMggtYbiw/mjX60XgQvTLABslwbW/GH4cQ7LfWN9JDkHw==
X-Received: by 2002:a1c:1d93:: with SMTP id d141mr2570402wmd.14.1594106082670; 
 Tue, 07 Jul 2020 00:14:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 63sm28575200wra.86.2020.07.07.00.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 704181FFC1;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 40/41] tests/qht-bench: Adjust testing rate by -1
Date: Tue,  7 Jul 2020 08:08:57 +0100
Message-Id: <20200707070858.6622-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Emilio G . Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Since the seed must be non-zero, subtracting 1 means puts the
rate in 0..UINT64_MAX-1, which allows the 0 and UINT64_MAX
thresholds to corrspond to 0% (never) and 100% (always).

Suggested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200626200950.1015121-2-richard.henderson@linaro.org>

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index eb88a9013761..ad885d89d054 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -25,7 +25,13 @@ struct thread_stats {
 struct thread_info {
     void (*func)(struct thread_info *);
     struct thread_stats stats;
-    uint64_t r;
+    /*
+     * Seed is in the range [1..UINT64_MAX], because the RNG requires
+     * a non-zero seed.  To use, subtract 1 and compare against the
+     * threshold with </>=.  This lets threshold = 0 never match (0% hit),
+     * and threshold = UINT64_MAX always match (100% hit).
+     */
+    uint64_t seed;
     bool write_op; /* writes alternate between insertions and removals */
     bool resize_down;
 } QEMU_ALIGNED(64); /* avoid false sharing among threads */
@@ -131,8 +137,9 @@ static uint64_t xorshift64star(uint64_t x)
 static void do_rz(struct thread_info *info)
 {
     struct thread_stats *stats = &info->stats;
+    uint64_t r = info->seed - 1;
 
-    if (info->r < resize_threshold) {
+    if (r < resize_threshold) {
         size_t size = info->resize_down ? resize_min : resize_max;
         bool resized;
 
@@ -151,13 +158,14 @@ static void do_rz(struct thread_info *info)
 static void do_rw(struct thread_info *info)
 {
     struct thread_stats *stats = &info->stats;
+    uint64_t r = info->seed - 1;
     uint32_t hash;
     long *p;
 
-    if (info->r >= update_threshold) {
+    if (r >= update_threshold) {
         bool read;
 
-        p = &keys[info->r & (lookup_range - 1)];
+        p = &keys[r & (lookup_range - 1)];
         hash = hfunc(*p);
         read = qht_lookup(&ht, p, hash);
         if (read) {
@@ -166,7 +174,7 @@ static void do_rw(struct thread_info *info)
             stats->not_rd++;
         }
     } else {
-        p = &keys[info->r & (update_range - 1)];
+        p = &keys[r & (update_range - 1)];
         hash = hfunc(*p);
         if (info->write_op) {
             bool written = false;
@@ -208,7 +216,7 @@ static void *thread_func(void *p)
 
     rcu_read_lock();
     while (!atomic_read(&test_stop)) {
-        info->r = xorshift64star(info->r);
+        info->seed = xorshift64star(info->seed);
         info->func(info);
     }
     rcu_read_unlock();
@@ -221,7 +229,7 @@ static void *thread_func(void *p)
 static void prepare_thread_info(struct thread_info *info, int i)
 {
     /* seed for the RNG; each thread should have a different one */
-    info->r = (i + 1) ^ time(NULL);
+    info->seed = (i + 1) ^ time(NULL);
     /* the first update will be a write */
     info->write_op = true;
     /* the first resize will be down */
-- 
2.20.1


