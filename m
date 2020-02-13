Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9AFC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5696120873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQtepx4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5696120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NNN-0001hZ-Hf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKL-0004kL-0i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKJ-0003mz-U4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:20 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKJ-0003kY-M2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:19 -0500
Received: by mail-wr1-x441.google.com with SMTP id t3so8743312wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dX/a2gresk53+psqLbyuBofhTGzw6h0OJ4TRN4KF5Rs=;
 b=IQtepx4vfMTvVFOK9Y6UxzAtq0SHyHWQqFQ8JI7tMZMn0QV+8Pd9bQxmtz+H9RONrL
 qSY9GCRkAYjQrCkd6Ic4oJsGvEDLeMqk6tZR15G+3/3n96moR1AMtwSOb0p5A/lgYVBe
 b/pN1oUsSpcdC8iKaPNv6o07d5ar0IDhD4ROL1+idItbz2+HCkPNqgvhnL8sZmC0mNFM
 sW7Cosw+jQdHUCMNCUdJOOuZeXZZXlMzroxcWW0x8UgBQYuZH4NX659rVNRFX6ut4hAt
 8X309SO6JINTqM4tV5UpynLmITd5N0WCqLw2f0T6WrBtM/+BlwP22xNTJaWEAY6dsm8t
 /m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dX/a2gresk53+psqLbyuBofhTGzw6h0OJ4TRN4KF5Rs=;
 b=hhqp1AfKa8BCWz2IoQ4TVZjXR6Oquy76f1IYx8RTGuMf1oDXmZsh4OA1Vdg1Y051ow
 JA/BnRjne3y/R4rIuqgV5lSCVpWEL2MalhqzJglBvsOvF+OKG+DgPyGGKtN3TsrA/GQM
 6TudN2t/5jpLoNQAFtKdfwB+bYm3i72xHCNhQapIq9EF8UbJFSrxGtAwLAtu0Zh4A7iD
 k0lukPT/ZTcQ7h33ZJrHNC9BnchHmypQmGoA1EmRbdQAYnqK7mNw17KaeebE+ZaMOehI
 wI+7tGEeBishAkIJZLWjBTHMbZ2Y8moxqRKVx49kvFI2kYlS8XKNNtkf0Gp2Oj3oNb2C
 EQRQ==
X-Gm-Message-State: APjAAAX0dFv36Ult3A+d1tegBZuXT0i9sGYtICQCOU4Gax/evkRcRh1T
 lg+BbJRIL/6Lc28bBKfgMirQKQ==
X-Google-Smtp-Source: APXvYqxVlNOwSuluIVpSUIJTp1bpxZcIZMGZ5qLV6QfBdiWGN5qMo9fUTAq6tVcIQsBJFXkM8Hhq6w==
X-Received: by 2002:a05:6000:124b:: with SMTP id
 j11mr22157353wrx.285.1581634278278; 
 Thu, 13 Feb 2020 14:51:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm4841916wmc.27.2020.02.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3F8F1FF91;
 Thu, 13 Feb 2020 22:51:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/19] tests/rcutorture: mild documenting refactor of
 update thread
Date: Thu, 13 Feb 2020 22:50:54 +0000
Message-Id: <20200213225109.13120-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
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
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mainly to help with reasoning what the test is trying to do.
We can move rcu_stress_idx to a local variable as there is only ever
one updater thread. I've also added an assert to catch the case where
we end up updating the current structure to itself which is the only
way I can see the mberror cases we are seeing on Travis.

We shall see if the rcutorture test failures go away now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/rcutorture.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 256d24ed5ba..9559f13cd1f 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -236,7 +236,6 @@ struct rcu_stress {
 
 struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] = { { 0 } };
 struct rcu_stress *rcu_stress_current;
-int rcu_stress_idx;
 int n_mberror;
 
 /* Updates protected by counts_mutex */
@@ -288,29 +287,48 @@ static void *rcu_read_stress_test(void *arg)
     return NULL;
 }
 
+/*
+ * Stress Test Updater
+ *
+ * The updater cycles around updating rcu_stress_current to point at
+ * one of the rcu_stress_array_entries and resets it's pipe_count. It
+ * then increments pipe_count of all the other entries. The pipe_count
+ * will be read under an rcu_read_lock() and distribution of values
+ * calculated. The final result gives an indication of how many
+ * previously current rcu_stress entries are in flight until the RCU
+ * cycle complete.
+ */
 static void *rcu_update_stress_test(void *arg)
 {
-    int i;
-    struct rcu_stress *p;
+    int i, rcu_stress_idx = 0;
+    struct rcu_stress *cp = atomic_read(&rcu_stress_current);
 
     rcu_register_thread();
-
     *(struct rcu_reader_data **)arg = &rcu_reader;
+
     while (goflag == GOFLAG_INIT) {
         g_usleep(1000);
     }
+
     while (goflag == GOFLAG_RUN) {
-        i = rcu_stress_idx + 1;
-        if (i >= RCU_STRESS_PIPE_LEN) {
-            i = 0;
+        struct rcu_stress *p;
+        rcu_stress_idx++;
+        if (rcu_stress_idx >= RCU_STRESS_PIPE_LEN) {
+            rcu_stress_idx = 0;
         }
-        p = &rcu_stress_array[i];
+        p = &rcu_stress_array[rcu_stress_idx];
+        /* catching up with ourselves would be a bug */
+        assert(p != cp);
         p->mbtest = 0;
         smp_mb();
         p->pipe_count = 0;
         p->mbtest = 1;
         atomic_rcu_set(&rcu_stress_current, p);
-        rcu_stress_idx = i;
+        cp = p;
+        /*
+         * New RCU structure is now live, update pipe counts on old
+         * ones.
+         */
         for (i = 0; i < RCU_STRESS_PIPE_LEN; i++) {
             if (i != rcu_stress_idx) {
                 rcu_stress_array[i].pipe_count++;
-- 
2.20.1


