Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90293C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA5420873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agxIFFq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA5420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NTc-00026M-HC
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKT-00054V-Qb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKS-00045k-Nz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKS-00044J-Hv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:28 -0500
Received: by mail-wr1-x441.google.com with SMTP id t3so8743687wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xiuLr2bgSRxDP5CJng9ok5G0lC9iDI/XVskdjRAUAgg=;
 b=agxIFFq7U6KXmq8jycm7mz8QZkjoKJOFtMkI+LTnroDyl3sQ+GWdwG/UpMaER6zmdt
 DzsgFWvRZeVmUuVLyReyGX37X9+poCJELXx8R7ZC1aUpqgNY71mxSOR83KdjZlnofQ9S
 Z1VKVeVDynaNviHwk8NzGb9z9q+Mgfq62eQMb0+8EjyRPSbGR5LVrhId69XfPbdOkQJT
 oEHTUihWmfQSKmFfv7VdotOJJVL7r4WyCDvMRgDtgQePozKo7AWbJAq4/YUEO5e3M9xU
 zGJDzMHE+kiKC3q/fRdDT4jJWgyi5q+/XQURahNyLhZ8VkKqmWo5DpKp8kWdhecfRj+D
 MwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xiuLr2bgSRxDP5CJng9ok5G0lC9iDI/XVskdjRAUAgg=;
 b=G4YUQzFgVtPmwF0xq8+OZxfzShkrCIYj54i57lAviy1oNh8r9Q2s9OWeTLCseNJtWZ
 ThzCK5GAFqOUUatUyN23EuqVd6ldwkA8Is5kILwk2ekODV/G7sFt3q6fvc7V+W508Y/C
 etvaRj4GL+0SLgosFns9O9hOY9HRemjKcP7bJQKJY0g1HkkRaEiaq6D5GP3SPf1lnDSi
 AuB6voLt/r8pKm01MwK78eOIYZKTCvhiI6QAX6UbI11FKrQCVHZRBIDtxvbHe0+Y/WCf
 b+PFH3zLG6NmxsL5F5ZXt1trUt6CEFQdwS238woVW47trfJ/qlTjAEqsVFqnX2xYeMcy
 AgxQ==
X-Gm-Message-State: APjAAAXNwFhl7fEQLrEmbtgpBaPf/FYCwQ+zg4yfrNb/FjTDxD4KkNCp
 QzRJncSqvz1ERiArG+OWc/y0SA==
X-Google-Smtp-Source: APXvYqxgr+UUnwT3gcqjY1JqNXbb3ODr7reC59cjxIhx4KMQRI4qRpi/KJ7xNYRLorHWAlydlt6WJA==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr23308629wrh.49.1581634287601; 
 Thu, 13 Feb 2020 14:51:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm4309836wrp.4.2020.02.13.14.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6BBD91FF99;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 09/19] tracing: only allow -trace to override -D if set
Date: Thu, 13 Feb 2020 22:50:59 +0000
Message-Id: <20200213225109.13120-10-alex.bennee@linaro.org>
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

Otherwise any -D settings the user may have made get ignored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/control.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/trace/control.c b/trace/control.c
index 6c775e68eba..2ffe0008184 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -226,10 +226,15 @@ void trace_init_file(const char *file)
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
 #elif defined CONFIG_TRACE_LOG
-    /* If both the simple and the log backends are enabled, "--trace file"
-     * only applies to the simple backend; use "-D" for the log backend.
+    /*
+     * If both the simple and the log backends are enabled, "--trace file"
+     * only applies to the simple backend; use "-D" for the log
+     * backend. However we should only override -D if we actually have
+     * something to override it with.
      */
-    qemu_set_log_filename(file, &error_fatal);
+    if (file) {
+        qemu_set_log_filename(file, &error_fatal);
+    }
 #else
     if (file) {
         fprintf(stderr, "error: --trace file=...: "
-- 
2.20.1


