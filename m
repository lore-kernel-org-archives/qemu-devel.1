Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D70C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A9520863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ss2K+B11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A9520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7buj-0004v5-Jx
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkp-0003Sh-K2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bko-0006OB-Gi
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bko-0006NV-AS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id a11so8602726wrx.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h+Y+t0dpxJfi/9GTwgQnzZfP7op/VsJjQNNxO4mFlAc=;
 b=Ss2K+B11QdQE0oxs5X7l27fDEZQxvXACr82lPYxkv+ZHekN+s+xXdU+ukymOKzMqPi
 sD2CleetU1uWqwEsAzY0f5rIkBMPgaGoViwnDJR/CcLGYBYwNqObjX8GV2lA4NM2BfsY
 5kVchudlTZ+h+f0qaq/p8yeHKlIe123WW9dA+Kl4S/F4Mnvst7dxh2ao/fzWvms3zSC1
 LqdC+zaS+a/K7V1DKZ8UwZJo4W8qqM/FDYm2SeNmx4jTWKhePNzFpSjwhCWA1oiEa+Gr
 dO9FDF6sCY9MazdoGi+/y2gCvu2hw7+i8y1otN0EOvxoY/K1UI8m4aSggEdjsM6hMgbB
 +8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h+Y+t0dpxJfi/9GTwgQnzZfP7op/VsJjQNNxO4mFlAc=;
 b=rhHiUe0EH/17WVr0xmnhJyoDKZCrguV0Q/gBYIIZJcLEXgH9/qbX1NanYKdBhxO06V
 +45DKZAH901sJIKi4THww4OuJTtHscmnC6XP0IdESPIKTTteRGI4FqpD6eE7gR49gilJ
 ulDC4J2Bdx1JAzJpuaotvxNLbCnfOL8SNuXLp/BMqYivYLuDMEKNgGr8SzfWRwm1jGLb
 SHLq/k0wygbarvYOZRGR8f3bO3IQfghEUXvYmvGjngmLvWtUpyx8k8llClg4tDYwLwmc
 Il6IFmU1+2vmM3wsrtLeig6tE1Nc121+MBusHwPwFxlmc5lD1NINmpjlok0HSVY5Lda0
 fg/w==
X-Gm-Message-State: APjAAAURIyl3EUhIY7fmNteUx1FRF4oxcG6PwHeaCanAeP3FnYLbCW6i
 jJo+QV4BcRt3fgZJS4X8DD8Xfw==
X-Google-Smtp-Source: APXvYqw7k8/exNjvwez5EGslS3JrqI8jDXBCBMAg2P6ome2vJdVhIfIqvNRmZRC0bmUlkNxJfbntkg==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr4809263wrv.30.1568105041244;
 Tue, 10 Sep 2019 01:44:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a205sm3066063wmd.44.2019.09.10.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE5331FF9D;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:17 +0100
Message-Id: <20190910084349.28817-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 13/45] tests/docker: add Buster to
 DOCKER_PARTIAL_IMAGES
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

We need to add additional packages to the base images to be able to
build QEMU so lets avoid building with it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index cf535cbd196..89881fb5f5d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian8-mxe debian-ports debian-sid debian-bootstrap
+DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian-ports debian-sid debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


