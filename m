Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AA32087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCX6xUy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AA32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cHV-0005ZI-07
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008CE-RQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvC-0006g9-NX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bvB-0006er-Ee
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r195so215296wme.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P/I2OnZViMdHt3FAidu0SleYqkts7IpxERv4eYEqeXc=;
 b=PCX6xUy/9pyy7C6kxmT2gz9AhhIZrXdeu1D+vBoSOkzU1iA7E1H946AqcKNgXQ4VZw
 x11wB+sGwptYNddX+N9rKIHzN3bY7xlMXr6XCKAc0gKnuH4LvOadPCWrNaM5WuGbfx+6
 9IgnLjnNuvKLnkXKpsjSaj98iNAeP+4jk837pcVTp3VDQLTyoYfgsR1bGUxsGq38SxnW
 yba/xdJNpGuv6U9TaC0I1tpRu1ry4wq1sXLWx4F9lYHESs2FidOY6J2VyH9nnHSeI+fc
 EZxS4k5Qvry69r0lPi2jGB3kf73NVgLf0xL/JO8UFmuw7UC83YoTek3SnbJ/RymVLj/7
 7YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P/I2OnZViMdHt3FAidu0SleYqkts7IpxERv4eYEqeXc=;
 b=gd10JdqmZN7lz3PyelT4IoCNbqsUVp2HT9ze+Hdk/asxcq1YN0Uh96cvvdcdDpt84k
 g3/RIJNkX3zVegJlzbApt9wVe3nWQDZJ9ZY3vffIQCbTSfV1ko42InicdkRH/C9rBqlw
 APMqOyyjfO25vtFajq+ssjdj9CvUbkYHZQPeqG7/JzqPZydnW1jGYu/lUulDgMwhPYMD
 5auCWN0c9fUg7G1tkcgUtygRl840nflsCSB4OeaPJX21blxQP5YpXWehyEkL75lQRNSw
 P/MSefF7neSuM2wHkMxVoczss8D6tl4Xt629W47uMOKeHS0BAulLkNtATsA7izhseqYE
 HBWg==
X-Gm-Message-State: APjAAAVE7xPTfT/VdOJkYNnCEqO8J65+z3ql2kZwHsOsKKRFQVtxtM4d
 64+Y3inU/PnAtOCEKq0HGMjlgg==
X-Google-Smtp-Source: APXvYqzdL9EPx8voDN8XTSjq2sMjGwJitPEkMK8Ryl9KczKSoD72Ogg2xKb+I+CreFB3KNS8P+xm9g==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr111670wme.96.1567629027460; 
 Wed, 04 Sep 2019 13:30:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm31755302wra.91.2019.09.04.13.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5CBF1FF9F;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:46 +0100
Message-Id: <20190904203013.9028-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH v1 15/42] tests/docker: move our m68k cross
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
 tests/docker/Makefile.include                     | 2 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

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


