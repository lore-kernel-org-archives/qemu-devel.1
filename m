Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC830C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5AF21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Klhzn33n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5AF21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0fa-0003cY-QC
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07N-0008Ns-HM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwl-0004Nb-H2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwl-0004Mx-AQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id i16so5518494wmd.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qkrQNPdYjgzsGeZKliHj5m6aTSoldYZ7J5gDgev0N24=;
 b=Klhzn33n90q3jrfUfd0J3LfkrOUYuc29UNP9Ht9Z7TxLYqg1L22Qbp0UpepMBAroFU
 QnJ0GKJ/njWO1UdfYgG0sSGUwgayg0dzq07c7m/w/G7jkbTJ5flyAnmD1noHtVU6TCHw
 Y6B8Yw068kD3DVr3zK1MN0dBVRUkMcfJIKVWS11fyc7DusyGTBUgTYWlSQgTqxADT/VT
 lfCDgsnxG0BpOa8csVDI7IHO26tOdiCLUqYECaUjBO3Ei8dGOUwVBKqUu7oypy4kBHFW
 ZSuZt2ojf7d5nxYA2ZjS8eKrWJDmThrbLI8xKSJ/E6PkfLu++byAxaL51q4ArOheCasG
 /fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qkrQNPdYjgzsGeZKliHj5m6aTSoldYZ7J5gDgev0N24=;
 b=TE5uV0IMM0YFT1QapCI+NAL5KznAjn3Hhw9Tv4YA9EGWBfHbZxDd5R0Jk5JW78wMYK
 DUatCOehwGqE7lObKaY1wCHXS1AsVYLbVPTy+tctVG2TdEeKu5vzLWcLQpw79NJ9HoyE
 ZctS/zRGU4gaetiWzkRUBTK6h6MaTaU1MZBqE+mRJhKSoxWWI0oyM2ZqRS8dZ4DqESKp
 pstUeJ/1+ZsoLPz9zbqGWrGFfkguYYKx7tZqsHV99TJz5B07zswIfTZcgPjYFRtfKJhC
 zm8YK3JcNIzeXTl1X5WF8Nx23wI/KAeVeoZCSX5BdidMk2/pulcxK4PP0BoIUFqjuHpw
 WsxQ==
X-Gm-Message-State: APjAAAUNT0YyjvO6p/YVElcTEmUcYqaxLGyVMbwtuY2Xj7hiwW3K7mUk
 efRqggtMuGxORTHLREDhRo/UnQ==
X-Google-Smtp-Source: APXvYqzuTnf5cIst5SxKKE73FKmBUyTpbFHj9yVF/X4PQBqdpGIEbl6z4AscSj+7Qixrvfvoi7JE+Q==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr3906066wmh.114.1568913022190; 
 Thu, 19 Sep 2019 10:10:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y12sm10697593wrn.74.2019.09.19.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D79F1FF96;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/16] tests/tcg: clean-up some comments after the
 de-tangling
Date: Thu, 19 Sep 2019 18:10:06 +0100
Message-Id: <20190919171015.12681-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These were missed in the recent de-tangling so have been updated to be
more actuate. I've also built up ARM_TESTS in a manner similar to
AARCH64_TESTS for better consistency.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/Makefile.target         |  7 +++++--
 tests/tcg/aarch64/Makefile.target |  3 ++-
 tests/tcg/arm/Makefile.target     | 15 ++++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8808beaf74b..679eb56bd37 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -74,8 +74,11 @@ TIMEOUT=15
 endif
 
 ifdef CONFIG_USER_ONLY
-# The order we include is important. We include multiarch, base arch
-# and finally arch if it's not the same as base arch.
+# The order we include is important. We include multiarch first and
+# then the target. If there are common tests shared between
+# sub-targets (e.g. ARM & AArch64) then it is up to
+# $(TARGET_NAME)/Makefile.target to include the common parent
+# architecture in its VPATH.
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index e763dd9da37..9758f89f905 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -8,7 +8,7 @@ VPATH 		+= $(ARM_SRC)
 AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
-# we don't build any other ARM test
+# Float-convert Tests
 AARCH64_TESTS=fcvt
 
 fcvt: LDFLAGS+=-lm
@@ -17,6 +17,7 @@ run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
+# Pauth Tests
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
 
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index aa4e4e3782c..7347d3d0adb 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,25 +8,26 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
-ARM_TESTS=hello-arm test-arm-iwmmxt
-
-TESTS += $(ARM_TESTS) fcvt
-
+# Basic Hello World
+ARM_TESTS = hello-arm
 hello-arm: CFLAGS+=-marm -ffreestanding
 hello-arm: LDFLAGS+=-nostdlib
 
+# IWMXT floating point extensions
+ARM_TESTS += test-arm-iwmmxt
 test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-ifeq ($(TARGET_NAME), arm)
+# Float-convert Tests
+ARM_TESTS += fcvt
 fcvt: LDFLAGS+=-lm
 # fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
-
 run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-endif
+
+TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
 EXTRA_RUNS+=run-test-mmap-4096
-- 
2.20.1


