Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A19C3405E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE05206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heNDNZA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE05206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4So8-0007Wv-3S
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOG-00034y-BN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOE-00082i-66
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:00 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:38148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SOD-00082I-TW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:58 -0500
Received: by mail-pg1-x52f.google.com with SMTP id d6so364935pgn.5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3Rcexh5kqSFADdUujEVkhgsAb5ir6oyYtsJro9Fnu0Q=;
 b=heNDNZA3hcSKTgtctVsDu/zjP/4GhzGO7wcMU6LGxq4XXUHi2PLcAlh2fTTjfzM+XZ
 zC/x0WuFeLWSXS+OVHfY3hI6a1vmJJPTlGyJMSHImbigKor2j8t00l0vJTKU6x8Tnu3z
 5tPhJxTAbSmYncQruKJI+q34dwtV6TJudwbG+2lpHyH9M3pxzZiDAdjtBJ5aDahZwEii
 0lBzKdvtUD5iimIAU83k3wIonYcSsoWoGyZrxFrqp+YYUn1dKlc/Gf6q40Rju4mTsvdy
 zndLgQeKaugKxyPIf6qZYy/JW3BahDTEiV+nhs3rha2cHWUJb2vhEM5Dn3LF06XzlAYo
 RWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3Rcexh5kqSFADdUujEVkhgsAb5ir6oyYtsJro9Fnu0Q=;
 b=UkEaPJcypXLvdnGZy0dy5zCnSziqh3FVFTeuqjbICXHfmUWOj/0yvtGS50PZe9G4Ta
 e/EtGhoKOMvwyqfOc6hAZ/P5HYxvXrTDcowonl9577+RRAzRxbcRAc2PvqqVkC8I/LZT
 lSrwTWsEAJqYsgorC8bE3cGiJRNQ5p23P++Qc01/rnFTH8bG3cj4fxUe6qjtf2papziG
 k1Mhyw/sHUOv+ApGNdeqdLBt4/O8ZXrtlTt3rJ0xj8/qhX2q5BCINRoy/l49l2BEMFaa
 3RilDhRT6YM+oM3YdU5mjURIvn7myjO6ua5u+WUlO9FDe70CncXR1Psec52CqLFMTF+e
 0ifA==
X-Gm-Message-State: APjAAAVvLpRmUMX+nBVmOXpALK4e/75Hh0GnZXGrlKYVi6YwzHpz24tO
 Tu5wHutAamxjywOT8nbyozvATBGTnAY=
X-Google-Smtp-Source: APXvYqzHj78rZRXm5CiKOmfnxh8TZQ26VVi1XMmPQhcHhEwPBieBB/DbAKKsTliu0YZwFklpqf/taA==
X-Received: by 2002:a63:5903:: with SMTP id n3mr29788938pgb.25.1582130396079; 
 Wed, 19 Feb 2020 08:39:56 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:55 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/14] tests/vm: Add workaround to consume console
