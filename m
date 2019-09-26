Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DABC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2159222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atuRu5O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2159222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYyp-0008GB-LI
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-0002Iv-D9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-00053j-KV
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm4-0004x4-Qg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 7so3939031wme.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=78Pca9rBvEb7vK2eIbGvM6734Nd4aMq+PG+qbhl5A/I=;
 b=atuRu5O3GeedQkbEkucjHOwBGKRRih6aoEkb3MKFobv4EcqX6/iMxWewrDiC3RXh4r
 TS+DxTou+9IrSwMRqUImgmy6mhH4FZ3EuWD3mJ1Qv6d+vDFmHA4udNZORCTIcN+mLQ2F
 JjuYfTJzxZ0qnm27N07CNGRnPFjbu1uFyIGr8jzvOlOpxu0bbBcFjQXFDuKaxcwQYNvg
 BGogTmHxQPSW6FtDf7zWkhpFfuTukDHRtH9XejoHn71cK0f/AawFsyzHji/kJtjpCoPa
 oySuApam8JPlzS1rfFfydC4irqnGjyF6Gw+t8yjFhi+U/QUyfryD2IWNYzeWGtZ4+BKE
 T3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=78Pca9rBvEb7vK2eIbGvM6734Nd4aMq+PG+qbhl5A/I=;
 b=g75MPAzB86/Xfd/gvNA/JRoGxa81Ahpy851m+ll9BrFjQFSiyIvkvMGtzH3nnH1ssV
 cZ8zX9H0c8HvGSYh2sVT0qX3oREqdW4uHJ5sU7SJpXl0Uyw6kulA3K/ZHY9iBO08FpsG
 MWzISt8wRB2gLFcJr3qgJN9gin6Fqsvxs/TgcrvDTiLsU7YyvrKwQM7DexTPOsoVgQXo
 8Fmb6bPGIlTX78hXzG8JJjKceWDSSy6Qbgm9h1WbhEmopBbXoJ846W7LLisnacEVLuaq
 FAfL7kJLd/uVS7m+XXhT1eg6lgwHs70V4lyLi4vSQs2u/pRMx9k6ULvpX8oFTlbotMGd
 zeiQ==
X-Gm-Message-State: APjAAAU2P6ndxb4lpwZsY7T86ncpFLwnmi++2iM1l4HX+AB575gB3M9z
 QR5zkMIMPGVSualmyK+nR/IviQ==
X-Google-Smtp-Source: APXvYqwRB4SeJ5019JoFBuxOAtsBYAqAsL5VUNvJGhTiwZNQ7xmQXLpFoTrjqaucE1H5Y2WhQj7WQQ==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr4528091wmi.90.1569523554444;
 Thu, 26 Sep 2019 11:45:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm9042277wmc.24.2019.09.26.11.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 409E71FFAB;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 22/28] docker: remove debian8-mxe definitions
Date: Thu, 26 Sep 2019 19:35:47 +0100
Message-Id: <20190926183553.13895-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

We don't have a debian8-mxe dockerfile anymore.

Fixes: 67bd36beda1ae
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190923181140.7235-2-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3fc7a863e5..274c848a1c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
-DOCKER_PARTIAL_IMAGES += debian8-mxe debian9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


