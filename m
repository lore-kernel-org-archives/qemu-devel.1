Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A6FC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF5D20720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR43YNNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF5D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSMl-0004FG-V3
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ5-0005SE-FA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ3-0006FP-OU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:59 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:43806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSJ3-0006Eu-GP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:57 -0500
Received: by mail-pf1-x42e.google.com with SMTP id s1so1868564pfh.10
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=He5LBREQA24cBQ1DXRllAwt0MoWNHv1kGRWxO6ZPqnI=;
 b=SR43YNNMGbxY1vTaR4RDW89Uh8L6D+IpXlVAFCbJDS/1nXWa8NLCrXjZbGbeSc080R
 j+6f6tnCf3Dv519lByoIYvmlVa8YcY/SLAtnQiNd/HSyheGt6s5WrAU4DTsnau4k378a
 VmD8e01CAHBBrkzhFWixpMT1nOU679Xhess5UtY99ZXvH33+rRikkSD+qW/WIICaRg6r
 wumVk5KDMMXUq8FKFFIOP0ZGXk9ciKTrxIST++Rkvi3HYtROSkPTA9KZgixusfTsI4tG
 CyMQd8Sp6+I97WwgkRPusKTzdrN9g/WLhDpQXLdLoxwFh8ehQGjJYz0Na5gGp1eG0hCP
 +vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=He5LBREQA24cBQ1DXRllAwt0MoWNHv1kGRWxO6ZPqnI=;
 b=QUwM9fdJ/Z+rgldTEHNGE/gHRsVcGviGsKUYpbNcDK9MmJcxj7pq9Wu3iOzdOfQewF
 l0Gj8s7q2LiWEBLeV4/HDQNM4O6xEXTvZ2pvQVd4zn4fwSn31WlSMZHEPf6kW3j3PlE9
 0bceeM6j/z372F0BqvekaM0FXq8/L52+sI7zxGSFfHNzVIedx1/wnlgbe33J/Df3vRfv
 +VbRxeuD+d+BBDNDrEpRux7e2MBgtEmPKbVLSj3PfmBdwlGT8qNqfkZGB0j+L0NMvUQB
 kxszTzaatiVRY5IgGdNkLvsOjs7GXY75OrivyDkSvF8fKhcjm1uOQP4mF+vinQYSpvz+
 UC8g==
X-Gm-Message-State: APjAAAW/ArtQ5NgHQ/fUXxmmtdxvZ7zqe+4DpWUKGNBvRxuErrlmrdbF
 epYmRYdakeySjcwkDx2Y0LxAf2kqOjA=
X-Google-Smtp-Source: APXvYqymcO9f3yF2kK+paOlUyHAIM++uhZEqN6HEHZsejLmupi5EsbRMZmZdu9ATpxdFDGfvGrlaZA==
X-Received: by 2002:a62:342:: with SMTP id 63mr38753663pfd.19.1580938436042;
 Wed, 05 Feb 2020 13:33:56 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:55 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/14] tests/vm: Add logging of console to file.
Date: Wed,  5 Feb 2020 16:29:12 -0500
Message-Id: <20200205212920.467-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds logging of the char device used by the console
to a file.  The basevm.py then uses this file to read
chars from the console.
One reason to add this is to aid with debugging.
But another is because there is an issue where the QEMU
might hang if the characters from the character device
are not consumed by the script.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py        | 48 ++++++++++++++++++++++---
 tests/vm/socket_thread.py | 73 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 5 deletions(-)
 create mode 100644 tests/vm/socket_thread.py

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a926211da8..87a484c55c 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -31,12 +31,17 @@ import tempfile
 import shutil
 import multiprocessing
 import traceback
+from socket_thread import SocketThread
 
 SSH_KEY = open(os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")).read()
 SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
                    "..", "keys", "id_rsa.pub")).read()
 
+class ConsoleTimeoutException(Exception):
+    """Raise this exception when read from console times out."""
+    pass
+
 class BaseVM(object):
     GUEST_USER = "qemu"
     GUEST_PASS = "qemupass"
@@ -59,12 +64,18 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # This is the timeout on the wait for console bytes.
+    socket_timeout = 120
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
+    console_logfile = "console.log"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
+        self._console_fd = None
+        self._socket_thread = None
+        self._console_timeout_sec = self.socket_timeout
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -179,6 +190,15 @@ class BaseVM(object):
                             "-device",
                             "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
 
