Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E07C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56A52467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emYzfYx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56A52467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irO94-00067l-AV
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy4-00008n-K3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy3-0008I1-7l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNy3-0008Gw-1X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so14183226wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RS8nsqaOjTUj87+40p6EqU+Bu6aWQBCN9gEX2YyFJYE=;
 b=emYzfYx1qwLcpZDbe525DuLuOB+WHytphlRLtN8uyca0lSjjLDPNM0hOxTMtdYioQi
 embBcDoahMzv8lY/iSNPoh91tljlVog6kj2155i35lms89eADr9HHxy2LAycLLnnjQe1
 YUQ8L9vJvnjwrf4wKxTtoYyyxauB3Mp+3jtAztV64Ez4v2ejWka9uMkn6twlp2htgRXi
 BHmZVZZb0YM+8XaF3PbPVwjj5C9vT8HoB+d9IuhY3cVYfYpw4eyHTcjapqRnUXG40eZA
 cy4KrUQtp+j7YyTokBbV02RElVsQ4r8J2OtRVQsUDmYYuQB6I3d8h2qvRFCrjTyC9JtB
 9BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RS8nsqaOjTUj87+40p6EqU+Bu6aWQBCN9gEX2YyFJYE=;
 b=CLiIj4TQKOPRm+L+oB7hbVqmRWMdXEZHQb4Go2n7RFjQER8z2XlNXEZy0LJyzGWHXl
 gTOg07xJ5vieQ59p0XTv5Ua3yi0Nr6LothzeVLNWDgk1y/H1IoSE7zICZpaSyXPXG1Pe
 pqRBYuHh0wff0sjfpZ6j8ZrjySF50CTpQiSpyEogVmxu0xx4nR3CynPpGRUF0s72j5kM
 dFGFnG8U89N6Ls5w/z7ig1dmXxUoTSCP5ZrctaA7tr2nQXWHYqcpWhToZm62XXhlt/RV
 v3JbKfPr68h70MbCKvyTo/+2AaYcweA9XMFpOEGcHqTGgyMkCIaC3e62yG+kkSBRggU7
 DSbQ==
X-Gm-Message-State: APjAAAXcrxB0oa69+nGXmyP6y7TKg92oU4M/O5ceL62hQezUuNe1d8OQ
 gdwtYzAnH5Kuf1kCZk19luWkKQ==
X-Google-Smtp-Source: APXvYqxIYH1YAJJ4aCbxBaYcwxpe05Lp8AeU408aavH37IaE15F9LQFYq7Du957vlD+jB2SeQlgGqA==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr26009288wme.76.1579015134028; 
 Tue, 14 Jan 2020 07:18:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g7sm20007100wrq.21.2020.01.14.07.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:18:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2773C1FFA3;
 Tue, 14 Jan 2020 15:09:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/22] tests/tcg/aarch64: add a gdbstub testcase for SVE
 registers
Date: Tue, 14 Jan 2020 15:09:49 +0000
Message-Id: <20200114150953.27659-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A very simple test case which sets and reads SVE registers while
running a test case. We don't really need to compile a SVE binary for
this case but we will later so keep it simple for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - properly plumb in
  - skip if fails to connect
---
 tests/.gitignore                      |  1 +
 tests/tcg/aarch64/Makefile.target     | 15 +++++
 tests/tcg/aarch64/gdbstub/test-sve.py | 81 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

diff --git a/tests/.gitignore b/tests/.gitignore
index f9c0170881..8cc428b58b 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -10,6 +10,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!test-*.py
 !docker/test-*
 test-qapi-commands.[ch]
 include/test-qapi-commands-sub-module.[ch]
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index afcbd06467..aba17881e9 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -43,6 +43,21 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
 sysregs: CFLAGS+=-march=armv8.1-a+sve
+
+ifneq ($(HAVE_GDB_BIN),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+AARCH64_TESTS += gdbstub-sysregs
+
+.PHONY: gdbstub-sysregs
+run-gdbstub-sysregs: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
+	"basic gdbstub SVE support")
+endif
+
 endif
 
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
new file mode 100644
index 0000000000..90201d8009
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -0,0 +1,81 @@
+from __future__ import print_function
+#
+# Test the SVE registers are visable and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+import sys
+
+MAGIC = 0xDEADBEEF
+
+failcount = 0
+
+def report(cond, msg):
+    "Report success/fail of test"
+    if cond:
+        print ("PASS: %s" % (msg))
+    else:
+        print ("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+def run_test():
+    "Run through the tests one by one"
+
+    gdb.execute("info registers")
+    report(True, "info registers")
+
+    gdb.execute("info registers vector")
+    report(True, "info registers vector")
+
+    # Now all the zregs
+    frame = gdb.selected_frame()
+    for i in range(0, 32):
+        rname = "z%d" % (i)
+        zreg = frame.read_register(rname)
+        report(True, "Reading %s" % rname)
+        for j in range(0, 4):
+            cmd = "set $%s.q.u[%d] = 0x%x" % (rname, j, MAGIC)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+        for j in range(0, 4):
+            reg = "$%s.q.u[%d]" % (rname, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint128_t", "size of %s" % (reg))
+        for j in range(0, 8):
+            cmd = "set $%s.d.u[%d] = 0x%x" % (rname, j, MAGIC)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+        for j in range(0, 8):
+            reg = "$%s.d.u[%d]" % (rname, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint64_t", "size of %s" % (reg))
+            report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    report(arch.name() == "aarch64", "connected to aarch64")
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
+except:
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+
+print("All tests complete: %d failures" % failcount)
+
+exit(failcount)
-- 
2.20.1


