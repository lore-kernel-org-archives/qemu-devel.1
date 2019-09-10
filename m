Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64C8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709CF20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWKn4YL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bya-0001rQ-U3
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqq-0000gE-CF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqp-0000ZH-9K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqp-0000YU-2v
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id y19so18419610wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mj0FEYDHS4vof3dkSOxUfn9pkgNUQ8rYr9j9H50hm2U=;
 b=sWKn4YL+ApBkzzIuaBgtmcJdQABNOCVAQsezyLzOlgqpRuVw5AiLTC5jzCefTu6XUN
 cbCtdmhBjbtUhwg4shPxL5rCFDcSwoTy+bf6y3RibWR14zSqL1720T0nHMRihcP/rB2T
 x41Ji7EbzKM2CFuC1uLw8/P2DRZDzhgl29iORKwYsi0O3nrN0t43KAuFJd+WwMI7/H4K
 8/ExAUapBdlGcy9zhJxqQOCaRpnrPsKtgS2y+s8I+hJvrFkkhlz/PJN2ZlUMcMaXXj1V
 wo1eR8lfeZAMgzGL0GTFOKkU3jU0LoiZbGckzjBXINDHd+klXfaumVuRJaPeYP2OWzRC
 JT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mj0FEYDHS4vof3dkSOxUfn9pkgNUQ8rYr9j9H50hm2U=;
 b=PuueJAvPD3HxXr6c0ea9BCeCOHx7Qm7GUo/RNkPEPe94mmh/AVFIt/vyyFBy/If91T
 h4XBNEgfKQb32YbS0w4AjdxlN9y6R39mKO0cKjCoWrpIP9oyQm3Zl/V1kUCMzigvWF48
 d53NwDSahfBg8/bhA2SDUcTGPDa1HqZxMvC+iwQ64P9HU1THZ9KOpNdu+g5Lk35uCPC5
 5jM3H2Y8tlluPVvhWFpR80Pj58pxRyJrk6iQQbubuPgfUNvW+MoqJuFHwSuV8wVmSH9I
 HMmx81KX5zxKipYoCQRBN5kqFLpY4DtrzZ6QFLm0z2+ki3aRjjEvdOo08+BeTVSM9f2X
 ylQQ==
X-Gm-Message-State: APjAAAXdRv9eKZqo/CUPPN5NyberviVkhu4kNUt1rF2Q8A05sUW/1/Zu
 3sz8MQHRNBmUEstFsJOJKfKyZljEpX8=
X-Google-Smtp-Source: APXvYqxxJcKTcjjSGsiinwzgz596dDzFVYv2aQJokQVSdQwnLqKv3Tq6zE57i6cJ8Dp/4qBgsBnleQ==
X-Received: by 2002:adf:e488:: with SMTP id i8mr23744547wrm.20.1568105414047; 
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 17sm8776070wrl.15.2019.09.10.01.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 576FC1FFA6;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:23 +0100
Message-Id: <20190910084349.28817-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 19/45] tests/docker: move our sparc64 cross
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 62f2733eb66..50c5e64212a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -103,9 +103,9 @@ docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
+docker-image-debian-sparc64-cross: docker-image-debian10
 
 docker-image-debian-sh4-cross: docker-image-debian-sid
-docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles/debian-sparc64-cross.docker
index 7a2c2ab19c2..31fd34f120b 100644
--- a/tests/docker/dockerfiles/debian-sparc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-sparc64-cross.docker
@@ -1,10 +1,9 @@
 #
 # Docker cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.20.1


