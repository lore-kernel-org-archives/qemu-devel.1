Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EFC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1CB20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxaxL3XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1CB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j020a-0004bO-UW
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z9-0002sx-52
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z8-0005iy-2g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01z7-0005hS-SC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so2265090wmb.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y4d6Sguo40PEMFEa1p9tKAqrtcGlKPa27ISKFx3kAqI=;
 b=xxaxL3XOk3IDVbga8LKTZmCLe/MHkX23MmNEtqohD2umfyItiXSveJjh5a4SjHwFFe
 8I93g7ZLOJhRZ62nIMc5t50jAGhJOrwCpSQeinSI41ALjlOJPcjDSP3csld8r/Yixyt8
 QvlKFABopqjjHkK2O8d7aYAzufhN16g1Otc60AtZ4PAhurwk09t53VqZbYDG89ZYKJkz
 eGdj8Klcj9fWhJlZ5pI7He86f0OClxvng2C5FbeSc8nAmSPM0rKQ3LyUdwL3Y9A/VglJ
 e3LLfJXhxBPCgphF8YGesQqCWSq/8mqcQqqAveUkxYh6Btqp7AAE1coc6TjB07HU6BjJ
 YaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4d6Sguo40PEMFEa1p9tKAqrtcGlKPa27ISKFx3kAqI=;
 b=AdcIZiq1ZNcFv2U88BhOU8yQaJ1PzgVYRpYFjBczmbd+oGGyt9FuVTHIRjq/sb67sP
 pZvhtTHBrRrqr9XrjIL/EfIjQB4dU1eXeMBplbcfhzh+wdL4ADLponJq7ueJ1Q83hJS7
 2Xi0vjhI6YWtCZIxpNw3qm0MKHw3u/caOtP1EgrdDbkWu7IL7AQ3Uw5X9NQcui/ztfv4
 Xpt8xVfxegl9ESEABd5/pHg2xgbzVVGYvWw9Arq4MrhDnYiWVOj2VGM7v7/qOCbeagVb
 TP6YyYN5MnvRGq37vRMArq6b1rpuDyhsQGd/lgNuvnAgFf42BIG/nzXXFaM+Ola/nlBH
 Aazw==
X-Gm-Message-State: APjAAAXNyQPsvgmyDkDPz5srbpVYUjxcR3QnvUQ1dX9i9clSe9CfZv0O
 yoHW7SfaXzZtJNZ6Z2vQBoVDcQ==
X-Google-Smtp-Source: APXvYqwQsuBWOql+9b9V/MTI2aE8Bq8cOBX55jN/KLkZR0+KNn4wL0NwpjNiRyA1gQq/pOT9P45Q4Q==
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr3908121wmj.2.1581075584796; 
 Fri, 07 Feb 2020 03:39:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm2954784wmj.42.2020.02.07.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B27191FF90;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/5] tests/rcutorture: better document locking of stats
Date: Fri,  7 Feb 2020 11:39:37 +0000
Message-Id: <20200207113939.9247-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207113939.9247-1-alex.bennee@linaro.org>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is pure code motion with no functional effect.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/rcutorture.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index e8b2169e7dd..256d24ed5ba 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -65,8 +65,6 @@
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
 
-long long n_reads = 0LL;
-long n_updates = 0L;
 int nthreadsrunning;
 
 #define GOFLAG_INIT 0
@@ -78,11 +76,20 @@ static volatile int goflag = GOFLAG_INIT;
 #define RCU_READ_RUN 1000
 
 #define NR_THREADS 100
-static QemuMutex counts_mutex;
 static QemuThread threads[NR_THREADS];
 static struct rcu_reader_data *data[NR_THREADS];
 static int n_threads;
 
+/*
+ * Statistical counts
+ *
+ * These are the sum of local counters at the end of a run.
+ * Updates are protected by a mutex.
+ */
+static QemuMutex counts_mutex;
+long long n_reads = 0LL;
+long n_updates = 0L;
+
 static void create_thread(void *(*func)(void *))
 {
     if (n_threads >= NR_THREADS) {
@@ -230,8 +237,9 @@ struct rcu_stress {
 struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] = { { 0 } };
 struct rcu_stress *rcu_stress_current;
 int rcu_stress_idx;
-
 int n_mberror;
+
+/* Updates protected by counts_mutex */
 long long rcu_stress_count[RCU_STRESS_PIPE_LEN + 1];
 
 
-- 
2.20.1


