Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B179AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C4622522
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXaqgeHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C4622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjky-0004J8-2A
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbM-0005cj-OH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjbK-0002Zm-FW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:36 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:53722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjbK-0002Yr-6N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:34 -0400
Received: by mail-pj1-x102c.google.com with SMTP id l36so777433pjb.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WguiU1MpCfikMD0tIg2PmMZ5FyB6ak1jQimxWfvBjhM=;
 b=XXaqgeHsQ6TTpUb1LJjXFiM7cdPqq4158BfYtItZ2bOAXmJuKq4GbMB0aRFQtukL6k
 79dhgUfUO4oKgex4ztcLwBCZ73Cwy3d6TNJFOzJ/2F5kpIiGWBuH34jcOd5vBz3dNQbx
 HL5aZIlqXxAEPqWTh41bWicF7vqmIktR0rrC/rhSbvJt9o33Ulkyzpsbl+W9krFRYlZi
 CQGLDBYGt/QDk94TPqvRu3q8lwa4fYiP4U81PKQIhGgEx3BM03IRZxk/oDClcCyHvJWF
 Qd6iI4hd/JCbT2OydnvSl4oTOJ/qV23oE6PfEbx4XrVbN5d49qpGZOPVJl0HfFyXoqPE
 uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WguiU1MpCfikMD0tIg2PmMZ5FyB6ak1jQimxWfvBjhM=;
 b=Gf9PV+dMJkZ2o1qPAIhgdnd3qj+dZmX86Oeo2nYBOPhYAzO9kWiDVXECPW2mvGKjLi
 yk6KX+EfA4354Dw4FnOqx1d+RkN9pGhzaJ0gucGxGz5pgEmVsePAYPo2BsX/JR10Gcq6
 12RbpQCRmxg2dg3iFymzEXsG/WQ2lF+RSm4ibTkqO2tA9jfxMRR9yAJikZGO9pqa8AmX
 o3Nq3H4GcG4YjuARpoDsbXsxp4j8z2keODYtgrGsYxCzII86hZzAEDtomIsreHrvglON
 xp6VmS1vnURF1F5UBo84Z6sM7ar8MHcLechpeAXO+4OqC6pdmDT3M4Zkoj7rdfUt52I3
 FeHg==
X-Gm-Message-State: ANhLgQ3Kg8DXeAzDyxUgsugH16P7zI5yt1eaGgHALHuQ/pqPMGf0uiCe
 zE7Efcfw5BXQloquexQfxjTq7WVlKjw=
X-Google-Smtp-Source: ADFU+vtahLjHVyKSEEKT16QUT4Jt+vcG9Z+xx6YAfFHPfphyCnnge+6jYQMbDWkevdfci0l38qO6Xg==
X-Received: by 2002:a17:902:d915:: with SMTP id
 c21mr11813164plz.239.1583864852545; 
 Tue, 10 Mar 2020 11:27:32 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:27:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/10] tests/vm: Add workaround to consume console
Date: Tue, 10 Mar 2020 14:25:36 -0400
Message-Id: <20200310182536.11137-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182536.11137-1-robert.foley@linaro.org>
References: <20200310182536.11137-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102c
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
 tests/vm/basevm.py            |  23 ++++-
 4 files changed, 193 insertions(+), 8 deletions(-)
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
index 75868d3b37..71595d2d25 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -50,6 +50,7 @@ endif
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
 	@echo "    BOOT_CONSOLE=1        	 - Show the console output at boot time. "
+	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
@@ -85,6 +86,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
@@ -102,6 +104,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
@@ -126,6 +129,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(BOOT_CONSOLE),--boot-console) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index bd4a1f9639..998c5d54c1 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -81,12 +81,14 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # This is the timeout on the wait for console bytes.
+    socket_timeout = 120
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None, config=None,
-                 boot_console=False, build_path=None):
+                 boot_console=False, build_path=None, log_console=False):
         self._guest = None
         self._build_path = build_path
         self._boot_console = boot_console
@@ -113,6 +115,11 @@ class BaseVM(object):
         open(self._ssh_tmp_pub_key_file,
              "w").write(self._config['ssh_pub_key'])
 
+        self._console_log_path = None
+        if log_console:
+                self._console_log_path = \
+                         os.path.join(os.path.expanduser("~/.cache/qemu-vm"),
+                                      "{}.install.log".format(self.name))
         self.debug = debug
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
@@ -259,7 +266,8 @@ class BaseVM(object):
         args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_path = get_qemu_path(self.arch, self._build_path)
-        guest = QEMUMachine(binary=qemu_path, args=args)
+        guest = QEMUMachine(binary=qemu_path, args=args,
+                            console_log=self._console_log_path)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -273,6 +281,8 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        # Init console so we can start consuming the chars.
+        self.console_init()
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -284,7 +294,9 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
         vm = self._guest
         vm.console_socket.settimeout(timeout)
 
@@ -559,6 +571,8 @@ def parse_args(vmcls):
                       help="Show console during boot. ")
     parser.add_option("--build-path", default=None,
                       help="Path of build directory. ")
+    parser.add_option("--log-console", action="store_true",
+                      help="Log console to file.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -575,7 +589,8 @@ def main(vmcls, config=None):
                                    else logging.WARN))
         vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config,
                    boot_console=args.boot_console,
-                   build_path=args.build_path)
+                   build_path=args.build_path,
+                   log_console=args.log_console)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


