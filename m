Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6055A222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhyjzEvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6055A222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYzQ-0000d8-MW
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcc-00080l-BG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYca-0006Zi-Iz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYca-0006XP-3E
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id a6so3883032wma.5
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qPbJ0Vyzpo4m5HrZGcWq1sJdvODZz8Jza37b7xYvbEE=;
 b=RhyjzEvfbSGzBrwVuOhC3bNsPYl04wD+efnOjC+UBr2r8ZBWrIRqFFOV2ry+HGZTbC
 fRJEwMA/IJFUYrKcG5lvIp394T/vIVhI0fMro6qHUUk+4gsz62kW5r66SdYOwOO+6609
 LXefKrnrcBqO4qHzwPmbjtPkFcBX/jeng4bHfoUMABzxnSo3zkKmjH5Zazj6uuylOYxU
 R8/IUxZpz3m292s/4ukpc51SgOmEiETjvrAkV8WfoQbekz1f7IgvlRdtlOYQ2UDuTyhe
 xQNutj+A3DEfC5fN6r7SBe6evyPHEo4WamYTI8oJnuETjps0xd77g9Q7q/J8bOm1IDqn
 f37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qPbJ0Vyzpo4m5HrZGcWq1sJdvODZz8Jza37b7xYvbEE=;
 b=ZLr1OuEMTbY+KmHRw0fp/AlRWn7Th/+6if+G2PhcGmUHrT5H47EW7u8uUrP8wv/+il
 ObsFjeMs1jO2KRM2HXd3ojVEoRNBDGe6pyqlDD/enEBRCom4IZNhWoqYJc4XzpQOREBq
 tiTGUhy5HNqD2NFg7l61Y5rUEFWL5f9whtr9KOR95T+ceobJgTyFyZ3KuCtdg9uakmsp
 HBcvYNvjhLxhk3ZmspYBTFCmsKahu9EluN0Xw2eZikb8HKFp8x0F0clqxI54/wKeik/G
 k1MLTdX3DSjSesBwHEL+0FEyUp7ede5Z0Z/Of9tEX5llgQEblTU4aSF2Uv3uklSRbViH
 Lh/Q==
X-Gm-Message-State: APjAAAU4IYUvsC7JkvrI0alYezvH5Fv6k4Tvz7LjJPHO1GwHyBzJtFUi
 6eUCeObPKDCmJ5dI48rkHB8Pfg==
X-Google-Smtp-Source: APXvYqzSRHyENBAgFfqMfVk7h4NMVzXExWAvCqXwMSDx3JJ34GjZ/hnLhQw4sIurl8sS/OH/Rvj4yA==
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr3873832wmm.37.1569522966349; 
 Thu, 26 Sep 2019 11:36:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h63sm5689480wmf.15.2019.09.26.11.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:36:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C0B51FF9E;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/28] tests/tcg: clean-up some comments after the de-tangling
Date: Thu, 26 Sep 2019 19:35:39 +0100
Message-Id: <20190926183553.13895-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These were missed in the recent de-tangling so have been updated to be
more actuate. I've also built up ARM_TESTS in a manner similar to
AARCH64_TESTS for better consistency.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8808beaf74..679eb56bd3 100644
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
index e763dd9da3..9758f89f90 100644
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
index aa4e4e3782..7347d3d0ad 100644
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


