Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F029C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E2F2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E2F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtUG-0002zs-3c
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jdtLa-0002Cn-Nn
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:31:42 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33742)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jdtLZ-00028V-Iy
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:31:42 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 800E3CD463;
 Wed, 27 May 2020 13:31:40 +0300 (MSK)
Subject: [PATCH v2 11/11] tests/acceptance: Linux boot test for record/replay
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 27 May 2020 13:31:40 +0300
Message-ID: <159057550026.16818.11665839081165803832.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:30:39
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
Cc: wrampazz@redhat.com, alex.bennee@linaro.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a test for record/replay, which boots Linux
image from the disk and interacts with the network.
The idea and code of this test is borrowed from boot_linux.py
However, currently record/replay works only for x86_64,
therefore other tests were excluded.

Each test consists of the following phases:
 - downloading the disk image
 - recording the execution
 - replaying the execution

Replay does not validates the output, but waits until QEMU
finishes the execution. This is reasonable, because
QEMU usually hangs when replay goes wrong.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 0 files changed

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a9ce4f66..97f066a9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2498,6 +2498,7 @@ F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
 F: tests/acceptance/replay_kernel.py
+F: tests/acceptance/replay_linux.py
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/tests/acceptance/replay_linux.py b/tests/acceptance/replay_linux.py
new file mode 100644
index 0000000000..7c5971f156
--- /dev/null
+++ b/tests/acceptance/replay_linux.py
@@ -0,0 +1,97 @@
+# Record/replay test that boots a complete Linux system via a cloud image
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
+
+from avocado.utils import cloudinit
+from avocado.utils import network
+from avocado.utils import vmimage
+from avocado.utils import datadrainer
+from avocado.utils.path import find_command
+from boot_linux import BootLinuxBase
+
+class ReplayLinux(BootLinuxBase):
+    """
+    Boots a Linux system, checking for a successful initialization
+    """
+
+    timeout = 1800
+    chksum = None
+    hdd = 'ide-hd'
+    cd = 'ide-cd'
+    bus = 'ide'
+
+    def setUp(self):
+        super(ReplayLinux, self).setUp()
+        self.boot_path = self.download_boot()
+        self.cloudinit_path = self.download_cloudinit()
+
+    def vm_add_disk(self, vm, path, id, device):
+        bus_string = ''
+        if self.bus:
+            bus_string = ',bus=%s.%d' % (self.bus, id,)
+        vm.add_args('-drive', 'file=%s,snapshot,id=disk%s,if=none' % (path, id))
+        vm.add_args('-drive', 'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
+        vm.add_args('-device', '%s,drive=disk%s-rr%s' % (device, id, bus_string))
+
+    def launch_and_wait(self, record, args, shift):
+        vm = self.get_vm()
+        vm.add_args('-smp', '1')
+        vm.add_args('-m', '1024')
+        vm.add_args('-object', 'filter-replay,id=replay,netdev=hub0port0')
+        if args:
+            vm.add_args(*args)
+        self.vm_add_disk(vm, self.boot_path, 0, self.hdd)
+        self.vm_add_disk(vm, self.cloudinit_path, 1, self.cd)
+        if record:
+            mode = 'record'
+        else:
+            mode = 'replay'
+        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
+                    (shift, mode, os.path.join(self.workdir, 'replay.bin')))
+
+        vm.set_console()
+        vm.launch()
+        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
+                                                 logger=self.log.getChild('console'),
+                                                 stop_check=(lambda : not vm.is_running()))
+        console_drainer.start()
+        if record:
+            self.log.info('VM launched, waiting for boot confirmation from guest')
+            cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port), self.name)
+            vm.shutdown()
+        else:
+            self.log.info('VM launched, waiting the recorded execution to be replayed')
+            vm.wait()
+
+    def run_rr(self, args=None, shift=7):
+        self.launch_and_wait(True, args, shift)
+        self.launch_and_wait(False, args, shift)
+
+class ReplayLinuxX8664(ReplayLinux):
+    """
+    :avocado: tags=arch:x86_64
+    """
+
+    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
+
+    def test_pc_i440fx(self):
+        """
+        :avocado: tags=machine:pc
+        :avocado: tags=accel:tcg
+        """
+        self.run_rr(shift=1)
+
+    def test_pc_q35(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=accel:tcg
+        """
+        self.run_rr(shift=3)


