Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E35C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CFB206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSFIrqYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CFB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrU9-0008ES-Jz
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPj-0004qk-RA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPi-0000JV-GJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPi-0000HN-78
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id x1so20467924wrr.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JaUAcLe7WApBUvZggWzDrAHFeYLwHQ7XG4Fw2HOaxGw=;
 b=RSFIrqYEdE0/yJtJEOEytzg/HWvurEB5+6/0P4Y7M8RjoE3E19CgVLQ2nHgxHF50Oa
 Yo8s9TAN5BYiLAAzdx1Yvsx5J7WrTNv6Hq7xsztPBX6cx3gAgMYFsQ1++CanGF52bQQJ
 FmM2Sp3YvcjsAlqJt6F5iMSSAf6/K+JbYiH7iSYnmwrSAu2TXyAZqCt8CLh33s/lnkNn
 IZ3rAofmjv2nga/Wh3IirCS9TMvvsH1VHOFQG1ZnXTYr2q3443rwLboWgft2eoUaSkZE
 3+B3Ah8cvE65Wxfs5NReXi+OyfgJItAIabF9puSzA4YcHIw2BWI2MpTQBZX3kq04Q5u/
 v0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JaUAcLe7WApBUvZggWzDrAHFeYLwHQ7XG4Fw2HOaxGw=;
 b=lQ9oYW8XFCvtz0rFI7d9DT+Yc+TtLwLeJA2TXHIMvInzAlCzHPbiO1OYCNyU4D3AtS
 BHp9ILEMQP845X+ySaCla6pFqW1rKMrkc+/ANopSkHnnLymKAEr7ZU960NkeAWoZKgHO
 2slSODEPQEYENgTAabCkMIEvspHlUVrlykm3xO1ZqMXvR3B1Ro7NTuV8AJrPbdsw9dXg
 OedPQFlfDc6i1CtPbnFdHBy/VtEUi0tEyhFvnikdYIzE5aw9P5sRctmWMxYe17O+wqVp
 /avkyCEcfBpu0RsltrZWgj3rZfQqZbHm6mz0nzQQ8UxXq6LSsSRHaeTnvsiIHaoL+DlQ
 ncSA==
X-Gm-Message-State: APjAAAUDOHRkDOf212Iyv6P+pyNdvlQflP2FsZHoEIiT1vdot+IJyfAN
 DPTDYO7+04j1/qGp+sSVFKWMyg==
X-Google-Smtp-Source: APXvYqz3/YHQEZOTMAcbkA3Lf+i3exv17hiPoKmTxaxo6s+QWNg4ka/DQKghtk3X6i7WtFJBaDLD5Q==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr59384191wrp.102.1564590316038; 
 Wed, 31 Jul 2019 09:25:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d10sm57418559wrx.34.2019.07.31.09.25.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D022B1FFC5;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:12 +0100
Message-Id: <20190731160719.11396-48-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v4 47/54] tests/tcg: enable plugin testing
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
---
 tests/Makefile.include                | 10 +++++++-
 tests/tcg/Makefile                    | 34 +++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.softmmu-target |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb86586..0611aede077 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1052,6 +1052,14 @@ check-softfloat:
 		"SKIPPED for non-TCG builds")
 endif
 
+# Plugins
+ifeq ($(CONFIG_PLUGIN),y)
+plugins:
+	$(call quiet-command,\
+		$(MAKE) $(SUBDIR_MAKEFLAGS) -C tests/plugin V="$(V)", \
+		"BUILD", "plugins")
+endif
+
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -1066,7 +1074,7 @@ $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
 endif
 
-build-tcg-tests-%:
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
 		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
 		"BUILD", "TCG tests for $*")
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 9f567686240..8341a5345bc 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -120,11 +120,37 @@ all: $(TESTS)
 #
 
 RUN_TESTS=$(patsubst %,run-%, $(TESTS))
+
+# If plugins exist also include those in the tests
+ifeq ($(CONFIG_PLUGIN),y)
+PLUGIN_DIR=../../tests/plugin
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
+		 $(call strip-plugin,$<), \
+	"$< on $(TARGET_NAME)")
 else
 run-%: %
 	$(call run-test, $<, \
@@ -132,6 +158,14 @@ run-%: %
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
 	   	  $(QEMU_OPTS) $<, \
 	  "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
+	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
+	  "$< on $(TARGET_NAME)")
 endif
 
 gdb-%: %
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 49d48d8a1c3..cd628306b3e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -25,5 +25,6 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-plugin-test-armv6m-undef-%: QEMU_OPTS+=-semihosting -M microbit -kernel
 
 endif
-- 
2.20.1


