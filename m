Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0186C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8927520449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAnDLgN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8927520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5coJ-0001E9-Ts
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c40-00014e-9Q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3y-0003ZE-W6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3y-0003YX-M5
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id y135so3360195wmc.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7DN2Mz1jlphjeBD6Hgfr/tcOfOE2X7DGMlU3BQxiSxE=;
 b=cAnDLgN4AEjP9y/AdcF7Qad0MexMWbLi1FxkPzh9cRZnESXJki8NPyezG2BsNCb3M3
 jWfhihJNGNNHMwhNx+ccV003tzJRxqy+r5hlDET37Gve1DGLbN1eLBGkLtbdphMtTyIU
 SBXJRRl1ec4eoTmYp7KMWY9PATyjKc0aW5u3qP1gV1lf+4p4LcQtcr/rNXMMRmh4IA8V
 n/vy+ptkxGP3qjBcUMia/RX+1xUuVXSNV84+khTdnGpH9I3imoXbh/ZxOR4SWyot9BQT
 oNu7zAPjAXGUULtyOLRj7oRnQSibj7NiZyNETobSnQEa2mDnmvtcjjWDG8EvYwnVRTIC
 swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7DN2Mz1jlphjeBD6Hgfr/tcOfOE2X7DGMlU3BQxiSxE=;
 b=GrG2Hlxjl9w3+sezSFLcr6pDilDIRxAk5aA2YkmxN55y1pTXnGs3uh+bApzozK/IAW
 0Pg7l1GzOjqMoDi2231s4DaSwkUJdGTu8wnvQnL9tK1pOWmuEsiWsGgJxO0iuJJvMNQL
 Jch5+cnKyRCmXpLDxJGs57GlLzaS9RhiJjo/hgvP3aw92OA/ID6QdYF8qYjy++XdrL2p
 4a9e0S/CyMjkOtpujUbtlEsTDm0pGLhCR0FCFt44Hwp7U7Nu015TTTX9ZnniuT1MgmgR
 jkQQ+PLIc+118ZNV2dxI9J+5WL5uoj6mWhYgLzBT+rH00m6PLzBaNl0H0BG4TlVeOuBk
 JzpA==
X-Gm-Message-State: APjAAAXdp+HqhPWxkxtUY7LVRQH6NB4JEi6wGc7Z0uNvr51q/2Ht7bP9
 b2kCa72aFaZ5viq55rkn0ZFibw==
X-Google-Smtp-Source: APXvYqwxZ/3qH4xAUQVEL6xftra8LeqVUoazzpo1a3ZpbXlrwkniQHVStG3lkhotvwZbI17u2RKSuA==
X-Received: by 2002:a7b:c7cc:: with SMTP id z12mr132592wmk.80.1567629573695;
 Wed, 04 Sep 2019 13:39:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm4336262wrh.25.2019.09.04.13.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAD6E1FF8C;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:57 +0100
Message-Id: <20190904203013.9028-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v1 26/42] tests/docker: add debian-amd64-cross
 for non-x86 hosts
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

When building on a non-x86 host we need to setup the x86 build like
any other cross compiler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                 |  6 +++++
 .../dockerfiles/debian-amd64-cross.docker     | 22 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 2c8cb790ad0..cb0961a69e4 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -87,7 +87,13 @@ endif
 
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


