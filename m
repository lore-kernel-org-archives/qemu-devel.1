Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B658CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BC8222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHH07EOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BC8222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqWM-0000zx-C4
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNq-0001CY-1K
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNo-0006zA-OL
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNo-0006yF-Hz
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id q13so4215483wrs.12
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2a+TCqZPYf8Fdku0JFcZTliUzkB7c4m1IgL3Bv67Zg=;
 b=BHH07EOkM4HJyzv2agpdiUHn1dj5nBzg6y99Or0BF31z6ZdfekeMfhWqtDAMuKjekb
 X+x/pOpO8b44j4kllnlHDM2RVxpbIz0uR6ndp1vgTxLrU+nON5d+4w7nLHY++X8m+MUa
 ryU4EjRDmk3QBNV7sB+W69daSsHo+MZ3Zf0DxF5A/f4q35SUajBZ4DETRfNo45xJJx2G
 WPPSlXM/Qf3kmgOawTPRpiobe7BSNBfGgld/TqnJwt3BEr5dS+RULIi5wZ+4EpHP3nrB
 1NV/zuQxkAr05h4zVaQgucAhjLfIclwg2pj5FHlGINO6MpzAJSo7cAiLbq8XBAT4jJDk
 d+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l2a+TCqZPYf8Fdku0JFcZTliUzkB7c4m1IgL3Bv67Zg=;
 b=QOL3HjUx/kvmN2cB54kXu5Il0wx0E/lUWeNx0rqe6mGLEIATlSrzPHcI+pkSTuOXth
 USKcn4D08di4CpruP40yafyumvHGgvCbFn/m1WQDk7ZS6ZLxiV/EBPVHQsEf+dKlmRvh
 MPJ25kT90yHkR+hfpmgLmcriGxFiYVgsUB4AUdWhRCEq4ELYRt5GuYthAA9wtf3r3q2r
 j1cFzuyQqnVkWeyRpmkxAujnACMZT5PK9OAZ5TyUzFlcxk/MA0TlyBSKu/Er0EaUlY6e
 5Sx1y9cKSwwWWJt0EQiuo/ucbt/3qMiujDyPnlSydBaSSENTHcKG7Dkv6zTQmqrMjWUi
 VKnA==
X-Gm-Message-State: APjAAAUmyhWEcZDCIXuHkLRXzVAomxxENLq2Vi3bCXMrAeO9kbn4hU05
 y4AqiglgxuEC7aNTjbGNKKuhT7ha
X-Google-Smtp-Source: APXvYqyt/9KSSZS4oEEqy4+7NR3UuNIljRBOqIb/i5GyNSnYlaJ9R25uRfXKQ2VXW4sxQ5eDHp0inA==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr11922925wro.310.1571497867235; 
 Sat, 19 Oct 2019 08:11:07 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
Date: Sat, 19 Oct 2019 17:10:51 +0200
Message-Id: <20191019151058.31733-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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


