Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03C21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lY+pPjfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03C21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYpj-0004tk-0B
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-0002Iw-Dm
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-000541-LV
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm4-0004w3-Q7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id i1so3927931wro.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sWokc3VfRDh7CCMRnemCi17aJjvdK8FYydyOgOjehxY=;
 b=lY+pPjfCj0B9vP9DcspOyjk5lGCg1P34tL8FoTd7NB5URt3bGtq5uIvmiwevHhDzzi
 8AMgvgGL0idHx72AR3t0fqxdm7CDVTc8uLXqpc9J6h/rXSaY0imv8E5wfOKSNPULr+DV
 nvuRkpSYCHND4O+qujmLlVLV5RCGyPZMMd4VjHpHZ9ehSZB/gY1vYMY4zp6TOAEDIpuu
 CRtgu0uC8fR+0xq7jZWZOAEumyIpXhR/49KK4vkVMVdU0rUi0BhbFIYl1MB3XG7Ax4/C
 Km9FHUXXiHugsfuXS2vrLs3S5UcjJEz7lV7fnHXbiwd451IXLpc2s4ffdRvKhvm2QiDa
 sO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sWokc3VfRDh7CCMRnemCi17aJjvdK8FYydyOgOjehxY=;
 b=GB9wl0tE3aYGCOA6x1yVlk7/7kBr9dS83EnaPbRI3dShuTZ1yT5cTTISYaWO+eb127
 DeozlEtpga96a+jBLX913aKr9SUzwgaiAcEGk8ECebrzbPl90H362lT4+AphSSr3Wo/4
 +dHrHZMCfpLnKhhD86aeEdAdcAOVEl6OrKdQc0YpeJyMPqeiIH2b5xEyRUPHT+pBrEa9
 kiSymv38/HBSJjct7Js8/lu39c3nWLIId1ziIWpj3P3nR8PzFN9qOLcA4/MWa2NZ7aoe
 q+7ZlKpx1W9mTHFL4PqnOINaV/cDh4cqnnHcxOBpwkvbsegJGRJyFSMkZs7ziNEBaMA6
 DuTw==
X-Gm-Message-State: APjAAAU2JadF2cEMYqMviUnYB5BFbuUiDBfXCC20QFLogMOpag/HIFyG
 8fKyn4nxN+3pUJoJ77nh8riptA==
X-Google-Smtp-Source: APXvYqwXmOIyyNngbq0XMegY0WDzRs5vHsvwtlSrFX7MdLWyoG8Gudq0xc3GilDZxQgiFrbguqTciA==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr4304317wrq.177.1569523552304; 
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm5564157wmg.41.2019.09.26.11.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5718D1FF8F;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 23/28] docker: remove unused debian8 partial image
Date: Thu, 26 Sep 2019 19:35:48 +0100
Message-Id: <20190926183553.13895-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
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

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 274c848a1c..47ff777440 100644
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
index 1212a85c35..0000000000
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


