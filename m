Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5047420863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPcgI7J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5047420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7byt-0002H5-UB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkn-0003Q8-Tg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkl-0006Lg-9Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkl-0006L3-1C
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id t16so18373920wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RTgrDOX3GQcsRTevkPr9bJYB3sELKwKwlcNOxCXwEks=;
 b=SPcgI7J7RzaIQ8XKRNezOqC5IbVyr+B66yQXNZOFImAaZI2jyWJs+RKMQiEF34YO48
 l0WMZBF2gHvOkhpuBaKnkgiu6ycICYHhLR3GsdT7baAbswd9AM1sH8qF5u1+zxrGIAqT
 gW3HMekW89oDznYInEAe9RMNqogWh+/jDoFb2iMmtaun7qKswCrhFf8zEnMofj8L5Mo7
 LpfRKSGH0iVYD4jUCUyLvj/OSnjuTNQN4oka28j9BagJlb+JrXb6xowZX/UIdbnKnaEP
 nciQZVG5qHc+eGgOV8k71NzduytzhGMmoFmUZjPD81e/uzFZ651zmJ1hR3ddt3RmnmCI
 1WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RTgrDOX3GQcsRTevkPr9bJYB3sELKwKwlcNOxCXwEks=;
 b=UkX48IgOqiw8h4EzSsQjqmmcDd6X2d5Cg7efrADag0T7Qki+lCrvDXmHUoQRTb7k8w
 VeLZPfwYFi4fqHSOkuphy4bXfBJqNeNw72n0GWOkuRUaQltIqJ00d2L9bSUiaQPugH81
 7i+bFP+5yRPSjnBgvVrCQGszlPOVgc0aO8kRO6dUkaIn752CWMJRazp/CZItMPVkTNVl
 mkaSYU6UQD0ukji4ej1cDp9IGkqgnkrquJ6AKBtfcuH8oRqoTU4gvU9oa3SO4WU0hjl5
 ev2QJMFRmIgEtDolLSACzU2lTNoT8a7AiMOBc+T11LcNMenHm8070HcGc/ctpubzB+cU
 58MA==
X-Gm-Message-State: APjAAAUciv10R8huuPvA8vf/e708M253r8/J2OeIhxyOqEM0RIiA0HWP
 jOKNK3oNPPAD2Cm69innZcJsRQ==
X-Google-Smtp-Source: APXvYqzYe3Q8XVESMtY4Fm/wyNZpDJy4HUgk7CoAXdldXUq2HOiYBCFSTeNPftCWdxwOvt6pNQpZ4g==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr26564512wru.51.1568105037714; 
 Tue, 10 Sep 2019 01:43:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm16450494wrm.38.2019.09.10.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E80E1FF98;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:12 +0100
Message-Id: <20190910084349.28817-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 08/45] tests/tcg: cleanup Makefile inclusions
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Rename Makefile.probe to Makefile.prereqs and make it actually
define rules for the tests.

Rename Makefile to Makefile.target, since it is not a toplevel
makefile.

Rename Makefile.include to Makefile.qemu and disentangle it
from the QEMU Makefile.target, so that it is invoked recursively
by tests/Makefile.include.  Tests are now placed in
tests/tcg/$(TARGET).

Drop the usage of TARGET_BASE_ARCH, which is ignored by everything except
x86_64 and aarch64.  Fix x86 tests by using -cpu max and, while
at it, standardize on QEMU_OPTS for aarch64 tests too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190807143523.15917-3-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile.target b/Makefile.target
index 933b27453a1..5e916230c43 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -39,9 +39,6 @@ endif
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
-# Makefile Tests
-include $(SRC_PATH)/tests/tcg/Makefile.include
-
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f5ac09549ca..8400656b9d3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1062,23 +1062,28 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
-	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
-	$(if $(DOCKER_PREREQ), 					\
-		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 endif
 
 build-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
-		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) \
+	       	V="$(V)" TARGET_DIR="$*/" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
-run-tcg-tests-%: % build-tcg-tests-%
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
-		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" run-guest-tests, \
+run-tcg-tests-%: build-tcg-tests-% %/all
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
+		V="$(V)" TARGET_DIR="$*/" run-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 clean-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) TARGET_DIR="$*/" clean-guest-tests, \
+		"RUN", "TCG tests for $*")
 
 .PHONY: build-tcg
 build-tcg: $(BUILD_TCG_TARGET_RULES)
diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.prereqs
similarity index 92%
rename from tests/tcg/Makefile.probe
rename to tests/tcg/Makefile.prereqs
index 9dc654663d6..53b01962e1d 100644
--- a/tests/tcg/Makefile.probe
+++ b/tests/tcg/Makefile.prereqs
@@ -8,20 +8,19 @@
 # each target.
 
 # First we need the target makefile which tells us the target architecture
