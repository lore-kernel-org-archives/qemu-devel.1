Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D7BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC4C2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6JustDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC4C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGbZ-0005Sa-TE
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUW-0005eN-EX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUV-0000Ul-5R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUU-0000NR-Sk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id s1so5174395wrv.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Q2lkx0fMNS8OCExFZJ/0oeLEFUXLbn1Ix69DopYAxs=;
 b=D6JustDbNPQ2mX7VegXxMpE5hOEiECnZZ7wfdxi45CoJ0gCwNGd1zthnUcecGPYbYZ
 SxnJ/xnRt46zm2ARPU1yLfZdijFAN8uyGGfqHQZmIHVNeweAwYaLGhhZfhWMufxE17yK
 +uLt0pvZKOfkFh6Q5xYrbuP24gTG2V3Diovvz3TZXEjB9zV+jPBj0An+kxrC8cibmlWZ
 N9X343Qh9VFRAU0FWSOsx9fMvVZC+zolgxxze4B2FccNsd4mkwNTskcyN2W2GA6chI92
 Crh4ulwH53zyKysjqp3+c+1RsYZuTDnWOT1/xUhHQrlyp24cgvMVKVTCN3l8OYQqKKXb
 FDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Q2lkx0fMNS8OCExFZJ/0oeLEFUXLbn1Ix69DopYAxs=;
 b=B43WAPoU7vjTVbtnoG+1VVhpX0oyZOzKCjTIgMzTDRFeMfUPQuCG+1mkAGgC+0B9nV
 vTmF0y1uOcV0Bqn9pehPLutFwCBuBCy2WgkqSK4dnmH9tgQXkhc+YPXFTJ4D5Qwdr7T/
 Qx7JAuOUFIZH+7lpgVk7bzOCgpRbRU0wZhmURaVfg4pI7QBWlUvZnSs+NwBBDX8i1WMJ
 MsO6I6jusegScLqAWNR4clR6D4kqstVxuzw8hijJKQg+7Rl/irnx1zmQc0xVyYSTwevy
 Z+X/7xXG0Iqi2Ls8VkOPLrqe7AR9BTVMc3oN+0p5CPVD8bN/kgal55DVNrVLFTllfV/s
 SdWg==
X-Gm-Message-State: ANhLgQ1TrxnAmktT3o5yiT/qr1IzxtnN7ev+3Cd46bxg8sSj98/NL/X7
 Dzhltjjje3I45zKuDUyKkFsftQ==
X-Google-Smtp-Source: ADFU+vvbwNoCuh3VwtjcKBu9u38J8haXQ0I1ZB/Gasoqb54prOn4soFSgyPtzN6CK4bCDbBbvQa1XA==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr204731wrw.358.1584467937736;
 Tue, 17 Mar 2020 10:58:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k5sm233113wmj.18.2020.03.17.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DE5F1FFAB;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 22/28] tests/guest-debug: add a simple test runner
Date: Tue, 17 Mar 2020 17:50:47 +0000
Message-Id: <20200317175053.5278-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test runners job is to start QEMU with guest debug enabled and
then spawn a gdb process running a test script that exercises the
functionality it wants to test.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-23-alex.bennee@linaro.org>

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


