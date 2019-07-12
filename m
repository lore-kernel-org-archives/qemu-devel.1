Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C0C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EDC216B7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkiE5R5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EDC216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltaw-0005GB-8O
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZp-0000N7-T7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZo-0000NE-TM
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZo-0000MQ-L5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id v15so8585978wml.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JcoASBExlpQtKdUtfQbzGmK9Gr4mswv4Mu9eWVCSbVE=;
 b=wkiE5R5rAiIcW9MW9Y0CAoASKoFesN5pIWItulm5xEbOp+c1II8mDqTcx/pqyM7H2B
 fG3DXp2Y6tNBOcMCHQnPkl2TImCszPWvPz/ZOm6CLZGNcJ1G+KV080ZED5BaGMIDjz5V
 zmLKtLGsi9ECvnNRlAGtsJjjDKRfny1ohe17YCZauH5a92Je+y6k7Sd4NEluHmbuNUsd
 DLEMbAwfQLDUKuH+XcXwQDgkPT60H81JNRVEKZhbnD3Dhn5dkPdNeJWBn8wNTeBX+/TH
 uH5SjeTE+uD/4c2eYxiVD5qQ8WABuY1qxguWyc4rkdjOw0jNPJmjIAd8elvb7eiHGDwa
 YJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JcoASBExlpQtKdUtfQbzGmK9Gr4mswv4Mu9eWVCSbVE=;
 b=Kf/ouT4++6I0F5/xFzziRRZI37VS9o/qQgp7O5OpMGKYfTRsng9/tWWIylTomsaTyE
 RYj7DT+vco43f4UtloLVCRxp0dphU3oVnxdsH+HUB0Bmp5jpL1INqDNyjECqa91d7jNm
 h/F6rUAqzXloGd+ZmhbExm291JqjxrTeTwCqALrpewKLPACDcQcbrB/vnLSY7UvoqZJx
 vs273Eq4EoMvWdKvMeI14DB0HrUaI4tjH+FWBvQAKUfep1Cap9PZxPjzF4yCXRQyu/Yh
 DMRX8ALNh2WPa/Fa6Coj+yPqQXqhdAVFzusQrGkFtluZonQMCqiPJUrSgLYwTKoqyLIl
 vOzQ==
X-Gm-Message-State: APjAAAWnVHFdfXz/MWZ1Ma3f2T5fd0KNKL7jgtfTmQCJkI6Fnznp4GqI
 YFHvSjUCaIWnCblWrH/rLYv9vhvMSUI=
X-Google-Smtp-Source: APXvYqxlnGFsaEbt63oTXBrtS2RfNSRvDyvnPWkZ6fP980VDER2Dj+ukFA3B0xxdAKIZ7R0Z4AL0Hg==
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr9475404wmc.133.1562930335373; 
 Fri, 12 Jul 2019 04:18:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w25sm7457764wmk.18.2019.07.12.04.18.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:54 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 009251FF87;
 Fri, 12 Jul 2019 12:18:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:49 +0100
Message-Id: <20190712111849.9006-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 7/7] shippable: re-enable the windows cross
 builds
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
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pkg.mxe.cc repo has been restored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index f2ffef21d11..f74a3de3ffd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,11 +7,10 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    # currently disabled as the mxe.cc repos are down
-    # - IMAGE=debian-win32-cross
-    #   TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
-    # - IMAGE=debian-win64-cross
-    #   TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
+    - IMAGE=debian-win32-cross
+      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+    - IMAGE=debian-win64-cross
+      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.20.1


