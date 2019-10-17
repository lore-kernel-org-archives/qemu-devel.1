Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB188ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A2720820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoRjSHqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A2720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9iE-00027C-JE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91B-00017a-2U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL919-0006aY-8t
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL919-0006a9-1i; Thu, 17 Oct 2019 12:52:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r5so3143282wrm.12;
 Thu, 17 Oct 2019 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lRZXRUlp7wZ+Lo2v+5O7rUObPFoqCZggqml9lEdRP5k=;
 b=JoRjSHqtQSNd0fv/x2i+EbhPEnTJEA5zoBmxfXVXAXiaFHjS5C8wwaGT/TdW0Mbn40
 uNpxNF+qy9lUg1zZkmcPobwUZ0pmYAtfyqTzhkzlFufo1wyxvCGD+f/Fgw2DRbvIAxpa
 G/d3u1aJkjfO2stL/RxbpvT4qrrCqP+9L/AoTkyg0y/IX26IAt2pXFB6NtLUM8Twxjt1
 5zT1sUQLLGi/FZvsiSk5iEpLimpY7FMlP1uootZlDwUz1eFY5udAgbQ1JN3vGDjKOtYr
 GnxahV8tX9A+nhCOtnLN+Gig3UiFbxRkbxSI9BHUHoO0NpoaLu7jAImqWl9b3AdYZBNs
 5EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lRZXRUlp7wZ+Lo2v+5O7rUObPFoqCZggqml9lEdRP5k=;
 b=PhPplVfSW8rFdwO/NscZWS3oLcmlDMCHnVa9bh/17Sf83kRb4YEiSTJ6urcqISMf4e
 h27RjPcC6jb0jfX6fu2o2EVlisFzkO0uZuOgGnN1OJjn+1xkB8rkVHjkJqUOjoPiZ/6h
 DzrP6j61Wr84dVMPkVQUmjbZgVgq3vKmjG+r50OMOtw3vZvwL/Vi3fJEgwb0Wwo9dJPK
 7AshDsQv7pTT2RNx0O2mbWMzkSZ0zgrh5zdAImaQAtHkfod8HH6br85PAw5/bj5udgUq
 iXyBqjZFq7RDPeEQ08o1f0f58gzKn10rMDmNJg0JaEjn3eYVHlGCgqa0JKKNo5vTCjof
 Misg==
X-Gm-Message-State: APjAAAWISyebzlDiRUdM05ZhPrNGuXWHRLijX4P9bAnbNzPjfQ/OIlZg
 PgKLafEGFODdBf/ZM81BX41F3Dejzms=
X-Google-Smtp-Source: APXvYqyK75HOsZxzyqMMGrxmu+rlPdSuKPxW5C5AST652f8Xt+WlPw3xopfzzedXaWL8DSRQrIrjwg==
X-Received: by 2002:a05:6000:1283:: with SMTP id
 f3mr3707402wrx.370.1571331169525; 
 Thu, 17 Oct 2019 09:52:49 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] Acceptance tests: refactor wait_for_console_pattern
Date: Thu, 17 Oct 2019 18:52:31 +0200
Message-Id: <20191017165239.30159-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The same utility method is already present in two different test
files, so let's consolidate it into a single utility function.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190916164011.7653-1-crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMD: rebased fixing conflicts in linux_ssh_mips_malta.py]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 26 +++++++++++++
 tests/acceptance/boot_linux_console.py    | 47 +++++++----------------
 tests/acceptance/linux_ssh_mips_malta.py  | 18 ++-------
 3 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index bd41e0443c..a0fe16e47f 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -8,6 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import logging
 import os
 import sys
 import uuid
@@ -53,6 +54,31 @@ def pick_default_qemu_bin(arch=None):
         return qemu_bin_from_src_dir_path
 
 
