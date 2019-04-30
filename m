Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4FAC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D602075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiobEaZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D602075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW78-0008Cs-Dd
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:00:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW28-00048Z-WF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzq-0000pV-Au
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzp-0000oZ-WB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id v16so19428732wrp.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RExLEUbU+WhAIZTJBGlgOhgxBRk7o/x1G7uPxMvM+Ao=;
	b=aiobEaZVKps4zoBObKr1vtVI6JMYcVnz8Qpazpbttyn9EShOrI/DqRe6qGHd3hyIhQ
	tZMpMlqdYR28Td4E3bYnF/xEPuuKkGtmS3GIzsWkJK/4nuXnBwljRvd4oLUM+AC98qfG
	HESVDzsjITO+yJOvCnruC3KttvLhbVJrXwDFRGWjoTE/9g9hWtd9YSJdSokcjMFmexdh
	fOkPkgUp9dsFTKdN8qzFPmaZ0tYSs8mTa/1pXdt9Y7ILCm0vl//pPR+vCojjQJBdhQfd
	gR37BanqoiiBLY/poy6PHYiOMVgfVNsLJwAYwHn2yml3sDPJvE0rKQM3k557ZrolOer5
	os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=RExLEUbU+WhAIZTJBGlgOhgxBRk7o/x1G7uPxMvM+Ao=;
	b=Rr/Hn2JsGvJrbiEQI97lNdRYm+HG29NNNTSmTxCrr90BilTiOat+OIq4MrCzZs0IJw
	qWY11POqVXZY2fZ/6U02wAwYYLaDAf4k/Q6E7yU/KQYvgX/XTq/OS0oXpMKfcJuzrB+T
	D14v9NII870TnHnUJHeqzISu5ht4YoUFG+KTykk5Z3TzK84Rv7R0bYo8WhreWYpg4pyA
	zbcTKiJ8g3hqqZA4v2oCXzFdjX8A8eRPYfIaEKdNIKwK+POvyfIYIB+alBQNZAtSXI9X
	+nrRKkrK3koPyZb5YkWNEWE2fwLf2lBWkn8TPzLeXZhOLnaDRODqhB70foBnY7z2hChB
	+Lkw==
X-Gm-Message-State: APjAAAUaIrtvW6iDJHqzHLag4QmKkE8d7fKGeboVOzBKD0TJSinna/Qn
	lKkEWKXT9xvDn9QrhOnQq30oyNjs41g=
X-Google-Smtp-Source: APXvYqwUe4+f/L+f/tvfbdpxcbqfzr3bbEQO41TJXn7ewKXKmepkFZZlBcWLBRDy0znBsp9MX1NilQ==
X-Received: by 2002:adf:da51:: with SMTP id r17mr6391725wrl.118.1556643164885; 
	Tue, 30 Apr 2019 09:52:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o16sm26557588wro.63.2019.04.30.09.52.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:43 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3E2711FF9F;
	Tue, 30 Apr 2019 17:52:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:34 +0100
Message-Id: <20190430165234.32272-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v5 15/15] Makefile.target: support per-target
 coverage reports
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165234.SwSvpBe6xXXwCLPUb0NARqjEL8NlpX3lZO-5L3DDaqM@z>

Add support for generating a single targets coverage report. Execute:

  make coverage-report

In the target build directory. This coverage report only cares about
target specific blobs so only searches the target build subdirectory.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile.target | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index ae02495951..aa5d9d6ba6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -238,3 +238,19 @@ endif
 
 GENERATED_FILES += config-target.h
 Makefile: $(GENERATED_FILES)
+
+# Reports/Analysis
+#
+# The target specific coverage report only cares about target specific
+# blobs and not the shared code.
+#
+
+%/coverage-report.html:
+	@mkdir -p $*
+	$(call quiet-command,\
+		gcovr -r $(SRC_PATH) --object-directory $(CURDIR) \
+		-p --html --html-details -o $@, \
+		"GEN", "coverage-report.html")
+
+.PHONY: coverage-report
+coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-- 
2.20.1


