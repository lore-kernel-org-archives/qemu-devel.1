Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5CC4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD78920640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EU1qUetO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD78920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nOD-0001Cp-5f
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLW-0007cF-7R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLU-0000JD-Uy
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLU-0000IZ-OU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id q18so3189309wmq.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qkrQNPdYjgzsGeZKliHj5m6aTSoldYZ7J5gDgev0N24=;
 b=EU1qUetOU0pLY8bfY2VPwp6pm7Duz9HzhCyXxdYas1bRV4WwdsLbAlkzCDzUvFNNXa
 t1XdwPw+9QgI8EpWESEW02kCCIh6STzT7M/0dJ3snbd9jB8OX0CnQTWsXu6cYOvN23Zt
 ZV0Iue4n7kSkaM30xrNzHPHn320p4cxGpg4F0bhwVRwjVHlZayGx4oZ7MXQoa9E4IXeK
 hdbHA9ke6864qcA27QKY0SMNNeMox65EshHLW0dVxLRlkfWVHkag2ZykJ4uyLAnqNVMh
 P+LfcG+5i7kw6j44Okh4ixCoGVcV4NJMBBsKhEVy7B2M35cM6DRzLzNi3/KqExGIpPa0
 Jv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qkrQNPdYjgzsGeZKliHj5m6aTSoldYZ7J5gDgev0N24=;
 b=hCwUYNwyjuarV4+droNzLSjJx4BZC36Ru9s3dIYdt141V7pbKLnk4h4m/h53ficedY
 mzAFF+PdGUPiFqYDa7MTs1ddfA49utXUWyBtN+tXP9baCSvriqxWsAyGK1e8k6AMeKtH
 Q2r7Or3QWPoEh5QTaTNc1azQWVS2cBq07vfRM1QORoju4uvLW2L7ZRbU2EkSJqAdJu73
 UjtX4DQuVIFDd9+gUirKn1x26DKV30q/arbV3rzdFQb7ZMUL9NXHSkl3iqEr9GmYcDfz
 54IHRn7SCUcvN4gnlsR/euTs4vEUY1gCK4Pj06zoqyxPXvHjbtiXq+K+3Pj4dvkPpem2
 s+9w==
X-Gm-Message-State: APjAAAUnvHhKhfOlhITiYHDXv2s1QOiAhyHqllhccHNUf6uLRJijb9Zi
 zAUcoGcZ19p/OsteClHH+khu3w==
X-Google-Smtp-Source: APXvYqzLEzYYSCt7zh5+odjfnwIE1KnIWwRED+WSrx/N1qUUh/XeaKYy46rtXvfgH0Jzutc9ejC51A==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr3831855wmg.25.1568387927507;
 Fri, 13 Sep 2019 08:18:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r18sm32090869wrx.36.2019.09.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86ABB1FF8C;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:40 +0100
Message-Id: <20190913151845.12582-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 1/6] tests/tcg: clean-up some comments after
 the de-tangling
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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


