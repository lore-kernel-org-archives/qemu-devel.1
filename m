Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C70CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F9B2082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL91lvr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F9B2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqmr-0006zK-LU
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkh-00059L-Do
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkg-0002sB-2s
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkf-0002rw-Ti
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id f22so8753641wmc.2
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2a+TCqZPYf8Fdku0JFcZTliUzkB7c4m1IgL3Bv67Zg=;
 b=eL91lvr1o7Kg+wOKDN8X3IJ7Xkcx4yhEg7uXfWnOxQ4ySTyO1IpVxhXqBnIOfWhy+t
 rBa+kChJMwlryj8epNZFktmaCS2QcNwUTVwZR9jb0joc30ULEFKSYY4r0CMf41+XUltM
 BvShJYu6lRUGVVVUwj9elHaJxBID/bgfw6JgDR3Omo9STh7NhWy6pz3+MfeTQkHKpC5Z
 FDA7vCjGkSvDwfqvkqRTHaLNfpVy9lY+rlkb64lfIQeu/eZBQXTGoPy5y7nxoWRlSrrx
 6Q8bGvEQFdzkoLowLkNX/8OuWxGRh2x+iZYA4MlEVOvhsqbLUyiNzqzeBNNlqgjjOGf9
 8ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l2a+TCqZPYf8Fdku0JFcZTliUzkB7c4m1IgL3Bv67Zg=;
 b=TsAeFRbTiHQSVjVt1wfko3avXLYUbbrjALcgC4OQmp3WoiRL0IBjYl4s6Xxnf2idi2
 5l+/6iE7wQ0YS8zu6k15Hz9B6K++jdT6r6ooVv8njDrX9cqLeMr1hxDkvxRAeLmCIAlV
 aTDevAtrVb9NIilo1cxNsIqnB1qVduJLbA7Q8ln4zVUi0wetOjKHYooCAsOpp1uM3XKF
 ZErRFOgzEOrLls1NjgwJhXQ/FuNZiEr1VuY++6OaZOcuS+PqYi0dfF7wnFDslesbVEYZ
 iUQINz349Tx90NTdwz1BLmb4L0T8xZQkz1zilTbpyf2aNJviOvMjpdlVbeRDlsu9ZaNT
 kEAw==
X-Gm-Message-State: APjAAAXvL7gbKOP9kAJOkYum7pHtUbHmpDxGejptMNvxq893joFdoRvQ
 q2wKIjt186xo7zQtQ082f0pAfuco
X-Google-Smtp-Source: APXvYqxFnHkP56/IBULT5vzXpkrkh6hmUd7Rs0z883K54SntiBLeB1rb6f5NmeaIMaBgh9KYIpJTPQ==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr12569560wmb.93.1571499284716; 
 Sat, 19 Oct 2019 08:34:44 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
Date: Sat, 19 Oct 2019 17:34:30 +0200
Message-Id: <20191019153437.9820-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The same utility method is already present in two different test
files, so let's consolidate it into a single utility function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: fix self -> test, failure_message is optional, added doc
---
 tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++++++++
 tests/acceptance/boot_linux_console.py    | 18 +++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index a0450e5263..7bc77118dd 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -79,6 +79,25 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
             test.fail(fail)
 
 
+def exec_command_and_wait_for_pattern(test, command,
+                                      success_message, failure_message=None):
+    """
+    Send a command to a console (appending CRLF characters), then wait
+    for success_message to appear on the console, while logging the.
+    content. Mark the test as failed if failure_message is found instead.
+
+    :param test: an Avocado test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    command += '\r\n'
+    test.vm.console_socket.sendall(command.encode())
+    wait_for_console_pattern(test, success_message, failure_message)
+
+
 class Test(avocado.Test):
     def setUp(self):
         self._vms = {}
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 497faa4f7f..4b419b0559 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -14,6 +14,7 @@ import gzip
 import shutil
 
 from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -33,11 +34,6 @@ class BootLinuxConsole(Test):
         wait_for_console_pattern(self, success_message,
                                  failure_message='Kernel panic - not syncing')
 
-    def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\r\n'
-        self.vm.console_socket.sendall(command.encode())
-        wait_for_console_pattern(self, success_message)
-
     def extract_from_deb(self, deb, path):
         """
         Extracts a file from a deb package into the test workdir
@@ -166,12 +162,12 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('Boot successful.')
 
-        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
-                                               'BogoMIPS')
-        self.exec_command_and_wait_for_pattern('uname -a',
-                                               'Debian')
-        self.exec_command_and_wait_for_pattern('reboot',
-                                               'reboot: Restarting system')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BogoMIPS')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                'Debian')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
 
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-- 
2.21.0


