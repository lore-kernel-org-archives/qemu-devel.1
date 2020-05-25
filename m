Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF98C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A533E20787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBB2-0005gT-QR
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jdB8W-0000ZZ-3c
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:16 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54720)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jdB8V-0008MQ-3f
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:15 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 27FEDCD466;
 Mon, 25 May 2020 14:19:14 +0300 (MSK)
Subject: [PATCH 2/9] tests/acceptance: add base class record/replay kernel
 tests
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 25 May 2020 14:19:13 +0300
Message-ID: <159040555391.2615.4700513751491354604.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:19:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, NML_ADSP_CUSTOM_MED=0.9,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: philmd@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a base for testing kernel boot recording and replaying.
Each test has the phase of recording and phase of replaying.
Virtual machines just boot the kernel and do not interact with
the network.
Structure and image links for the tests are borrowed from boot_linux_console.py
Testing controls the message pattern at the end of the kernel
boot for both record and replay modes. In replay mode QEMU is also
intended to finish the execution automatically.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 MAINTAINERS                       |    1 
 tests/acceptance/replay_kernel.py |   80 +++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/acceptance/replay_kernel.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 47ef3139e6..e9a9ce4f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2497,6 +2497,7 @@ F: net/filter-replay.c
 F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
+F: tests/acceptance/replay_kernel.py
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
new file mode 100644
index 0000000000..3208179789
--- /dev/null
+++ b/tests/acceptance/replay_kernel.py
@@ -0,0 +1,80 @@
+# Record/replay test that boots a Linux kernel
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import gzip
+
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import process
+from avocado.utils import archive
+
+class ReplayKernel(Test):
+    """
+    Boots a Linux kernel in record mode and checks that the console
+    is operational and the kernel command line is properly passed
+    from QEMU to the kernel.
+    Then replays the same scenario and verifies, that QEMU correctly
+    terminates.
+    """
+
+    timeout = 90
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    def wait_for_console_pattern(self, success_message, vm):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    def extract_from_deb(self, deb, path):
+        """
+        Extracts a file from a deb package into the test workdir
+
+        :param deb: path to the deb archive
+        :param path: path within the deb archive of the file to be extracted
+        :returns: path of the extracted file
+        """
+        cwd = os.getcwd()
+        os.chdir(self.workdir)
+        file_path = process.run("ar t %s" % deb).stdout_text.split()[2]
+        process.run("ar x %s %s" % (deb, file_path))
+        archive.extract(file_path, self.workdir)
+        os.chdir(cwd)
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_deb() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir,
+                                             os.path.relpath(path, '/')))
+
+    def run_vm(self, kernel_path, kernel_command_line, console_pattern, record, shift, args):
+        vm = self.get_vm()
+        vm.set_console()
+        if record:
+            mode = 'record'
+        else:
+            mode = 'replay'
+        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
+                    (shift, mode, os.path.join(self.workdir, 'replay.bin')),
+                    '-kernel', kernel_path,
+                    '-append', kernel_command_line,
+                    '-net', 'none',
+                    *args)
+        vm.launch()
+        self.wait_for_console_pattern(console_pattern, vm)
+        if record:
+            vm.shutdown()
+        else:
+            vm.wait()
+
+    def run_rr(self, kernel_path, kernel_command_line, console_pattern, shift=7, args=()):
+        self.run_vm(kernel_path, kernel_command_line, console_pattern, True, shift, args)
+        self.run_vm(kernel_path, kernel_command_line, console_pattern, False, shift, args)


