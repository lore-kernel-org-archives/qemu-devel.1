Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D3C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3447C206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txh+1q5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3447C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWjC-0007Fv-BW
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33184 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWZk-0007Pv-93
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:35:05 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQWZj-0000PL-Kz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:35:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42199)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQWZj-0000Ls-0C
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:35:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id j2so12165452wrs.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t5aCOcvr56XHS9qZa9KjXvG7frU1XUx0WSgEKCSykPw=;
 b=Txh+1q5y0xEa3jIbOpuCP7C4St3cxe2BD5svaKLjQaJLuR0yJCJa+8fXPkv5W5PNaC
 LgMUOCMenq5bHy/fKX3AhWEhV1IUctaprhyRooJyj6p34fi1QXKxFc+mN9asJggLmeXp
 tD2f5SCj9c3rIQVRu+8ApW42esfvHNKBOFCAM6/YZf7LaVMf8t1TH4SacEBLUnYaFeRC
 YRmaB1Gg1fa9eHuo7rO5Z6SlMsx634vhEzANngoekwJFCORcV+Cka6VvoNqHHzSpnBHS
 L+/xlgzDd7rOG0ODUUhPUx5+EqDM1nUJO6v6BvTCgtRZBvozh3Ig2Hla0qYM9JVXnUjk
 1+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t5aCOcvr56XHS9qZa9KjXvG7frU1XUx0WSgEKCSykPw=;
 b=YUZjNS5zsl6DiZKryZ/czvdMj9eicztaqjSn8TT4qUYafRsWjQOPud4/SLeenV+vwd
 5SzjdnySq9n6Kw7CXbtR6q0yXbQ+Geh9K/4s2aeuIeH34td8LvY0PhpflBfhhRSSqN2I
 hwJyNRE6ccEbSh4fGLXYUJUfqlufSS+l+8haV24XqqfOMPl372k3YXMgUmz1lVSOEsDw
 en7unWI8JzqX6pfXnnaa2M5EVjhuTDBexNBTT5FGXqFkdBXmZ6tErHQczSSGeuN8sAVb
 HWl//SDNGd8MldhQkzsxJy482IKyiqSECaVPDHYQbfd8JB4kzymHZr/IzNBC29XX/Sm6
 P8vA==
X-Gm-Message-State: AGi0PuYtUA7cMnHg8qC02q93awgWuz8jdZ8WQrVq+Q/w5iC+eW8Ez4Kz
 VM2Ox3zoD72VHm/uQp4cBKBRbg==
X-Google-Smtp-Source: APiQypKK0BQ5OLTRNKUfU+6f+lrFhpkgqEDAdPNntGut9qLLRXZ1VKw/lZZAzfScWECC6+yIv+acvw==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr18468026wrg.70.1587389701466; 
 Mon, 20 Apr 2020 06:35:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j4sm1161155wrm.85.2020.04.20.06.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 06:35:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F14481FF7E;
 Mon, 20 Apr 2020 14:34:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg: use EXTRA_RUNS to run gdbtests
Date: Mon, 20 Apr 2020 14:34:55 +0100
Message-Id: <20200420133455.25401-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::430
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, richard.henderson@linaro.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With --enable-plugins the gdb tests confuse things somewhat as the
plugin code attempts to enumerate tests with non-existent binaries.
Fortunately we already have a mechanism for these extra tests that
don't automatically include their own binaries. Use that mechanism and
drop the unneeded .PHONY declarations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target   | 5 ++---
 tests/tcg/cris/Makefile.target      | 1 +
 tests/tcg/multiarch/Makefile.target | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index d99b2a9eced..312f36cde5f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -54,9 +54,6 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-AARCH64_TESTS += gdbstub-sysregs gdbstub-sve-ioctls
-
-.PHONY: gdbstub-sysregs gdbstub-sve-ioctls
 run-gdbstub-sysregs: sysregs
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
@@ -70,6 +67,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	"basic gdbstub SVE ZLEN support")
+
+EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
 endif
 
 endif
diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
index 24c7f2e7616..e72d3cbdb23 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -23,6 +23,7 @@ CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
 
 # override the list of tests, as we can't build the multiarch tests
 TESTS = $(CRIS_USABLE_TESTS)
+EXTRA_RUNS =
 VPATH = $(CRIS_SRC)
 
 AS	= $(CC) -x assembler-with-cpp
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 47fd675aba5..51fb75ecfdd 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -45,15 +45,14 @@ run-test-mmap-%: test-mmap
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-MULTIARCH_TESTS += gdbstub-sha1
-
-.PHONY: gdbstub-sha1
 run-gdbstub-sha1: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
 	"basic gdbstub support")
+
+EXTRA_RUNS += run-gdbstub-sha1
 endif
 
 
-- 
2.20.1


