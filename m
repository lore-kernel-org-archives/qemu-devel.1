Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00653C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE30121883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUAKJXnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE30121883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cMd-0003Pa-AF
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008Bh-LC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv9-0006dY-8Q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv7-0006Wc-Fn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id k1so205155wmi.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p3y2eX+7FONDbDZLCLCZxdBeIEWMh8ZiPOEtCXfGU9A=;
 b=mUAKJXnz8UhhFcroaGb1tuken8Ra0GlXgXT5Eq8B0VlfDrLuNKq+Zy51oxh18yWqBL
 1RXdhXlrtJLlTD89vxCashJe67dN7NbZAeBpQvr0MvCNNRpxtBTVM4fmoJyvTnkxyIBm
 bDI6BiZVsXZcNI3yU2TmUlPN1w/8+6H0afwz0t1vVo8bknclKfdI4r9ePV5+2fpFZ8BW
 m5+DQYCUpo9orD/YHvl2dxtMhgEVgNAtnBqw+gBepAYCZ0ygoC6S5OBAL37xgAmM3i7k
 JKcXZWvIg5Bh2aC02Co8iJbD+1PCNrtMlppLoHoj2m0PTIH6eHO6c+12IaophsaVRRBz
 zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p3y2eX+7FONDbDZLCLCZxdBeIEWMh8ZiPOEtCXfGU9A=;
 b=SnlnS+jsLKUUwuETEfycCLqNSBNUBmi3ZSJ9Y7xHETAyRN/Z+JtjI8ZteTeacA91JS
 Ib9+N9ABDpl8sY28t+X/GoPKg5BEuLXGb4kMeGcc4tUYE5Ze3CmHrirxPnhJRDytRoCn
 wNSNvM8lbb1fbQts8l4EZ2Tl42vpjuCsUMzt+ZacX9HFqV6pwVx9FI+oQUEBRVLFHLmB
 oHhKw1BwMqF4JJ2GOwA39Bwlaubtb15Ta+b3TNKRQ5w58c7BvlNXAZfCMfbpNXlz6YZ3
 oBj01vGoqlc6m8lBtRplbAH1YnWkwyaWFQEBeXf7N8o961HmF4493FFTGV07ByHCUIC6
 ONcA==
X-Gm-Message-State: APjAAAUgNTBjjgijvpiaODzwgNCZiHfTOf9u2yS6aQdEuqPg2UXgHT1y
 hCU4H8NpAVrvxgj4qcoQIbu0fg==
X-Google-Smtp-Source: APXvYqy/i8dCPHdiTXO0t1LYi3UM0WPFv0ZPZ3TNihK4CVus5rSZvXnwaBsBUUaR7yyKrW1bg3CLdw==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr93152wml.158.1567629021269;
 Wed, 04 Sep 2019 13:30:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm12493544wru.93.2019.09.04.13.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 530611FF99;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:40 +0100
Message-Id: <20190904203013.9028-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH v1 09/42] tests/docker: set DEF_TARGET_LIST for
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
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