+def wait_for_console_pattern(test, success_message,
+                             failure_message='Kernel panic - not syncing'):
+    """
+    Waits for messages to appear on the console, while logging the content
+
+    :param test: an Avocado test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    console = test.vm.console_socket.makefile()
+    console_logger = logging.getLogger('console')
+    while True:
+        msg = console.readline().strip()
+        if not msg:
+            continue
+        console_logger.debug(msg)
+        if success_message in msg:
+            break
+        if failure_message in msg:
+            fail = 'Failure message found in console: %s' % failure_message
+            test.fail(fail)
+
+
 class Test(avocado.Test):
     def setUp(self):
         self._vms = {}
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8a9a314ab4..9ff2213874 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -9,12 +9,12 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
-import logging
 import lzma
 import gzip
 import shutil
 
 from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
 
@@ -29,31 +29,10 @@ class BootLinuxConsole(Test):
 
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    def wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing'):
-        """
-        Waits for messages to appear on the console, while logging the content
-
-        :param success_message: if this message appears, test succeeds
-        :param failure_message: if this message appears, test fails
-        """
-        console = self.vm.console_socket.makefile()
-        console_logger = logging.getLogger('console')
-        while True:
-            msg = console.readline().strip()
-            if not msg:
-                continue
-            console_logger.debug(msg)
-            if success_message in msg:
-                break
-            if failure_message in msg:
-                fail = 'Failure message found in console: %s' % failure_message
-                self.fail(fail)
-
     def exec_command_and_wait_for_pattern(self, command, success_message):
         command += '\n'
         self.vm.console_socket.sendall(command.encode())
-        self.wait_for_console_pattern(success_message)
+        wait_for_console_pattern(self, success_message)
 
     def extract_from_deb(self, deb, path):
         """
@@ -89,7 +68,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_mips_malta(self):
         """
@@ -112,7 +91,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_mips64el_malta(self):
         """
@@ -145,7 +124,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_mips_malta_cpio(self):
         """
@@ -181,7 +160,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line,
                          '-no-reboot')
         self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
+        wait_for_console_pattern(self, 'Boot successful.')
 
         self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
                                                'BogoMIPS')
@@ -208,7 +187,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_mips_malta32el_nanomips_4k(self):
         """
@@ -266,7 +245,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_arm_virt(self):
         """
@@ -287,7 +266,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_arm_emcraft_sf2(self):
         """
@@ -314,7 +293,7 @@ class BootLinuxConsole(Test):
                          '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
                          '-no-reboot')
         self.vm.launch()
-        self.wait_for_console_pattern('init started: BusyBox')
+        wait_for_console_pattern(self, 'init started: BusyBox')
 
     def test_s390x_s390_ccw_virtio(self):
         """
@@ -335,7 +314,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_alpha_clipper(self):
         """
@@ -357,7 +336,7 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
 
     def test_ppc64_pseries(self):
         """
@@ -377,4 +356,4 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern)
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 25a1df5098..ffbb06f846 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -13,6 +13,7 @@ import time
 
 from avocado import skipUnless
 from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
 from avocado.utils import ssh
@@ -40,19 +41,6 @@ class LinuxSSH(Test):
     def setUp(self):
         super(LinuxSSH, self).setUp()
 
-    def wait_for_console_pattern(self, success_message,
-                                 failure_message='Oops'):
-        console = self.vm.console_socket.makefile()
-        console_logger = logging.getLogger('console')
-        while True:
-            msg = console.readline()
-            console_logger.debug(msg.strip())
-            if success_message in msg:
-                break
-            if failure_message in msg:
-                fail = 'Failure message found in console: %s' % failure_message
-                self.fail(fail)
-
     def get_portfwd(self):
         res = self.vm.command('human-monitor-command',
                               command_line='info usernet')
@@ -109,7 +97,7 @@ class LinuxSSH(Test):
 
         self.log.info('VM launched, waiting for sshd')
         console_pattern = 'Starting OpenBSD Secure Shell server: sshd'
-        self.wait_for_console_pattern(console_pattern)
+        wait_for_console_pattern(self, console_pattern, 'Oops')
         self.log.info('sshd ready')
 
         self.ssh_connect('root', 'root')
@@ -117,7 +105,7 @@ class LinuxSSH(Test):
     def shutdown_via_ssh(self):
         self.ssh_command('poweroff')
         self.ssh_disconnect_vm()
-        self.wait_for_console_pattern('Power down')
+        wait_for_console_pattern(self, 'Power down', 'Oops')
 
     def ssh_command_output_contains(self, cmd, exp):
         stdout, _ = self.ssh_command(cmd)
-- 
2.21.0


