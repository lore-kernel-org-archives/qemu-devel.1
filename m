Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5562A21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3qhAO3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5562A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuNO-0001R7-FK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpt-0004Vh-OX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtps-00078I-9J
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtps-00077q-2d
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id c22so865963wmd.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kHDw5giSQUpa5TavdPwJmtfXF3VzRIg0gye452+mQFA=;
 b=n3qhAO3kwLwn+fuVou4I4zvxlFjgYpq5U8GrQ8VznxWHN7kbhSrbm8I/IGcj0qxUH2
 9cMkCa3SzI12UABnNvb1eigaJ/T48+MwxeHZ4TygRbdst3HXmWJ2LQg3XslHdEKvQBzR
 03DlGt+E6rpIWwL6q2BYhTqZq/lBUGn46FTW8ia7y+oJ2YZQWjRqthOsgMc5uoGjQJKa
 J1vT2kj39PSLZIflWi/eGTKLzgOcri53dgugNBoEVRHbdR0pdUYsbYe4oxaRESHojxpD
 rm850s9fmoqylPL/dzJ14gGEpdPAc8C5tubvaJsLtBCmrmmw22bY9xdojiGZilYMLXAU
 Fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kHDw5giSQUpa5TavdPwJmtfXF3VzRIg0gye452+mQFA=;
 b=f5UodWGWyXEuJQqh84NwFhRPa4cOSXUnGEUBClidPdtK09kDkn5i2fa9PjfVNOluy+
 JqKzH1ExSStaSlxZgsK/FT/qylTUO0YlXhmO8rLHnGQPpp37VNOFxpPhYFKQ3IHknG0n
 u8s3yN+LGmTHAXtLfRYKCX49CQzKyWfg2TA19fYXcMNx8IlFgC7hnMtFsT6Jw/pN7jvy
 UvS69fW+ycuQt6VZ3kR/P72ga8KkPS8psQGGYjZWiFaj2HM1TS1nTjKzytarBPr2KFD8
 1frrbAAn2bLvT93+LMD7l9VJMstS4nc0tWap7FzPEwsTIPZej9CtVBR7fAN5hVhhmxw/
 cJNA==
X-Gm-Message-State: APjAAAXlCgO5NZ9i1msEuKMjWdY0zeX9pG85RvfSzfPs9RQ1cpE+tLhs
 FLwTSost3E24NqOaORrHnHB1UQ==
X-Google-Smtp-Source: APXvYqxOOfyKHYtZWpkh7qPbfj5PIOpB/3ZikbAGxWt+Z2FAHAiW0ZyCHFBGouvo41jM47ogm0pHAw==
X-Received: by 2002:a1c:2c88:: with SMTP id s130mr2133109wms.66.1571987794791; 
 Fri, 25 Oct 2019 00:16:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a2sm1430092wrv.39.2019.10.25.00.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C10081FFD5;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 64/73] tests/tcg: enable plugin testing
Date: Fri, 25 Oct 2019 07:37:04 +0100
Message-Id: <20191025063713.23374-65-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If CONFIG_PLUGINS is enabled then lets enable testing for all our TCG
targets. This is a simple smoke test that ensure we don't crash or
otherwise barf out by running each plugin against each test.

There is a minor knock on effect for additional runners which need
specialised QEMU_OPTS which will also need to declare a plugin version
of the runner. If this gets onerous we might need to add another
helper.

Checking the results of the plugins is left for a later exercise.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 09e5b410dca..a2c4c56dbe4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1060,6 +1060,15 @@ check-softfloat:
 		"SKIPPED for non-TCG builds")
 endif
 
+# Plugins
+ifeq ($(CONFIG_PLUGIN),y)
+.PHONY: plugins
+plugins:
+	$(call quiet-command,\
+		$(MAKE) $(SUBDIR_MAKEFLAGS) -C tests/plugin V="$(V)", \
+		"BUILD", "plugins")
+endif
+
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -1070,7 +1079,7 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 
-build-tcg-tests-%:
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 96646130020..3c7421a356e 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -123,11 +123,39 @@ all: $(TESTS) $(EXTRA_TESTS)
 #
 
 RUN_TESTS=$(patsubst %,run-%, $(TESTS))
+
+# If plugins exist also include those in the tests
+ifeq ($(CONFIG_PLUGIN),y)
+PLUGIN_DIR=../../plugin
+VPATH+=$(PLUGIN_DIR)
+PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
+
+# We need to ensure expand the run-plugin-TEST-with-PLUGIN
+# pre-requistes manually here as we can't use stems to handle it. We
+# also add some special helpers the run-plugin- rules can use bellow.
+
+$(foreach p,$(PLUGINS), \
+	$(foreach t,$(TESTS),\
+		$(eval run-plugin-$(t)-with-$(p): $t $p) \
+		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
+		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
+endif
+
+strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
+extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
+
 RUN_TESTS+=$(EXTRA_RUNS)
 
 ifdef CONFIG_USER_ONLY
 run-%: %
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		-d plugin -D $*.pout \
+		 $(call strip-plugin,$<), \
+	"$* on $(TARGET_NAME)")
 else
 run-%: %
 	$(call run-test, $<, \
@@ -135,6 +163,15 @@ run-%: %
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
 	   	  $(QEMU_OPTS) $<, \
 	  "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
+	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	    	  -d plugin -D $*.pout \
+	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
+	  "$* on $(TARGET_NAME)")
 endif
 
 gdb-%: %
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 509f1afa93d..96d2321045a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -26,4 +26,10 @@ AARCH64_TESTS += semihosting
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+run-plugin-semihosting-with-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		 $(call strip-plugin,$<) 2> $<.err, \
+		"$< on $(TARGET_NAME) with $*")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 231e9a57b48..3fe237ba391 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -23,3 +23,4 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-plugin-test-armv6m-undef-%: QEMU_OPTS+=-semihosting -M microbit -kernel
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 3ddff852404..0765f37ff04 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -34,6 +34,12 @@ ARM_TESTS += semihosting
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+run-plugin-semihosting-with-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		 $(call strip-plugin,$<) 2> $<.err, \
+		"$< on $(TARGET_NAME) with $*")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1


