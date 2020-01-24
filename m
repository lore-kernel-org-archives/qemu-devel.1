Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE04C35244
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF4B2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXdYUiwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF4B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5s5-0003Zr-5n
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kx-0008BA-L4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ku-00065y-WA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5ku-00063w-Oi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:40 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z3so3602380wru.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CO6Bh5iCXjaTaQynC+oib+Hg/v44ekrp+1dnmcnUnXM=;
 b=YXdYUiwC+kskyrxKRiG0WuNYg7xAiqdjeV9ItNT2q8p54GRtB9XcpDKbXMA+BnknGN
 IjFvspL9XBEB6Xefggz2xBlDRxqP0rRLmv17vR7UItX5EGAhq7/3vhombcyr2I7zyISk
 qGQDpYyrCzG4YgQjDuTytt8YyKozdfZOqoR1ifXoBRCLJZXOgUNjKqi0ZS7QQgbtKGwH
 RKdEmwSB6URxoU77HwdICnJL6DoQHVdSru+lVIUeBArgendSxLk+CsOhWcSG/7pbWWDG
 o6Yu+0Axjp0h6ZCtfEghSG77Jr8VQl/LqHafKFimh/y0nKz6J/tUyhla8RbQ4zBMcn1r
 uiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CO6Bh5iCXjaTaQynC+oib+Hg/v44ekrp+1dnmcnUnXM=;
 b=SZer4ZL7Lzlx0orOuICg1zgviTqgB6rARBg2x6KawwPGW+1Zr1EvpDv+LM+heBfgqf
 oXqGtz6ipApKjMYVC9FaFNTtvM93Xycd21UxuEidCuNY0Nq6C0XRjpHqyE6FCrxaGYia
 6r2I/vySjF8FTNrjsC6abAjCsOpmgVfUv98FE6ZxTo612jfXlG0ygrDPjJCpkYAXIS6M
 CKlqJA7deqmfsLsiMsWOi96Y65ZsvAZI1je3rXwGdWKJ0n79SJxsN6QZo3CBaUj+LlAu
 VJMARGmIi4b5n+sBsjQjv1ZB1kCuFYiA5pjFeExJzRaMQyLaPMTr/F3OQ3Ct1QrZjBOu
 iqRA==
X-Gm-Message-State: APjAAAUV7/1iAfk0YtjvTtLAhCIfcH3hyGGoY7ytn8cnK2HOXorIW3ig
 rUgc4ajTgsLwrPuXlxR6WhntSQ==
X-Google-Smtp-Source: APXvYqw6b5Y7RfoCS77JpioH/+3gAcR2znNFrr9ZLZ/ec+lLJlk2K8sWieYE+Nggd8juDSUABpLsYg==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr6098434wrp.17.1579898439673;
 Fri, 24 Jan 2020 12:40:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e12sm8804760wrn.56.2020.01.24.12.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 319821FF99;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/13] tests/docker: switch to multiarch aware container
 support
Date: Fri, 24 Jan 2020 20:40:22 +0000
Message-Id: <20200124204026.2107-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We drop support for DOCKER_PARTIAL_IMAGE and related hacks in favour
of explicit building of lists of images by type. Currently we can't do
any of the QEMU builds but the docker-image target will allow us to
test that every docker image we declare can actually be built.

Later commits will re-enable the builds for each host architecture we
support.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 124 +++++++++++++---------------------
 1 file changed, 46 insertions(+), 78 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index c9e8bc40a1..b2b41c3e9b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,12 +5,37 @@
 HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
 
 DOCKER_SUFFIX := .docker
-DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-# we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian9 debian10
-DOCKER_PARTIAL_IMAGES += debian9-mxe debian-bootstrap
-DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
-DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
+DOCKER_BASE := $(SRC_PATH)/tests/docker
+
+#
+# There are 3 classes of containers
+#
+#    BASE_CONTAINERS - intermeadiate containers which are used to build others
+#    TEST_BUILD_CONTAINERS - contain enough compiler support to build tests
+#    QEMU_BUILD_CONTAINERS - contain build dependencies enough to build QEMU
+#
+
+BASE_CONTAINERS :=
+TEST_BUILD_CONTAINERS :=
+QEMU_BUILD_CONTAINERS :=
+
+#
+# Helpers for sub-arch includes
+#
+# $1 = list of dockerfile paths
+get-basenames = $(sort $(notdir $(basename $1)))
+
+#
+# Dealing with different host architectures.
+#
+# For x86_64 this is easy enough as most cross compilers are built for
+# x86. However for other build hosts we may have a limited choice. To
+# fully support all potential build hosts we can use QEMU's own
+# linux-user support to have a native version of the toolchain.
+#
+-include $(DOCKER_BASE)/dockerfiles.multiarch/Makefile.include
+-include $(DOCKER_BASE)/dockerfiles.$(HOST_ARCH)/Makefile.include
+
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
 
@@ -42,18 +67,21 @@ $(DOCKER_SRC_COPY):
 
 docker-qemu-src: $(DOCKER_SRC_COPY)
 
-docker-image: ${DOCKER_TARGETS}
+# The global docker-image rule builds all docker images we are capable of building
+DOCKER_TARGETS := $(patsubst %,docker-image-%,$(BASE_CONTAINERS) $(TEST_BUILD_CONTAINERS) $(QEMU_BUILD_CONTAINERS))
+
+docker-image: $(DOCKER_TARGETS)
 
 # General rule for building docker images. If we are a sub-make
 # invoked with SKIP_DOCKER_BUILD we still check the image is up to date
 # though
 ifdef SKIP_DOCKER_BUILD
