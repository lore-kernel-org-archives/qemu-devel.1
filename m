Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E07C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5000320828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fi/wmRpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5000320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cbv-00045j-Q5
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvX-0008Ef-95
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvQ-0006na-1N
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bvJ-0006gG-GW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id q12so204919wmj.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oAvhvXME+54VRvS2clCGoY6uoOz3RlYmcJNO8CHCVtg=;
 b=fi/wmRpikBCTtuVs8qLRK2S41gp7mSNTVakc9Z/KQfmhySE42cIANt+mHhQgxfKYyc
 NsPPZSN5Hkox5M8KkIGk5uylwF+/wfKMw6p5vEZTL3+fmv23St28W6iiAv9aqOqZu5gA
 eM++Wa9mVNK2I1o5IF6wl8nH+teS8NqolAsQpJzVEWzuPkwa2lNFi7ea1oNahqEWoqhz
 svBEb+MaSsQK439yVGpvH/YjLgnxFdpm3RNB0fiUnpIRZ9if54VOAZ5XIxGA43RgrOLG
 0jxl3hOfYykyU5Br8CqIojDCUgrQLPJCIsJoftezM2uUfGbysJKdqXwTJ1b85Rl5HPuN
 ZEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oAvhvXME+54VRvS2clCGoY6uoOz3RlYmcJNO8CHCVtg=;
 b=h69zmiOTl9jouC2S1yKDOIhJ9PXUIfmjSh9k2Az+KJOWFmr3tYdmRM01D+Snylmk8/
 bxxj95nOXMZxNnVzEy09gybZDcBQFp8nftZ3hXK1e/f5bB3VFyoW3mpQ+gELqTODNa8n
 C+VzaArI5OD42VV6tWpkiKMRoosJlom5nmel17i4csPWC3YrYVyBVZTencd9GpGefx3W
 /O8U5pKwXzwnqxQVw3p7jWjI1kFbTktbszhqozN+xopZ1kgxrLzAGPtmoXef1rURwIOc
 67rvoYXydX/GE7dpVcgM7jMwtMXxfWpQLLC/cTiK34v7zH3xr6WvCJhFdYzf4Mk8PUKy
 n7sA==
X-Gm-Message-State: APjAAAVGiQ/d/i10hRO0yzccjv2W0VOO0GwaDaKzUWH05x5efO5iRUkm
 U7/k+gnzG/PH8a7SbhdKKo5BCg==
X-Google-Smtp-Source: APXvYqyNIiehEryY2KOUCwvdv6Ksh7xrU+fbfoDBwOp+yVqOAiK1MgKiX155VzrRZ+OlJA0He4GRag==
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr90494wmg.53.1567629030159;
 Wed, 04 Sep 2019 13:30:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f13sm20944033wrr.5.2019.09.04.13.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 377A01FFA6;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:50 +0100
Message-Id: <20190904203013.9028-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH v1 19/42] tests/docker: move our riscv64 cross
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
 tests/docker/dockerfiles/debian-riscv64-cross.docker | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 896c1c5a601..93190b1e2a2 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -104,10 +104,10 @@ docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-mips64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
+docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 221697f9d11..5e2d6ddb600 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
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


