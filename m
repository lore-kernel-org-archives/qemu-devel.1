Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C8C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3559A2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTbD82Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3559A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXnK-0005hd-FI
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjo-0006oF-B3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjn-00017R-7Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:48 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjm-000156-VP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:47 -0500
Received: by mail-wr1-x42a.google.com with SMTP id c9so16905576wrw.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7a0BuF+U2Jf5ebp76pSk7XSrwapwkGOTSopdBJmma/g=;
 b=zTbD82EtblZvLa+1b9Z9m+6vjbqq7gph7d7Ccu+SHXLFAxoJ0Gj8rm17p7UG7m1qrb
 sL9LRZsrbS22VPPXYWFN2yHQVtHPkBSN6Ll75dvEBYmR8Q/nMrdknGM4a4m7Ge3PfuKG
 0bSsLuyt7JI+EfCya5ppyHE6auEYrpuLybvR5FejsdVe40UJzwrqLbWOXOZ0WNA0cBYu
 8NEEDPQwXWnIvGc+xCx7Hte8SnpTJ2EM+iHHOdgFgGawHBr7ck7q0CTbMYkre1jLGhSp
 ltvL38lub6O7G/tCg3/SoNfMvPC6vwpMznmtq4Klb9ChBeX/vH9E2dFNJeUpB5L4AI5e
 mziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7a0BuF+U2Jf5ebp76pSk7XSrwapwkGOTSopdBJmma/g=;
 b=Z53IYjzXHXadT6SgjT72KDBYrSBm0UzW1g9ND4+xIdpWJm9986cofOFoFle7sVZIYk
 0WjIVYyLc9CsGTsbJUX/0+zFJ3+iqWla5w4NBPSmo8N8mJl4NgcoYfp/oHH53tUbwAXn
 75QNzHJCdmNmD30bF4Ss9VtakvApHyaovTbrgenVj3FFq589+34SNJ03+9agWi1grsfy
 ZV5Wq3LWE8tyMYtBnIV3sYbhaVP5eD34viY22kGUl4BDfarEdUEkcK3rEVA9uytfIocQ
 RrqP2a2zPPpp4r7eJYzfJDU3GU2AcyhhuCfHNBL2KXaiMiLgHTvExHrR7s/jlDdmRBkj
 OSSw==
X-Gm-Message-State: APjAAAWfTy+3NGzJGtjMW7IwLOzIQnnJPd5qf56yV54q5FGQjMGgTx0T
 HwmWO6FS99qWWgpMZens06gSmQ==
X-Google-Smtp-Source: APXvYqwwgw0f5O3giV5wncH6FwIjRhJ7Wym+TngFl21nDVTWlngpzN3SX3Yzl7cU3D2Kbat78cF4Vg==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr13934296wrr.127.1580720986003; 
 Mon, 03 Feb 2020 01:09:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm24402020wrw.52.2020.02.03.01.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25B6A1FF99;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 09/17] .travis.yml: build documents under bionic
Date: Mon,  3 Feb 2020 09:09:24 +0000
Message-Id: <20200203090932.19147-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

It looks like the xenial tooling doesn't like something in our setup.
We should probably be moving to bionic for everything soon
anyway (libssh aside).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 3128eff7e01..f245765cfed 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -165,7 +165,8 @@ matrix:
 
 
     # Check we can build docs and tools (out of tree)
-    - name: "tools and docs"
+    - name: "tools and docs (bionic)"
+      dist: bionic
       env:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
-- 
2.20.1


