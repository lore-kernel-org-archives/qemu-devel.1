Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB981CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A8821D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3H7ZscG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A8821D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5Rt-0005fz-EM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oc-0007zm-KZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Ob-00034j-Ff
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Ob-000345-9g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id 22so3037199wms.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4cAF+jXyqILcdqYr8jn1OJvirZtMtT4XAzWjgRvCIE8=;
 b=G3H7ZscGBxRreorPhaUOz2hzVWi/h0Ev6UvbExvGnOe15GS4b30beTDBKmuwmDSDba
 K2bVPuE73Iyf5+XyDc6i8ukW6htOucIRKTad+ft4XMZsoGlRtny56BlluqW0/mKOf8GF
 8myeueF3vyjHfAVkYDxg1C9yY7pwYLYvvc528aL0Rg1fFvC+kX47a9o8O0MmnJYReEwR
 mSRLXLPdv/HJkVAY9GiHEfn72pMHzRLrSAsSWRHSpqqX/jLmv2bOmXI5++nvbKAPPMgG
 cLTegoyMwNTamtZPanIaQSCajXPqOCaJZ9Qbj8yfWSzpP5TBdc5OBl/ca3xmr1NPMm45
 YVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4cAF+jXyqILcdqYr8jn1OJvirZtMtT4XAzWjgRvCIE8=;
 b=grD900xqLVfUH4ubeugiavk8X7d1AIHgJhXBmC8MrEe1U0T5jCtvE0U88gRyfAhLK6
 q3a+DqgO1m8o5mHnFMccDf+oQZT4mQepvGQLnJFdgasSVKVcaGbhj7+YkuQ/uBxNimv+
 IqtUQLYJZnjLT9Sb3TsLU+eAaKRmTHM30TagKIXO4lqw6As3UJ1kDnkXBqEAqGnmOvQ3
 Z5ETimMEnwk2Gyha+Z3V6GkIDfRGaNxU0tnvYjBcBlaijj1mIsCMHZX0GLZdcUe7yMOf
 jo5OLjfs5f3V+u66svaiiqec70KBtBnLaaFSjg3Vc9mdyQXZztMjGh2+9xSZWJvkjmjY
 eIlg==
X-Gm-Message-State: APjAAAU/aY1Hl2xotT6ZiV3GYYDkbVpPXUq4wEIKFXUZEEnLQC9oSg1O
 9wCDf/tjl4ViO2Tymo9AZwv44w==
X-Google-Smtp-Source: APXvYqxCcsplgrg+URWqt/ioIazDQGhHIIFpVCOX9jY56E5a9NcniOe98NwlsMYxVtScAjra+4eSQg==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr5110226wmb.16.1572032232130; 
 Fri, 25 Oct 2019 12:37:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l26sm2464604wmg.3.2019.10.25.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA9041FF90;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 03/15] travis.yml: Use libsdl2 instead of libsdl1.2,
 and install libsdl2-image
Date: Fri, 25 Oct 2019 20:36:57 +0100
Message-Id: <20191025193709.28783-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We've removed support for SDL 1.2 quite a while ago already, so let's
use SDL 2 now in Travis to get test coverage for SDL again.
And while we're at it, also add libsdl2-image-dev which can be used
by QEMU nowadays, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 7be2a9949f5..b446e04e8ae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,8 @@ addons:
       - libpixman-1-dev
       - libpng12-dev
       - librados-dev
-      - libsdl1.2-dev
+      - libsdl2-dev
+      - libsdl2-image-dev
       - libseccomp-dev
       - libspice-protocol-dev
       - libspice-server-dev
@@ -309,7 +310,8 @@ matrix:
             - libpixman-1-dev
             - libpng12-dev
             - librados-dev
-            - libsdl1.2-dev
+            - libsdl2-dev
+            - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-- 
2.20.1


