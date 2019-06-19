Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F8C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB3B20673
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XToJjNX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB3B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgql-0001um-DG
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgZA-000459-2T
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgZ8-0006mI-Aw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgZ7-0005bR-Di
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:48:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id r16so477367wrl.11
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z4VvhhuchSdMT3GYoRhtK0sFOye981rDs7adl9IorKk=;
 b=XToJjNX3ocCDt98L335DOJbdH5DcmpT4Wv3EJ7NaA5aW84SC4mHOnv544EdzrCbsec
 rh1xDOwYq9Hfvb/2hjP3c32q9P2ED5wIoZedJiU93bkY1xa/labgXITJBU3pu7LPwGBi
 fEJaw2ET/JzDuyMaQkq98D6IoQHDHPy+06j1lGOKzP4IV6J+vRNoqDz35oI2wP/L6p1h
 O+2jzCLIgspbDFvWOdGUeex1qkuhyzMgnQ/JLOoh/YZUm895NsYU3Am0xcvzundGpzHD
 nTRrlGEM9jzmuWfGVED3E+j1OoQmHKzi/fazISkZ8PIFKKEaAeTPpA7pzD2F80EMflmJ
 QbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z4VvhhuchSdMT3GYoRhtK0sFOye981rDs7adl9IorKk=;
 b=FLi6zaxC8lakKWZWiYth5W1Y4mFcOcIn+cMJUrRUVof6oIyfZkxmhd5ZrRaiHE3ALb
 nje35DEQjh+8BdNL4rzGLTmpfbVuZXzG++fA2nGCVBmJpfvDxza5OMs8OTvt/tBNVzmL
 KkQ1ht+aF1wtU7DE6zit/61YIcOUrtfkRkUXi+P5FqeFPZWO1EpQ7d0nfwzi3RLONhzs
 5zI06zB1PyN9PpllDEWVrxK24jQwxJOo2zT88DnqHoNgOrWQF3siwQRMeK1mghW5+wPF
 4mvfPwX1564GgspwBl9hdZ0fBg1B1ASDfVKb4YttB0z7RnpNjLtuiObh6B/sjqiGGVoi
 2qUQ==
X-Gm-Message-State: APjAAAXa1zqvhrrj3Ru+sEedDy2m//HHYT6oEanpK+2zBBYxQeml48PX
 LWTY6NTal0AQyTZQgZRwbuhI/w==
X-Google-Smtp-Source: APXvYqyEBv3Hk8f4FqT1Xa3oSGAD/frdrKs0Rc2eeCRumzSV7mmIO0FxTWlteVyMNnWQ9CDrmjb7oA==
X-Received: by 2002:adf:db12:: with SMTP id s18mr34656917wri.335.1560973640305; 
 Wed, 19 Jun 2019 12:47:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v27sm36544731wrv.45.2019.06.19.12.47.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:47:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C12681FF9F;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:20 +0100
Message-Id: <20190619194021.8240-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 16/17] .travis.yml: default the
 --disable-system build to --static
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's fairly common to build qemu-user binaries with --static linking
so the binary can be copied around without libraries. Enable --static
in the default qemu-user build to cover this.

There are other qemu-user builds that use dynamic linking so they
should catch any problems there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..9750dc905c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -80,7 +80,7 @@ script:
 matrix:
   include:
     - env:
-        - CONFIG="--disable-system"
+        - CONFIG="--disable-system --static"
 
 
     # we split the system builds as it takes a while to build them all
-- 
2.20.1


