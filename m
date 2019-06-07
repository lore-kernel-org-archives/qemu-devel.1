Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEFCC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8935D207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtzQfhuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8935D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAqg-0005se-Ni
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047O-RI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004Fk-6q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAov-00045a-R7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id c2so1338018wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rd5+Go34lR5r032gcxkrHBNwDzwFUaH0wsbx46lnxds=;
 b=KtzQfhuHaLrRhn0hNES7YtosF42tXuzszpjKOXitI2MRSzfro0ec2jJunY0V0Io+2x
 rBOB+eyYQboGLbfn5Gl6O1EtaOupLR2n5GgEj/5gQcJW/XCTOVUJkgz860SOgA8rOTn2
 YVV2viExmPNU4An4LZlx7MI3M2mFGIPloUpylBuH2tVTKPBxXO2VCQVBd44y8sSnro+9
 uMMYmsWZ3mqVYP46Hog0rnIpfVxET5C2GHlpr08msI5zPz02pTYaWW+6aDXMnbDq0CLo
 Eh3af5khAIJVujIAchnB7xnOoSmOS78VEJoonI9S01zc6IAyYCbR0RVE6Y1xy9+iIwrz
 B4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rd5+Go34lR5r032gcxkrHBNwDzwFUaH0wsbx46lnxds=;
 b=gP+l3Zmn9Bppr1h8JgBntSC4HEjZEhecknrjhiBfiQrCvwKFZa9p5MyWaArtz82e3I
 L6cKln7dcgjNFhur+b8BvchKANWF4+3RR5AEZ/WPjrBBAlh96W2fVw+vqpQJZLELTx8/
 lO+TyzTPoy3AY7IZ37lGv6DmXpcwvf4ldN0ysrvcVxv8q6KueaEvsyfU3cEB1eiio4f4
 5jvIqccSbHwrqZYhFwgjfDLgsDPvbxkOEkAkr8B0/DLv5e6pxzD0xj4/sE6e9INk1ANw
 9cJfu8vXCREDAHQklkVbXleFhXyR9iBPlbQorHp51cFjtoHC8jin4CVMEBshaLzk2z4a
 H+YA==
X-Gm-Message-State: APjAAAVQez0e3w092QHyi4ID/CbIjU4tAvImcE6BaGGpmje8LN7iYg/8
 JpMw9ff02Q+a2EKCuaH2DqdOyg==
X-Google-Smtp-Source: APXvYqw8bE4o9W+RCod07b72FTGh2ENf3I0AsxGJTeZ6hnOI+Lb6mqoI3hhiMuimRxywUIluzgTnUA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr18792478wrq.333.1559898356437; 
 Fri, 07 Jun 2019 02:05:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y2sm1331087wra.58.2019.06.07.02.05.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B5811FF92;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:04 +0100
Message-Id: <20190607090552.12434-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 05/52] tests/docker: Update the Ubuntu image to
 19.04
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has aged a little and we have a separate LTS image for testing on
the older distros. Update it to a more recent release like its Fedora
cousin.

Besides it is useful to have something with gcc-9 on it for squashing
those stringop truncation errors.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 36e2b17de5..8d256961f0 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,6 +1,15 @@
-FROM ubuntu:16.04
-RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
-    /etc/apt/sources.list
+#
+# Latest Ubuntu Release
+#
+# Useful for testing against relatively bleeding edge libraries and
+# compilers. We also have seperate recipe for the most recent LTS
+# release.
+#
+# When updating use the full tag not :latest otherwise the build
+# system won't pick up that it has changed.
+#
+
+FROM ubuntu:19.04
 ENV PACKAGES flex bison \
     ccache \
     clang \
@@ -21,7 +30,7 @@ ENV PACKAGES flex bison \
     libepoxy-dev \
     libfdt-dev \
     libgbm-dev \
-    libgnutls-dev \
+    libgnutls28-dev \
     libgtk-3-dev \
     libibverbs-dev \
     libiscsi-dev \
@@ -34,7 +43,7 @@ ENV PACKAGES flex bison \
     libnss3-dev \
     libnuma-dev \
     libpixman-1-dev \
-    libpng12-dev \
+    libpng-dev \
     librados-dev \
     librbd-dev \
     librdmacm-dev \
-- 
2.20.1


