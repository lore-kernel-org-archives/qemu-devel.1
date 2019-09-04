Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25471C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76A22087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyWAvfTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76A22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cMN-0003FA-Cx
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3q-0000p1-Vr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3p-0003Qb-OV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3p-0003Pp-Gp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id n10so249203wmj.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=68LGDwWChmAv2fWCzB7IqhsP8GzqVkWxCTjfvKv21og=;
 b=cyWAvfTzFnrPpTif9QgM241PJ5CHQrygnslKo2QLTFJ2Ix96mfvmqlPxKps08Zjxbo
 PfnWBuhEBQVC9RY0I7A/YGvuG/4s0nkQDPSZ1O4xkuXOGP01BTTTqe1lULYLbZx3OwDM
 IvVtoPJT5Oa059SpI3LYtglbBR5LYEGJS8yt9LJUal+4QLngH0vWHv05MlPEuM+KcRYh
 lF8MioZUPS3J01tANsPC8DjGXiAq5dGJRqO9EjqtbhYGlfxovBGz/cJZjWAmTGL68R2G
 0Rvb3as5uM/uYIvLIl5ZHfetL40GAxH8Px21x3itmz4GvLAKprkwhxdPvrA8Upx9xczw
 njTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=68LGDwWChmAv2fWCzB7IqhsP8GzqVkWxCTjfvKv21og=;
 b=NqFlPTOOp0hcbrV+PU+D0tTH0izjShOwjRQ880x8LvueAPaNluPJnrMNYxC3uFM++Y
 IL4wKexxS+wxVBMxQDtAQqkPY+Mq/uVOjoeWKOnz2/3fCIuguAHUU1S/aAC+8eJvLTOV
 L8+PXGOGrPco6QIlDrDETK0RvLo9D3pLyaYRiLYVZnlIgSRnG0VKkjUlAjtPaVmPKY9U
 ee/IzoJBwjv6zPCnpEgTsggeIUrdELVPkU5COf+5mfDC0cRGQyh9t1iVEHSCaYLSrNqB
 CdSKGEviimEHKHB897o8PfGpdBJtZOb2Q8B3vL/Xkxtr8Wv3VfwZjQ4DMiBQ400XIH6W
 8mlg==
X-Gm-Message-State: APjAAAUjIby+4Ww/StcqJlCImwCxzMZRnJ0fXkh5d+9etPvDxozWesPp
 rIsPUq7A0nao+Ak/YDTiRhlRQw==
X-Google-Smtp-Source: APXvYqyALLDzxDS55UK6pSAmdAiSMgx2FG1Zxm+AaZusPpPppOy3v8fVHVEoTO7OPp1mNCn+UAwnKw==
X-Received: by 2002:a05:600c:cf:: with SMTP id
 u15mr131057wmm.168.1567629564149; 
 Wed, 04 Sep 2019 13:39:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g201sm287121wmg.34.2019.09.04.13.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9ECB51FFAE;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:55 +0100
Message-Id: <20190904203013.9028-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH v1 24/42] tests/docker: add debian9-mxe to
 DEBIAN_PARTIAL_IMAGES
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

Another image that can't be used directly to build QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8d7f9376578..2c8cb790ad0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


