Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AD9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BC52084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti3hs7Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BC52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cNp-0000N6-PC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0Z-0004a1-Nt
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0Y-0004p1-L4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0Y-0004o8-Bj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id w13so18473145wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y2CQYPgfdIziwHG+aXAJVzgAz9y8buKOTbwwFzIZ8YU=;
 b=ti3hs7TlPxkpshkDnKY5agSkhYYGBSJG2gtodAOdpFF9MFdNw0jeopH6g4VQ+pE0BX
 mlv8z2UQ1RtGdLTn5l3UwbhNdqV7Lq1abh7YHaI8u37bEEumA90+1+6jkBk+ncE6sPQ8
 Oba8KRZeGR0TmP5DKZ1PecsPEcQ7SPgz1rvNwqO9sxymuQVtcVpUh8kJPcVRO5t2SRmW
 P4rMi4zEfZ88kQu/Lt9chXLBLkGsEkXnuHVt85t59zlhpu+JivmTJsjE301w8UXP2U5Z
 Uo4zOcqNDiSvh2wj5ZhJMiqY9EPesRxUoYHVqsZJDjFqzjSlQ7HIRSwTRaJ3v5rBFzZW
 A5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y2CQYPgfdIziwHG+aXAJVzgAz9y8buKOTbwwFzIZ8YU=;
 b=S3TplXEM5B8lTospJDHr/3FJ7y7IXFHb9la0PcFhLmdqzKvGYMSNucZjlvbwFpFM/w
 Fs0YFtKz0cf3v9jhdJNOH23xKxUBs8x6gP0J8jSAFKDiCVm3WYY0mOPXo4H9FlV6pKhr
 gPa8Zl5DjpAcTm3MsBZzihmQtcduYt6Y6F/zHuvQmxn+58OCwD0yzSpNCy8OjbmElbpb
 t1RJTQzY6eZo3V5EuE6hU2UhR1SHxpCyFzFjBTMtdFWU7e5qMWrF7pB38t/ltYJ5edAr
 pGfiz14e+2wyK+RpncSfbDWIRaXplsqXVCjfzGoOH/dmgwCg5UVQHHcsDZweK910Dodw
 Vuag==
X-Gm-Message-State: APjAAAXXuqIz674QQ5vnpzAjGnL2+fsvj6P8jY0k/r/XSLRrFx5hU1ND
 Hat8R78ULNmapzX5zGaQBbZIsBNY0rA=
X-Google-Smtp-Source: APXvYqydaFvNVdfnLGuXlIanbTkWNjbLHTdHYwGRt2jKV6euMy56SjovT9W2N99knpxTGAWb4kzoEg==
X-Received: by 2002:adf:e992:: with SMTP id h18mr336729wrm.319.1568106016494; 
 Tue, 10 Sep 2019 02:00:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m12sm15013356wro.32.2019.09.10.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 802421FFC4;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:47 +0100
Message-Id: <20190910084349.28817-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 43/45] .travis.yml: Cache Linux/Clang jobs
 together
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These jobs build different components but use the same
host features. Put them in the same cache bucket.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 74f10d352fe..1ff26205795 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -173,11 +173,13 @@ matrix:
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - env:
         - CONFIG="--disable-system"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
     - env:
         - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
@@ -190,6 +192,7 @@ matrix:
 
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
-- 
2.20.1


