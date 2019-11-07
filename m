Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF44C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E8A207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTQkB5b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E8A207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSioC-0007bV-6t
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSik9-0003G9-PM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSik8-0006jE-CF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:37 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSik8-0006it-6m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:36 -0500
Received: by mail-pf1-x441.google.com with SMTP id 193so2731390pfc.13
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RQogdHqT92+3dXdjI90KovlZh55RRNpNiecef2mLhCs=;
 b=bTQkB5b1kQVLaHJbaOpg3d6ChmkFJ7XpGPwqyyvvUc4a9GKv+5uVZlQH/HHJKyZA4K
 hws1MenGAhaSB4R3C8Nh4ZB+MKSBWsEy6CPu9FCh+ZKeRi1/RycrXKyqKDAcWUKsG45c
 BxODsE7kLgux29NsOktO7ejQnC60H4nselrkJpbJ7fLu8++NLSF8ngwYI4SvA6Ttks3O
 eHnz6crl9Pq/2uNcL1JCHLb/DyDCnU8r+xfx76v4lJAdPlqEHSWOjEpFNKYSsAVmjuQC
 buP6wvlDtU42PsKz+PJxLDRcZglWqZsC4dVqbw+6JpAED2FyDLk8vasXogXCkRlL1J6C
 ZB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RQogdHqT92+3dXdjI90KovlZh55RRNpNiecef2mLhCs=;
 b=TOmghzGzCA9oBo6d63mVa5DvLILrMToDNvZUk/FEsba67GfvO8i+wSHlcW+So9WYo8
 i1/+mo43y/qp+SYa9ZLucmCGRMmFtNwyaB3EFiyK3JpsQuJpLiEuXQBG3jiqqX1HpG8T
 4TmjXlWMwFlB2NBLoHAVOcDZceYP5UoEKx9dLhDL+ciK+2oU2roQ9mt1IcWUGHDSZcOW
 NxKqTLb5joWZu773pK710pfaWjThTHdoDDFmeXBZWrpVNsusduOET83OXwwIDu30WMjT
 RxTvc9Q5ZmELqFxZNHVhF7ojSJ8jXTEcVJR46/jEgpQJmaxjFEnEpW4frReZ8ObQ8hde
 /FtQ==
X-Gm-Message-State: APjAAAX9iQn8eqAkGB5WLVNGP5BSbZ+f7VICPwOpgNHSeDTtyR3CbP2c
 IYki5v4oDvSpKeiP8k7L7MlxpmyySB0=
X-Google-Smtp-Source: APXvYqyhu+u4Q2AyWuHN1/jKV/TXS8F4g2axtpLXpD3yv1EwjlYIeBHPLC78R2IrZ7IvU4DWBLUtjg==
X-Received: by 2002:a63:f246:: with SMTP id d6mr4789561pgk.368.1573136794926; 
 Thu, 07 Nov 2019 06:26:34 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id f8sm3375502pgd.64.2019.11.07.06.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:26:34 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] Add a mutex to guarantee single writer to qemu_logfile
 handle.
Date: Thu,  7 Nov 2019 09:26:10 -0500
Message-Id: <20191107142613.2379-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107142613.2379-1-robert.foley@linaro.org>
References: <20191107142613.2379-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

This is being added in preparation for using RCU with the logfile handle.
Also added qemu_logfile_init() for initializing the logfile mutex.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/log.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/util/log.c b/util/log.c
index 1ca13059ee..dff2f98c8c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -24,8 +24,11 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
+#include "qemu/thread.h"
 
 static char *logfilename;
+static bool qemu_logfile_initialized;
+static QemuMutex qemu_logfile_mutex;
 FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
@@ -49,6 +52,14 @@ int qemu_log(const char *fmt, ...)
     return ret;
 }
 
+static void qemu_logfile_init(void)
+{
+    if (!qemu_logfile_initialized) {
+        qemu_mutex_init(&qemu_logfile_mutex);
+        qemu_logfile_initialized = true;
+    }
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
@@ -58,6 +69,12 @@ void qemu_set_log(int log_flags)
 #ifdef CONFIG_TRACE_LOG
     qemu_loglevel |= LOG_TRACE;
 #endif
+
+    /* Is there a better place to call this to init the logfile subsystem? */
+    if (!qemu_logfile_initialized) {
+        qemu_logfile_init();
+    }
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (!qemu_logfile &&
         (is_daemonized() ? logfilename != NULL : qemu_loglevel)) {
         if (logfilename) {
@@ -93,6 +110,7 @@ void qemu_set_log(int log_flags)
             log_append = 1;
         }
     }
+    qemu_mutex_unlock(&qemu_logfile_mutex);
     if (qemu_logfile &&
         (is_daemonized() ? logfilename == NULL : !qemu_loglevel)) {
         qemu_log_close();
@@ -114,6 +132,11 @@ void qemu_set_log_filename(const char *filename, Error **errp)
     char *pidstr;
     g_free(logfilename);
 
+    /* Is there a better place to call this to init the logfile subsystem? */
+    if (!qemu_logfile_initialized) {
+        qemu_logfile_init();
+    }
+
     pidstr = strstr(filename, "%");
     if (pidstr) {
         /* We only accept one %d, no other format strings */
-- 
2.17.1


