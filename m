Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F77C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3079420870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0UI2Pl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3079420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dLE-0003Jn-UL
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDZ-0001ym-BK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDX-0002TA-RW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDX-0002SW-Ko
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id h7so192202wrt.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6gFtLJYtViu/bHjCP6AP8cA/3kIHosahflHgjIy5jC8=;
 b=k0UI2Pl28IyQeF7qy9IzVIxo42t71MDZ/qdAbsaH5u7blaVGZa//8a1B01SKVIMMSk
 x/isVpimoCPrLu+LIVNiSKIS6DUhXEKrsm+S/uCkXQogoqJag76wXIQCpOP2dESZwPyY
 bhYOdu4oLeLjN+TYMEokpO3qlC2rAQYel2G/C12/oHtyGW9izPHdFaK0/6yXJe28KgXN
 Cfh1WIX1+cKxrLIhg7xQ/aaCLygOfMUUrEf0Hqnlu2HQYDRt5wmvJ7ObpQlzSAX0uqUM
 pEHo0PIG6m8aQf4HANyOTUkVf3K4eQOJF/ZEk9aPf3mynqGXZTLAiY85Xcy9Y/GzMS+R
 GxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6gFtLJYtViu/bHjCP6AP8cA/3kIHosahflHgjIy5jC8=;
 b=ITMCV+7/8KGYr2obaQ4T83ZN0wpoEVk4GbqzzjL3TPCfCjInXbp0EXcLBl8a97ozr6
 IK/u0TUeaKGe7LcwfuHHIGB9RGAon1wCQ6MlUBBQE+aRnBD4GskuhQh/+b6lsEdpLWj/
 cj1rRGmJjOoWXrJTSTUzyuyKBkFFBgzH7eytBrW4PSdGkMaVY0DzKRAjq+zm3EOvv+66
 ayATpaGo3P2CQzhPmX+texsdg/bH4RCbqyA/7I1GeWr4jIEjDcmyWVV89vee4VrHqj0S
 SwZuzqFA5ZctnlWllWh6jpvzGF/W2kJL6sefsHb8d0lNlC/Dh8LTS+M+tdLg7s8gdVSf
 43kw==
X-Gm-Message-State: APjAAAXzJnpMCveMvHfcLcrECl7Vh5UBNDaObP/LXWZ1buLYKrT7A/AC
 WpnfSdzldDvoSbYB6uRy5dHbXA==
X-Google-Smtp-Source: APXvYqy8F/1V5kEqlVDQutwa5qsAr68PBcM0sfPpc0ExoL7XqvW0Z7Dfh0hDcAoS8LuHMXzjM9+z9w==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr20279135wro.127.1567630166559; 
 Wed, 04 Sep 2019 13:49:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm30367775wrh.28.2019.09.04.13.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 220551FF8F;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:49 +0100
Message-Id: <20190904203013.9028-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH v1 18/42] tests/docker: move our mips64 cross
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
Cc: fam@euphon.net, berrange@redhat.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>, stefanb@linux.vnet.ibm.com,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
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
 tests/docker/Makefile.include                       | 2 +-
 tests/docker/dockerfiles/debian-mips64-cross.docker | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e946aae14fa..896c1c5a601 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -102,11 +102,11 @@ docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
+docker-image-debian-mips64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
index bf0073a4662..1a79505d696 100644
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
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


