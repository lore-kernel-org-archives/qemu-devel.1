Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D455C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C04208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7B46hVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C04208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c9R-0005Xt-17
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqp-0000eF-7G
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqn-0000Xt-TT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqn-0000XE-Ll
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id k6so6264185wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wIHRhiiS+MkSK/ZUnrDx5gR8gQD5vefos0xkr3Kmw7Q=;
 b=c7B46hVZmO7bsQ6hLgO60QTDqJBZ36sMm8YIcTXONr2pz626+px32tb7HpDcEVcwRO
 zRzN41uSVVpuqANLoeI3m/2GGBIdwoS8dSpwoRahMzMCZ4z+ipS5DkJVwOpR9AZf9Qxq
 /rlTjMkqU+Vq1YxLPr0oQkn1HG1Ek7djwdXXbhiUkQ6xXPdz/aQthVLR53oTAgTr0WJG
 S3whGo5Vqaq8Zq6O3hx8wNT/qqRAp3k3i5TKsDpvNltOvf7dMhc56NO63AgZDd3zka8b
 9vpIYitPQhsxMA+v/gfQY0nYFbANqz3qFJHp/tv8uZMaZ5PMtxWpbVXWm47lpJFv26WC
 5qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIHRhiiS+MkSK/ZUnrDx5gR8gQD5vefos0xkr3Kmw7Q=;
 b=Kn/QpLo4dqFzoWbCR3f1Ywht2SEQXASsf/vG1SPmt9KH17EhW0pZS29gsApyUmZmoU
 ANFZeEevqMJLd2OEw7KmlA+TZMPI/Z9QXP2c2z9eZXQ6BhbP86HCv6zp7hFHeP4nyaLK
 o1IcA0Edt5rfUvnVdKd2RNOPisxcdH5Nvo9RY2Rux+svgPF7uMiu84Yu2TzW0cnt/cAn
 zkcWbQZWKbVPn16J6d+cfK4q0/oBy/npEcfXM5f/cC7F5AnN3PGyR1RIpDP5varq1qNs
 Fu8SMv9WwTXxmiCB0RLrjEK73hgc3BARzeWHcgr5sy0nCPNKHAdBZJQEIexo6wQMfkb1
 ElGw==
X-Gm-Message-State: APjAAAVx2vVrqZ6uE8KphZG66poHkpMkMl8ohBamzaW5liLhiNIptt9p
 3ZNkLFN9CpKWFb++5+3G700aiQ==
X-Google-Smtp-Source: APXvYqxxsWAa+0pZni/ysY/Ct+mBZnv61XUIB1xBb6FdSmqjRe/vl9t2gjlXiRKO3rJt1vQuZv2FFg==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr26267045wru.27.1568105412601; 
 Tue, 10 Sep 2019 01:50:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a6sm8352694wrr.85.2019.09.10.01.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B7C41FFAA;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:26 +0100
Message-Id: <20190910084349.28817-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 22/45] tests/docker: move our riscv64 cross
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


