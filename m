Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF8EC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB0E2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8QxSurd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB0E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEVT-0003lb-U7
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERL-0006R3-LY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERI-0003D8-DR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUERH-0003Cf-T7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id d15so8437933wrx.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=67oQwpEs2PvLm/27/7hAV2hnOAJBQY7TkPiq2zfh6Fw=;
 b=S8QxSurdO7IyfpJsdMm3hepzgUi8sYTZdEzzWBJeUUvIQEaAsMS0VVUfHH0BfdpQDg
 XP1nAAOB3Ux/bZJf038+7INrQFwhVbfKfPF01cwtbWeKq4H8lq2gkaYQJb7fx6Mig395
 apvWtPb3MqG8kmnCbsnEsuyO0p9ma5TgNR3h/2+MpJk3tn6YLQ7BaSgswlFzyuIycB0v
 Zo5tUhM3gbUvqtXEOx8jfRi+/kRVjmN/+Efk6yKgW1tvHb/oXlfgSymT8rTsnGqB826s
 dpbiTE9O/OfNu+y6kL8qgz5WsEJHrZAOsfqVamN4AeY3scifkhieyA42W+RF/4wgDRuo
 0K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=67oQwpEs2PvLm/27/7hAV2hnOAJBQY7TkPiq2zfh6Fw=;
 b=Jts6Tz56UG47tuv91iIyMSZbP5o7VbJJdtN0Com7RuUSAdzsSsoYEDBkkoLLxnMn2C
 gsIetx8wIR2AZKf1YWin4nURiEDTHJpa7ZM9EKGFidnQ7zoj0XJLgZ9V2GNT9wJO6a+J
 dw8ziMEd+esUPTYLDMd0K67LW/esaYTSMKG8O8KPlI5NHDalp73mtMooVsNFTCFGKV2h
 xRD1QL6A9ZWQ34mzGehjM3FSkyZ17CIkZdQ51c3yLPoPfkHCcTV9AbIa6WcvNybzJ7JA
 wWOx/dxbfYxITzy4kLMX+7NIK5Hl/wc4W7ZKG/rIqCu/kXnKh4Hyr+J5h4HGUIyYsrka
 dK/g==
X-Gm-Message-State: AGi0PuZ73BatkJ4BVTWSTmDx2ekEGrjtFgDFhpSFB27oXwvkbKEBuO+N
 /quJaErePrYrh2cpA4ZyuaQhLQ==
X-Google-Smtp-Source: APiQypL6pJlC02ZJa/rwEdW9B/GzEJDuCcJEwxfBkf4MuH9pdFwmSBe8IwtswKiyUov2OkApW9FiYg==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr16315wrj.114.1588273298361;
 Thu, 30 Apr 2020 12:01:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm901426wru.68.2020.04.30.12.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 61F981FF96;
 Thu, 30 Apr 2020 20:01:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 8/9] tests/tcg: add a multiarch linux-user gdb test
Date: Thu, 30 Apr 2020 20:01:21 +0100
Message-Id: <20200430190122.4592-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the gdbstub code was converted to the new API we missed a few
snafus in the various guests. Add a simple gdb test script which can
be used on all our linux-user guests to check for obvious failures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use EXTRA_RUNS to queue the tests so as not to break plugins
---
 tests/tcg/aarch64/Makefile.target   |  5 +-
 tests/tcg/cris/Makefile.target      |  1 +
 tests/tcg/multiarch/Makefile.target | 14 +++++
 tests/tcg/multiarch/gdbstub/sha1.py | 81 +++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index d99b2a9ece..312f36cde5 100644
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
index 24c7f2e761..e72d3cbdb2 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -23,6 +23,7 @@ CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
 
 # override the list of tests, as we can't build the multiarch tests
 TESTS = $(CRIS_USABLE_TESTS)
+EXTRA_RUNS =
 VPATH = $(CRIS_SRC)
 
 AS	= $(CC) -x assembler-with-cpp
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 035b09c853..51fb75ecfd 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,5 +42,19 @@ run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
 
+ifneq ($(HAVE_GDB_BIN),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+run-gdbstub-sha1: sha1
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
+	"basic gdbstub support")
+
+EXTRA_RUNS += run-gdbstub-sha1
+endif
+
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
new file mode 100644
index 0000000000..734553b98b
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -0,0 +1,81 @@
+from __future__ import print_function
+#
+# A very simple smoke test for debugging the SHA1 userspace test on
+# each target.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+import sys
+
+initial_vlen = 0
+failcount = 0
+
+def report(cond, msg):
+    "Report success/fail of test"
+    if cond:
+        print("PASS: %s" % (msg))
+    else:
+        print("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+def check_break(sym_name):
+    "Setup breakpoint, continue and check we stopped."
+    sym, ok = gdb.lookup_symbol(sym_name)
+    bp = gdb.Breakpoint(sym_name)
+
+    gdb.execute("c")
+
+    # hopefully we came back
+    end_pc = gdb.parse_and_eval('$pc')
+    report(bp.hit_count == 1,
+           "break @ %s (%s %d hits)" % (end_pc, sym.value(), bp.hit_count))
+
+    bp.delete()
+
+def run_test():
+    "Run through the tests one by one"
+
+    check_break("SHA1Init")
+
+    # check step and inspect values
+    gdb.execute("next")
+    val_ctx = gdb.parse_and_eval("context->state[0]")
+    exp_ctx = 0x67452301
+    report(int(val_ctx) == exp_ctx, "context->state[0] == %x" % exp_ctx);
+
+    gdb.execute("next")
+    val_ctx = gdb.parse_and_eval("context->state[1]")
+    exp_ctx = 0xEFCDAB89
+    report(int(val_ctx) == exp_ctx, "context->state[1] == %x" % exp_ctx);
+
+    # finally check we don't barf inspecting registers
+    gdb.execute("info registers")
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    print("ATTACHED: %s" % arch.name())
+except (gdb.error, AttributeError):
+    print("SKIPPING (not connected)", file=sys.stderr)
+    exit(0)
+
+try:
+    # These are not very useful in scripts
+    gdb.execute("set pagination off")
+    gdb.execute("set confirm off")
+
+    # Run the actual tests
+    run_test()
+except (gdb.error):
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+    pass
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
-- 
2.20.1


