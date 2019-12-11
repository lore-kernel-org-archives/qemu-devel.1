Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD55C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1743B21556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nc+Ci3za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1743B21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5j0-0000NA-Vw
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WF-0003K1-IT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WD-0003Gu-JR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5WB-0003Ct-5a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:19 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so24916475wrr.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HgQILMH+wQNyAcOrarpR7rw2vBB43pS1pI9nkMO2sho=;
 b=Nc+Ci3za4eDF4uV6K0p3FaUjxumMKBdrCJ6LvrS/aOLXFVvYoDjFTVXsLMPrZZAqcb
 PTCHbnF1qZIficgGEnf4VS7caGCQVm8kPfQgv5nWqCj/MdZvFAlb+hBnyyG688QZkDit
 JW+/uyqLXawXf9Tl5KG4T9/CRowl9zi1doo2dCMMYTNMsFWAAeKD+BMxEnWiJQbjoTGt
 i5+Wf496KquGzpd8VfFgniVWlGV878HctSyoxlOekLf2I05whUJbUbmVjdGl+Bc66rwG
 J4wYXGpOilHPjuv6jzwtuHcWEiuQ9tBrnuT2GpTPwU9GSZ7k6RAH8ZCLSYbAwNIHM8OP
 rBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HgQILMH+wQNyAcOrarpR7rw2vBB43pS1pI9nkMO2sho=;
 b=iJAWy4gN/c8/Ougf2BBzz7X+84PmQKR/PGs9q7OHIF78bMFsnPhmOisYeDsRI0FCB/
 PgALy8sKR8DlT5F8N+cZI0RhWdjCFWvDJaGdygvBw/4q3sDQB7wb9zT9RqLBkgr8U7jU
 dL1hCCgOQjeTBthCJzxuhibZoU9QQWuChcobwyHXjKfHH9WeF4ozLS2zQu/1ELfOTmmM
 0WFdyoXZ6OaTwZbAFDdfKQD/hizH3vUe/b06809H39JBWKoPmmV/asxmXSLdYlNoM4fT
 01ENn42SXGOBarR4gMtziQfhZBP9lSTZWj+jmuOheXKS2b2szn6UEx03pK9M105g2ofI
 bRHQ==
X-Gm-Message-State: APjAAAXJCNpqEytBCt5gbu6N9C5TbiMbD8ZHus/c4pehqAjhJtAwS5aZ
 Z1rJgU/6m8m5clREt1KACPWwNQ==
X-Google-Smtp-Source: APXvYqz2/O894u7dIs9iGd3IwmLEPeavCdEWIZpjgNsOWepBEUZkga0Cbq/Kl2/Y0aLV5Y2MnOMJXw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr954545wrp.314.1576084277875; 
 Wed, 11 Dec 2019 09:11:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w13sm3138312wru.38.2019.12.11.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:11:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D0D21FFA6;
 Wed, 11 Dec 2019 17:05:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] tests/tcg/aarch64: add test-sve-ioctl guest-debug
 test
Date: Wed, 11 Dec 2019 17:05:20 +0000
Message-Id: <20191211170520.7747-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test exercises the gdbstub while runing the sve-iotcl test. I
haven't plubmed it into make system as we need a way of verifying if
gdb has the right support for SVE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 71 +++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py

diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
new file mode 100644
index 00000000000..2c8c21ca381
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -0,0 +1,71 @@
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
+        for i in range(0, int(val_i)):
+            val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+            report(int(val_z) == i, "z0.b.u[%d] == %d" % (i, i))
+        for i in range(i + 1, initial_vlen):
+            val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+            report(int(val_z) == 0, "z0.b.u[%d] == 0" % (i))
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
+    initial_vlen = int(vg) * 16
+
+    gdb.execute("c")
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
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


