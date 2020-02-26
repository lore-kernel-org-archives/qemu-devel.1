Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30271C4BA0D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EA521D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EI45H9uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EA521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rL0-0005d2-6F
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rII-0000lC-8L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIH-0002lm-7G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rIH-0002jR-0a
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id m10so3890602wmc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ITdhJtBi+hshLd/SCnxQXLHEvNRwcFRFczk6s3Q/ph4=;
 b=EI45H9uEnDgWI4S5CYtLcxE2QM/AXkWHxkgWFx4aq/kxE57BRCVgeRqX6rQgFZ3Pv3
 uBefuS+zVC6yqi2uC/BswvVQejGq05MdGKmu+IT/FjwMnvNY6MX7/dHSdZKkF+exI3Xh
 n/M8am4TB1Bkdhrdqpwz1Q+W+Pjk0TkzD/+MyPpgw6F2aU4ouewiPOFknoonUS3ZtYkJ
 Ld1+POHj47IU3vEkKZVWzUvJ0/td06BoERqF2FfpycDQ6+4QziAszXl1sYSnwpqBUUMS
 IFdNdqe8hY4X1MXq/csp0RqxgglrKKRBtpfbRstPYC1ite75OJvca9S+k6KiRijNiZSR
 S3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ITdhJtBi+hshLd/SCnxQXLHEvNRwcFRFczk6s3Q/ph4=;
 b=DqJqZivx2bmpyGRxBs6KpmLhZEytsJw9Tr1UD8hqo+UKMCmiUaUurGvvsjR3KuM9/u
 Cf235lvknw+SJ0H7NF+vxJXqzu3vXgl601J3pKjfyKaoeY5gvF1Ev+ak/91Qcf7yvl4B
 Oy8I/esyQNhKDRtL/GfvDn9jB81uqJ1DB+pHJs1ztlVEi8i+DVSNp+biXQgNFL3AFmfx
 PuhGfbDfl54OjtaaCTrRlwpQrHS2OPmBeaekOvKK0IkvrMaSHs1HlbN2RNTYYgp5FO+o
 dnmGNjXdpYYu0jprgHb7N91/o77cI/pKqS2G/D8catai7tGQl8yS+hx1B5opG0q4OsDL
 wx3Q==
X-Gm-Message-State: APjAAAWuG5Z3aQHb+oUN0zMHQOF8visoSxCFNtHO2+vww98iutiH29F4
 yXyw379jn9j0dDqmfIHgA2WANA==
X-Google-Smtp-Source: APXvYqzWP6HgXPeSfryDXil4eUvv4PvXHQ4RW/EBee9sZMNKiBSx+C94f7JHGVg7rG2TvBRgTAbwPg==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr3777116wmh.121.1582702784044; 
 Tue, 25 Feb 2020 23:39:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm1758147wmc.47.2020.02.25.23.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:38 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F17E1FF99;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/19] tracing: only allow -trace to override -D if set
Date: Wed, 26 Feb 2020 07:39:19 +0000
Message-Id: <20200226073929.28237-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise any -D settings the user may have made get ignored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Message-Id: <20200225124710.14152-10-alex.bennee@linaro.org>

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


