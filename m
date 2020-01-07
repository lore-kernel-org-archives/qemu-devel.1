Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC68C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8AE20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYrt2jJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8AE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotA9-0002rJ-Ak
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iot9M-0002Il-5W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iot9K-0003Fi-Bm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:00:15 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iot9I-0003D2-LG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:00:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id y17so454655wrh.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N1hZ2+dZ+KNrvRY3A4OxdrdpA3fvLZxJeHpvL0wNwYY=;
 b=VYrt2jJnnHT2I+Sm3+ne0cCmiLKuaDkhAZCiV/5QK1Q4HFtfhi2D/aoEAkjcCiwd9K
 HKqynQMfK0/iTPWwm852O3mekraR4qj6OQ8LI0St8GOTgrJ6q9o10tmfysHrF1TWpvdg
 gTffdynm4jThwgg4sDpnKfA03EBXrx4jHIUriailfL+X7tcNh4O+UWXUtkncAH4CsSEv
 f+8AoG1AGgbyP3mb1ovoAg8cBlrgB7FOnn0Fe/H5bXZlRQ3VMyAoFPfaeTwTracqgTAU
 XcXZ5syy4CsPkQjkH9uenFILtrktVQgTprIMVmbIQfLHnRyv9bFX5pWJPRWqo8+TQ9Oi
 PAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N1hZ2+dZ+KNrvRY3A4OxdrdpA3fvLZxJeHpvL0wNwYY=;
 b=Ms6vqfLkr0naJG7kA6nNeK2LsaMUn40qOwveM/8f3M5cvNh4DZvGkYCnaEWky6I5NG
 Elfi3Cvl8akw49Y1t7xUf9QzM48Wzn1/iKzGN8F4MXvPt9upAkxpALR9ygoaiWJi6548
 89woSJyxT8a6jfmdGk9MEhhada5moashs30wVFagCvDSQ144JCikqVFQtxpcsRmIoH1t
 5xR5O0CrWakDdTy4DrUJ5BI9QLLrLpTu727L4fO3VSfDTVNZndcQdbBZkt7cb5E+LMCT
 /2pQCLNLCwrWu5h4pb+0Bez3EVDdMqVHGggoUMQqtZz/pMT5uM5GEpW44Dm0yTz15BIw
 fkrg==
X-Gm-Message-State: APjAAAWjLW/ycXi6hCG76qRJigcksx45MU2Cn7hXOT3FgShYUr5l9aNJ
 y8sq9NypZkcs0eBMDZjAT2EQcw==
X-Google-Smtp-Source: APXvYqzsGgIzz83ENfweiTTD/3WppwWMF/Za65eESdrt0FPunHfjlKrjt23uJWf+FBTLCEHC9sntqA==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr318649wrv.108.1578420011021;
 Tue, 07 Jan 2020 10:00:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w17sm770964wrt.89.2020.01.07.10.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:00:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 542DB1FF87;
 Tue,  7 Jan 2020 18:00:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] testing: don't nest build for fp-test
Date: Tue,  7 Jan 2020 18:00:03 +0000
Message-Id: <20200107180003.6753-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Peter Maydell <peter.maydell@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-calling the main make is counter-productive and really messes up
with parallel builds. Just ensure we have built the pre-requisites
before we build the fp-test bits. If the user builds manually just
complain if the parent build hasn't got the bits we need.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include |  2 +-
 tests/fp/Makefile      | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49e3b0d3194..7a767bf1148 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -969,7 +969,7 @@ FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
 
 # the build dir is created by configure
 .PHONY: $(FP_TEST_BIN)
-$(FP_TEST_BIN):
+$(FP_TEST_BIN): config-host.h $(test-util-obj-y)
 	$(call quiet-command, \
 	 	$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
 	         "BUILD", "$(notdir $@)")
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index 5a35e7c2109..56768ecfd2f 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -554,15 +554,13 @@ TF_OBJS_LIB += $(TF_OBJS_TEST)
 
 BINARIES := fp-test$(EXESUF) fp-bench$(EXESUF)
 
-# everything depends on config-host.h because platform.h includes it
-all: $(BUILD_DIR)/config-host.h
-	$(MAKE) $(BINARIES)
+# We require artefacts from the main build including config-host.h
+# because platform.h includes it. Rather than re-invoking the main
+# build we just error out if things aren't there.
+$(LIBQEMUUTIL) $(BUILD_DIR)/config-host.h:
+	$(error $@ missing, re-run parent build)
 
-$(LIBQEMUUTIL):
-	$(MAKE) -C $(BUILD_DIR) libqemuutil.a
-
-$(BUILD_DIR)/config-host.h:
-	$(MAKE) -C $(BUILD_DIR) config-host.h
+all: $(BUILD_DIR)/config-host.h $(BINARIES)
 
 # libtestfloat.a depends on libsoftfloat.a, so specify it first
 FP_TEST_LIBS := libtestfloat.a libsoftfloat.a $(LIBQEMUUTIL)
-- 
2.20.1


