Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB9320684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zs7euPhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5uC-0005uI-PH
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oj-0008Jd-Sd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oi-00039i-Bt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oi-00039C-5s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a11so3615835wra.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5aMWHoUAPHVKIGtZD9kL4mkNdNLEvsYrFkunGwuaRjU=;
 b=zs7euPhpqqqyVBRaUXjA4tZtv9vamuMDM+HN4eciZ9hs126H9PJjfh+rUUYqe/UaBn
 CKQfqaklZ2XnTdAd39SQkki3lEW1VGPMVVFMIhBPBfO4I5wAOWZ9eDlUvrjCuFjsdJ9N
 yagMd7YaRlfboQuBe8V34yYGGqQ8OMIElzESGY9cCytwmfuyD1nP5MZbEObpijlAUbGZ
 Z2GGvpiz1506bW3uezPzsBofZY3pNzi6FxDMyHqkygYkwKrpiQKf/kz8+luKVpKhcPSM
 bmf+Ux8GsOEJiCfuPdLSKJZBBAilW/eWII6o+9ek/wPj8rdsW76yBo0NaSjn/VgK6q9z
 p2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5aMWHoUAPHVKIGtZD9kL4mkNdNLEvsYrFkunGwuaRjU=;
 b=nLxjNyTbeYl0EgTq9PZZmhrQV4y7m9FhQoTW3iWPy0RP2mNIGyp+SbpWxMKDc4q3rs
 XhWgSbm+cx4CN5bc2MmIpaMZLrbDRWYfc3LlaUKKdfFEycFa+NmcPZZdVRpDRRT6RMPA
 vJLqGLfcUluJsOHCd4iVcNlUHhqZYSoAK3qFAVv3Hh89KmOMDbUTa4XLq0gDEaYl9EuE
 lPNMnYycxCQ+lu4KMhiKJQir+FsyqdsEl009iSJa1jH8ri5B+xwvfgk/0+/4OntcD5Ho
 ojKbiZFYAXE+pZ6aFKdgoFFDKZK80C7pifYW0OzH3qA/egeK1VEzjXZaey/IwZNlMLZP
 d7bw==
X-Gm-Message-State: APjAAAXqsRnrBpAT5M2b+2nM3PoyJ38JbHUnhDzotPY2/RGVsgO9xteg
 S2QVslDMyJgAk8H3eUa2306wAA0H3vQ=
X-Google-Smtp-Source: APXvYqxjHXlefSS2FLDOFdc2an5fg55dY42iaMxFV/qJJOCX3x1Mi5f/a+ic1D4f29JGgXWv60iKkA==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr4445412wrb.222.1572032238998; 
 Fri, 25 Oct 2019 12:37:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v128sm4161805wmb.14.2019.10.25.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB1B11FF9E;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 14/15] tests/docker: set HOST_ARCH if we don't have ARCH
Date: Fri, 25 Oct 2019 20:37:08 +0100
Message-Id: <20191025193709.28783-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

As the docker rules want to be able to be run on a virgin unconfigured
checkout add a fallback and use it if we need to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index bbc6f88510f..f74a3de3ffd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,8 +27,6 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci:
-    # usually host ARCH is set by configure
-    - echo "ARCH=$(uname -m)" > config-host.mak
     - make docker-image-${IMAGE} V=1
   pre_ci_boot:
     image_name: qemu
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 89c56a3a88c..19dbe261699 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -2,6 +2,8 @@
 
 .PHONY: docker docker-test docker-clean docker-image docker-qemu-src
 
+HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
+
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
@@ -88,7 +90,7 @@ endif
 
 # Enforce dependencies for composite images
 docker-image-debian9-mxe: docker-image-debian9
-ifeq ($(ARCH),x86_64)
+ifeq ($(HOST_ARCH),x86_64)
 docker-image-debian-amd64: docker-image-debian9
 DOCKER_PARTIAL_IMAGES += debian-amd64-cross
 else
@@ -106,7 +108,7 @@ docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 # For non-x86 hosts not all cross-compilers have been packaged
-ifneq ($(ARCH),x86_64)
+ifneq ($(HOST_ARCH),x86_64)
 DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 DOCKER_PARTIAL_IMAGES += debian-s390x-cross
-- 
2.20.1


