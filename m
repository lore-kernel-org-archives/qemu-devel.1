Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74FD20828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNV9avIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74FD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dHO-0000NR-FQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDW-0001vY-Hv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDV-0002RH-6x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDV-0002Qe-0M
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id t17so246052wmi.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eex9C7ku7qLfjN/PN3lyTLs+AN2XoVsX1psapATGztk=;
 b=VNV9avIS44htgTf6d22q1L8b91Xr7ylE4pmd79JEDm8z42TxMKy+4wm2hkSbhJLBwB
 366+y/s0wBW/4E04rXWp3dT1eSMerwzZSLyb1nAWP78FEFPNImdl6Q7xvbOXF0tdYgb6
 5sc5sC3TRgGU640Mpfzg7KRZNUdZHJHoOM8Gg6cNX2HGVlVQNnrbaDMsvVpWGY/XUFBU
 JZpwsow8dHFqevMjTOmzaEx7AY/GZlAy8ZwUpVaxcwnUjp2nq4Y936EdrsLAKiCya7QT
 VP1VdzEHUayXFPTvIfQqUduptKJsQzhNg866gWVikfmakgiaHJ5gCtxAFDwcxLG+K91j
 1lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eex9C7ku7qLfjN/PN3lyTLs+AN2XoVsX1psapATGztk=;
 b=f573VrB3z6MmPGnU38pXMvM9+d327MccN01l7eSmEw6RFlVR7YSk7+s2T4IDpMaB2D
 Pgw5BPZsOCEpIB3unQ7uFHC7Q75yuItCFrzSFm72jvP3eWExBFRhpWkBaiDmy0X4vv0L
 LB68dx+XZwOi25ZX4JP/c/JJ14ifoFlSzd/sbSlA/UV2B3Tv4/qdt6qIhDtfzpv8+ooZ
 bsVOwoNSWJrW1c0W9J0VvOwryj7PhOOoSDhLnyP4QAYlGTP/zNCZl1w2BczPJpFE/e5r
 nA/DDBb9UebDq8sc734kStc0MJZ9QmfYIhH7j9uc4a0oNjvXLBQEki72ELWfwD7x3aNd
 0Gig==
X-Gm-Message-State: APjAAAWmb/3mH4czR/C+YhZun0OxcfOZ9aVyjW4LpCt/oHUsnauc4IqG
 heTFrZbrInVCrt+wh14/ehOsQw==
X-Google-Smtp-Source: APXvYqwz+ZQWRTNTWoJL/Ha66PNITQW0Z3bQ3Ilu3/L/TwogQ5bipVmJ133u9hMfE1drfqVvfzSOMw==
X-Received: by 2002:a05:600c:1087:: with SMTP id
 e7mr143646wmd.19.1567630163863; 
 Wed, 04 Sep 2019 13:49:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n7sm18017391wrx.42.2019.09.04.13.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 775B61FFAB;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:53 +0100
Message-Id: <20190904203013.9028-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH v1 22/42] tests/docker: drop powerpc-user image
 for QEMU cross builds
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Jessie has entered LTS the powerpc architecture has been dropped
so we can no longer build the image from scratch. We will still
support a minimal powerpc-cross image for building testcases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
---
 tests/docker/Makefile.include                     |  8 --------
 .../dockerfiles/debian-powerpc-user-cross.docker  | 15 ---------------
 2 files changed, 23 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 59fbebbe2e6..f4e9dfc0120 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -126,14 +126,6 @@ DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 # work around issues with poorly working multi-arch systems and broken
 # packages.
 
-# Jessie is the last supported release for powerpc, but multi-arch is
-# broken so we need a qemu-linux-user for this target
-docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
-docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
-docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
-docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
-DOCKER_USER_IMAGES += debian-powerpc-user
-
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
deleted file mode 100644
index 6938a845ee2..00000000000
--- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
+++ /dev/null
@@ -1,15 +0,0 @@
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
-FROM qemu:debian-powerpc-user
-
-RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
-RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-- 
2.20.1


