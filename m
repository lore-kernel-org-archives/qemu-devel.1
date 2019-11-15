Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525AC43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B451D2073C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2GbYr87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B451D2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbR9-0007uC-PL
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iVbO0-0004Q8-4C
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iVbNy-0004PT-VE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:40 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iVbNy-0004PG-OD
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:38 -0500
Received: by mail-pg1-x543.google.com with SMTP id 29so6007121pgm.6
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jRenRuOm4Z6evRvZHH+d3jhAxtFeu++eNMWL2guRWVY=;
 b=h2GbYr87HvO2wfQxpXY34QBWwuM8HUUdVpXw7rgKxdKL+VHHTjcogthG3kC6Go6i9e
 G9TPtMxTaJrt74cd+XuTwEJo34l5uSkwJj8HWdQIbOjbgEO1kcsmJ9FgCcVv/0NqwqMO
 Lw6sjH5C86mZTbPacRlkG1TLgPkwmwUAUg9bQAnGvhrhqvmXQkP26ZmoTGaGcNZar4gF
 WgieA3KkqKbOZCr3V/m+9q/mbqPeRZywAma+k9wCQu7hxBKnH1IMHGNnwRgQSLbiGOda
 6eMcuS7ZBFkGewxTIs5yC8H30p/I0VPE1z1rORuTvUFoNc+TgNP9WPkPmlIEGRlSHYYX
 KUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jRenRuOm4Z6evRvZHH+d3jhAxtFeu++eNMWL2guRWVY=;
 b=V5IObTb2ChuUHnkssaBeoxWX8sKs/HZsZomB9h2yK7QKuEhbtCovzx0LrXP/+n945p
 Q1wY8FubtJwSdZTXmR9NNr2EwD9Dn3Is3u6mxMqDMgMyGqERkmhfSoe7h/bvd3VHycA4
 wmJHGUBpryZ+YUEcM8/gfM1fqckBfyYJMIecgyRvUSA/UflfafOjhXuiwaKGp6KThFEJ
 3O4ePyuIvtqsoGL1uu5lcCATnX1qk951oqe28lTd3W7KDVR4r75uJA4E2VJsmYlNJ2o/
 Ncdsz5Ok5Wq8LN6Ll1gllbpusyUX4iOFMDkVf8XZwKdEIgnSm62Xzg5dzBKC4l7qtbcA
 F2iQ==
X-Gm-Message-State: APjAAAVm751K2r7jqQyzliUfXFglC0Qk6pbEFxkD8HiOjjJ22UY8IM6F
 Qabd5SgLAM400NG8s8Vpj9S9odImQeI=
X-Google-Smtp-Source: APXvYqxCzmWUzeMEkBLcnmt9bneQ9yVR61djNrrZEt3dEP/pC3osMpkmrGVPHIpWkZ0FVfyuUBFHsg==
X-Received: by 2002:a63:fe4d:: with SMTP id x13mr15657215pgj.82.1573823497512; 
 Fri, 15 Nov 2019 05:11:37 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id w138sm12007249pfc.68.2019.11.15.05.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 05:11:36 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] Add a mutex to guarantee single writer to qemu_logfile
 handle.
Date: Fri, 15 Nov 2019 08:10:37 -0500
Message-Id: <20191115131040.2834-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115131040.2834-1-robert.foley@linaro.org>
References: <20191115131040.2834-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also added qemu_logfile_init() for initializing the logfile mutex.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
v2
    - In qemu_set_log() moved location of mutex lock/unlock 
      due to cleanup changes.
---
v1
    - changed qemu_logfile_init() to use __constructor__.
---
 util/log.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/util/log.c b/util/log.c
index 417d16ec66..91ebb5c924 100644
--- a/util/log.c
+++ b/util/log.c
@@ -24,8 +24,10 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
+#include "qemu/thread.h"
 
 static char *logfilename;
+static QemuMutex qemu_logfile_mutex;
 FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
@@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
     return ret;
 }
 
+static void __attribute__((__constructor__)) qemu_logfile_init(void)
+{
+    qemu_mutex_init(&qemu_logfile_mutex);
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
@@ -70,7 +77,10 @@ void qemu_set_log(int log_flags)
     if (qemu_loglevel && (!is_daemonized() || logfilename)) {
         need_to_open_file = true;
     }
+    g_assert(qemu_logfile_mutex.initialized);
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (qemu_logfile && !need_to_open_file) {
+        qemu_mutex_unlock(&qemu_logfile_mutex);
         qemu_log_close();
     } else if (!qemu_logfile && need_to_open_file) {
         if (logfilename) {
@@ -105,6 +115,7 @@ void qemu_set_log(int log_flags)
 #endif
             log_append = 1;
         }
+        qemu_mutex_unlock(&qemu_logfile_mutex);
     }
 }
 
@@ -240,12 +251,15 @@ void qemu_log_flush(void)
 /* Close the log file */
 void qemu_log_close(void)
 {
+    g_assert(qemu_logfile_mutex.initialized);
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (qemu_logfile) {
         if (qemu_logfile != stderr) {
             fclose(qemu_logfile);
         }
         qemu_logfile = NULL;
     }
+    qemu_mutex_unlock(&qemu_logfile_mutex);
 }
 
 const QEMULogItem qemu_log_items[] = {
-- 
2.17.1


