Received: from eggs.gnu.org ([209.51.188.92]:38871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6I-0001nc-F5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6G-00027E-AT
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:48 +0100
Message-Id: <20190225152053.15976-67-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 66/71] iotests: Let 045 be run concurrently
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

From: Max Reitz <mreitz@redhat.com>

Adding a telnet monitor for no real purpose on a fixed port is not so
great.  Just use a null monitor instead.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190210145736.1486-10-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 scripts/qemu.py        | 5 ++---
 tests/qemu-iotests/045 | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 32b00af5cc..f7269eefbb 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -144,10 +144,9 @@ class QEMUMachine(object):
         return False
=20
     # This can be used to add an unused monitor instance.
-    def add_monitor_telnet(self, ip, port):
-        args =3D 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
+    def add_monitor_null(self):
         self._args.append('-monitor')
-        self._args.append(args)
+        self._args.append('null')
=20
     def add_fd(self, fd, fdset, opaque, opts=3D''):
         """
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 55a5d31ca8..d5484a0ee1 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -132,7 +132,7 @@ class TestSCMFd(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
         # Add an unused monitor, to verify it works fine when two monito=
r
         # instances present
-        self.vm.add_monitor_telnet("0",4445)
+        self.vm.add_monitor_null()
         self.vm.launch()
=20
     def tearDown(self):
--=20
2.20.1
