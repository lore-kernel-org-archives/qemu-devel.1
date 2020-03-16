Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10383C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D0B2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBvq+Gr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D0B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDumF-0002EA-2U
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXr-0003qg-Cn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXn-0002Qk-UD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtXn-0002Ji-HR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id v11so22320923wrm.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m8trnK4dsJcOAkqMwuDk8oN/65638+mbTVeX6RjAM68=;
 b=HBvq+Gr1rLXtJLvRVXx6L79nqcvJ2B+xPBsegPXIx70/Li1laLUTPSzyQ7N1knJBT9
 A5hB/O6zxN0U6SAyyL4of8l97vq2fOvasvtL8DId2Q9vwr1TWF0+VnP7oGFNX/h6GPXb
 K0BIJ6QsrFkChDqvYM2KEnqNVl8LvwWuQsHbfdNaDTqyhSKUvqXwJI1PSTCt6R3x0H+C
 VfPQ0WYwkE1VkYcmjGF20YNhFKw0K5vMoPlsnCnHKL4F07cU+ytdwdznYHsYtNwcUl+A
 j3aR7YnTUUSa6MNtR62gvnuBrnQuxIuWp7S9xPx7ErAwbDE2s7dfpS2KosyP4vjntqyd
 QbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m8trnK4dsJcOAkqMwuDk8oN/65638+mbTVeX6RjAM68=;
 b=Y7MkFhfseBzA3eeH8heWVlGH3eSKUlXjpG/XmdzPkV7YN5xz9ETjiZH8v5oqPREwQN
 yRoJBPiW6rBhEcHuow13WofH9M8LDVpj09rWbi7s09mws/8Ovk55GAFRcg3u+AOYtP5w
 TguueUXR9Sl81/oGWvQWHcwA8zTibCkORFBjPIQDkSY8G1GcJKtUEXPtHDKGWAyPOUA7
 A+yKR8r9YS14bFvK/KWz7ASKy7ENpte7gZr7YiBZjFlOYlVQfrrDwwxpXVUdcKyc3opt
 ksOSKyRFsVbpiYLpesN57jZSxiAD/k/6ORb5m4iPacDBypP1/oJtAwMYIsTEkOnzTyLz
 tbbg==
X-Gm-Message-State: ANhLgQ3/4MdwefmpYhewBz8vmZL4GJKrk8Q+7XFTsJm6GqMEQ0PsQzYg
 Pqasp8SqAemJ/XQBT2qq9kopew==
X-Google-Smtp-Source: ADFU+vuZHzlkb3X9TGWbTjsEEpevcVTZ7Ke10xn8DgpeFvoA4hK1S37CzkczmHtXeNtOh4BrSUjPQA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr456320wrv.104.1584379730464;
 Mon, 16 Mar 2020 10:28:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 9sm443006wmx.32.2020.03.16.10.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:28:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 815581FFAE;
 Mon, 16 Mar 2020 17:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 23/28] tests/tcg/aarch64: add a gdbstub testcase for SVE
 registers
Date: Mon, 16 Mar 2020 17:21:50 +0000
Message-Id: <20200316172155.971-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
index 7306866f216..d03c037d772 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -10,6 +10,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!test-*.py
 !docker/test-*
 test-qapi-commands.[ch]
 test-qapi-init-commands.[ch]
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index a25afc071cc..b61b53e4dd1 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -46,6 +46,21 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
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
index 00000000000..90201d80094
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


