Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E6C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C33B2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVf2MLUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C33B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXuc-0000ol-9S
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqb-00027l-Cv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqa-0002FP-Aw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXqa-0002EO-4T
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so15978021wmj.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BSza5NvDIp4Ck6pKLulcW18+0YCTBavyfujXh+YFfm4=;
 b=CVf2MLUvnFeP3IaP1SjNlbhxlI3Vl1DL4qLBXpCAm2IjLFFgsWQ/+BNxTcsdCmLId7
 xFWKxr7weUUt0nhPnrvKqjKRfjkQwWE1CYx9Yx4/2XK1tJFt938GrDnY6qAMg3hK6LPJ
 WZuLKL4CU4NjA3ArAGr5fAZcgss9xwPV+x4KibrC8g36i7jPUeMSIlU2GE2wsdQqAujH
 w2TqK5PoGv4oKpcvd1EFlHhIq0yhaT25FJ4qOmXS2kFqJLhgdWWeMaJVWy6yG2HcBpRZ
 iXuD++x7A/1I9tqlCaehou0Mpvuz3BriA3UST3FQp/u0vk6nw4DMA2jpxVZXT9Ey6iXv
 b+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BSza5NvDIp4Ck6pKLulcW18+0YCTBavyfujXh+YFfm4=;
 b=e045J3yEFjwBowcnykUbqBmrplJq/Eo0okplL99/byBCXtU0Ws94hj3Lv3gpEd7Jht
 k0S2jaePcj4Wo44M40hkYvyc8BaZa6XRsug2Pd9kWb06OyanZY4bxJzkakAGOO4cCeSn
 h491iaYb/dQk/xOqkyDKG3u79ud9OZzU6Nl90CA4WmWohKhrC5WsxlD74nWYOMWsiMOq
 0Vry6erMUtqKGue+BqyZWyCdE4RpbQK8K6/eW/zLeVLo2Pfgv6JiF3wEeVJJdu3CjWOt
 7jAkYvPd9UXsXe/0Ai0FmaKiiRVJorRtShuyOmtPyH6cwHIxDHQkjfRDJ2yIT70JkDv0
 Ihrg==
X-Gm-Message-State: APjAAAXElR06HMhjOp0gfsjwcVLo92Vf8d04GMcPRFovKhwhDK+B1JCF
 r7rdrVQO526wgglwFGsonL+/XA==
X-Google-Smtp-Source: APXvYqzYlFOwvVm6iszrveffOvPVA5S/vjpCIT/HM5+yM6H3OksE71q/HvnmP3JCXRoLGmIgLU0hvQ==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr26980608wme.153.1580721407126; 
 Mon, 03 Feb 2020 01:16:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm22131643wmh.46.2020.02.03.01.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:16:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C1F901FFA5;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/17] .travis.yml: drop cris-linux-user from the plugins
 test
Date: Mon,  3 Feb 2020 09:09:31 +0000
Message-Id: <20200203090932.19147-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

While it shouldn't cause problems we will never get useful information
from cris as it has yet to be converted to the common translator loop.
It also causes the Travis CI to fail for weird reasons which I have so
far been unable to replicate on a normal Xenial system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 875671325c8..c1c6df475a8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -387,9 +387,10 @@ matrix:
 
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
+    # we skip cris-linux-user as it doesn't use the common run loop
     - name: "GCC plugins check-tcg (user)"
       env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
         - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-- 
2.20.1


