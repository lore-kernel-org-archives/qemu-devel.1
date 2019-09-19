Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83013C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C1721928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbJY7zRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C1721928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0BQ-0004AL-Rp
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06q-0008Ns-Le
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB05n-0000PG-Be
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB05n-0000Oh-44
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so5580613wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FEApLzz8EuHV+XBsNFul7xa5XssJJY+Lsb1MZ6+FuAA=;
 b=WbJY7zRH3FBZJID4Msl3iQLfATLOJAVeGd2ybGuFZIMZMUlMCOLQujs0NmUQHGfOme
 1H0AvesJ+qAaFDqO2OTNbp1K08pEU/3RwJGMgmWpaDfIlBSuCx+FQVgGBv/Li5hwYZXc
 voerk9OkoIUf8bKpBchw5Q2lU9gMbpJMDS982ccohsZppkxySp5OPFphuqlTj0nYXxpd
 Cj1ApVaReI6hzQyYaoA2RzKFA8LOXhMxhSKwOSJMDNIgcQ+Z8N9cqPBG9a33Lqvnx4gv
 +5ozAw+mjiW2+0LD88cFXyJ4VOK4hAAEy+VOWqOW4OQEQLm0cujwlq4Fo5RpGt8Cv0Rb
 /aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FEApLzz8EuHV+XBsNFul7xa5XssJJY+Lsb1MZ6+FuAA=;
 b=IufINyblZQV+4eRygmpHcdKX5w0Y7EHncOLBPLzZAlronat+JOAy8P4a2g+mUeTaJ6
 ZiESlbyc0zxgglOu3gBLKZnc7bWhbE4CU6Bbw0Y7Xi2p9XoByrPWQIYW7QF8ooBfxrxB
 BM6saGmK88vfxlUtzcQGBj+C5jZjfDxnCzj9cS+F6ZHxf6rwi36frM7GKTelm/9l35da
 57pQS92EY62uFTBMsJrAXuzGcJOcxFElqGePtJC6wARFE9yjC52rCIiwKTu6AX+ReY/f
 YsEJaFYcflrFJq6dGEWElt+AeyRZUhP8BX29DRaTYzN++aSbQLoJvdZ7oBGbbqeIc1xU
 ftnQ==
X-Gm-Message-State: APjAAAU2Ekp3IgISqhDCTxdhR8mfZr03vzMlWygkZPEL51J6+HAc22Jz
 7NNCoL7VEHHZDtsTRg8z/TDQ7Q==
X-Google-Smtp-Source: APXvYqy3zWqraInHq/1yrCNNyAj0A9JsjYziQEXKuPMMBnC6Hs6DZdjj9iWXwqDknHXcmxaetGrhRQ==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr4099465wmr.143.1568913582083; 
 Thu, 19 Sep 2019 10:19:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm14108473wrg.80.2019.09.19.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1543E1FF9E;
 Thu, 19 Sep 2019 18:10:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 14/16] configure: preserve PKG_CONFIG for subdir builds
Date: Thu, 19 Sep 2019 18:10:13 +0100
Message-Id: <20190919171015.12681-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The slirp sub-module complains about not being able to find the glib
library on cross-compiles because it is using the default pkg-config
tool (which isn't installed in our cross-build docker images).
Preserve PKG_CONFIG in our host config and pass it down to slirp.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile  | 6 +++++-
 configure | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 111082ce545..3cf5b1e7539 100644
--- a/Makefile
+++ b/Makefile
@@ -499,7 +499,11 @@ capstone/all: .git-submodule-status
 
 .PHONY: slirp/all
 slirp/all: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
+		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
+		PKG_CONFIG="$(PKG_CONFIG)" 				\
+		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
+		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
 # Compatibility gunk to keep make working across the rename of targets
 # for recursion, to be removed some time after 4.1.
diff --git a/configure b/configure
index 30aad233d17..377fbdc9f1b 100755
--- a/configure
+++ b/configure
@@ -7302,6 +7302,7 @@ echo "OBJCOPY=$objcopy" >> $config_host_mak
 echo "LD=$ld" >> $config_host_mak
 echo "RANLIB=$ranlib" >> $config_host_mak
 echo "NM=$nm" >> $config_host_mak
+echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
-- 
2.20.1


