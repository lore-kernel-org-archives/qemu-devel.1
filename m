Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAF6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55E62146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgV3O78Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55E62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtRG-0002u0-Fd
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5L-0003VB-2j
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs58-0007aW-4q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs57-0007aK-V4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so3661099wro.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=09O1Ly8NFsL8DCLzHd3RHxhmvaQZgOCY++TrLIyuMqA=;
 b=LgV3O78ZmNmcFS8tmPwXrJ9aqbYX1MMDlxZdcFapkm1aB7tK/9nltPoiswwZdRJ5g9
 cgkHT3y6Gt2H9jE1ECZ5u6BVpK0lod5P2XGDN/RK8o465hdRftxEKO9KX+m02Lut0bs3
 vFqlqfY85ygTEXXOoi2UtJeuOkIOXrxaBDUVLOwRLK4sYwOxEGQ/BWiebKgfO2uk7CHF
 f9F+MsHDfi3rDIrHmXNkNe6+AW4diQ1IzOSeJCvlUnOXjSQV1C+ltK/ILMBqKgTK6wtW
 PJNIOOE00Wc1OjOIl8HWrmE/PRYRt/ep9yssAlCTpLXF3I8Y2n8sp5zKpQrJUoYHm/Cw
 VyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=09O1Ly8NFsL8DCLzHd3RHxhmvaQZgOCY++TrLIyuMqA=;
 b=idDKh0QXW39jKddNKw6N5vQEC53FekcqTCcIZlNFZceIwV64BhOwWTCBDWD6Qzyz+L
 fJxQQ8wzr6aPUz3C5uuXFNVc2i1DzvUcC4hob/I36O4iOOfOr8YZzA78Mad0rOTOuiLs
 6qPgeqY+kULEevQBr0+5PUms4KZ0bAivBxXlc5uU7p6nUnq0Soug/XUwMwVABMYV7uZ6
 IqCPyXaYIB/KnozGdlamEVeJ27sdbYZ11Cwfj2srMDVvPzrFZJP8wfs6BT5kPDKAQv2n
 znAbdW1JgRHtPEbcaine+KK8L3f0DBctsOCRaGGGIbIxrBOD5HvoZg2vikXmx75Xi3de
 Pgyg==
X-Gm-Message-State: APjAAAVpPiPVHYAQ3F9zINJMNGXlyORNtKxi+KnCpsLs+tdluXa+vU5a
 0ClNFQwYAJGfozVNcKG6p9P1iA==
X-Google-Smtp-Source: APXvYqwOvLkLMuGHsEqxBQhmqjinfaH/W/TJwancI0j03bP4N7jQiaiU+lIG6DOmKv274JlkH50u0g==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr3298080wrq.318.1569359444843; 
 Tue, 24 Sep 2019 14:10:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a71sm656450wma.43.2019.09.24.14.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9D7F1FFB8;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 33/33] tests/docker: remove debian-powerpc-user-cross
Date: Tue, 24 Sep 2019 22:01:06 +0100
Message-Id: <20190924210106.27117-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Despite our attempts in 4d26c7fef4 to keep this going it still gets in
the way of "make docker-test-build" completing because of course we
can't build a modern QEMU with the image. Let's put the thing out of
it's misery and remove it.

People who really care about building on powerpc can still use the
binfmt_misc support to manually build an image (or just run the build
from pre this commit).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tests/docker/Makefile.include                 |  9 --------
 .../debian-powerpc-user-cross.docker          | 21 -------------------
 2 files changed, 30 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 180e5439ef9..dcc37093138 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -149,15 +149,6 @@ DOCKER_PARTIAL_IMAGES += fedora-i386-cross fedora-cris-cross
 # work around issues with poorly working multi-arch systems and broken
 # packages.
 
-# Jessie is the last supported release for powerpc, but multi-arch is
-# broken so we need a qemu-linux-user for this target
-docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
-docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
-docker-binfmt-image-debian-powerpc-user: DEB_URL = http://snapshot.debian.org/archive/debian/20180615T211437Z
-docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
-docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
-DOCKER_USER_IMAGES += debian-powerpc-user
-
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
deleted file mode 100644
index 83749b0abb8..00000000000
--- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Docker powerpc cross-compiler target for QEMU
-#
-# We can't use current Debian stable cross-compilers to build powerpc
-# as it has been dropped as a release architecture. Using Debian Sid
-# is just far too sketchy a build environment. This leaves us the
-# final option of using linux-user. This image is based of the
-# debootstrapped qemu:debian-powerpc-user but doesn't need any extra
-# magic once it is setup.
-#
-# It can be used to build old versions of QEMU, current versions need
-# newer dependencies than Jessie provides.
-#
-FROM qemu:debian-powerpc-user
-
-RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
-RUN apt-get update && \
-        DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-
-ENV QEMU_CONFIGURE_OPTS --disable-werror
-ENV DEF_TARGET_LIST powerpc-softmmu,arm-linux-user,aarch64-linux-user
-- 
2.20.1


