Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE535C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831972146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxICYUxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831972146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtXc-0008UQ-6k
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5G-0003QK-IL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs56-0007aE-Mi
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs56-0007Zw-G5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id r3so3648220wrj.6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PeXbOtrBZF+8O5whsej0UzKUBQHCTeTmZtfTgjX8/9A=;
 b=IxICYUxPXcggMr8qGX5+yGX3rpelSb40/1xJyrENWeKkyJB/CM5dE6toSqA9pIQLuu
 QA8oxX0KKJDHaC9ALx42h9hr5fc7+nY2MFGC4CyPRRneGls0xxcwpNpQBlYofnsZzZZT
 DoSjPG7xZmEX/2OSTjTnuzCI9/De2HAMJljYNKENZ1vDWB+Q5HIvZjR+v/M/LsETSljP
 Iqj/qDbJqgbi1E9xrcbHAfP92G0et2p+pr30oGUuvfDu6abHmAu+ZOKxmY875VTwJZ7C
 Bi3SqWZ9XK17A8p9KKRmuYHDUVD40YbAM7CEz01E4cGtTg4fsxFREOJup+cN+7GfE7lc
 JUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PeXbOtrBZF+8O5whsej0UzKUBQHCTeTmZtfTgjX8/9A=;
 b=cq3vzhuEpoGuJ2mjsLyKjbD12WFzr3O9ItzBk+2ajDugb0B66dms8wRv9WmbsyxpEP
 ojFZ/1HMPL705eFIo3r+377ChmhukSmfQkcYr7pTd4SxcP5FEmDXAEuXOu68LoThCsNo
 IdCsLTgpsj7tubDJqAxO2TdrQT3s09+EzPgkj4uOAxdJdD6mA2CoIDhUtWFzhmTrpXe2
 3vqX1lDQkjnSUVGBaddcqYVbRWCcZX0aRHBph3F9Tdn5rYrO9Q9/YxrEqKb9S7+6gfYp
 +GK4HdMswe9MQA6zqMUdUQweLIXiAW3EUEsahXlzSf+4RVFArr81R6Lqed6gqtO6EvVn
 7Wvg==
X-Gm-Message-State: APjAAAW0ArKBR/7uXkGQns5cZ7vIT0Ekiyw80jRmzluQ4WBboxSfVnWD
 Vu3yUcot0URxEwgmenqrBsJGKg==
X-Google-Smtp-Source: APXvYqzgDbgQMGaOvtgmqN48PYfnd0Sc/G3LQyWC0VnbjKyXAUHzso2UxLlobJ+eo0A6fCCIFIc0cA==
X-Received: by 2002:adf:b648:: with SMTP id i8mr4455366wre.372.1569359443311; 
 Tue, 24 Sep 2019 14:10:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y13sm5145416wrg.8.2019.09.24.14.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7170F1FF87;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 28/33] docker: removed unused debian8 partial image
Date: Tue, 24 Sep 2019 22:01:01 +0100
Message-Id: <20190924210106.27117-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

debian8 partial base is also not consumed by any image, so remove it.
For QEMU's development cycle, we only support debian9 (stretch) and
debian10 (buster).

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190923181140.7235-3-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include           |  2 +-
 tests/docker/dockerfiles/debian8.docker | 34 -------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian8.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 47d2273f29d..82d5a8a5393 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES := debian debian9 debian10 debian-sid
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
deleted file mode 100644
index 1212a85c35b..00000000000
--- a/tests/docker/dockerfiles/debian8.docker
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Docker multiarch cross-compiler target
-#
-# This docker target is builds on Debian and Emdebian's cross compiler targets
-# to build distro with a selection of cross compilers for building test binaries.
-#
-# On its own you can't build much but the docker-foo-cross targets
-# build on top of the base debian image.
-#
-FROM debian:jessie-slim
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Setup some basic tools we need
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        bison \
-        binutils-multiarch \
-        build-essential \
-        ca-certificates \
-        clang \
-        curl \
-        flex \
-        gettext \
-        git \
-        gnupg \
-        pkg-config \
-        python-minimal
-
-- 
2.20.1


