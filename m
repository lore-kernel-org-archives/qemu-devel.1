Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2109C76195
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A356D208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDTR+aVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A356D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkL6-0005vu-5F
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKe-0004X5-LN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKd-00011H-J4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKd-00010R-D2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id g17so24928186wrr.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1LS+KlxpEqELEq9qDHxmPBrdtBLm31lNrlXQcOciuak=;
 b=kDTR+aViCx2mpH43V8HBtoVNYAU0/LvhBoJqXKjq14vMwmObqQgyut60TTV/nSKl7c
 Vo28bKwkhK0TMBVpZTCPp9ZHV+LcEcVHQkaA4sxtZWbdf2oblMwyb7+YdBidR/u5gLYM
 m73sLy4RbFHaSDhAvxcAfEE/trK1sGogY+y6JIoqNuxWjwunTnWuf35tkGwXurk5k+SC
 zFchF6DdX0kCFjb2MFmZ9UfTOxofAX0GU5OyVQds+KvBgt+/uAQUDkwi3wrwgrjluGU0
 N99wYEZacMJ1bMrSsMkyjoXmXFaDU0nBNKOfkKhnrD5QGDBPvlAk8O+9XMC8sEfK4u1o
 1J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LS+KlxpEqELEq9qDHxmPBrdtBLm31lNrlXQcOciuak=;
 b=hJqqhEXWojfQSkwdUmnBWUKh0NuOgmAPmMrWnlxE0m/3Jq6iuHeQrBO2AaaMFoUR+U
 0hIYcNBirj24hGvjF3YRPrsG0OrhqBdlCh0Vg0ce+3N/G7ZZk6EVBRIRdJDmoKWCER+g
 7AUjecsykuVzuAWydmYGwUuWnUjkNmyhuDKEJ+mMrCjh9IIHquq+qS8ALEC4e343YuAB
 URorGV9MZ7+wNcKbuoYs6M6EiqARx2Nh9s6FCKVeLecTewr/cF/PVkKLrtx6Q6BSIgQV
 t6Kpo4WVwUb3O7BIxeIOxbn712gmzDc9DqxSqX71qmgu7tWu5Ie1mA18jKowZ2CXMF/P
 qEPg==
X-Gm-Message-State: APjAAAU1ePxuTY5ivbFlPafKX7DGeSWcETn1ewEPvCjsMcFb0McIw+OQ
 pnGU3KMU4uRcF7yyCh+gUgS0Vg==
X-Google-Smtp-Source: APXvYqzgSEPVFJtqVZt/Zo1tRISIMbfTLXIBcC5Z4CgySD7mb1nMbWIAVAeOOfc6uMSifi1zWNJuBg==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr43370382wrn.31.1563371454243; 
 Wed, 17 Jul 2019 06:50:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h8sm24309259wmf.12.2019.07.17.06.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DEF81FFA3;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:30 +0100
Message-Id: <20190717134335.15351-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 18/23] travis: enable travis_retry for check
 phase
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have some flaky tests and usually the test passes on a retry.
Enable travis_retry for the test phase and see if that helps keep
things green.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5d3d6ee1d32..caf0a1f8faf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -75,7 +75,7 @@ before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
-  - make -j3 && ${TEST_CMD}
+  - make -j3 && travis_retry ${TEST_CMD}
 
 
 matrix:
-- 
2.20.1


