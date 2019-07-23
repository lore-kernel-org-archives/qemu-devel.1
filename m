Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF91BC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ED5223DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyatRNP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ED5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40973 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hps9z-000765-Di
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9a-0005fn-9n
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9Z-0007MB-A8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9Z-0007Ks-1E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r1so42595852wrl.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U0N4Iilux9QVCqxzdOq2k8lgc3K4HVZ6wxnptntO45I=;
 b=uyatRNP3MxaBDDjYD7TM1Kl6Q7cvLOSJK1gBjDOv13BPTnQaygixx+BJmMet63zvhM
 /0limyN8m8eAgcd/felDgm2cS0tpe9lWj98SAaYPCIJWxwXXmXSB7ABFX48AhiRrA/ia
 nNtNMpOHwgu69oGbXo9+OooxKYY8ZOK/sJtKf9U9s0TT2jYc0HXDJzWVHxj4yn8epB9I
 +q7zTTDmhnxB6PavH2ScB9bP2GT9Y2r/HHC99CVjNveabx+3Gipi53AYzUpsb51RTllx
 KlZzQShslzwiNVlWk3UPjyjthrXTrUtVxjkEIys/Y2Bdjeef8q2W7uIClWX+jIO7mT/I
 5fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U0N4Iilux9QVCqxzdOq2k8lgc3K4HVZ6wxnptntO45I=;
 b=XdKLwntvf8PcNy41ZgONB2GieT2wGTB1J1PAJ55FxtLGlMxrm9iZ5Vo6+kGhE0nnX7
 TEqDkRh6dwr+xNPsOoMMoxIbfdpuPvd6CZkaDwcJJ8qk8tqV4qYy5U41rj7Y94oOk01P
 WFrGLSGJD3Wh1/UcbjWICLs9sbiCqT5pBAkQrmGJoQG22TFlRV76P057S+9cLcbhqvdV
 uaVrvsZYCoiqJTvq+877RmHi5wGAdYdnUE+qdBu1rUoIJ+IcD1vpkm1jYSV3g2n4cYNg
 H+Gyp/lm8LV5OMIlekAF/fQEF6+pjSr3/pgO7w1StDo56xoraj26rQWxCdNk/U87dHOG
 h3nw==
X-Gm-Message-State: APjAAAVDvtyqVkxfiX6m/fxyiDUCAZnlc+e6nixKKu/UN1++ol7optAe
 2570ykJX4kMvmihfABBn1q/UMg==
X-Google-Smtp-Source: APXvYqyzvlchFqJwc/j3gcEionqKH3K1cqHgrSEs2SWNJRsjZPEDQuM/xg8fEk3Ous1ESC+rsqQG1A==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr80440310wru.318.1563878175919; 
 Tue, 23 Jul 2019 03:36:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n8sm33476180wro.89.2019.07.23.03.36.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C2341FF90;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:52 +0100
Message-Id: <20190723103612.5600-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 03/23] tests/docker: Install Sphinx in the
 Ubuntu images
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190711120609.12773-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index d3b72209c85..2500ec84b6f 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -61,6 +61,7 @@ ENV PACKAGES flex bison \
     libxen-dev \
     make \
     python-yaml \
+    python3-sphinx \
     sparse \
     texinfo \
     xfslibs-dev
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 9d80b115009..0bb8088658d 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -48,6 +48,7 @@ ENV PACKAGES flex bison \
     libxen-dev \
     make \
     python-yaml \
+    python3-sphinx \
     sparse \
     texinfo \
     xfslibs-dev
-- 
2.20.1