Date: Wed, 19 Feb 2020 11:35:29 -0500
Message-Id: <20200219163537.22098-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ConsoleSocket object provides a socket interface
which will consume all arriving characters on the
socket, but will provide those chars via recv() as
would a regular socket.
This is a workaround we found was needed since
there is a known issue where QEMU will hang waiting
for console characters to be consumed.
We also add the option of logging the console to a file.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 162 ++++++++++++++++++++++++++++++++++
 python/qemu/machine.py        |  12 ++-
 tests/vm/Makefile.include     |   4 +
 tests/vm/basevm.py            |  24 ++++-
 4 files changed, 194 insertions(+), 8 deletions(-)
 create mode 100644 python/qemu/console_socket.py

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
new file mode 100644
index 0000000000..a1f74e60ac
--- /dev/null
+++ b/python/qemu/console_socket.py
@@ -0,0 +1,162 @@
+#!/usr/bin/env python3
+#
+# This python module implements a ConsoleSocket object which is
+# designed always drain the socket itself, and place
+# the bytes into a in memory buffer for later processing.
+#
+# Optionally a file path can be passed in and we will also
+# dump the characters to this file for debug.
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+import asyncore
+import socket
+import threading
+import io
+import os
+import sys
+from collections import deque
+import time
+import traceback
+
+class ConsoleSocket(asyncore.dispatcher):
+
+    def __init__(self, address, file=None):
+        self._recv_timeout_sec = 300
+        self._buffer = deque()
+        self._asyncore_thread = None
+        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        self._sock.connect(address)
+        self._logfile = None
+        if file:
+            self._logfile = open(file, "w")
+        asyncore.dispatcher.__init__(self, sock=self._sock)
+        self._thread_start()
+        self._open = True
+
+    def _thread_start(self):
+        """Kick off a thread to wait on the asyncore.loop"""
+        if self._asyncore_thread is not None:
+            return
+        self._asyncore_thread = threading.Thread(target=asyncore.loop,
+                                                 kwargs={'timeout':1})
+        self._asyncore_thread.daemon = True
+        self._asyncore_thread.start()
+
+    def handle_close(self):
+        """redirect close to base class"""
+        # Call the base class close, but not self.close() since
+        # handle_close() occurs in the context of the thread which
+        # self.close() attempts to join.
+        asyncore.dispatcher.close(self)
+
+    def close(self):
+        """Close the base object and wait for the thread to terminate"""
+        if self._open:
+            self._open = False
+            asyncore.dispatcher.close(self)
+            if self._asyncore_thread is not None:
+                thread, self._asyncore_thread = self._asyncore_thread, None
+                thread.join()
+            if self._logfile:
+                self._logfile.close()
+                self._logfile = None
+
+    def handle_read(self):
+        """process arriving characters into in memory _buffer"""
+        try:
+            data = asyncore.dispatcher.recv(self, 1)
+            # latin1 is needed since there are some chars
+            # we are receiving that cannot be encoded to utf-8
+            # such as 0xe2, 0x80, 0xA6.
+            string = data.decode("latin1")
+        except:
+            print("Exception seen.")
+            traceback.print_exc()
+            return
+        if self._logfile:
+            self._logfile.write("{}".format(string))
+            self._logfile.flush()
+        for c in string:
+            self._buffer.append(c)
+
+    def recv(self, n=1):
+        """Return chars from in memory buffer"""
+        start_time = time.time()
+        while len(self._buffer) < n:
+            time.sleep(0.1)
+            elapsed_sec = time.time() - start_time
+            if elapsed_sec > self._recv_timeout_sec:
+                raise socket.timeout
+        chars = ''.join([self._buffer.popleft() for i in range(n)])
+        # We choose to use latin1 to remain consistent with
+        # handle_read() and give back the same data as the user would
+        # receive if they were reading directly from the
+        # socket w/o our intervention.
+        return chars.encode("latin1")
+
+    def set_blocking(self):
+        """Maintain compatibility with socket API"""
+        pass
+
+    def settimeout(self, seconds):
+        """Set current timeout on recv"""
+        self._recv_timeout_sec = seconds
+
+class ByteBuffer(deque):
+    """Simple in memory buffer with read/write interface"""
+    def write(self, bytes):
+        for i in bytes:
+            self.append(i)
+    def read(self, n):
+        return ''.join([self.popleft() for i in range(n)])
+
+if __name__ == '__main__':
+    # Brief test to exercise the above code.
+    # The ConsoleSocket will ship some data to the server,
+    # the server will echo it back and the client will echo what it received.
+
+    # First remove the socket.
+    address = "./test_console_socket"
+    if os.path.exists(address):
+        os.unlink(address)
+
+    # Create the server side.
+    server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+    server_socket.bind(address)
+    server_socket.listen(1)
+
+    # Create the object we are trying to test.
+    console_socket = ConsoleSocket(address, file="./logfile.txt")
+
+    # Generate some data and ship it over the socket.
+    send_data = ""
+    for i in range(10):
+        send_data += "this is a test message {}\n".format(i)
+    console_socket.send(send_data.encode('latin1'))
+    connection, client_address = server_socket.accept()
+
+    # Process the data on the server and ship it back.
+    data = connection.recv(len(send_data))
+    print("server received: {}".format(data))
+    print("server: sending data back to the client")
+    connection.sendall(data)
+
+    # Client receives teh bytes and displays them.
+    print("client: receiving bytes")
+    bytes = console_socket.recv(len(data))
+    recv_data = bytes.decode('latin1')
+    print("client received: {}".format(recv_data))
+    assert(recv_data == send_data)
+    # Close console connection first, then close server.
+    console_socket.close()
+    connection.close()
+    server_socket.close()
+    print("test successful.")
+
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..6a4a5c2845 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -24,6 +24,7 @@ import subprocess
 import shutil
 import socket
 import tempfile
+from qemu.console_socket import ConsoleSocket
 
 from . import qmp
 
@@ -71,7 +72,8 @@ class QEMUMachine(object):
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None, sock_dir=None):
+                 socket_scm_helper=None, sock_dir=None,
+                 console_log=None):
         '''
         Initialize a QEMUMachine
 
@@ -82,6 +84,8 @@ class QEMUMachine(object):
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()
+        @param sock_dir: where to create socket (overrides test_dir for sock)
+        @param console_log: (optional) path to console log file
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -118,6 +122,7 @@ class QEMUMachine(object):
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._console_log_path = console_log
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -566,7 +571,6 @@ class QEMUMachine(object):
         Returns a socket connected to the console
         """
         if self._console_socket is None:
-            self._console_socket = socket.socket(socket.AF_UNIX,
-                                                 socket.SOCK_STREAM)
-            self._console_socket.connect(self._console_address)
+            self._console_socket = ConsoleSocket(self._console_address,
+                                                 file=self._console_log_path)
         return self._console_socket
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 778e506755..76a1bd7fe8 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -32,6 +32,7 @@ vm-help vm-test:
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
@@ -48,6 +49,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 	$(call quiet-command, \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$@" \
 		--force \
 		--build-image $@, \
@@ -62,6 +64,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
@@ -82,6 +85,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
 		--interactive \
 		false, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 8400b0e07f..a22b59b23c 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,11 +57,14 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # This is the timeout on the wait for console bytes.
+    socket_timeout = 120
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None):
+    def __init__(self, debug=False, vcpus=None,
+                 log_console=False):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
@@ -75,6 +78,11 @@ class BaseVM(object):
         self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
         open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
 
+        self._console_log_path = None
+        if log_console:
+                self._console_log_path = \
+                         os.path.join(os.path.expanduser("~/.cache/qemu-vm"),
+                                      "{}.install.log".format(self.name))
         self.debug = debug
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
@@ -185,7 +193,8 @@ class BaseVM(object):
         args += self._data_args + extra_args
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
-        guest = QEMUMachine(binary=qemu_bin, args=args)
+        guest = QEMUMachine(binary=qemu_bin, args=args,
+                            console_log=self._console_log_path)
         guest.set_machine('pc')
         guest.set_console()
         try:
@@ -199,6 +208,8 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        # Init console so we can start consuming the chars.
+        self.console_init()
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -210,7 +221,9 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
         vm = self._guest
         vm.console_socket.settimeout(timeout)
 
@@ -419,6 +432,8 @@ def parse_args(vmcls):
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
                       help="run tests with a snapshot")
+    parser.add_option("--log-console", action="store_true",
+                      help="Log console to file.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -430,7 +445,8 @@ def main(vmcls):
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs,
+                   log_console=args.log_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


