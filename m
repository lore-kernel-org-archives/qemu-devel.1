Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2260C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14ED20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXEhvKZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14ED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cHd-00083d-5C
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqx-0000pr-HH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqw-0000dI-34
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqv-0000cp-Sa
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id t9so537654wmi.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8rTETEcYS3jec87Xegg9zkrdJAv4L7q/upZyeHVm888=;
 b=SXEhvKZ4ufCoC5U2GFzjNNG0fEz8wM/gTZAUi8ZHJ+sgORW7fJXwvP21GYrJO4QEeW
 FWj0ZTrxg7ixt+NwftTgJhID33PyNYherJA06jgg0GJUHNgOmPvLcDfvv9Lk2tbsph5V
 CcmWqvnXh1FBIj6GyHG18PGRuiUWA8AYk22B0OnuGrlLJJe2jGJq68MR1T4+Ln9LNYIv
 zV/akguiL85hO7PcP5kaTGO5xbb8pVLVPAgdYYDi0P/yFLDx3flq/D9SvFYISHxLpeax
 VOfOrovZTdiYXscii+clkxp2XPUZgLbrsr/NFMMiUpIhm52gIJNAx/9mOdQX0CSxnN8x
 nhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8rTETEcYS3jec87Xegg9zkrdJAv4L7q/upZyeHVm888=;
 b=XqFqxA/dSng3rcOKE9phRFGJGWOtY9/fHyTniN2ZgNhyLsz7xVQZi6kz4+z9TbDArs
 /XRV842CMYCO8FnneMT7bDPCi5kPUjqEKSZ6VmehF8z32QdwqVTdpTo5nRqWSkpvdIc6
 lH6JBuon5TZf1qJwuJk+QCdt+3TPuYNJpDG09+vHd1NJBZjfecSWXjYK6qKIh/x//24v
 wCy/6Io73AHT6lG0vMY7rUzF8HORo+USH+4Q/NChXf3Epgee4MZ1tO3R07Nnf98bMhvj
 lZ/Yi/VunXrafZXbApi1IZ99V8/SJSW10/U1Gsy8gTSL++ch4vv0NUAWKEaZTYKbfbO0
 OHWg==
X-Gm-Message-State: APjAAAX7QnhAZq+ogKCO75YdBc5jZs72cPagIOlHeVL8IUOC4iNg5mDn
 zG7KCYPpIPfjDfiTwJA7vjOXiCt0Yrs=
X-Google-Smtp-Source: APXvYqyiuCs/UIXCJakqOj3yn1nqwUoE4N8IQImYORMpvvNzIJKcVm4UzvvHZOp/mf6arbLWQRFfrg==
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr255098wmb.148.1568105420715; 
 Tue, 10 Sep 2019 01:50:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm3154475wmc.25.2019.09.10.01.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA20D1FF9C;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:16 +0100
Message-Id: <20190910084349.28817-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 12/45] tests/docker: set DEF_TARGET_LIST for
 some containers
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

You can assume the failures most people are interested in are the
cross-compile failures that are specific to the cross compile target.
Set DEF_TARGET_LIST based on what we use for shippable, the user can
always override by calling with TARGET_LIST set.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 7c2cc93daf8..6b59ef0843a 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -17,6 +17,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
+ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index d866fe5d75b..363a162a253 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -15,6 +15,7 @@ RUN dpkg --add-architecture armel && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
+ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 2b8627673c3..d5365881e79 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -17,6 +17,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
+ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
index 3c4d6f9ec1f..a54efa7253a 100644
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -20,6 +20,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips-linux-gnu-
+ENV DEF_TARGET_LIST mips-softmmu,mipsel-linux-user
 
 # Install extra libraries to increase code coverage
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 34b0b828957..a1481e16e2c 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -21,6 +21,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
+ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 
 # Install extra libraries to increase code coverage
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index fc056d7bc35..f10883c8188 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -16,6 +16,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
+ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 
 # Install extra libraries to increase code coverage
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 6732f9ec789..efa346007d6 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -21,6 +21,7 @@ RUN apt update && \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
+ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 
 # Install extra libraries to increase code coverage
 RUN apt update && \
-- 
2.20.1


