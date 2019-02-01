Received: from eggs.gnu.org ([209.51.188.92]:39537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboO-00084A-9y
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboK-0000I6-9y
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:16 +0100
Message-Id: <20190201163518.31157-26-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/27] qtest.py: Wait for the result of qtest
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qtest.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index adf1fe3f26..afac3fe900 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -31,6 +31,7 @@ class QEMUQtestProtocol(object):
         """
         self._address =3D address
         self._sock =3D self._get_sock()
+        self._sockfile =3D None
         if server:
             self._sock.bind(self._address)
             self._sock.listen(1)
@@ -49,6 +50,7 @@ class QEMUQtestProtocol(object):
         @raise socket.error on socket connection errors
         """
         self._sock.connect(self._address)
+        self._sockfile =3D self._sock.makefile()
=20
     def accept(self):
         """
@@ -57,6 +59,7 @@ class QEMUQtestProtocol(object):
         @raise socket.error on socket connection errors
         """
         self._sock, _ =3D self._sock.accept()
+        self._sockfile =3D self._sock.makefile()
=20
     def cmd(self, qtest_cmd):
         """
@@ -65,9 +68,12 @@ class QEMUQtestProtocol(object):
         @param qtest_cmd: qtest command text to be sent
         """
         self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
+        resp =3D self._sockfile.readline()
+        return resp
=20
     def close(self):
         self._sock.close()
+        self._sockfile.close()
=20
     def settimeout(self, timeout):
         self._sock.settimeout(timeout)
--=20
2.20.1
