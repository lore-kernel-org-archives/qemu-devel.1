Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4589DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDEB21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6sjbn8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDEB21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cWK-0005vr-Hv
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c40-00015K-UC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3z-0003Zd-KP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3z-0003Z8-EV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q19so217414wmc.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qKk7W/OkoQyoVSUhxE+KkbmuWnbPiA9cvGBg2KVCJvo=;
 b=d6sjbn8DlOEmacWGSVqP0Ru5XKQKJQpxnq9U0KZQl7Z6hzFA7qlU1Jt8DAJEJmPUQr
 MW7kqR/f5dYjLrAqOw3wlsy8URXLxEk1wh8EnaMPFOgSBWV4nyuhh3Dj/Oq+L5OG90n1
 1Aao3w+9sbL7Jr/VkMxDv9fZ6c1V8N2x8k7Khdz+LA/kZcUHq2sgyjypjc3SESJurjDp
 1UODrzcBD1DMepgu4j8cKlp0HcvCkU77/KUoNGB0Q/Hanqa1N5DG92Qy7Gv4DtzT/ada
 OFkyUXk31SEwOu3Y0KGUeTUHbawEV1azeP0pkRUi3T4xIjx2KLmRaWDP+NJDC/EPxf53
 rMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qKk7W/OkoQyoVSUhxE+KkbmuWnbPiA9cvGBg2KVCJvo=;
 b=ghEtto5d98D8Ae95yRIWKK7ed5v+rB0gw6Z8Ep6ImZY9cZ7t9WLXWdNFxw49QDBffE
 NNkDJ1QEWAE4NFwjQLnsE+Dt/Wx6JdIMdhW2fcb9YP9bo7aRLhA/D2BNCRDARf6aygTb
 GBs/CWgjcH82OJlqhA/gvVJXN0MTV+qlWpPQdoryKp2GrpYfFrxOOv2sduXM49ZL0BCg
 99HLkF11qIw5aJMmijqK8ccfTMtdybEQ0Pq7lvNiPdEQz4ALgfOPlNFsgVGbC6pEiKO+
 J3j10W12IduMKFJdDIQXAswVSRuePGmMaB+xRFnc5i9z20WbYpFG62Miv6AHdsKPcF55
 tDaA==
X-Gm-Message-State: APjAAAUWvHsS9qDDJXMI7jHms8mXsMGkZyrGEBANVhgromAb1Hm/YxRw
 1iEsErfKSoIivMe+5xhBbNJ4vA==
X-Google-Smtp-Source: APXvYqx/8Ra9Rrkok4kApFMHCt4Qte3qP8A4RLJn5NE+0o9YcaNkUj96Q2DsFfrbFaXLcDdxpry9tw==
X-Received: by 2002:a1c:7ecf:: with SMTP id z198mr86274wmc.175.1567629574472; 
 Wed, 04 Sep 2019 13:39:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j30sm528393wrb.66.2019.09.04.13.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAB461FFA3;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:47 +0100
Message-Id: <20190904203013.9028-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v1 16/42] tests/docker: move our sparc64 cross
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
 tests/docker/dockerfiles/debian-sparc64-cross.docker | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

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


