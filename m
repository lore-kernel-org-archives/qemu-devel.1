Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFFAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0784206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/L6jT8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0784206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cFg-0005iY-K6
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqv-0000mc-41
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqt-0000bv-Lv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqt-0000bW-F0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id q14so18391952wrm.9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ARJkONkMBY8LeB1yLjlkzhVw30O5bw77o+QDas9FiKk=;
 b=E/L6jT8B5elGgwyBLGAJkR1YvDGZJArgL0TGyHpeeifs0J+X+V3gw4O4QWVza80O1g
 pGp4D5Bv/z0lQ8JfvKxC1cAmAeE57FJu92gFnfyjIk/wscxPODfqF7Egu6Ca1EeVM4OY
 dOsWzIMWOBe2uLeiCUr/N2kMj8Jz5YBn1u8u3iIoSzb/zsJyDPPMZ9CXQ1X9vmQJ1bvi
 7lCsk0YjTF4edL4Mt7xfQ99GPMqSJ1m7T9N+FUGKy0qq0hNoxH3qFVl2SLsj1qTMou+2
 YOkSsUn4kL5qG0hsLdujwDpGXQ/lFgx+zDHiISdiv9bh3Dwo4eeTwnAWJwzo7JsPMwoK
 y7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ARJkONkMBY8LeB1yLjlkzhVw30O5bw77o+QDas9FiKk=;
 b=a+r9hV/mBcTh3+p8/y6VYasTklWZLlRsceo9VqEa7y8PgR0L/BnCMbGG5DM75xGInn
 6jmxWJqedg6DZuwCfPuA/xIQW36V1nveFj9sx7mCDvGnZfCPekzvLchp3wpSwpZWk9Yx
 a9C4BghMDCeNIlsskPeajifAAaD9iw3jqI1YxnXs7BDHM8HOz9LKSDLUBex/75BJ2ByW
 cSIXujQJFXoe3Bv6GhKKbdsR2iNuzfHprM1R44pLi73RcZe0rdO1Tvh2rojmkVJyb2lO
 nOMKobPU0BeQFVDJBBVKnZBsdQr7IG4L2VexuoTWa04UAE0j9tjJDOgI6GjCl9hmr2zG
 Wbaw==
X-Gm-Message-State: APjAAAURTtorPsSYYxn9qWnE7nckumq7R0mkAZ+s3fRwBn5JWs3K3WO1
 6kNGyjHACFXthZSImDTQ9gku0A==
X-Google-Smtp-Source: APXvYqzKOvJbxKDfeq93dECA590jCGkTvfvrPc/b5SDQxSte0nCxgVtPwgDxCK7XcpCDa1rPgxB0QQ==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr26124485wrs.147.1568105418420; 
 Tue, 10 Sep 2019 01:50:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z25sm1868449wmk.0.2019.09.10.01.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 616C11FFB4;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:34 +0100
Message-Id: <20190910084349.28817-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 30/45] tests/docker: use --arch-only for
 installing deps
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

The Debian QEMU packages require a bunch of cross compilers for
building firmware which aren't available on all host architectures.
Using --arch-only skips this particular requirement and allows us to
install just the dependencies we need.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 55045ff5d5a..09ca0a1ba79 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -13,7 +13,7 @@ RUN apt update && \
         crossbuild-essential-arm64
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a arm64 qemu
+    apt build-dep -yy -a arm64 --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 363a162a253..15378f8ea2c 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -11,7 +11,7 @@ RUN dpkg --add-architecture armel && \
     apt update && \
     apt install -yy crossbuild-essential-armel && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a armel qemu
+    apt build-dep -yy -a armel --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index d5365881e79..4a20af6fe1a 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -13,7 +13,7 @@ RUN apt update && \
         crossbuild-essential-armhf
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a armhf qemu
+    apt build-dep -yy -a armhf --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
index a54efa7253a..08a8e1c29cc 100644
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mips cross-compiler target
 #
-# This docker target builds on the debian Stretch base image.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
@@ -16,7 +16,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mips qemu
+    apt build-dep -yy -a mips --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index a1481e16e2c..2fca1124053 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -17,7 +17,7 @@ RUN dpkg --add-architecture mips64el && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mips64el qemu
+    apt build-dep -yy -a mips64el --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 88accad2692..4abf7832ac6 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -16,7 +16,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mipsel qemu
+    apt build-dep -yy -a mipsel --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index f10883c8188..9973df9ff74 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -12,7 +12,7 @@ RUN dpkg --add-architecture ppc64el && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a ppc64el qemu
+    apt build-dep -yy -a ppc64el --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index efa346007d6..eb73c988559 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -17,7 +17,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a s390x qemu
+    apt build-dep -yy -a s390x --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
-- 
2.20.1


