Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDFC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1220206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYmu3e7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1220206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2InS-0005cY-W2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjR-000070-6O
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjQ-0002Mf-48
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjP-0002Kw-Ua
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so7788407wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6kVJ6Rk8MNPYq7XtbttxL4g3BI/a4u+7aEZDw9SWmQ=;
 b=sYmu3e7afL3MVy8r96vEIyQ0aEzV1r6O/UX9LQAafbtIQtLIJcC71+vrQZu9wryJyv
 YasJGbxwwLTRgxpDpjsmHypp+29SGasyPMX6k4ushYbAsHwvk2TnAQy5udTJyKUdXqXu
 IAhfKt/goVD7MnSfNwTkJQUx/YPs7cNh85nrGK3aNo9TD/WXNzw9FzTmZ5thDcXLfeEg
 LnRyySYQYAuCSaqgy6vYrAI2xep8iebEx57/JPpZrH1GjUkN23vTMBOhVo7XZRxmRdIq
 L5uq0IiKKFMdJwurAcDqW88C5L8KMY62/Z7zRbysKXATRcoHXCoxnrDm9Df+4OdjT7we
 oV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f6kVJ6Rk8MNPYq7XtbttxL4g3BI/a4u+7aEZDw9SWmQ=;
 b=mj7BElHBjt1XA3kx1NLU81fpcIV8rUFbOiFdGL0zeW0oO8WKhBFJKB9ZXvCfWZ0Ojb
 Iob2GDm2+ncKgfkzHyNFQYfVxNzkpS0GOelukKSG5OJkplt/+X7o+s+2USpDApq8toWV
 c7bLAAgjzyLwcDXE5hJf9YPhvyiUXvjIMhV84vZp4FJwWd+W9REpTdCxTMPOwqvpr8+C
 eYX68CFvSZ7oPs+JwEwri1iL7Xc5vHX2PudM979ze4b74bmE3szOoBOPyVC+Mo2PiSia
 71tMPsvFxORMiC1ibc9Y7VQaYFAlhOk2DxQ32XAUHtpKQVdOOIilTCgarBXpUPx843+1
 qsWA==
X-Gm-Message-State: APjAAAUSQjhUbcE8M/K0iT2gieBME9zBu8vXDr9yH9erp4ufC4qkI3yP
 kuRcV+6q7ZzLKdnahfcPiTSrCBm2rA0=
X-Google-Smtp-Source: APXvYqy/s0Ta3TNzvEpI14Dezd/1s1NHfkUY6gYKdtp4lIM8Y/G7+qPv7m76ZmVch41d6pr/qwUe6g==
X-Received: by 2002:adf:db84:: with SMTP id u4mr23299487wri.317.1581616614787; 
 Thu, 13 Feb 2020 09:56:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/30] Makefile: Fix typo in dependency list for interop
 manpages
Date: Thu, 13 Feb 2020 17:56:20 +0000
Message-Id: <20200213175647.17628-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo in the dependency list for the manpages built from the
'interop' manual, which meant we were accidentally not including
the .hx file in the dependency list.

Fixes: e13c59fa4414215500e6
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 430bbad0557..b5a7377cb18 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,7 +1059,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH/qemu-img-cmds.hx))
+       $(SRC_PATH)/qemu-img-cmds.hx)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
-- 
2.20.1


