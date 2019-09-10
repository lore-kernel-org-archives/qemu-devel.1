Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9822084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ht6jYTEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9822084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cL1-000528-3p
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0V-0004Vx-F1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0U-0004lF-6e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0U-0004kP-0V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:14 -0400
Received: by mail-wr1-x42d.google.com with SMTP id q17so13761542wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hGE7sY0DslSLr14WQPlibGJPM36ldFhI5JCT7J6BHEE=;
 b=ht6jYTEXWRThvovjo4M3WWlFqD2D05uqr+dnHqriEjfDKxZ+R9020Np4+wenQfUfZs
 xYoZmB0o5SbvF+u4MmqmPM/EANfi+CBg/4qv+d09lSgghPFOVYHfa5w9zgaSozVjF+YW
 Rg0DQbMagJSy7mi2aUu6ujOO+ElFeBU6uSKM0SRzgkPpQWPCPgwh+KxgwEeCQqoXt5Mn
 UFT3B56cnJqN7k/QKErFqFmFgWKTxFnvKKkHbhbL0rF4bBACSgKNX/SqUp6HEV+e1J/H
 gADrCHYqfoev0yv//AtemwJV59BmYoyS5rF8n1zXTHAhdpKvvcjewStY68zPJHwquaEe
 7l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hGE7sY0DslSLr14WQPlibGJPM36ldFhI5JCT7J6BHEE=;
 b=cQMz7hGQtEod/5+fqvPSi1Qti7dTWnmfnSCmaS9Tsi1L9a4B8Py5eIu/NMYXsfOphK
 zOobz/h82zuuaiCxEGhXK2O86NPi2vUg7IIacpfIBtVnU/iOjzafLInusF+vh4W0bCVi
 wQpuduZOvsYRuWLg22KO5G6I9lRaD7fZPx3tk2rlW0HgllK/gU5w+9/IepBlbiWSJz33
 jBmTXDOXFMn/bBKzK8cXdfxEf+AINfwLECyz4NriZZTnhRtlWP6h7J1MstXfNxbc67gf
 N00+IcRIuVZxuLnulnp8oIskbBTL638PZWcjTRrjR02XVQksWTww1z3biAHRa72JHQCP
 jSgw==
X-Gm-Message-State: APjAAAVsjLAHmogC+8uSN2b/7qIWa4PR/wwqHAcW2Qw9Qupo0/YjnFp/
 Tb73sKBULS4Jf4foo2C3P95c7g==
X-Google-Smtp-Source: APXvYqyuozV2FsF5Xh2VW2v/guiyUZFooyKE6pPKsqijJ18X8i6Moz8j2R5/oxQ1JR5F40Dzu1+VbA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr18683592wro.17.1568106012930; 
 Tue, 10 Sep 2019 02:00:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x9sm3671232wru.26.2019.09.10.02.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4188B1FFB3;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:33 +0100
Message-Id: <20190910084349.28817-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 29/45] tests/docker: add debian-amd64-cross for
 non-x86 hosts
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

When building on a non-x86 host we need to setup the x86 build like
any other cross compiler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ffd..bbc6f88510f 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,6 +27,8 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci:
+    # usually host ARCH is set by configure
+    - echo "ARCH=$(uname -m)" > config-host.mak
     - make docker-image-${IMAGE} V=1
   pre_ci_boot:
     image_name: qemu
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 27a1cc0d833..7df8dbe1a17 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -89,7 +89,13 @@ endif
 
 # Enforce dependencies for composite images
 docker-image-debian9-mxe: docker-image-debian9
+ifeq ($(ARCH),x86_64)
 docker-image-debian-amd64: docker-image-debian9
+DOCKER_PARTIAL_IMAGES += debian-amd64-cross
+else
+docker-image-debian-amd64-cross: docker-image-debian10
+DOCKER_PARTIAL_IMAGES += debian-amd64
+endif
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-mips-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
new file mode 100644
index 00000000000..5d890419251
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -0,0 +1,22 @@
+#
+# Docker x86_64 cross target
+#
+# This docker target is used on non-x86_64 machines which need the
+# x86_64 cross compilers installed.
+#
+FROM qemu:debian10
+MAINTAINER Alex Bennée <alex.bennee@linaro.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture amd64
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        crossbuild-essential-amd64
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt build-dep -yy -a amd64 --arch-only qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
+ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
-- 
2.20.1