-docker-image-%: $(DOCKER_FILES_DIR)/%.docker
+docker-image-%: %.docker
 	$(call quiet-command, \
 		$(DOCKER_SCRIPT) check --quiet qemu:$* $<, \
 		"CHECK", "$*")
 else
-docker-image-%: $(DOCKER_FILES_DIR)/%.docker
+docker-image-%: %.docker
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
@@ -62,7 +90,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
-docker-binfmt-image-debian-%: $(MULTARCH_BASE)/debian-bootstrap.docker
+docker-binfmt-image-debian-%: $(DOCKER_BASE)/dockerfiles/debian-bootstrap.docker
 	$(if $(EXECUTABLE),,\
 		$(error EXECUTABLE not set, debootstrap of debian-$* would fail))
 	$(if $(DEB_ARCH),,\
@@ -86,69 +114,8 @@ docker-binfmt-image-debian-%: $(MULTARCH_BASE)/debian-bootstrap.docker
 			"CHECK", "debian-$* exists"))
 endif
 
-# Enforce dependencies for composite images
-docker-image-debian9-mxe: docker-image-debian9
-ifeq ($(HOST_ARCH),x86_64)
-docker-image-debian-amd64: docker-image-debian10
-DOCKER_PARTIAL_IMAGES += debian-amd64-cross
-else
-docker-image-debian-amd64-cross: docker-image-debian10
-DOCKER_PARTIAL_IMAGES += debian-amd64
-endif
-docker-image-debian-win32-cross: docker-image-debian9-mxe
-docker-image-debian-win64-cross: docker-image-debian9-mxe
-
-# For non-x86 hosts not all cross-compilers have been packaged
-ifneq ($(HOST_ARCH),x86_64)
-DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
-DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
-DOCKER_PARTIAL_IMAGES += debian-s390x-cross
-DOCKER_PARTIAL_IMAGES += debian-win32-cross debian-win64-cross
-DOCKER_PARTIAL_IMAGES += fedora travis
-endif
-
-docker-image-debian-alpha-cross: docker-image-debian10
-docker-image-debian-arm64-cross: docker-image-debian10
-docker-image-debian-armel-cross: docker-image-debian10
-docker-image-debian-armhf-cross: docker-image-debian10
-docker-image-debian-hppa-cross: docker-image-debian10
-docker-image-debian-m68k-cross: docker-image-debian10
-docker-image-debian-mips-cross: docker-image-debian10
-docker-image-debian-mips64-cross: docker-image-debian10
-docker-image-debian-mips64el-cross: docker-image-debian10
-docker-image-debian-mipsel-cross: docker-image-debian10
-docker-image-debian-powerpc-cross: docker-image-debian10
-docker-image-debian-ppc64-cross: docker-image-debian10
-docker-image-debian-ppc64el-cross: docker-image-debian10
-docker-image-debian-riscv64-cross: docker-image-debian10
-docker-image-debian-s390x-cross: docker-image-debian10
-docker-image-debian-sh4-cross: docker-image-debian10
-docker-image-debian-sparc64-cross: docker-image-debian10
-
-docker-image-travis: NOUSER=1
-
-# Specialist build images, sometimes very limited tools
-docker-image-tricore-cross: docker-image-debian9
-
-# These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-alpha-cross
-DOCKER_PARTIAL_IMAGES += debian-hppa-cross
-DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
-DOCKER_PARTIAL_IMAGES += debian-powerpc-cross debian-ppc64-cross
-DOCKER_PARTIAL_IMAGES += debian-riscv64-cross
-DOCKER_PARTIAL_IMAGES += debian-sh4-cross debian-sparc64-cross
-DOCKER_PARTIAL_IMAGES += debian-tricore-cross
-DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
-DOCKER_PARTIAL_IMAGES += fedora-i386-cross fedora-cris-cross
-
-# Rules for building linux-user powered images
-#
-# These are slower than using native cross compiler setups but can
-# work around issues with poorly working multi-arch systems and broken
-# packages.
-
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
+$(foreach i,$(QEMU_BUILD_CONTAINERS), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
@@ -174,15 +141,16 @@ docker:
 	@echo '                         "IMAGE" is one of the listed container name.'
 	@echo '    docker-image:        Build all images.'
 	@echo '    docker-image-IMAGE:  Build image "IMAGE".'
+	@echo '    docker-binfmt-image-debian-IMAGE:'
+	@echo '                         Build a binfmt Debian bootstraped IMAGE'
+	@echo '                         Specify DEB_ARCH, DEB_TYPE and EXECUTABLE.'
+	@echo '				Optionally specify DEB_URL'
 	@echo '    docker-run:          For manually running a "TEST" with "IMAGE".'
 	@echo
 	@echo 'Available container images:'
-	@echo '    $(DOCKER_IMAGES)'
-ifneq ($(DOCKER_USER_IMAGES),)
-	@echo
-	@echo 'Available linux-user images (docker-binfmt-image-debian-%):'
-	@echo '    $(DOCKER_USER_IMAGES)'
-endif
+	@echo '    BASE: $(BASE_CONTAINERS)'
+	@echo '    BUILD TESTS: $(TEST_BUILD_CONTAINERS)'
+	@echo '    BUILD QEMU: $(QEMU_BUILD_CONTAINERS)'
 	@echo
 	@echo 'Available tests:'
 	@echo '    $(DOCKER_TESTS)'
-- 
2.20.1