+    def init_console(self, socket):
+        """Init the thread to dump console to a file.
+           Also open the file descriptor we will use to
+           read from the console."""
+        self._socket_thread = SocketThread(socket, self.console_logfile)
+        self._console_fd = open(self.console_logfile, "r")
+        self._socket_thread.start()
+        print("console logfile is: {}".format(self.console_logfile))
+
     def boot(self, img, extra_args=[]):
         args = self._args + [
             "-device", "VGA",
@@ -201,6 +221,7 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        self.init_console(guest.console_socket)
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -212,9 +233,10 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
-        vm = self._guest
-        vm.console_socket.settimeout(timeout)
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
+        self._console_timeout_sec = timeout
 
     def console_log(self, text):
         for line in re.split("[\r\n]", text):
@@ -230,13 +252,27 @@ class BaseVM(object):
             # log console line
             sys.stderr.write("con recv: %s\n" % line)
 
+    def console_recv(self, n):
+        """Read n chars from the console_logfile being dumped to
+           by the socket thread we created earlier."""
+        start_time = time.time()
+        while True:
+            data = self._console_fd.read(1)
+            if data != "":
+                break
+            time.sleep(0.1)
+            elapsed_sec = time.time() - start_time
+            if elapsed_sec > self._console_timeout_sec:
+                raise ConsoleTimeoutException
+        return data.encode('latin1')
+
     def console_wait(self, expect, expectalt = None):
         vm = self._guest
         output = ""
         while True:
             try:
-                chars = vm.console_socket.recv(1)
-            except socket.timeout:
+                chars = self.console_recv(1)
+            except ConsoleTimeoutException:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
                 if not expectalt is None:
@@ -335,6 +371,8 @@ class BaseVM(object):
             raise Exception("Timeout while waiting for guest ssh")
 
     def shutdown(self):
+        self._socket_thread.join()
+        self._console_fd.close()
         self._guest.shutdown()
     def wait(self):
         self._guest.wait()
diff --git a/tests/vm/socket_thread.py b/tests/vm/socket_thread.py
new file mode 100644
index 0000000000..6160e9163d
--- /dev/null
+++ b/tests/vm/socket_thread.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python
+#
+# This python module defines a thread object which
+# reads from a socket and dumps it to a file.
+#
+# The main use case is for reading QEMU console char dev and
+# dumping them to a file either for debugging or for
+# parsing by QEMU itself.
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+import sys
+import re
+import threading
+import time
+import traceback
+import gettext
+
+class SocketThread(threading.Thread):
+    """ Implements the standard threading.Thread API.(start, join, etc.).
+        dumps all characters received on socket into a file.
+    """
+    def __init__(self, socket, filename):
+        super(SocketThread, self).__init__()
+        self.alive = threading.Event()
+        self.alive.set()
+        self.socket = socket
+        self.log_file = open(filename, "w")
+        self.debug = True
+
+    def receive(self):
+        """Until the user calls join, we will read chars from
+           the socket and dump them as is to the file."""
+        self.socket.setblocking(0)
+        self.socket.settimeout(1.0)
+        while self.alive.isSet():
+            try:
+                chars = self.socket.recv(1)
+            except:
+                continue
+            output = chars.decode("latin1")
+            self.log_file.write("{}".format(output))
+            # Flush the file since we need the characters to be
+            # always up to date in case someone is reading the file
+            # waiting for some characters to show up.
+            self.log_file.flush()
+        self.socket.setblocking(1)
+
+    def run(self):
+        """This is the main loop of the socket thread.
+           Simply receive from the file until the user
+           calls join."""
+        while self.alive.isSet():
+            try:
+                self.receive()
+            except Exception as e:
+                sys.stderr.write("Exception encountered\n")
+                traceback.print_exc()
+                continue
+
+    def join(self, timeout=None):
+        """Time to destroy the thread.
+           Clear the event to stop the thread, and wait for
+           it to complete."""
+        self.alive.clear()
+        threading.Thread.join(self, timeout)
+        self.log_file.close()
-- 
2.17.1


