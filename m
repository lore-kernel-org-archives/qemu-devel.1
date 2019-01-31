Received: from eggs.gnu.org ([209.51.188.92]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gpBcf-0007w3-KI
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gpBcR-0005N5-Az
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:39:05 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 31 Jan 2019 14:38:10 +0200
Message-Id: <20190131123810.10233-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qtest.py: Wait for the result of qtest commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Peter Xu <peterx@redhat.com>

The cmd() method of the QEMUQtestProtocol class sends a qtest command
to QEMU but doesn't wait for the return message ("OK", "FAIL", "ERR").
Because of this, it can return control to the caller before the
command has actually finished.

In cases like clock_step or clock_set this means that cmd() can return
before all the timers triggered by the clock change have been fired.
This can be fixed by making cmd() wait for the output of the qtest
command.

This fixes iotests 093 and 136, which are flaky since commit
8258292e18c39480b64eba9f3551 when the machine is under heavy workload.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 scripts/qtest.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index adf1fe3f26..afac3fe900 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -31,6 +31,7 @@ class QEMUQtestProtocol(object):
         """
         self._address = address
         self._sock = self._get_sock()
+        self._sockfile = None
         if server:
             self._sock.bind(self._address)
             self._sock.listen(1)
@@ -49,6 +50,7 @@ class QEMUQtestProtocol(object):
         @raise socket.error on socket connection errors
         """
         self._sock.connect(self._address)
+        self._sockfile = self._sock.makefile()
 
     def accept(self):
         """
@@ -57,6 +59,7 @@ class QEMUQtestProtocol(object):
         @raise socket.error on socket connection errors
         """
         self._sock, _ = self._sock.accept()
+        self._sockfile = self._sock.makefile()
 
     def cmd(self, qtest_cmd):
         """
@@ -65,9 +68,12 @@ class QEMUQtestProtocol(object):
         @param qtest_cmd: qtest command text to be sent
         """
         self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
+        resp = self._sockfile.readline()
+        return resp
 
     def close(self):
         self._sock.close()
+        self._sockfile.close()
 
     def settimeout(self, timeout):
         self._sock.settimeout(timeout)
-- 
2.11.0
