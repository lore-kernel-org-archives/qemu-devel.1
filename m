Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB10224650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L40IF6uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB10224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtXC-0004AJ-LD
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNU-0006vs-PR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNT-0000zm-Bq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNT-0000uv-47
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id m24so4930791wmc.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mUysB+KCVNDJImTrn1g1Sf4sZ1iooDukb6kMQuinDJU=;
 b=L40IF6uZCGZS14txqiYJXwjArg8XcaWe4PMZnAXkRUPHNUdj+todE42Soo70HZB/ck
 I0T6t/ILA0Bnj9yZZWQhen/ZzE8sQpN5D4psFQZb1Kz3RGkIr8BpRpLNhqh3nlPwjY+t
 7aBEpJS1uLi4t4GZ0IkBYsiSHgpHtUIo9r26cVs7Pv5NSVYqzNWWgOsA22kp+8PY1DRi
 fjFPMvPNQWcRilcc/ge/P9qZi5ATlkhcq7bnABSw3KG8xX4jSbIQOjVeYCVH/Xx6G3Jg
 DsONUKiYjldLoLZpymZthsX0cifKl3rgkYsO5DbsrQc9jg8bDde7dUCu+gdsou6Toa7n
 e6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mUysB+KCVNDJImTrn1g1Sf4sZ1iooDukb6kMQuinDJU=;
 b=EH6tFuH1KDyCheYruzJx8LCbz9nB1fZjeMyTi+d97YaxYxW0ofbZf7bkhkoGAUytML
 rEtRWYCs3m0G00LposkDyDpXiZUJ+m4tN+lMGL2MxgpdKXGUt9IMPYwaysKpWUtFLIYH
 4Nn6qEFWbzLfI2NUF5UCV/1KhyoM+ztlWhonRndRaoFAwbr5qAzSsFBut8v67o5uLt33
 jsQRVMl7BfaTYTa7zQryN+1082E149FWxagHnmfQdc5A+T/T37f4uDk8/yfyCO6V3nP9
 FZY5NTtFT4VGMZW/0TZ/A6/If+tFfEpbd6OfQMzFBwuCpJKNRh65za+CbtLEfRbmleYL
 8uOQ==
X-Gm-Message-State: APjAAAXDHWcs7KcOCcnZXy6N1/ShVd7HLTnCsSxzhKxe8YAqb/V0VxIm
 IVjtxnrOkihDZllUsrmzThYhyhq1CVU=
X-Google-Smtp-Source: APXvYqzrAH4TxD2GflO5d0TzrmPW+JwZkMxkCfwLy0FvxDpAgyFinr2w8MXfhhC3Vhf3vrl0+782cg==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr8926967wme.175.1576752594098; 
 Thu, 19 Dec 2019 02:49:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b67sm6052291wmc.38.2019.12.19.02.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A02001FF9D;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/25] Add a mutex to guarantee single writer to qemu_logfile
 handle.
Date: Thu, 19 Dec 2019 10:49:22 +0000
Message-Id: <20191219104934.866-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Also added qemu_logfile_init() for initializing the logfile mutex.

Note that inside qemu_set_log() we needed to add a pair of
qemu_mutex_unlock() calls in order to avoid a double lock in
qemu_log_close().  This unavoidable temporary ugliness will be
cleaned up in a later patch in this series.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-4-robert.foley@linaro.org>

diff --git a/util/log.c b/util/log.c
index 417d16ec66e..953a66b5a8d 100644
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
@@ -70,7 +77,9 @@ void qemu_set_log(int log_flags)
     if (qemu_loglevel && (!is_daemonized() || logfilename)) {
         need_to_open_file = true;
     }
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (qemu_logfile && !need_to_open_file) {
+        qemu_mutex_unlock(&qemu_logfile_mutex);
         qemu_log_close();
     } else if (!qemu_logfile && need_to_open_file) {
         if (logfilename) {
@@ -105,6 +114,7 @@ void qemu_set_log(int log_flags)
 #endif
             log_append = 1;
         }
+        qemu_mutex_unlock(&qemu_logfile_mutex);
     }
 }
 
@@ -240,12 +250,14 @@ void qemu_log_flush(void)
 /* Close the log file */
 void qemu_log_close(void)
 {
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
2.20.1


