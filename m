Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C5C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C4D2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWsWH02F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C4D2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Ay-00028F-6J
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AK-0000pP-Rb
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AJ-00067i-F0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw7AJ-00067A-8i
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id 10so6199137wmp.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p3y2eX+7FONDbDZLCLCZxdBeIEWMh8ZiPOEtCXfGU9A=;
 b=KWsWH02FzKiOeEnH/sDrk+lnmX086001Sx7PZtJYlQyAv4j4WWU9cNqvqW3EdxWpBi
 IqqEsiT3xj7Inx4sDNgw82Uct150SVydJ/Uzv2aRMgLdJbPAbnF1osFGwxnQdqztlv/F
 p6d4l16h1UF1SOOSS71+5JNxlfyZCo2i+B4KXQodVNpII6WLwUpv9wwgfV8JUovmXVjG
 CxV8ZRr7lR52i/R0zovxLnivbInY4/3Pj/ZyKuFP+LRf5ic97eFHCdYZY+QAoiYwVpyK
 EeeUlg5SGZ5yOr033fVDbwzrl1Dw3ZUia0UorxWwcNL5VFuQTaLceF4nXi3zs6KWQDbu
 x2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p3y2eX+7FONDbDZLCLCZxdBeIEWMh8ZiPOEtCXfGU9A=;
 b=WJl+sD3HPygDKdnbv110BOqfJdM7PofqWXgROt7ES+oMSxalbyQcsFU/IhZxNPAg+e
 yFOQA4mDY85Y8Evf4j/bBHgEAw5WojJtrB22vJzLAd3jRepvxeLlde/7cTbHT9c329wX
 1H2rt4OQQ93Rgsnkp87yHM6lLmoumJWan4mxS1Aoy+l+JcyO/0aMSneh3jlnk8EODFsv
 zkyOWRYMht8zRqD2Xw2PISrj85JwV+zS8sHxjUSjfwp14azd7YfzA9RiQ52lpn9qgiHV
 7uJfYuJYmHeOtcwawp9jgx7+7usyc62yiVOSl0mW3P/0ClWWkroBEOYUcud6EiGfbPt0
 e6pQ==
X-Gm-Message-State: APjAAAVzDu0GbRSVblz6UHMY9pvJa+2AvvglCtg5DfzVjO3EJ9Iib7XE
 UL/jloBCtNhVVdQNL6mWn1Yv6A==
X-Google-Smtp-Source: APXvYqy4VQ5iBgVCfizwdIyoln8uT4CIzVNDRzNLU/rn4zy82dLv5BDZk9YF9F3SuXGh57TdfbABdQ==
X-Received: by 2002:a05:600c:218d:: with SMTP id
 e13mr11807076wme.29.1565365850091; 
 Fri, 09 Aug 2019 08:50:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f12sm109154462wrg.5.2019.08.09.08.50.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:50:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B84D81FF8F;
 Fri,  9 Aug 2019 16:50:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 16:50:47 +0100
Message-Id: <20190809155047.24526-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809155047.24526-1-alex.bennee@linaro.org>
References: <20190809155047.24526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH v1 2/2] tests/docker: set DEF_TARGET_LIST for
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You can assume the failures most people are interested in are the
cross-compile failures that are specific to the cross compile target.
Set DEF_TARGET_LIST based on what we use for shippable, the user can
always override by calling with TARGET_LIST set.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-mips-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 7 files changed, 7 insertions(+)

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


