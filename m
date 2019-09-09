Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C750C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081AC218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0MPg58o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081AC218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7I4Y-0005QI-4T
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7I3a-0004hn-Rd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7I3W-0000vN-IU
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:42:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7I3W-0000ti-1K
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:42:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id t9so14254171wmi.5
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y4AWb77QkjKjbHJERD/B2CIg2QEHWkCYs9dY7bv0pP0=;
 b=C0MPg58o9PsSMpqYLfwGE0iFkyP710OqGP7xifjdyaQkpkFAT2cgsfa0DGh7BYmWwc
 dptMFrucB9RwVJv/XrrN/dNVsiy/pKvZMwpEaNsf5FdCRJOLfF9M7mO9TI26ZLuvBmPZ
 6NXkDewLohCZUCNHf72fQB0NrHoWje5UT+d4y4h5Av9IgexmmJmsKGrBr2QQUwC0T8JP
 WYRExT0xwN5qHPsVlPWKe3ALvUa/UMJCfocARf3u/qzgWURqotlvu5lDI23/2cByDKBf
 1XpeI5tT2WlyqBJokUvCBniiH/RV64Av2vblbtVcLvTSB1SDAD7M5O3PpROeX7mAvEfx
 1LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y4AWb77QkjKjbHJERD/B2CIg2QEHWkCYs9dY7bv0pP0=;
 b=K55su83aWdSLoHdeEoC32SbWWNbs1MDTBOMx5x5W31z3flR3zfYeLKhHoUspeMiUUD
 mZAzMFmrDUIy5qz1+FjjW8ukPS2ij75TVMWKKdQU8dZrOk7dsKtSz288mmVQlbk+UMKL
 tQ845tlgqE1mQMCWQ+w9SWXwvtYTIgl7WYq7sorxjDrUrtJzUH/OaKVVQpBNjBvdPFz9
 2/rA4TBdZUrCzozMlTfe+JfBYJDB1hqGmwDy9/DDKqRF76+yCfXFiHkXyb8UqXJqTsMy
 0zbXCZXscCv0zqWRChZ57evQ+VTPJKr2VZ4qnwcH+OgAzALbnnZvM78/qHqWUadMSZfT
 ochg==
X-Gm-Message-State: APjAAAVYiPD2f7Mz5G3UqSb3iLw09dYi0E/mF4EDzsnHM8e56GKWAZAV
 rb3NRqzvDmvG4jRz/bsEwFLmVg==
X-Google-Smtp-Source: APXvYqzmswVBwwrfxeW+MNgRaOiUSYiqeyw23Us6uXRlWkIREm3YlSdEOrOvq6x2tESXQtiwEe4Eag==
X-Received: by 2002:a1c:f917:: with SMTP id x23mr19280587wmh.101.1568029320684; 
 Mon, 09 Sep 2019 04:42:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm22784525wmf.38.2019.09.09.04.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 04:42:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E2F31FF87;
 Mon,  9 Sep 2019 12:41:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 12:41:51 +0100
Message-Id: <20190909114151.32404-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH] tests/docker: pin powerpc-user-cross to a
 snapshot
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Jessie has entered LTS the powerpc architecture has been dropped
so we can no longer build the image from scratch. However we can use
the snapshot archive to build the last working version.

This now only lives on an example of setting up a user-cross image as
at least on x86-64 we can use the Buster packaged cross compiler for
building test images.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                             | 4 +++-
 tests/docker/dockerfiles/debian-powerpc-user-cross.docker | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b6c04059502..b06716ff71c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,7 +71,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 	$(if $(wildcard $(EXECUTABLE)),						\
 		$(call quiet-command,						\
 			DEB_ARCH=$(DEB_ARCH)					\
-			DEB_TYPE=$(DEB_TYPE)					\
+			DEB_TYPE=$(DEB_TYPE) 					\
+			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
 			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
 			$(if $(NOUSER),,--add-current-user) 			\
@@ -130,6 +131,7 @@ DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 # broken so we need a qemu-linux-user for this target
 docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
 docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
+docker-binfmt-image-debian-powerpc-user: DEB_URL = http://snapshot.debian.org/archive/debian/20180615T211437Z
 docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
 docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
index 6938a845ee2..83749b0abb8 100644
--- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
@@ -8,8 +8,14 @@
 # debootstrapped qemu:debian-powerpc-user but doesn't need any extra
 # magic once it is setup.
 #
+# It can be used to build old versions of QEMU, current versions need
+# newer dependencies than Jessie provides.
+#
 FROM qemu:debian-powerpc-user
 
 RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
 RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
+        DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
+
+ENV QEMU_CONFIGURE_OPTS --disable-werror
+ENV DEF_TARGET_LIST powerpc-softmmu,arm-linux-user,aarch64-linux-user
-- 
2.20.1


