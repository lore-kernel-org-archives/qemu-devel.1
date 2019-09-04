Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487ABC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137302073F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBfmWg8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137302073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cal-0002uT-I2
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3r-0000pD-48
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3p-0003QV-OH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3p-0003P1-Gq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id r195so239146wme.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e6/Y3kAQfcm8gVLpETkbTd4pLX1/IhY8SN6s+VJNHc8=;
 b=dBfmWg8iDm06KzYx+P55ql8aGiWC6HgQ64V3E1p1USBHf9V4jqszn3cl7A38xHlecD
 Ab+KpABJymTztogcdKmgZbqZ/gAg/ufp+I+YtVYxAoQElAGjBsT4zRYjcalDrBhA11Vg
 FogCMNe7pNLlmtTndlnp9XmG8JdibMYlgjyKP/mO6JHtFtSp/trm+NV8T+oflmOgESZj
 aYGhlbHKfpH+JOBKfqQWYQDBGe/09rhWmfAz1VmQ0YxpVTtUv5MPJtyTDcEQA9R/khmO
 /LkvK/tAb//u8t4nSHyBmpVWSWLv/QHcfEa2WUtpeV2WBI5MUm99DGTcOQT8Vn4cc4/m
 zdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e6/Y3kAQfcm8gVLpETkbTd4pLX1/IhY8SN6s+VJNHc8=;
 b=NCNxvJhhjfZ3ah+fVlekAVXEAWi+ZEQjpKVLn1HmfNl469HDcrwNOJgjkRSR4oWg6/
 eQuqPM/g0yRwxJwj0EvO1sb4zlujMBBHGYJOp22w+YbmjJjw/aAzM5lDMjD5SVKMv3ZK
 XhVDZkn8b1amrbA0EI42me0ZtxIZai1uB+QrfRSZeEfivY4/sq6/XbmWFd4kORd0tyMU
 TE69gBHzZN++JCNaugDQ/b4XzekyvjFe4huXWX3rS3+KQFNoDCKPCu28wFaJshs7iZb6
 FEnqvWBF/t0/Uqp5cu06FoVJyivjRlnohrSCfnVhhAMo8ZKKjdW1hhKVFGWVNMkganJ0
 NdMQ==
X-Gm-Message-State: APjAAAWSF2XZe9GTTbjfN+C5iAqOC0JBhcGhh/KCG15p7+Om+/J36qr6
 RiHPh/kCrTzNmZ/Po87MvHkN9g==
X-Google-Smtp-Source: APXvYqxW5nDuVkTydkmBKugkZ3daJ2x6G6px2BpARq8zn9X0pMCmjtrzAa+B9mhe0RX1ljZZjgHxxw==
X-Received: by 2002:a1c:9805:: with SMTP id a5mr99928wme.119.1567629563654;
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm248460wme.23.2019.09.04.13.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93FA11FF9C;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:43 +0100
Message-Id: <20190904203013.9028-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 12/42] tests/docker: move our powerpc cross
 compile to Buster
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

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                        | 2 +-
 tests/docker/dockerfiles/debian-powerpc-cross.docker | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 48c22ae40c0..7c1ff677a13 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -99,6 +99,7 @@ docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 docker-image-debian-arm64-cross: docker-image-debian10
+docker-image-debian-powerpc-cross: docker-image-debian10
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
@@ -107,7 +108,6 @@ docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
-docker-image-debian-powerpc-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
index 5d08fad7cd3..89dd4fbf870 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -1,14 +1,12 @@
 #
 # Docker powerpc cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets. The original
-# Jessie based no longer builds.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+        libc6-dev-powerpc-cross
-- 
2.20.1


