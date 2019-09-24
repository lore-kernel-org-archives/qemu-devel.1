Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB86D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf9WqoE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB86D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtmx-0003JL-0w
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5G-0003Qp-Sv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs56-0007a0-0x
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs55-0007Zr-QG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id r19so366880wmh.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zK0yuZrTDTwRTBFF7n6uiaAtWncNsTzP6ETmlJNaNAU=;
 b=Zf9WqoE4Je9zZcVUhCHtPA5iHtEqIvcSeKkEjz1gKvSblnE0Shd4jDh+To1F8b0EeA
 4ps9n+Os7mydX7K22h0Y6LLwtBqeWoeohHF5UHVhx9UJ4TgA3p+3Q2UZL06RYQv9XsSV
 usoEceUCme/JK6ZTINYaHbcB1etRSKW5adkOcx4vVlI+wOKt5sHORZ9EwmVibZBAtcRv
 RlLkTgwwsk4qGKerZY97tpkraB+Rkv0iXPqNHt/a2fdcaiSRQ1DguZX2RdV2iOAqsvpS
 nqmydfjlhSpmbgtWyQe+2mpnGJ7hXEt2na+VR1kEmDox1xKa4xrioZY1DCx2I6XvoWS8
 6dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zK0yuZrTDTwRTBFF7n6uiaAtWncNsTzP6ETmlJNaNAU=;
 b=WVKH1dhfMlxIpPdMYv0VEjPzOuvm29YCXqaZahVvWnLHUM9uFg3UKZdjbzquphSnYh
 AXbgdYCJq0m5If3bBG8Q7M1HCw3ZsyNiPNcgQyM6VCSpyghk08PbPqywdiqjJMzlj1kc
 Snjx7cRKt4+921PHEHrlolqNbRM25M1BCcgNSob1v9OF/xIQBFFxr1PafAyQrP8BN6L5
 hGgnNxJSDBh4XAKtVmA7q7406KFJyA3WvSCQqwhQRkENDFYy5AQA0bhGS+su0BBEZxVl
 qKkUdDfI9pJoW6ttAo138zIh+iy8eRQmXG/KpsLaIcahmTdD3iDGwhxBC3KFF2xntooS
 0psw==
X-Gm-Message-State: APjAAAX6Bg5nVBcrRW28nRvSHoj9lEZsdJoTxd7I7o22Mxnn4d2SnI65
 g4zoY2ShisT1ATYdi/CoiT0ERQ==
X-Google-Smtp-Source: APXvYqyXtLd2Riz0/RxPumHxEbMp0DS50QcuI6vdqhwtVKTDioFnvq/h4pGOQgLB49y7YqLbYku8fA==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr2499469wmi.72.1569359442782; 
 Tue, 24 Sep 2019 14:10:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm5202467wrf.73.2019.09.24.14.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E39AA1FFAA;
 Tue, 24 Sep 2019 22:01:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 22/33] configure: preserve PKG_CONFIG for subdir builds
Date: Tue, 24 Sep 2019 22:00:55 +0100
Message-Id: <20190924210106.27117-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The slirp sub-module complains about not being able to find the glib
library on cross-compiles because it is using the default pkg-config
tool (which isn't installed in our cross-build docker images).
Preserve PKG_CONFIG in our host config and pass it down to slirp.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile  | 6 +++++-
 configure | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a0c1430b407..8da33595edd 100644
--- a/Makefile
+++ b/Makefile
@@ -510,7 +510,11 @@ capstone/all: .git-submodule-status
 
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
index 397bb476e19..542f6aea3f6 100755
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


