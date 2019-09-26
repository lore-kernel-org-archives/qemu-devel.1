Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7330C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72223217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSO0GSTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72223217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZ7r-0001E3-MC
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmC-0002Ke-5b
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-00055x-EC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYmA-0004zf-5u
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id p7so3925537wmp.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w8is8rZhnjRu4cXABpaM/yIcdELm1IUron9MLQsKwM4=;
 b=WSO0GSTuHTeoFoV9WlkJgDPWjdjdhredHUKommUnQE1Q3kngFzTIllUCbW1CcYn+/7
 CPwpzzKOppnWwoeBeWyarEAmEAgqiP2/eOK2nTcrcHWEu5brnoWilSaRd2WpKlYQyxiJ
 NfzWe8oJC4ddpnPOsFzm5yCFTwpS4+x+hpzA5oWkXdbVTPh72W3M3SiidgGusL/ozElo
 yF0BhOvQ5RHX2sstKi2Daq47Fwv2xuvkxg1K1VXggEGLWzuXL4JOejKpw2IqK+hcnR8S
 yD/2EVxWYQbrR3C4wUo6GU5YINRmC6sngX/7kcc6yfrLNmL8ZiSzLiFrca4w0RBNBsbN
 /fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w8is8rZhnjRu4cXABpaM/yIcdELm1IUron9MLQsKwM4=;
 b=JBdNvXtLFllLajS2EL9i2dLynFK8UkSyEUaAm2YgYbNa/qVWhTYf4iTao9dKz6WDQg
 yhy9GLpdVy42aJbJ9l3/vBIaosM3GqRKZA2D5B4nDBeGpXHLRlKyhrvk34lJ7TOYt77o
 BNlEkqTrXZsw8poa3sscRbSe6GwxTGC3mvTLG6LM7pkEeds05jqscJf092mG7WMEu/rS
 BWGUFySU0RsE/xtt3VUC9WZq4XCCPdyTapl4+5NJ2B08/SbwgGxys7zPyhc7o5sQ9V1W
 QISwndkyY0h/Nn7cFEdP/y/36nKYsdaERrZalnZDb1uq+MC28pirjpdRPIgoOBGn4/w0
 3Nxw==
X-Gm-Message-State: APjAAAVgd/ABVCwzaLxvdWce6WS5ASuJCSG2TuPuvrQKiiWnIcMRV1vQ
 qMEe2eP0t45Dp8v8C5Yz73nWmA==
X-Google-Smtp-Source: APXvYqzOWDixjFNIbLIIQV5HitEbykHMCKUrH2mq0u0wcAvrSaTKfaCvfsWMGtWlwXsO3HwOxwPG+A==
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr3899752wmm.37.1569523557498; 
 Thu, 26 Sep 2019 11:45:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e30sm165916wra.48.2019.09.26.11.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 830401FFAE;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 25/28] docker: remove unused debian-ports
Date: Thu, 26 Sep 2019 19:35:50 +0100
Message-Id: <20190926183553.13895-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

debian-ports is listed as a partial image, so we cannot run tests against it.
Since it isn't used by any other testable image, remove it for now as it
is prone to bitrot.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-5-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a19341e326..df73def340 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian9 debian10 debian-sid
-DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian9-mxe debian-bootstrap
 DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
deleted file mode 100644
index 61bc3f2993..0000000000
--- a/tests/docker/dockerfiles/debian-ports.docker
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# Docker multiarch cross-compiler target
-#
-# This docker target is builds on Debian Ports cross compiler targets
-# to build distro with a selection of cross compilers for building test binaries.
-#
-# On its own you can't build much but the docker-foo-cross targets
-# build on top of the base debian image.
-#
-FROM debian:unstable
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-RUN echo "deb [arch=amd64] http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/deb-src \2/p" >> /etc/apt/sources.list
-
-# Setup some basic tools we need
-RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        clang \
-        debian-ports-archive-keyring \
-        flex \
-        gettext \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo \
-        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.20.1


