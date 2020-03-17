Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C7DC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06D20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9XYxBPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA06D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGUM-00051J-QC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN8-0000r4-4K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN5-0003l2-Tn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGN5-0003el-Kj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id s1so5143931wrv.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1JELrzWETzcBlGGiIwsXPqXELauVLI0go+Dpvqy4RLQ=;
 b=e9XYxBPDezqDY7XBWIopUR43GMrEt6AJzlctHRESgCg8d7sGjfAVt8L8kzk9LctGPk
 EhSFw29zvKUerqR0wsUYEXLrdqkf5horw9hS2gLY/0muiBAYL3NlM7UA25bpSjU+int9
 og2C2osVEgs8yeI8UQ4MGObmlHNQDifn7YfZLFRQfFypM4pIYwTsAQDRVbmDlurhBOAG
 P9GYwVsupOLBrCjmOWWVSu8uDzBhYoL7eQ+RuvygOF8V5ydMQBjtCOjKkAxaj8ydqDn4
 qzY0FlryehhmaB44WRkQH4qW8rg+JKKhOcLRSCNtf+84twLp3uukgWmXqbq1zJV/FRuH
 EphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1JELrzWETzcBlGGiIwsXPqXELauVLI0go+Dpvqy4RLQ=;
 b=AvspxBpqE8jifU2BfE7vzfk2Uj/3H7bPTyg4HwqKYHVGqdlBE0Wp/QIzy9ezMkE+S6
 2g2EEGlRpbEE41CCng+K3yWD5HkqAe0oIzCfAiLjRIJ0uRnyOlB25NXpTKa92AhiZ4R6
 zoWJLWahHjbYpfEKbRKvkM7t1IoS6wuvJHmWHdhZ3zjrhzzSLNK7eYfDK1HfMP1d8xiK
 8sgQV+X7Sz0yLUZunI2lFMcEpRykMXYIXKc58gh2utIhiHnrYMmCQ2yWWUHDIpY1U2ZW
 2/tFbvI1B48OspNoDvgitdoc0F0EZQLigBnwv6M2sMavSm1FVCI63jr2fFXln7eSJuTa
 0SWQ==
X-Gm-Message-State: ANhLgQ2s1aKc29q+kAqQNFo5jQsOFlwctGtXhDpqwARrUXHJxLM5WT6W
 hTjDrYDUBFHv+e8zAoKn7VNVfBCxRsU=
X-Google-Smtp-Source: ADFU+vvyERNJ0i2+ydTsKfEt99qMo4YgXCGKuO8MBIqiHFoBqn8UPF3oQoDU+qTnAVodHYgBQlAgCQ==
X-Received: by 2002:adf:f40f:: with SMTP id g15mr148569wro.213.1584467477290; 
 Tue, 17 Mar 2020 10:51:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm2184346wrt.0.2020.03.17.10.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D56561FFAF;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 25/28] tests/tcg/aarch64: add test-sve-ioctl guest-debug test
Date: Tue, 17 Mar 2020 17:50:50 +0000
Message-Id: <20200317175053.5278-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test exercises the gdbstub while runing the sve-iotcl test. I
haven't plubmed it into make system as we need a way of verifying if
gdb has the right support for SVE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200316172155.971-26-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index c879932ff6c..d99b2a9eced 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -54,15 +54,22 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-AARCH64_TESTS += gdbstub-sysregs
+AARCH64_TESTS += gdbstub-sysregs gdbstub-sve-ioctls
 
-.PHONY: gdbstub-sysregs
+.PHONY: gdbstub-sysregs gdbstub-sve-ioctls
 run-gdbstub-sysregs: sysregs
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
 	"basic gdbstub SVE support")
+
+run-gdbstub-sve-ioctls: sve-ioctls
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
+	"basic gdbstub SVE ZLEN support")
 endif
 
 endif
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
new file mode 100644
index 00000000000..984fbeb277e
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -0,0 +1,85 @@
+from __future__ import print_function
+#
+# Test the SVE ZReg reports the right amount of data. It uses the
+# sve-ioctl test and examines the register data each time the
+# __sve_ld_done breakpoint is hit.
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
+        print ("PASS: %s" % (msg))
+    else:
+        print ("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+class TestBreakpoint(gdb.Breakpoint):
+    def __init__(self, sym_name="__sve_ld_done"):
+        super(TestBreakpoint, self).__init__(sym_name)
+        # self.sym, ok = gdb.lookup_symbol(sym_name)
+
+    def stop(self):
+        val_i = gdb.parse_and_eval('i')
+        global initial_vlen
+        try:
+            for i in range(0, int(val_i)):
+                val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+                report(int(val_z) == i, "z0.b.u[%d] == %d" % (i, i))
+            for i in range(i + 1, initial_vlen):
+                val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+                report(int(val_z) == 0, "z0.b.u[%d] == 0" % (i))
+        except gdb.error:
+            report(False, "checking zregs (out of range)")
+
+
+def run_test():
+    "Run through the tests one by one"
+
+    print ("Setup breakpoint")
+    bp = TestBreakpoint()
+
+    global initial_vlen
+    vg = gdb.parse_and_eval("$vg")
+    initial_vlen = int(vg) * 8
+
+    gdb.execute("c")
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    if inferior.was_attached == False:
+        print("SKIPPING (failed to attach)", file=sys.stderr)
+        exit(0)
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
+    import code
+    code.InteractiveConsole(locals=globals()).interact()
+    raise
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
-- 
2.20.1


