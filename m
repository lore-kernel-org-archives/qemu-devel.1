Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F329C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AC32072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3ulImvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AC32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOMY-0005Ng-58
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCV-0005GQ-4u
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCS-00065K-Ti
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCS-00060A-Kt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id a6so3639589wrx.12
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f5dTlYsFtNp/wmtrOeuFSuNIyqa263n2dovazYjJJJU=;
 b=i3ulImvIG0FFP4JtWClFQ5JZiPE+YYwJityhvRarwOxwKxsQfgDRwClqlhND0pys5B
 lQbizVGuPX2iPl7ywvmhbonle6TNODs5mh218gPWJiGH8mlIyZn4eIXS+9sJasm4F8hU
 cgyHivH0tatGrlgnN/cvKMoxx5fYnJbkE15BsaAo57PSbcQSl3C/GR1vqMd/ytZKJEOq
 tIXcg6OtJCgfgyqqnIzckAzIZL3vk0Sikr1jlfnq+VrPwoFNT26/ppZaDIm42S06WviL
 w3/UhrI2oKjJF7osc2Ds8igJ0O/QjNl2L/07jYA6bIdw1DRFSJ19VafQOVtuAl499J0s
 gP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f5dTlYsFtNp/wmtrOeuFSuNIyqa263n2dovazYjJJJU=;
 b=B1TS6tWYrtgM9QXw/J/ra7IJv6AEzY6FkNqxSTJ1sqzPc3sZz8BrKQNJx3csKxmAtn
 m/6Gaup3+ZWf1NB3CulpCt6gdywTgPJJQTe7ho4bJ2zpPwi+1iwdVyNMYfp5QHRDLbE1
 z+XDG61uk4qYWse1Ia8P8fUGRdGwc38f6p+VimPgarnAdV2QsyUkUlacOZXDw7k9kd21
 DHBbYLGcFf4ZeUpGI7Iihnpgxc2Zz5hhWa+cgwNmIrx0DYYXhUT0u87/p95FiWF/i68X
 AUeGCRCTNndNNFon3acEyWkEp5Y0KNdbeXT/HihrHo7P11zxCVGyINBN684CSI3Smt/z
 5t/A==
X-Gm-Message-State: APjAAAUG83sWHnVk0xYZvAxqGmCf8oZgsoxMVUlHOu90P410/fRyTigc
 ey0QU8n7mNgePu78DOP4x0e5PQ==
X-Google-Smtp-Source: APXvYqxtcjY8Ys55/nSTH23r1/o/r6fORYOke2WkcFw0479V1P1dWOyf3TApsB3vFWC2raGixB7BVQ==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr13568937wrv.253.1580922651645; 
 Wed, 05 Feb 2020 09:10:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm546420wrp.95.2020.02.05.09.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F8251FFA6;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 17/22] tests/guest-debug: add a simple test runner
Date: Wed,  5 Feb 2020 17:10:26 +0000
Message-Id: <20200205171031.22582-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test runners job is to start QEMU with guest debug enabled and
then spawn a gdb process running a test script that exercises the
functionality it wants to test.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/guest-debug/run-test.py | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 tests/guest-debug/run-test.py

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
new file mode 100755
index 00000000000..8c49ee2f225
--- /dev/null
+++ b/tests/guest-debug/run-test.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Run a gdbstub test case
+#
+# Copyright (c) 2019 Linaro
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import subprocess
+import shutil
+import shlex
+
+def get_args():
+    parser = argparse.ArgumentParser(description="A gdbstub test runner")
+    parser.add_argument("--qemu", help="Qemu binary for test",
+                        required=True)
+    parser.add_argument("--qargs", help="Qemu arguments for test")
+    parser.add_argument("--binary", help="Binary to debug",
+                        required=True)
+    parser.add_argument("--test", help="GDB test script",
+                        required=True)
+    parser.add_argument("--gdb", help="The gdb binary to use", default=None)
+
+    return parser.parse_args()
+
+if __name__ == '__main__':
+    args = get_args()
+
+    # Search for a gdb we can use
+    if not args.gdb:
+        args.gdb = shutil.which("gdb-multiarch")
+    if not args.gdb:
+        args.gdb = shutil.which("gdb")
+    if not args.gdb:
+        print("We need gdb to run the test")
+        exit(-1)
+
+    # Launch QEMU with binary
+    if "system" in args.qemu:
+        cmd = "%s %s %s -s -S" % (args.qemu, args.qargs, args.binary)
+    else:
+        cmd = "%s %s -g 1234 %s" % (args.qemu, args.qargs, args.binary)
+
+    inferior = subprocess.Popen(shlex.split(cmd))
+
+    # Now launch gdb with our test and collect the result
+    gdb_cmd = "%s %s -ex 'target remote localhost:1234' -x %s" % (args.gdb, args.binary, args.test)
+
+    result = subprocess.call(gdb_cmd, shell=True);
+
+    exit(result)
-- 
2.20.1


