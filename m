Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E2AC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F4320673
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNSXM843"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F4320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgkV-0006NO-Dx
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYp-0003v7-7P
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgYk-00066T-TB
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgYj-0005aH-RU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:47:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so687321wme.4
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tCyaA/37lVkaqonlS+tvjCwQYalKW2S3rd3JDUZadC8=;
 b=BNSXM843/luvjaSm/D1+syXE24C/jWC2fPMxHBn9sYEedIJWsvmFBJKD8WMek9QjRC
 3DxU0dOHRI2/23vFwpHRb+mSVN6Nzo21ONg/s7GjvcSOjnBvWs9m773qTGBxmSJAGU/i
 R+76orE0tGdUlPKn8vpR5TywQYnqR37fT5YBvPF9O0IJpeTVUu/EdWyTd7HZKWsWpzZA
 /0bv6Bc2AAYTjRp6q6JDQGJD/MgUMJa2AJ6cGFpF/gQcquTZD8tR6YaDjSfplQbzrfoe
 TqANVBYhRXIINu7cokFklOViFnI4ESzQHFshBjjxe4ljekXKbjsO5//Lr2SUbENOKirI
 M8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tCyaA/37lVkaqonlS+tvjCwQYalKW2S3rd3JDUZadC8=;
 b=i+4qMdefog8uLG6tR3QO+0UN5+JkiMse36KKDch/op21frJr7CXOZY79Jp/EkWjYLZ
 z53nME2WTlduJ5xGVok1piQbo4gR7IFF5VNYOriY4oJVAa4qp7LqccS6wScLNliHm5Pr
 e/F206BJ07RH8N+acqSPAD2axNN9/6JFt9Ol/c52q9iHMYCDBQg95wzmzZdA2YphUDFJ
 4plDF8Ok/JkJnRpk36ulcdpQIKUVcIz4IQczoWgTORRqUG2WBhgErRv9aI3F9wS3fypP
 c3IvzFD3jaKAlOJ9UM8N0VPcGSOGdasWUj/c+69wPV4gWRBA9+ZWGruq0BlIceulpC0B
 8LJg==
X-Gm-Message-State: APjAAAWJ8DLBV1NEenveZ6nSY2ejlt8DU3VJuDRmPUgwAURqNTmyO1lQ
 JY28Qz1avMsymjP64W2O5XHx3A==
X-Google-Smtp-Source: APXvYqzWSqWq3szr/ylBQ/p9EMY+KRcvy6QAlQRAEFTSqYqj9pSTkQCSohDKbqboocJkFGUfohBC/g==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr9606393wme.29.1560973638685; 
 Wed, 19 Jun 2019 12:47:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n3sm14517578wro.59.2019.06.19.12.47.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:47:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D39391FFA3;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:21 +0100
Message-Id: <20190619194021.8240-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 17/17] .travis.yml: force a brew update for
 MacOS builds
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

It looks like the Travis image package databases are out of date
causing the build to error with:

  Error: Your Homebrew is outdated. Please run `brew update`.
  Error: Kernel.exit

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 9750dc905c..a891ce2485 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,6 +43,7 @@ addons:
       - glib
       - pixman
       - gnu-sed
+    update: true
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
-- 
2.20.1