+CROSS_CC_GUEST:=
 -include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
 
 # Then we load up the target architecture makefiles which tell us
 # about the compilers
-CROSS_CC_GUEST:=
 DOCKER_IMAGE:=
-DOCKER_PREREQ:=
 
 -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
 
 ifndef CROSS_CC_GUEST
 ifneq ($(DOCKER_IMAGE),)
-DOCKER_PREREQ:=docker-image-$(DOCKER_IMAGE)
+build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
 endif
 endif
 
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.qemu
similarity index 52%
rename from tests/tcg/Makefile.include
rename to tests/tcg/Makefile.qemu
index 210f8428237..7eff11d434e 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.qemu
@@ -2,20 +2,23 @@
 #
 # TCG tests (per-target rules)
 #
-# This Makefile fragment is included from the per-target
-# Makefile.target so will be invoked for each linux-user program we
-# build. We have two options for compiling, either using a configured
-# guest compiler or calling one of our docker images to do it for us.
+# This Makefile fragment is included from the build-tcg target, once
+# for each target we build. We have two options for compiling, either
+# using a configured guest compiler or calling one of our docker images
+# to do it for us.
 #
 
 # The per ARCH makefile, if it exists, holds extra information about
 # useful docker images or alternative compiler flags.
 
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+include $(TARGET_DIR)config-target.mak
+include $(SRC_PATH)/rules.mak
+include $(wildcard \
+	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
+	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
 
 GUEST_BUILD=
-TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
+TCG_MAKE=../Makefile.target
 # Support installed Cross Compilers
 
 ifdef CROSS_CC_GUEST
@@ -23,9 +26,9 @@ ifdef CROSS_CC_GUEST
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
 	$(call quiet-command, \
-	   (mkdir -p tests && cd tests && \
-	    $(MAKE) -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
-			BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
+	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
+	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC="$(CROSS_CC_GUEST)" \
+			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
 			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
 	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
 
@@ -39,20 +42,20 @@ ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
 # We also need the Docker make rules to depend on
+SKIP_DOCKER_BUILD=1
 include $(SRC_PATH)/tests/docker/Makefile.include
 
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc \
 		--cc $(DOCKER_CROSS_COMPILER) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
-DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
 
 .PHONY: docker-build-guest-tests
-docker-build-guest-tests: $(DOCKER_PREREQ)
+docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	$(call quiet-command, \
-	  (mkdir -p tests && cd tests && \
-	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
-			BUILD_STATIC=y \
+	  (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
+	   $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC=$(DOCKER_COMPILE_CMD) \
+			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
 			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
 	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
 
@@ -62,27 +65,32 @@ endif
 endif
 
 # Final targets
+all:
+	@echo "Do not invoke this Makefile directly"; exit 1
+
 .PHONY: guest-tests
 
 ifneq ($(GUEST_BUILD),)
 guest-tests: $(GUEST_BUILD)
 
-run-guest-tests: guest-tests qemu-$(subst y,system-,$(CONFIG_SOFTMMU))$(TARGET_NAME)
+run-guest-tests: guest-tests
 	$(call quiet-command, \
-	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=$(SPEED) run), \
+	(cd tests/tcg/$(TARGET_DIR) && \
+	 $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" \
+	 		SRC_PATH="$(SRC_PATH)" SPEED=$(SPEED) run), \
 	"RUN", "tests for $(TARGET_NAME)")
 
 else
 guest-tests:
 	$(call quiet-command, /bin/true, "BUILD", \
-		"$(TARGET_NAME) guest-tests SKIPPED")
+		"$(TARGET_DIR) guest-tests SKIPPED")
 
 run-guest-tests:
 	$(call quiet-command, /bin/true, "RUN", \
-		"tests for $(TARGET_NAME) SKIPPED")
+		"tests for $(TARGET_DIR) SKIPPED")
 endif
 
 # It doesn't matter if these don't exits
 .PHONY: clean-guest-tests
 clean-guest-tests:
-	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
+	rm -rf tests/tcg/$(TARGET_DIR)
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile.target
similarity index 92%
rename from tests/tcg/Makefile
rename to tests/tcg/Makefile.target
index 9f567686240..8dbcba4474f 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile.target
@@ -29,8 +29,9 @@
 # We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
 #
 
+all:
 -include ../../config-host.mak
--include ../config-target.mak
+-include ../../../$(TARGET_DIR)/config-target.mak
 
 # for including , in command strings
 COMMA := ,
@@ -64,9 +65,9 @@ LDFLAGS=
 
 # The QEMU for this TARGET
 ifdef CONFIG_USER_ONLY
-QEMU=../qemu-$(TARGET_NAME)
+QEMU=../../../$(TARGET_DIR)/qemu-$(TARGET_NAME)
 else
-QEMU=../qemu-system-$(TARGET_NAME)
+QEMU=../../../$(TARGET_DIR)/qemu-system-$(TARGET_NAME)
 endif
 QEMU_OPTS=
 
@@ -82,10 +83,7 @@ ifdef CONFIG_USER_ONLY
 # The order we include is important. We include multiarch, base arch
 # and finally arch if it's not the same as base arch.
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
-ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-endif
 
 # Add the common build options
 CFLAGS+=-Wall -O0 -g -fno-strict-aliasing
@@ -101,10 +99,7 @@ else
 # are expected to provide their own build recipes.
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.softmmu-target
-ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
-endif
 
 endif
 
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 31ba9cfcaa1..e763dd9da37 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -2,12 +2,14 @@
 #
 # AArch64 specific tweaks
 
+ARM_SRC=$(SRC_PATH)/tests/tcg/arm
+VPATH 		+= $(ARM_SRC)
+
 AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
-# we don't build any of the ARM tests
-AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
-AARCH64_TESTS+=fcvt
+# we don't build any other ARM test
+AARCH64_TESTS=fcvt
 
 fcvt: LDFLAGS+=-lm
 
@@ -16,6 +18,6 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 AARCH64_TESTS += pauth-1 pauth-2
-run-pauth-%: QEMU += -cpu max
+run-pauth-%: QEMU_OPTS += -cpu max
 
-TESTS:=$(AARCH64_TESTS)
+TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 2deb06e6e46..231e9a57b48 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -3,8 +3,6 @@
 # ARM SoftMMU tests - included from tests/tcg/Makefile
 #
 
-ifeq ($(TARGET_ABI_DIR),arm)
-
 ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 
 # Set search path for all sources
@@ -25,5 +23,3 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
-
-endif
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index cee342017e5..1c8790eecd2 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -12,17 +12,9 @@ X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-ifeq ($(TARGET_X86_64), y)
-CRT_PATH=$(X64_SYSTEM_SRC)
-CFLAGS=-march=x86-64
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-else
 CRT_PATH=$(I386_SYSTEM_SRC)
-CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index d0eb7023e52..08c5736a4d4 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -6,14 +6,11 @@ I386_SRC=$(SRC_PATH)/tests/tcg/i386
 VPATH 		+= $(I386_SRC)
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
-I386_TESTS=$(I386_SRCS:.c=)
-I386_ONLY_TESTS=$(filter-out test-i386-ssse3, $(I386_TESTS))
+ALL_X86_TESTS=$(I386_SRCS:.c=)
+I386_TESTS:=$(filter-out test-i386-ssse3, $(ALL_X86_TESTS))
+X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 # Update TESTS
-TESTS+=$(I386_ONLY_TESTS)
-
-ifneq ($(TARGET_NAME),x86_64)
-CFLAGS+=-m32
-endif
+TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
 
 #
 # hello-i386 is a barebones app
@@ -26,7 +23,7 @@ hello-i386: LDFLAGS+=-nostdlib
 #
 
 test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	$(CC) $(CFLAGS) $(LDFLAGS) $(EXTRA_CFLAGS) -o $@ \
 	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
 
 ifeq ($(SPEED), slow)
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
new file mode 100644
index 00000000000..df252e761cd
--- /dev/null
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -0,0 +1,36 @@
+#
+# x86 system tests
+#
+# This currently builds only for i386. The common C code is built
+# with standard compiler flags however so we can support both by
+# adding additional boot files for x86_64.
+#
+
+I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
+X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+
+# These objects provide the basic boot code and helper functions for all tests
+CRT_OBJS=boot.o
+
+CRT_PATH=$(X64_SYSTEM_SRC)
+LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
+LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
+CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+
+TESTS+=$(MULTIARCH_TESTS)
+
+# building head blobs
+.PRECIOUS: $(CRT_OBJS)
+
+%.o: $(CRT_PATH)/%.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
+# Build and link the tests
+%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+memory: CFLAGS+=-DCHECK_UNALIGNED=1
+
+# Running
+QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 74f170b9ede..20bf96202ad 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -6,9 +6,10 @@
 # $(SRC)/tests/tcg/i386/
 #
 
-X86_64_TESTS=$(filter-out $(I386_ONLY_TESTS), $(TESTS))
-X86_64_TESTS+=test-x86_64
-TESTS:=$(X86_64_TESTS)
+include $(SRC_PATH)/tests/tcg/i386/Makefile.target
+
+TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
+QEMU_OPTS += -cpu max
 
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-- 
2.20.1


