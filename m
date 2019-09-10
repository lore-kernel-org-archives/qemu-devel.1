Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318C3206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVi1CURH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318C3206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c45-0007Ny-Ue
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkr-0003VJ-Eg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkq-0006PK-5X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkp-0006Oc-VC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id h7so17351479wrw.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mdCWEzeqB/NJreuqbYnaAE61zGJxPS13UIEj9hf0Lqo=;
 b=kVi1CURHSGWJh2ir6b7dsOTDFoXH/zO3WIkPAk4NBSFIZl+a2XXMgB8cFeRBz+eeNB
 PZ3F3oGoXRFqjFH9HUCsvU0Hv728nr6Q0VGYJNWhgBmU4vkmHZqQcLPGHMWmWzuI5XMf
 8HTSbgMHVTFeXshjAIA+Rvz76qYpQ/SsACaeDm6WjXGCcbwZF/5zgog8j1aQkUN0+G04
 80qG4B+nc3Cw2CYyvOWQzvC7Wa3HU5GLBH7NrL94JRG1SzH/8hNRdWwfkMVTdFZGafKI
 4d5esLryXzPTvMQcH8WhKK0bpnyi8rGUBOycCHHK6VhKXqlM+teiKFjJP+iy3Nz5E4g0
 surQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mdCWEzeqB/NJreuqbYnaAE61zGJxPS13UIEj9hf0Lqo=;
 b=RiYDFwwyIb6JYBTcT3szHbZU0KWWgFBhfjmxKH3pEWbAW1WOuNrGI9KPTvCcv/P28T
 xGjl4LZRPG8zlMEDqnqiOzimipjMVLJjLXXwXKdXWiqnE0RcBdiKPPB46dNkZol4BlJK
 s7DP0cPaRiupN9l+PvBJeBK41BmB70yJREBUVzGfdGEYlIlLFFkyLwm2biXI1rJ27rGr
 bYKt2sVxBbg26yNRqahT32Oqtj1yuw56qQ+m5v3QXcEo7gUPAORCgOnl3b5FrohkYS+5
 8DcqLR10k0YoiuheDrTko4DccZIKHNneIiIZPbZKW1oparVF+9hmd2jCKlJk0noX+mPf
 jw1A==
X-Gm-Message-State: APjAAAWRZ2+ByZP4y9LdNPMfAT/VSqUBftjtLPTb9RLLODYXgkrcjnat
 IMRbt1c3wOgtULmdU+XW8zZCZcoH9dc=
X-Google-Smtp-Source: APXvYqxbJUynNbcSIc8YE4eGS/Q7UoaAW6Fe04wD895JxoY1db9X6CAb1RItD3859ofvb+9BAwfETw==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr9525156wrt.6.1568105042898;
 Tue, 10 Sep 2019 01:44:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm3020933wme.23.2019.09.10.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D74C61FF8F;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:18 +0100
Message-Id: <20190910084349.28817-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 14/45] tests/docker: move our arm64 cross
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

Now Buster is released we can unify our cross build images for both
QEMU and tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 89881fb5f5d..48c22ae40c0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -86,13 +86,10 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 endif
 
 # Enforce dependencies for composite images
-docker-image-debian: docker-image-debian9
 docker-image-debian9-mxe: docker-image-debian9
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
-docker-image-debian-arm64-cross: docker-image-debian9
-docker-image-debian-buster-arm64-cross: docker-image-debian10
 docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
@@ -101,6 +98,8 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+docker-image-debian-arm64-cross: docker-image-debian10
+
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6b59ef0843a..55045ff5d5a 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker arm64 cross-compiler target
 #
-# This docker target builds on the debian Stretch base image.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
diff --git a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
deleted file mode 100644
index 52787edcc2c..00000000000
--- a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# Docker arm64 cross-compiler target
-#
-# This docker target builds on the Debian's Buster base image. There
-# are no QEMU pre-requistes so this image can only be used to build
-# test cases.
-#
-FROM qemu:debian10
-
-# Add the foreign architecture we want and install dependencies
-RUN dpkg --add-architecture arm64
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        crossbuild-essential-arm64
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 8c648ef3c24..b8dae18d1cd 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -95,7 +95,7 @@ for target in $target_list; do
   case $target in
     aarch64-*)
       # We don't have any bigendian build tools so we only use this for AArch64
-      container_image=debian-buster-arm64-cross
+      container_image=debian-arm64-cross
       container_cross_cc=aarch64-linux-gnu-gcc
       ;;
     alpha-*)
-- 
2.20.1


