Received: from eggs.gnu.org ([2001:4830:134:3::10]:52833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0n-00011r-BS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0h-0006m3-Bm
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxC0h-0006lu-3Z
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BCF47E454
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 13:04:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:39 -0300
Message-Id: <20170927130339.21444-6-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-1-ehabkost@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] scripts: Remove debug parameter from
 QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

All scripts that use the QEMUMachine and QEMUQtestMachine classes
(device-crash-test, tests/migration/*, iotests.py, basevm.py)
already configure logging.

The basicConfig() call inside QEMUMachine.__init__() is being
kept just to make sure a script would still work if it didn't
configure logging.

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
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None, debug=False):
+                 socket_scm_helper=None):
         '''
         Initialize a QEMUMachine
 
@@ -65,7 +65,6 @@ class QEMUMachine(object):
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()"
-        @param debug: enable debug mode
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -85,12 +84,11 @@ class QEMUMachine(object):
         self._events = []
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
-        self._debug = debug
         self._qmp = None
         self._qemu_full_args = None
 
         # just in case logging wasn't configured by the main script:
-        logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
+        logging.basicConfig()
 
     def __enter__(self):
         return self
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index 0a13050bc6..e14d4320b2 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -388,15 +388,13 @@ class Engine(object):
                                args=self._get_src_args(hardware),
                                wrapper=self._get_src_wrapper(hardware),
                                name="qemu-src-%d" % os.getpid(),
-                               monitor_address=srcmonaddr,
-                               debug=self._debug)
+                               monitor_address=srcmonaddr)
 
         dst = qemu.QEMUMachine(self._binary,
                                args=self._get_dst_args(hardware, uri),
                                wrapper=self._get_dst_wrapper(hardware),
                                name="qemu-dst-%d" % os.getpid(),
-                               monitor_address=dstmonaddr,
-                               debug=self._debug)
+                               monitor_address=dstmonaddr)
 
         try:
             src.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 36a7757aaf..6f057904a9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -195,8 +195,6 @@ class VM(qtest.QEMUQtestMachine):
         super(VM, self).__init__(qemu_prog, qemu_opts, name=name,
                                  test_dir=test_dir,
                                  socket_scm_helper=socket_scm_helper)
-        if debug:
-            self._debug = True
         self._num_drives = 0
 
     def add_device(self, opts):
-- 
2.13.5
