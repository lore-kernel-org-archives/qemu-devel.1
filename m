Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A5FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6CD2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnK3LEJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6CD2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzjd-0008Hx-BO
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002QH-76
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005Ka-1m
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzec-0005Eo-5H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id o28so19317206wro.7
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wolmT8DGMqT5/SDubOMcrLiX89iFV1BFF9nqoSEWVkQ=;
 b=HnK3LEJx9gsdvqumlXaMtpCoB5AR5sr3T1FVazQjE2kovg409U707XspFFYwlTOjyp
 2PLtqDUGlMnHbKKV0z4AzcvyXBzwVBmiBZt+MJUBszyhV1VBvzhiKDXl8FjfjQ5HYr3n
 P64Q/kqcV6w47l5p/JbwIOef66fvhEEUV+odwBMXz4N/+jHFSCp3jmzb7UkmNJ3RXkJ0
 XFUL8BGp/uAXRMedhTrUQNtukYqk8+uJQFDFsnubQvQ8mJnqRJm+BRIAOuwHm8IGZHm3
 kXcF4njP4AXjDENug+XJBAV6Jcgq17gu522wUa+mauWJJsYQsBo8atMSCAwjK/wC7koV
 cDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wolmT8DGMqT5/SDubOMcrLiX89iFV1BFF9nqoSEWVkQ=;
 b=QMxT4J9Zf3mSGmhQwQvOfQZb4CmD6MVEa5mUtOJ6jk3423989D/0BMfFnHij861y+3
 asTIVoKiZPMUx0z0VZcBhN06hoy1dpdiEuPiNAAOYA5sNyYE+/Z2M5EBJfJ1zNQbkab7
 aXsLH+Oeq/pMrtTkZyHaXwFC7o4vSd+jwhm1YOcG3a5NKL3xoy8FTSJylZrr2yvx5YKI
 kl5LyIACtxyaNV7Nfv9A6crQ/wPLsM4t8DjgKSQPdEwkYx98EOO9ejF7p/VyTfleMffK
 wKMmhNn35Fzs6qH1AKC8vzXGgsB9tguTnW0dh4EsF9aDchA+I8MC7sMghTuI3Cj/wk1f
 AyYg==
X-Gm-Message-State: APjAAAUfCywogrNe8E7kcuz92FeR3YvrVEZJrsRxtV+5y8oix2nr7Cc1
 HJhnSpZ8fE9fWz7GflXo+KQ1JQ==
X-Google-Smtp-Source: APXvYqxOMcMFcTwwrmjNwnUVF5T3NLSq+p2K+5HyNwbDNH/XSS6PqDND7Hes+HjcmafhaL9UI67TYA==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr4809702wrn.116.1571771829144; 
 Tue, 22 Oct 2019 12:17:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm25758204wrg.63.2019.10.22.12.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90D281FF91;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/19] travis.yml: Use newer version of libgnutls and libpng
Date: Tue, 22 Oct 2019 20:16:49 +0100
Message-Id: <20191022191704.6134-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

libgnutls-dev and libpng12-dev are not available in newer versions
of Ubuntu anymore, so installing these packages fails e.g. in the
new arm64 containers on Travis. Let's use newer versions of these
packages by default instead. (The old versions still get tested in
the "gcc-9" build).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-4-thuth@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b446e04e8ae..e65e53f3d7e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,7 +29,7 @@ addons:
       - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
-      - libgnutls-dev
+      - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
@@ -37,7 +37,7 @@ addons:
       - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
-      - libpng12-dev
+      - libpng-dev
       - librados-dev
       - libsdl2-dev
       - libsdl2-image-dev
-- 
2.20.1


