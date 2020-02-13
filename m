Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D9C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5FC20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLe/bGVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5FC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NNU-0001w0-Ri
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKH-0004dH-Or
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKG-0003gU-N3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKG-0003eD-HM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so8061213wmh.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V4YbJuHMHTKZppvspX7lYfndG26GXtbu1NuW0h2HVeE=;
 b=KLe/bGVBvPm8isgWPAVPHM5oSTWD5CeeAi+60HnDmHOsABIrSO582YnKMq/c4eWdI+
 5HAN3ZFukntEWg92EoiWUOHZZBoG9nAyAS2LQjzbhbnmsJppYf7IwMsKm+LcuKabBQXH
 dZL/NmjPCDG8N0eb58+nwLyC3poEjVNWm0OrX4gvWKDTYgpkW0FZ9Xl/4Iu0pdowwRHW
 rIO0kDlghWSDPYrMKqr/UDo0IB486bGDRDe1aaoXeTLm7x7NDfFq2MIAL6rseYmwHuJj
 DgiyXy/IuTNgzOx99Y+wdZCprdUptPXt5o8MKi7+iRn3YuEkIdw1UV6MD+Qa/mJjGGMg
 tp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V4YbJuHMHTKZppvspX7lYfndG26GXtbu1NuW0h2HVeE=;
 b=XwokRkDb87ykg4C9BW+zQPhMXBj/PTqy6iPsmk1Oebbeys8z4FF3x3UVJRuHNQQsqI
 Rfzjs5NuZjgA6LOTVD+k6TflJ3nd5aayi0E1+B7WTdGqaJwKEnMv0c+CCnzDoBD0uAx0
 sGzlbr3mTtxR2G8/XUM3515o13gP1hYWn+mQQ8EjG4QRlJZjLGKn0CBqw2xFH8Ti0Wza
 qu3OzadxKI/lQEYBCcFlwI6CXS1hFFrK6pVGextPcfq3P2AxKy1XDNXsU/BhrfX3fG+4
 fbTzU1hnIhq4oy76FkEsGCfTkZrLGWPXAZepTdh9N9NhY0kEX3msziVOAMFa2iHZhttd
 s83w==
X-Gm-Message-State: APjAAAXxnsRiXc3OzI6l3AkWhZ1us+cv6uDcuAMULEqBcXxoUFfGDilS
 0Z9MNhbduulbLZDpuDG0ySOBjA==
X-Google-Smtp-Source: APXvYqyEwMhtzPyHjDRZ7z6eYNtlegfxYMH5pBb0ztJREu7summCryspAf/p07NpNkOq4RTO5Tnl+A==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr328313wmd.92.1581634275415; 
 Thu, 13 Feb 2020 14:51:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm4753745wmj.42.2020.02.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF7711FF90;
 Thu, 13 Feb 2020 22:51:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/19] tests/rcutorture: better document locking of stats
Date: Thu, 13 Feb 2020 22:50:53 +0000
Message-Id: <20200213225109.13120-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


