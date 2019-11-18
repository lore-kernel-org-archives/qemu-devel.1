Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F35C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C3E222DD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgIhSQ3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C3E222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoU2-0008Hq-I9
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNC-00004r-Ox
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN8-0005ld-TB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoN8-0005kY-NL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:46 -0500
Received: by mail-pf1-x442.google.com with SMTP id b19so10995878pfd.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wafFGt3nPwzzdj7M9taqKk32I4fEwfJNruFpoO9OReo=;
 b=jgIhSQ3gsl9P1WMR7CPp4cIm+p+ZNAWIu6ZTkVkou/VM4I6v1aKIcJteFNx4VOhmFQ
 Mbpky3kMuv6GtSBaOZsumq/q9BmgutMIHjQsn3d5h0pE6bTLpssX+d+NYixyK6Ocw/rp
 6dySDXZLqeXbh+55Kyh5NQCf63mM36/vNGIJ92fW6h4NdAMxXpAh+9vRayRnP03Ont0D
 VBhKf8Wc1uirhyaBlY3Qc6N2Yo/iyK/iDjywekwbAYWC7H+jPMUcxrINfFeWfiAkZZDB
 CfmW6bRtLljv2RjFl+Qz0c2ceQEIcdDmwGc2dKr+gHFcYW8EA3ld0w7TZxsFGj1MPkqJ
 /+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wafFGt3nPwzzdj7M9taqKk32I4fEwfJNruFpoO9OReo=;
 b=Ncq3j9MvkfaZR4VQ5MGtaxFzARcps8IyBCAjW1WekW4ZN+Wez4caRMD2mjc0Crr4BY
 0j0etJcZZKzKU6JgwCIcHBDR9Ym660LNmRAzSCF3KevUYjJM3dsvS/T0pqXUfSvyp4g3
 A45HxNos4caa1fDi5F777PMQWjVApTJVwWGZmIj9U4+Ne89WkT4RFIyBB5AUw2rWfGpc
 gJI15JMYFDXyeHU8ij/l7o+i+BVQ8jDS4jpvhg8YaIz3u7ZlCcTb95eU1x6BfMKJSywP
 U6ED08xMkFPYkj7JyYPo4ATfhgEIfr5TljiRhNDm1hlKlvDyPVfdLMqBhtPSCXz8ARUN
 N9Ew==
X-Gm-Message-State: APjAAAU8KDETdh2hg1uKCUqP2zkyT0EMu1fqUw8mEGLefrg2NsfRvTgr
 7my7lu7MZkKGejqI18iK71PicP83VbU=
X-Google-Smtp-Source: APXvYqwvNNEx4k70oPxbLrC1UnD3YPJQci6bNKDgbRCpd0kUlHvfGtzxIXkq+XWg0EvwyQhJLt64ww==
X-Received: by 2002:a65:628f:: with SMTP id f15mr1498253pgv.91.1574111745415; 
 Mon, 18 Nov 2019 13:15:45 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:44 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] Add a mutex to guarantee single writer to qemu_logfile
 handle.
Date: Mon, 18 Nov 2019 16:15:25 -0500
Message-Id: <20191118211528.3221-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118211528.3221-1-robert.foley@linaro.org>
References: <20191118211528.3221-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also added qemu_logfile_init() for initializing the logfile mutex.

Note that inside qemu_set_log() we needed to add a pair of
qemu_mutex_unlock() calls in order to avoid a double lock in
qemu_log_close().  This unavoidable temporary ugliness will be
cleaned up in a later patch in this series.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v3
    - Removed assert that mutex is initialized.  
      We will rely on the constructor.
    - Also added details in the commit message regarding the 
      temporary ugliness that will be cleaned up in a later patch.
---
v2
    - In qemu_set_log() moved location of mutex lock/unlock 
      due to cleanup changes.
---
v1
    - changed qemu_logfile_init() to use __constructor__.
---
 util/log.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/log.c b/util/log.c
index 417d16ec66..953a66b5a8 100644
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
2.17.1


