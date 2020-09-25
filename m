Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8776221D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjwB3VAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq8U-00047T-Gb
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq5-0002wJ-0V
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq3-0007eG-FB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id e17so3502815wme.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7uJYNbe5lkb51q2+AyPUZmp3kp5cS3cpbQny1Ymo9K0=;
 b=wjwB3VAgAU77vyL2OTnMzaRayFuCaZ0kCBfL1J9jDeWLtAxCjSTNYf9FWUMuI5ExGB
 ifRciv4oeeMQe1Gh84AIC8MfEeBKHrzaroLSdRd/wE+I6KLF+bnX+TXSZWOs3lnkXiMm
 Z89IW9w7AnrFSdSwYrDKdo7SzzIpxsa4XYSL+OLdgDh6nLoRglVkz2NYXPIWJygWsa+D
 F1DFVRq4N8xNVDMWHxh/jdzSlHzwq6jk5dFPLMdTQ8D7ynZKBrqt3K5OG7aoq2pQ7fpu
 lnn2dJ/e5rLOVG4kBNFVgkmkhlgbNWiaBjSPBZuxTaT5SF8f/r1RnbA9o0TVMleKV1Ef
 c7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7uJYNbe5lkb51q2+AyPUZmp3kp5cS3cpbQny1Ymo9K0=;
 b=tXivXqY1chtmct40ZqCeWmC1mvEDbS+3IVPrrHXHgnGEca0oZ0nSzpw4Ck4xM4uXhZ
 Ir4Np94EEfSXY+2npQ7n16K1dftro3UaBtvrvbaxxz6h5PHlweE0h9bAdfAC2g1AkVV/
 zdUG8kGhuOKGamX6Jaut52w3kBe6h6I7/DocSj1C5H+/DCZF99GFDTsmq3xILhgCq0RU
 AqUSq306p9NNrKgkGP25CniZY5FmryTJU3ZLdcUVBWGMjVzLaTA7e8gsts4yl5wr2R71
 IFhEoamxVG3knZok9WmvT0pzplOj05MOsAwRgUcEHO4YXNLV0oVdJxu19QfLRUMSveU9
 zZ8w==
X-Gm-Message-State: AOAM531cO2g2GbpRBsnimtT7qD2f4/2BT1+WZL8qAqwiKSd/I82W0nSw
 93RYiTxff+6+uvikGnsTKecn0NoLaY7BOQ==
X-Google-Smtp-Source: ABdhPJykRqXnarAjkd2p7nIp/t2a9UE+Xqm1ELOXvi8hr6LDT64Cvxym2O0inPPaJp2TVckiXkMTag==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3784148wmg.74.1601048445823;
 Fri, 25 Sep 2020 08:40:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k84sm3353801wmf.6.2020.09.25.08.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6362B1FF96;
 Fri, 25 Sep 2020 16:40:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/15] travis.yml: Drop the Python 3.5 build
Date: Fri, 25 Sep 2020 16:40:20 +0100
Message-Id: <20200925154027.12672-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We are soon going to remove the support for Python 3.5. So remove
the CI job now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200922070441.48844-1-thuth@redhat.com>
---
 .travis.yml | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 023fcf71190c..b6fee288bec2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -254,15 +254,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # Python builds
-    - name: "GCC Python 3.5 (x86_64-softmmu)"
-      env:
-        - CONFIG="--target-list=x86_64-softmmu"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      language: python
-      python: 3.5
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       dist: bionic
-- 
2.20.1


