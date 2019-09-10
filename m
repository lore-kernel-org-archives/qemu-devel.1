Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40DC49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4637E2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE0PtWjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4637E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36537 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cR5-00049V-OX
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0c-0004dH-0i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0X-0004nh-3F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0W-0004nA-SW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w13so18472952wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2x1SiZ8wUu6pIpQhf7+eEOKFCz5E7or12J1Y64puZA=;
 b=mE0PtWjjNPRKypA4eMhDhUe1exqIXn8/eABPDHhDtVLbx2S4Q+wgYf0xM60/MdNT8s
 U3AbXQiQjIDTJEl0cDGZF/UWu+Ni3Z+JQmJ2h4g/QMc6K4qz3OQoeU2jyYfponSFC8JU
 sfwv/M2RoUFliZ6HiykkMkD7z7mcqFT+ILyIS2wpsKFkMPoMbdMCagNcVECe+feP5FYf
 FJ8Cu/ZzRyy+ZttupBkmKTQQZ8SIpqwpaCG81glwNoeNmiUscUB9r2we2jSKcZnS84Vi
 OIEUhaCbWYxFx87I4b22eoPQgTOnsGzo1mPhbfJ5LopWkxYSt6W7PX9EGerO/NTXACvv
 XXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l2x1SiZ8wUu6pIpQhf7+eEOKFCz5E7or12J1Y64puZA=;
 b=nmlyUPJXURVq+F/20LmC5Ekuqm1zUqsHKQjP7JKpFcG8XJ2Mk+gdqSKIuaS6qL6In9
 GbmSrZzOU/qqFDo1Z+th+nzUej87D+rwKzxhH0slkTOoaWpdLtkba28Br7oIfJSniZhy
 d2p69SlnwNVLbueCkfjLvhyPNlNdJuSvzgNjUd5trZBDzjzC8ebzpNh48rL1Lq+kolPn
 7DW9HH61OvASYZ/iersn/KGA1FoxVF9XgdCivlLd5iV/ctpmRF673rH/qsN2pIjMqPka
 LMS3Xphu1MXYgv3xF5KTF8QEuobrJCSWBMsDjVt2/F68plv64KtJyaNQ49TDOxTYskyp
 eaBQ==
X-Gm-Message-State: APjAAAVYwnCyOXu2ahXbz5G4qqXX5qMHh0KQQF17xpI/hA91Wo08LP3A
 dXHt42EGmYdCmmVyVeRp7TbIPA==
X-Google-Smtp-Source: APXvYqyInkxKZOmpaJMUhc1Np+4oJ+5HxFMYxJHiHE+xr15EK867+YRWRsHiD6pAGoSFV/2gXHbcaA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr21006996wrr.302.1568106015817; 
 Tue, 10 Sep 2019 02:00:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q25sm2083119wmj.22.2019.09.10.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 76CD71FFB5;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:35 +0100
Message-Id: <20190910084349.28817-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 31/45] tests/docker: add more images to
 PARTIAL_IMAGES when not on x86_64
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

This prevents us trying to do builds which we can't complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7df8dbe1a17..50a400b573a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -106,6 +106,15 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+# For non-x86 hosts not all cross-compilers have been packaged
+ifneq ($(ARCH),x86_64)
+DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
+DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
+DOCKER_PARTIAL_IMAGES += debian-s390x-cross
+DOCKER_PARTIAL_IMAGES += debian-win32-cross debian-win64-cross
+DOCKER_PARTIAL_IMAGES += fedora travis
+endif
+
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
-- 
2.20.1


