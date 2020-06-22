Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76214C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F9C20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xar42K/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F9C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNeS-0005ZE-FD
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUm-00073f-KJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUk-0005g7-6e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id g18so7858384wrm.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SfCKKjXRpSzktD2zHuCdVYnzBzWod3odSIiX8dUA3RA=;
 b=Xar42K/1wjtXTgnbv0KVk7mQFYnxiGeu4JK4TeU0aAiM6kwk4XSzTnkRSCFiNHCWe7
 siWnL8D9HevP5Wv+vXMoZlwEy2thSP40n/u1gVFC1ABdURO3y9q9YH3VQYHW1HZBMIpj
 3EGy8AEfHXQRZSN9GbdMg4baZASUDbSa6cd8BAcH3Z7ndGfYCDYQ5lQFhM/pE+V+m6jr
 XTt42PKolpQP9oIzRkQHIMtfS73F7xEeAVP5w4nFZ3gELPd0DQBuqkTFdZ/NxWMsY2y7
 wKHuJyO+au0b11EEgGFEO6P1+Y+Ux7flXPHJwX9lDNPTYSoQVEDVcVDGscLcGhcJFCWy
 iDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SfCKKjXRpSzktD2zHuCdVYnzBzWod3odSIiX8dUA3RA=;
 b=Laa/xzEnPcUz6y/nBIEbNO5dJuQFr0MKxPROyifB5+tYR711vk5uxQ+tAegMd8XAxx
 xIGKfHplMHad1drytKtR2gmU0HGHVNyHQAiYLJdm5JMSDp3+WlJ8PamJHfq+xEu+GPdN
 L9kr3/OuMVlyRrOajcKiUuDs2jG01isAYZ7mp6BycR/njHGSDkJRndVA3YTspdSN3ei3
 aP4ZJ82A+BixUobqWY8lw+CQCJu8wcoDV/nMHqjqTT0iUQE5ji4CVxIvXUUIMtnxG9eA
 UWLDZQxjiyv/Y+t9CJOQriygpB8w174Dc2j1zkz/Q7VZOkt714L8rGJXjCaeuS0gba4C
 9dQw==
X-Gm-Message-State: AOAM533r3qPe2XLLUM2C+vCugdAkjumoVh/fAN0JP+eOk5XiobQpgIkf
 7h9eNOnWMATwiEj7Dd5dUitBHw==
X-Google-Smtp-Source: ABdhPJw+mNytSMdBKqjRwIGaWmbMZh1+4yMCyO/Wu8sCUNK2I0qcthqnjDUItiYCg3WwWyIdo4LigQ==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr17920774wro.125.1592836340554; 
 Mon, 22 Jun 2020 07:32:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm12311571wrq.39.2020.06.22.07.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7DED1FF98;
 Mon, 22 Jun 2020 15:32:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/18] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
Date: Mon, 22 Jun 2020 15:31:55 +0100
Message-Id: <20200622143204.12921-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 aurelien@aurel32.net, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

We add the ConsoleSocket object, which has a socket interface
and which will consume all arriving characters on the
socket, placing them into an in memory buffer.
This will also provide those chars via recv() as
would a regular socket.
ConsoleSocket also has the option of dumping
the console bytes to a log file.

We also give QEMUMachine the option of using ConsoleSocket
to drain and to use for logging console to a file.
By default QEMUMachine does not use ConsoleSocket.

This is added in preparation for use by basevm.py in a later commit.
This is a workaround we found was needed for basevm.py since
there is a known issue where QEMU will hang waiting
for console characters to be consumed.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-9-robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 110 ++++++++++++++++++++++++++++++++++
 python/qemu/machine.py        |  23 +++++--
 2 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100644 python/qemu/console_socket.py

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
new file mode 100644
index 00000000000..830cb7c6282
--- /dev/null
+++ b/python/qemu/console_socket.py
@@ -0,0 +1,110 @@
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
+        self._open = True
+        self._thread_start()
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
+            self._buffer.extend(c)
+
+    def recv(self, n=1, sleep_delay_s=0.1):
+        """Return chars from in memory buffer"""
+        start_time = time.time()
+        while len(self._buffer) < n:
+            time.sleep(sleep_delay_s)
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
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 041c615052e..c25f0b42cf6 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -26,6 +26,7 @@ import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
+from qemu.console_socket import ConsoleSocket
 
 from . import qmp
 
@@ -75,7 +76,8 @@ class QEMUMachine:
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None, sock_dir=None):
+                 socket_scm_helper=None, sock_dir=None,
+                 drain_console=False, console_log=None):
         '''
         Initialize a QEMUMachine
 
@@ -86,6 +88,9 @@ class QEMUMachine:
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()
+        @param sock_dir: where to create socket (overrides test_dir for sock)
+        @param console_log: (optional) path to console log file
+        @param drain_console: (optional) True to drain console socket to buffer
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -122,6 +127,12 @@ class QEMUMachine:
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._console_log_path = console_log
+        if self._console_log_path:
+            # In order to log the console, buffering needs to be enabled.
+            self._drain_console = True
+        else:
+            self._drain_console = drain_console
 
     def __enter__(self):
         return self
@@ -580,7 +591,11 @@ class QEMUMachine:
         Returns a socket connected to the console
         """
         if self._console_socket is None:
-            self._console_socket = socket.socket(socket.AF_UNIX,
-                                                 socket.SOCK_STREAM)
-            self._console_socket.connect(self._console_address)
+            if self._drain_console:
+                self._console_socket = ConsoleSocket(self._console_address,
+                                                    file=self._console_log_path)
+            else:
+                self._console_socket = socket.socket(socket.AF_UNIX,
+                                                     socket.SOCK_STREAM)
+                self._console_socket.connect(self._console_address)
         return self._console_socket
-- 
2.20.1


