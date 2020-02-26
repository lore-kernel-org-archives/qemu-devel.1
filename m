Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D4C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571292072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSD7nClc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571292072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rJG-0002DL-BS
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI9-0000KH-T7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI8-0002Ov-Vq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rI8-0002MI-Px
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id a141so1056837wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S8rlQzQx2BTIEiZ1sv279qV7IyK6QViRdYXPZhA7VgE=;
 b=fSD7nClc/i8ZjlwD0+V/q4PXpYDMaOLMmA2WeBceP9IYvx1lkocTnLtEWnvZM1LKrG
 WOZTss8OP1SiSiftsqR0GkAhZM0guX8eVLq6XXX2zeiZSXJNDbZ7ZJ2/AL4orJkvQNu9
 B7EJV1b1q3My/IztsJXCc3RpBycyXCvUnt43phKym3uItWnIJTroA8GSX4wO9xoEiGj2
 GCeTUw0O1Rzjgro0xWdwRLlrOaJohVsjA4wjBmOM84c8x+d60Cgjxog2Mxxb5gGknBIL
 Y7AaPJ+XUwtOvFCK47MiAJ5t3sziw+sEJTE8jH2JmCT8hag8IOY/RiJqORqy9edrVJJb
 7ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S8rlQzQx2BTIEiZ1sv279qV7IyK6QViRdYXPZhA7VgE=;
 b=H4btwZ7buF2VI2fEORELc7iSYWdDn8W5nCxsjBo+fqp9s85VLFjcMhyEAyegQQr4H4
 /IJpGID1quagCC3W2glqcytgzWP64k16lKNgHGXd37gtcU9qmkDKZTPfSCawAr/bQ5P5
 LeZvZPS5hk7YBPfe638ZFzJS1xZtPJAh7zbE9W/hbnxMrU/HfuZjoRDojoeM39VIRo1c
 bRNF+nTV54Gakbel03Ph2PnIaRriCenPyIKHX9k+IKQAiaMoTxL6cNbOryIhRPi4b9sw
 2SD6EHwzVBtQQ8xvVoB44E4KBx7r5TXzA8reKiAC5OM5J+qqLJE6nitagiOO/9zsoPyD
 l06w==
X-Gm-Message-State: APjAAAVNZRh6J1JD+NomxcukodecPYVzkG4Ayh7E7kHFREAv0JdaBmkT
 WfRL/6CvL/qdApR4luaSLPjyZesCvkk=
X-Google-Smtp-Source: APXvYqz2wMtWwyn8zO+3DM+GXmEDhuu1fvaORcN6ogrL+CJheUqb8io3XW6XHv7lExwNA+RFiAhpbg==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr3757321wmf.101.1582702775768; 
 Tue, 25 Feb 2020 23:39:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 12sm1725979wmo.30.2020.02.25.23.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:31 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 827971FF90;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/19] tests/rcutorture: better document locking of stats
Date: Wed, 26 Feb 2020 07:39:13 +0000
Message-Id: <20200226073929.28237-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is pure code motion with no functional effect.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200225124710.14152-4-alex.bennee@linaro.org>

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


