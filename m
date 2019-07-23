Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539BC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105CF22512
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKTi7QKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105CF22512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsBu-0007Me-5K
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9f-00060X-8Y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9e-0007QG-3r
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9d-0007PW-S9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id a15so37978670wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GAK5q9zpZRUsFFm1klLu6PZkQTgDPdn9WoHPkYsqZ/k=;
 b=lKTi7QKYqfEYLPMj6A7gUV0qfYAlm7dhxAEoIjzwhr4LSuP16Q/iZxrlO/rNT2dpYa
 o7Fa+R6jfo+ZWnQn8SHfrztniLUYcFBFOXkphU09fKfPk7xEDozWYoGrmjG5CQ2PZKoz
 0daBvhhkj79WN6VIvUWtiyWbWDB0/mxb1ji+DsiAeoe43EmgsRoyttUaCOQBG5zH81vR
 Dco3eMMQEsJ09VFu9OYapL6rWsXjYUDMksCM41KQVz+tA7sWkS8G+iFYDnLP9puEYfUe
 X6W3+LOZBSco8pPV5mEB2t5otIGNjekKmjufu87KQ3j33NOcjNN/3hMW3/VxUokCduoM
 ltzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GAK5q9zpZRUsFFm1klLu6PZkQTgDPdn9WoHPkYsqZ/k=;
 b=emdHi4RSsGa93c4VivBgv6zHFuyaOhY6e71ITcxYE7jth85O16oui7YXBRb2NG/fsZ
 Ol8u95vXEWSSw2QnvebdodBM58KXly0LMLkMAE1k9N0Vu02ql2wXNaIxdZBqfmUZ5GjZ
 BKidebFEa5Tr1AnzoyCflhhIYFglU33GBEq3T2m6+9hKBFJjNYy0KWKxP+hdYm11Ed8V
 ank5Z6Lqhdn14t09awGOopbOtSfseUoWUcmmOJ/kxb1pMuuI9hc4yWESONus4SeSnnPX
 6NUJkoJVM8wG+Z6QJEtIAQVg7qAEi9pRPlAkTbiyNrt8iwV0VV/ogfbmcY7dWvOOpg7C
 aj7g==
X-Gm-Message-State: APjAAAX4tqADSjBoVtXmC3snniIRV7YeQZqe76oFrms/yUEUC51t0CDb
 qFcOb9Ol7DfGLEEKwoFSqSIXCA==
X-Google-Smtp-Source: APXvYqwKnVJcHON/qdfiCU4fzmKRjV06g3Y2SCOJOdGg11lwMRn/Cl5bgg3p7+S4vHtJ94Wwa1MLJA==
X-Received: by 2002:a1c:c78d:: with SMTP id x135mr61406671wmf.82.1563878180703; 
 Tue, 23 Jul 2019 03:36:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w67sm52976031wma.24.2019.07.23.03.36.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F9F51FF99;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:58 +0100
Message-Id: <20190723103612.5600-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 09/23] tests/docker: Install Sphinx in the
 Debian images
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-3-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index aeeb151b521..cf57d8218f6 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         pkg-config \
         psmisc \
         python \
+        python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 5f23a35404f..52c589a7d64 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         pkg-config \
         psmisc \
         python \
+        python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.20.1


