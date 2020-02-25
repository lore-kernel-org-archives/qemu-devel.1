Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13612C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E9C2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wuf1amqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E9C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aRk-0003Pb-0c
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcL-0005MO-Vl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcK-0007CW-Vv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcK-0007Br-Pd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so14544316wrx.11
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V4YbJuHMHTKZppvspX7lYfndG26GXtbu1NuW0h2HVeE=;
 b=Wuf1amqSb6UKAG6mhYgdyoZiZV1IQ6vCZpGsVhYf2nby1Vtx3XfNAEsb17LWHvARL4
 XirsQO8AnDLr/Glnmn+xAmjVWHtswngc/ImRZ6mEodPOosUhKlbmCttXCC52syugLrN/
 JX/Kkl+qtqNNNiTGu32234FM53bsZRXXcpu/yHhV28fYNRU7ZtJzNLbmfbUoQZZOoHdQ
 gU+ZrWyG51v44iIUJRzQTPb6+cg2wBGp88Bw7+Yb0j2YgfT45lldJVb2dfZGM1bjA9V1
 oLdnGQ6tFNv+wICC4UcfhhHK5O/oC5oq6p7ZnqEueM61908hwTOC3NqZGa1t7hFImWjw
 LArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V4YbJuHMHTKZppvspX7lYfndG26GXtbu1NuW0h2HVeE=;
 b=PdafRgygvD98hkBahNFBWkvV6KZhnTGU9Dc6LHi0PI0q3m9jKwjQa2ECLDgwcAvrzA
 9kkMJzePQEJOTcsJhJ0/2DqLXMlDH8Vle/+m6z0khyD/SjuRmfg6BNggMFhNVECoGCON
 lrA4ORxkrgfKAQbYkTpo2QlaFqaLz78q4gee192jimp4BWyr2ebiflYi6AEmsN6J9dPc
 4fkHrugDS+SVMn7UCtz8ddlobhpudSmQOgLi7vadg5r260RXAeX1Mf0QKoQTWHJibW9h
 E3KNitQQkL5mz4bHauYR/LYseNMGkjjiSchRXurzolLSEYftS0qBb29DuI9eUNXntGbr
 1m8w==
X-Gm-Message-State: APjAAAVgmb0KyoPwHupYWOpjoOYhFrrDFGv4t7+BiadNKyAVxDb/rIUC
 nmTyEttMKrBKB2WHVbsB4R6lJA==
X-Google-Smtp-Source: APXvYqzfgppssIo3WIVKveBTketq4Dx8xYCq8CFlWQylfopmueOORCHIki6dEGOC4+IZ1qi3koWchw==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr1769240wrr.276.1582634835609; 
 Tue, 25 Feb 2020 04:47:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm24247090wrx.94.2020.02.25.04.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:13 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8866F1FF90;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/19] tests/rcutorture: better document locking of stats
Date: Tue, 25 Feb 2020 12:46:54 +0000
Message-Id: <20200225124710.14152-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is pure code motion with no functional effect.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


