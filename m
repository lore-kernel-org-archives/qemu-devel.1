Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8EBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86388206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qU4bPTeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86388206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c3D-0006SX-0f
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bko-0003R1-E8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkn-0006N0-7n
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkn-0006MQ-1V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id h7so17351139wrw.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1H1FAu7VydYddKbuodTRw29LVFATt0J64Dq/I7de+uw=;
 b=qU4bPTegIGs32n+szlRYVazm6cXbJ1U7YJiBgIya8GIFOtYtBJqsy3cHSHRaADnaB8
 DvQLghSd44xxOR4sC01cUtaYnsJLAngt0ZRiTQvO0o5iuX/uQD/5FvxXCCr9Q40WI5Ch
 7GYcPaJe55rrxr3k79XuUoICSNxeRKAP9xCw91/FgUX8zmWTR/drljePd4s6TXSiONKD
 WBVwN3N9/3s2m35yTznHScT1HhP9NrPKnWqdm7KR4PxxJnXLeOs6Ix1oeMg9KGpSEss+
 fZePPNc1UDfvWUjEWQuEB4U3SSUhI07Dh36y07kleBdF0ueft1R45YD5ooQ+ygr4dMLx
 EA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1H1FAu7VydYddKbuodTRw29LVFATt0J64Dq/I7de+uw=;
 b=c689aAV9WIjDY5/99kssCAkH5F1DkzSoNT+hU48AaBoij/1GngEdo4tRPSiZixT5kH
 j3CgHmYh7YaKA96lIOqElFQkNfrbL54nPRyfyNjdKQXvwWRLnVdFj0+i4Pe/al3mXwlj
 QXwh7LJPZOr1kStZ7nGtuc3oewKYku/ZcR1TPq5IiQFkEKzHEuu4y1Y9ahLhuQWtBFrN
 R9bbbqOIEN1TAdprKzMKYQAJSNRgeZWLscoeT3Xsrw4mWGpzTHPbup2nrL0F8aJrq6wh
 fhrlV1xSfCOb/JFSmJWyTouLPl+ZxOvSpMHILL6v3QuhpjuvWPd+uGp+ky1c+85saPiJ
 kRxQ==
X-Gm-Message-State: APjAAAXRvVIltHm7xZOKGh6ykq26sRoRWBs0GvJ4n1Qhx87CD+8tx57P
 kEwFnFajkEARMfFlIVpER6uxIA==
X-Google-Smtp-Source: APXvYqwkzWJtF+8lgflRchB6d2erROivAHV4xuQrYNCvK4uvu8lO7V9Jx8KER93xiH4+dtpT/8KtCA==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr4760582wro.49.1568105039941; 
 Tue, 10 Sep 2019 01:43:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g24sm26485161wrb.35.2019.09.10.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 10B021FF9F;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:20 +0100
Message-Id: <20190910084349.28817-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 16/45] tests/docker: move our Alpha cross
 compile to Buster
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7c1ff677a13..e7379f1d732 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -98,10 +98,10 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 
-docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
index 23444342f03..74bcabfdb12 100644
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
@@ -1,13 +1,12 @@
 #
 # Docker cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+        libc6.1-dev-alpha-cross
-- 
2.20.1


