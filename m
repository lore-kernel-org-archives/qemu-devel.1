Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC2C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1DC2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQnYu88Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1DC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7nE-0007Fk-N9
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lB-0003p6-82
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lA-00087H-9A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7lA-00086Z-2w
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id j17so3522626wru.13
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JPoDm/Y8ADNX7hlRvL6Q3jMgQOp/FBsw/kHWKcLczW8=;
 b=bQnYu88QMuoL/4Kq/aCY+0vm7r3Yhb4cQ2oMoJ2Q5qzotE2CObYcldqe3d5M+H8xMn
 xe4RCeG5hkVpeVxKeu6BakdF6eonrzjZQSg8ygSmYfb0arvIrqWiA8yki/BQUIciI8UC
 IFnuTgdwXAPdKphxBEopQZsExLjr2BSbxG0u8RXt9qFdYRWbp9+8GX6L4S/oCdC5lJ5g
 73md/sXcYDhSCzAy/KDLZbXU6EzA3h1/xPk82vVZ3OLygmHBWLCFitoMgf2Srr6rDasV
 PqOQ+wz+4v+6GqRI9twHB3fKwI3YTTHOWfoclcXN90f4nttc/Ytz+SS0taC4POTeAi6Z
 gq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JPoDm/Y8ADNX7hlRvL6Q3jMgQOp/FBsw/kHWKcLczW8=;
 b=pzxFpXzn8E3LZBiPGL2/M1J+Q5J/cr+APx3bC1pODhIxJGeu6sdWCJGF/RT2j7gn/F
 /KOEwFgqQQi99RLDmHV84gXQ79o6QeNVBw54hz96nyjKH0In4GXqJ+Gy8SPpSxFptzgN
 mZQ6oiFdp4Q7ZuLASRQEu4q1+CD8nrp9kdSs2jJ6uYTuJN0M+wxPUCxoAFQIVjjCOTNa
 jPsRsFCDyZv3SVZJEJ4JdlKJ7bbyYyVP6rVeNv3yHUrc+fGKMNIZGYBmcT32naKS8uVj
 Rh51SC23BvYGjYqhfdTLHDtbM4lxPWn2Fu6Z4/Nsnr6W0r/uGaKf9hL4bblTcXkhpds4
 qTSg==
X-Gm-Message-State: ANhLgQ283kFo1cepV3lkSo0fk3R90vdhGDVFx9dnEIOUDvINugyFl4Je
 5D1JTYJRlfmyA6k48vf1mxrAzA==
X-Google-Smtp-Source: ADFU+vvHD6qY0pwJSrQu5SlUJqrgC03XBvnOOh4RWRLiqdFIKpV1U9tTDAbae3c1r8bcCcXm6u0IEA==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr4282628wra.157.1585149359149; 
 Wed, 25 Mar 2020 08:15:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y187sm9898179wmd.0.2020.03.25.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 132201FF98;
 Wed, 25 Mar 2020 15:15:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/11] tests/docker: Use Python3 PyYAML in the Fedora image
Date: Wed, 25 Mar 2020 15:15:41 +0000
Message-Id: <20200325151543.32478-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Python2 PyYAML is now pointless, switch to the Python3 version.

Fixes: bcbf27947 (docker: move tests from python2 to python3)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-4-philmd@redhat.com>
Message-Id: <20200323161514.23952-10-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 019eb12dcb1..174979c7af4 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -79,8 +79,8 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-PyYAML \
     python3-sphinx \
-    PyYAML \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
-- 
2.20.1


