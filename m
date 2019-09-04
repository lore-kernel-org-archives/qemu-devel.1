Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4846AC3A5AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D2A20674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hN7swSUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D2A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cTx-0002cS-CZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008Bs-NB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv9-0006eb-NK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv8-0006br-LK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id q12so204646wmj.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c7umJv83whdCiZGCt8ZEswrCwowwGFdOv9ulf4HA70s=;
 b=hN7swSUET8CMhcMsBF2uK99MMexd1Vv1L+Bm3NfzQlhsqkD/4lW1BlD1s65y3BM8b8
 7gRvlTA8ZChifx7/bpF7IO3u3E5SmMx8X8WtNipsyrgiSbrUGJUSvtQTwocypq6lSP5D
 HOQMAA6WX8I7DbBNPI60agdnuYQT++7gTb9+ZB1pitC8gLRSzGw8j1FXJkNUB6l5x1q8
 z/EYnRfqTeL2OxU0S98kJIIAQepQXMryYF9vt6+ilq8qP1cUxbjeauVG1wVy1ydmmTpv
 VQhdp99w/xl+6LOvhjfg2JMhbSxuxnK3bLw8Jtsle5C2cb2zJaYkR4wt3yITKLNrlVSo
 ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c7umJv83whdCiZGCt8ZEswrCwowwGFdOv9ulf4HA70s=;
 b=JCdN95NBDyG08Nv5NGtbMkOXtTGnWAwoG544KhUO3yZIxCm7HvGFe5cQbbu2R0ckIk
 P9vM2ENwEpuH922y2dUUC21Oj6jrjZ5nI+ZmRHdn5IoKmRxzo0ShM4pgyZs2YwkZtTSd
 i3DOPsSxb09U5Q9jyByDN3+zpNO6lUx+GcYQ3HBsbu3IO1kPAFpRv78DJYbM6SlMz85R
 Nt9WW6BkXQdmX97scrJk4T5tAgW9S9u7aZRcX3DtEBoI+kvJMDOEKsFhBFcXy2ML/fiY
 KawLytOzDGPTeHro8LgQ7sNNw9tmGpTnsdHoy8DbmW6CzkkG7rowqGe8V8Q5d9CozzVq
 NCdA==
X-Gm-Message-State: APjAAAWJg9Z/8mmLz12ERvCoZYuzgiBK9npmON8vxdJ4ihk2yv59yEYt
 67hXNSTn+D0cwehU6xLC8W3g4A==
X-Google-Smtp-Source: APXvYqyyCv8u3KvuMR5sk/kvK1NHF2Tt0bkZFyPrEXUbrWtp8CZMDgY6MoG5X35tdcHLZdM5L+GhIg==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr116237wmj.16.1567629024800;
 Wed, 04 Sep 2019 13:30:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y72sm280956wmc.26.2019.09.04.13.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6665F1FF9A;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:41 +0100
Message-Id: <20190904203013.9028-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PATCH v1 10/42] tests/docker: add Buster to
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to add additional packages to the base images to be able to
build QEMU so lets avoid building with it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


