Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E737BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB32D222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/YkWvNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB32D222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYsk-0000nA-5r
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcd-000826-Dk
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcb-0006bJ-Sx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcb-0006ZZ-Dh
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id o18so3569183wrv.13
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h0dXtH6nZm3G94iVvanK9T3aTuLi2zSYLzFd05evVoY=;
 b=f/YkWvNO9dk1CzxJjhEidNqpeXIST+OdFfFZOCDO+Ftu1hwYxG1CPvfoDK2MSwwq/x
 d/6DjcyFlNmq7Sh8jWQPXz3vYYIzDbD5fBSedatyZ69/r7DzGoMUw3XXSs/znEWPO1vn
 emTageEA/H+4FbYAxGFLqCFtNr9OflLZ9fZelOEokwgv6WVTlkEdGuRS74rM0/zAY5si
 UzGSUHLSft82prKXcP5TrRnxt4row1+H6h31+J0DbxsA+hekhlNS7xO2EJvtYUI6FhI6
 Zack/jMMeCDOk6yCiNtKUUoBbLVg5ZHE0d5iBOMzbwVXCoYcPS16KcsaU2OfJqD8MXhA
 23nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h0dXtH6nZm3G94iVvanK9T3aTuLi2zSYLzFd05evVoY=;
 b=gYwUewlU8dUHIhBLYVhzwWmOQCExl6Z+1uzq/Qny90MZFFJLXCOX6/08/jgRm9wQKo
 y6Dob4S/p+ND4dDSUFyM2dLuxm5YOv3ySrhazr4hjb7SF3BT0iu2U1uEP/Z5ApMaqfLQ
 1DxN4eibhaISM+n5anMwZzZd1p8yf3RBlmTn5fcDhdadzgsuls79UScWy1ZwFg0oTT4y
 OY4I4VG7GC7Mu6LOJpw40QX3qOz6N6tPrALiVWhsDEHvqBkETaPkM+YGlOK0SV+ESBHj
 CUOn5atOmGv0LQa0OssBrKC20euJU/H1uGp1JaxuuvEAtTPEa0ubMXBQPWDqzt5uS9N+
 nBeg==
X-Gm-Message-State: APjAAAX4O3lDYE7S421z8OOCMu5o86QbpylRvYC69hcljhZoUjGZRvVe
 cry/MQmUuGRmSJS9nailtpr7Nw==
X-Google-Smtp-Source: APXvYqxQx82sk4EXCle1OODMGMvsI+B4rMUdWSoab5hslMx2EVLgwd7V1ym3q7ET+h6kaNrjvdQuCA==
X-Received: by 2002:adf:dd41:: with SMTP id u1mr4325669wrm.49.1569522968038;
 Thu, 26 Sep 2019 11:36:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm60643wrg.47.2019.09.26.11.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:36:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C58A1FFAC;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 24/28] docker: remove 'deprecated' image definitions
Date: Thu, 26 Sep 2019 19:35:49 +0100
Message-Id: <20190926183553.13895-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

There isn't a debian.dockerfile anymore,
so perform some ghost-busting.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 47ff777440..a19341e326 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,11 +4,10 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES := debian9 debian10 debian-sid
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
-DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
+DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
@@ -158,7 +157,7 @@ docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
 
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
+$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
-- 
2.20.1


