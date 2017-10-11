Received: from eggs.gnu.org ([2001:4830:134:3::10]:50227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6M-0006TG-8t
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6J-0000tI-6q
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e2M6I-0000sa-UX
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 11 Oct 2017 15:51:03 -0300
Message-Id: <20171011185103.26259-6-ehabkost@redhat.com>
In-Reply-To: <20171011185103.26259-1-ehabkost@redhat.com>
References: <20171011185103.26259-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] scripts: Remove debug parameter from
 QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

All scripts that use the QEMUMachine and QEMUQtestMachine classes
(device-crash-test, tests/migration/*, iotests.py, basevm.py)
already configure logging.

The basicConfig() call inside QEMUMachine.__init__() is being
kept just to make sure a script would still work if it didn't
configure logging.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171005172013.3098-4-ehabkost@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py                     | 6 ++----
 tests/migration/guestperf/engine.py | 6 ++----
 tests/qemu-iotests/iotests.py       | 2 --
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f6d2e68627..9bfdf6d37d 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -54,7 +54,7 @@ class QEMUMachine(object):
=20
     def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
-                 socket_scm_helper=3DNone, debug=3DFalse):
+                 socket_scm_helper=3DNone):
         '''
         Initialize a QEMUMachine
=20
@@ -65,7 +65,6 @@ class QEMUMachine(object):
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_s=
cm()"
-        @param debug: enable debug mode
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -85,12 +84,11 @@ class QEMUMachine(object):
         self._events =3D []
         self._iolog =3D None
         self._socket_scm_helper =3D socket_scm_helper
-        self._debug =3D debug
         self._qmp =3D None
         self._qemu_full_args =3D None
=20
         # just in case logging wasn't configured by the main script:
-        logging.basicConfig(level=3D(logging.DEBUG if debug else logging=
.WARN))
+        logging.basicConfig()
=20
     def __enter__(self):
         return self
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index 0a13050bc6..e14d4320b2 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -388,15 +388,13 @@ class Engine(object):
                                args=3Dself._get_src_args(hardware),
                                wrapper=3Dself._get_src_wrapper(hardware)=
,
                                name=3D"qemu-src-%d" % os.getpid(),
-                               monitor_address=3Dsrcmonaddr,
-                               debug=3Dself._debug)
+                               monitor_address=3Dsrcmonaddr)
=20
         dst =3D qemu.QEMUMachine(self._binary,
                                args=3Dself._get_dst_args(hardware, uri),
                                wrapper=3Dself._get_dst_wrapper(hardware)=
,
                                name=3D"qemu-dst-%d" % os.getpid(),
-                               monitor_address=3Ddstmonaddr,
-                               debug=3Dself._debug)
+                               monitor_address=3Ddstmonaddr)
=20
         try:
             src.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 36a7757aaf..6f057904a9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -195,8 +195,6 @@ class VM(qtest.QEMUQtestMachine):
         super(VM, self).__init__(qemu_prog, qemu_opts, name=3Dname,
                                  test_dir=3Dtest_dir,
                                  socket_scm_helper=3Dsocket_scm_helper)
-        if debug:
-            self._debug =3D True
         self._num_drives =3D 0
=20
     def add_device(self, opts):
--=20
2.13.6
