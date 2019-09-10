Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5019C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E16520863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvRfI7qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E16520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bs5-0001Ig-9o
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bko-0003RY-RI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkn-0006NZ-NA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkn-0006Ml-Fq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id q17so13656740wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fTRJKF1ILnRPS8xA0leIPjRzRY9B1niETk5vMsQ06xw=;
 b=AvRfI7qdZ/519v8vIB+rsHVFUD1BHo1Y6bEL/WrX9AD5+ExdRkquBS5R13V07vrd6b
 mb2B3pTx5Vl2Gty7Pv68aU/lAI38Ahg9m/e/s7BrqWVcR5Zw43sYjXgpvqB/oFGuJKen
 KT+ViCm6Ae4XAWie4fCFyP/OA/Y26w/l+CZ2FZ/HuMDfxjJ3LY5CDfHm2f9Ng1UFJP29
 b2vX6sNCV3Aw00rNvdiUddfDSrB+jZ/qqVSBJjucL3oT9VwsugBYW+Mkb3BuR66kJLMv
 Ass/ZptV4w3LvMS1QRa3NSshHJ+SPex+jH0mFBuJOSDPhLpABYI7EtfQWo8lR4vl2HwA
 DPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fTRJKF1ILnRPS8xA0leIPjRzRY9B1niETk5vMsQ06xw=;
 b=b7pA2et+S8SNts6nokYPLKuD+DrvxlTadZ9n9VktyVSOhX8t5DYa3Pb61jPkXhDcvP
 Mdn1WI2HcrX8IqNVJKmR1H4EJfRnimK9E2aKSGeUvZa0BCAK5VhRJd239uYTv99A8Awm
 73Ij1MBnlYFmJ9FwltwUcHhz1YXSmIHRZzyhj1IdsJsuP8QJ2HZQc+nSmcZx1blRZY4d
 lOO6D26QVBOhq54oR0cZ0iE9HM79d09wqYtRPRIt/tyVqPXcFh/ulTgP0UFleqUdKC2w
 gelpEeeafyPINAm294PkrUklgCb7n9UKfm29q6YIwEKceIkoClP2na31J2ABePpVRBgA
 Y29Q==
X-Gm-Message-State: APjAAAWDLFhTPsd2uwiGBIvVB00hXH14tt+9/kkpweAgVoZ/+tFDcXSH
 5N9gj6isbgQ0DH1ghL9+AN3Sa3iOOlQ=
X-Google-Smtp-Source: APXvYqzhbQ+hGTPrHNPLCjBxTlJhO8IEiifexq45yxF+qvvzEntypE90i8otW0lTaAAbBo81Qpm+OA==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr4929327wrj.277.1568105040476; 
 Tue, 10 Sep 2019 01:44:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h2sm25552700wrb.31.2019.09.10.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F3891FFA5;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:22 +0100
Message-Id: <20190910084349.28817-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 18/45] tests/docker: move our m68k cross compile
 to Buster
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
index ba5a624eaec..62f2733eb66 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -101,9 +101,9 @@ docker-image-debian-win64-cross: docker-image-debian9-mxe
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
+docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 
-docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
index 4311c9cf86d..25edc80e9a3 100644
--- a/tests/docker/dockerfiles/debian-m68k-cross.docker
+++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
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


