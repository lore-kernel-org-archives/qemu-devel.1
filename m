Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ABAC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71A8217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71A8217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcjYq-00014u-VG
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hcjQG-0001PR-BD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hcjQC-0005t3-UQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hcjQC-0005qA-1h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B44C309265C;
 Mon, 17 Jun 2019 04:39:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB893166A9;
 Mon, 17 Jun 2019 04:39:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 15E2617472; Mon, 17 Jun 2019 06:38:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 06:38:53 +0200
Message-Id: <20190617043858.8290-7-kraxel@redhat.com>
In-Reply-To: <20190617043858.8290-1-kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 17 Jun 2019 04:39:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 06/11] tests/vm: serial console support
 helpers
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a bunch of helpers to talk to the guest using the
serial console.

Also drop the hard-coded -serial parameter for the vm
so QEMUMachine.set_console() actually works.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/basevm.py | 86 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f27178f3c7c2..592a3447735f 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -2,10 +2,11 @@
 #
 # VM testing base class
 #
-# Copyright 2017 Red Hat Inc.
+# Copyright 2017-2019 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
+#  Gerd Hoffmann <kraxel@redhat.com>
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
@@ -13,7 +14,9 @@
 
 from __future__ import print_function
 import os
+import re
 import sys
+import socket
 import logging
 import time
 import datetime
@@ -79,8 +82,7 @@ class BaseVM(object):
             "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
-            "-vnc", "127.0.0.1:0,to=20",
-            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
+            "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
             self._args += ["-smp", "%d" % vcpus]
         if kvm_available(self.arch):
@@ -162,6 +164,8 @@ class BaseVM(object):
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
+        guest.set_machine('pc')
+        guest.set_console()
         try:
             guest.launch()
         except:
@@ -184,6 +188,82 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
+    def console_init(self, timeout = 120):
+        vm = self._guest
+        vm.console_socket.settimeout(timeout)
+
+    def console_log(self, text):
+        for line in re.split("[\r\n]", text):
+            # filter out terminal escape sequences
+            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
+            # replace unprintable chars
+            line = re.sub("\x1b", "<esc>", line)
+            line = re.sub("[\x00-\x1f]", ".", line)
+            line = re.sub("[\x80-\xff]", ".", line)
+            if line == "":
+                continue
+            # log console line
+            sys.stderr.write("con recv: %s\n" % line)
+
+    def console_wait(self, expect):
+        vm = self._guest
+        output = ""
+        while True:
+            try:
+                chars = vm.console_socket.recv(1)
+            except socket.timeout:
+                sys.stderr.write("console: *** read timeout ***\n")
+                sys.stderr.write("console: waiting for: '%s'\n" % expect)
+                sys.stderr.write("console: line buffer:\n")
+                sys.stderr.write("\n")
+                self.console_log(output.rstrip())
+                sys.stderr.write("\n")
+                raise
+            output += chars.decode("latin1")
+            if expect in output:
+                break
+            if "\r" in output or "\n" in output:
+                lines = re.split("[\r\n]", output)
+                output = lines.pop()
+                if self.debug:
+                    self.console_log("\n".join(lines))
+        if self.debug:
+            self.console_log(output)
+
+    def console_send(self, command):
+        vm = self._guest
+        if self.debug:
+            logline = re.sub("\n", "<enter>", command)
+            logline = re.sub("[\x00-\x1f]", ".", logline)
+            sys.stderr.write("con send: %s\n" % logline)
+        for char in list(command):
+            vm.console_socket.send(char.encode("utf-8"))
+            time.sleep(0.01)
+
+    def console_wait_send(self, wait, command):
+        self.console_wait(wait)
+        self.console_send(command)
+
+    def console_ssh_init(self, prompt, user, pw):
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        self.console_wait_send("login:",    "%s\n" % user)
+        self.console_wait_send("Password:", "%s\n" % pw)
+        self.console_wait_send(prompt,      "mkdir .ssh\n")
+        self.console_wait_send(prompt,      sshkey_cmd)
+        self.console_wait_send(prompt,      "chmod 755 .ssh\n")
+        self.console_wait_send(prompt,      "chmod 644 .ssh/authorized_keys\n")
+
+    def console_sshd_config(self, prompt):
+        self.console_wait(prompt)
+        self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        for var in self.envvars:
+            self.console_wait(prompt)
+            self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
+
+    def print_step(self, text):
+        sys.stderr.write("### %s ...\n" % text)
+
     def wait_ssh(self, seconds=300):
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-- 
2.18.1


