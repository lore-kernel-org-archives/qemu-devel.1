Received: from eggs.gnu.org ([209.51.188.92]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg3-0004f2-66
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg1-0002IM-Ly
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Apr 2019 18:04:57 +0200
Message-Id: <20190412160458.23920-2-kwolf@redhat.com>
In-Reply-To: <20190412160458.23920-1-kwolf@redhat.com>
References: <20190412160458.23920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] iotests: Let 245 pass on tmpfs
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

tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
@direct if the filesystem does not support it.

Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/245 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a210c1..a04c6235c1 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -209,6 +209,12 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
     # Reopen an image several times changing some of its options
     def test_reopen(self):
+        # Check whether the filesystem supports O_DIRECT
+        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit'=
, hd_path[0]):
+            supports_direct =3D False
+        else:
+            supports_direct =3D True
+
         # Open the hd1 image passing all backing options
         opts =3D hd_opts(1)
         opts['backing'] =3D hd_opts(0)
@@ -231,9 +237,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(self.get_node('hd1'), 'cache/writeback', True)
         self.assert_qmp(self.get_node('hd1'), 'cache/direct', False)
         self.assert_qmp(self.get_node('hd1'), 'cache/no-flush', False)
-        self.reopen(opts, {'cache': { 'direct': True, 'no-flush': True }=
})
+        self.reopen(opts, {'cache': { 'direct': supports_direct, 'no-flu=
sh': True }})
         self.assert_qmp(self.get_node('hd1'), 'cache/writeback', True)
-        self.assert_qmp(self.get_node('hd1'), 'cache/direct', True)
+        self.assert_qmp(self.get_node('hd1'), 'cache/direct', supports_d=
irect)
         self.assert_qmp(self.get_node('hd1'), 'cache/no-flush', True)
=20
         # Reopen again with the original options
--=20
2.20.1
