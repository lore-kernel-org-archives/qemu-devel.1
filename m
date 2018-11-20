Received: from eggs.gnu.org ([2001:4830:134:3::10]:56583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kJ-0004O0-FQ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kI-0003Lv-Ma
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Nov 2018 18:22:51 +0100
Message-Id: <20181120172252.17800-2-kwolf@redhat.com>
In-Reply-To: <20181120172252.17800-1-kwolf@redhat.com>
References: <20181120172252.17800-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] iotests: Replace time.clock() with Timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

time.clock() is deprecated since Python 3.3. Current Python versions
warn that the function will be removed in Python 3.8, and those warnings
make the test case 118 fail.

Replace it with the Timeout mechanism that is compatible with both
Python 2 and 3, and makes the code even a little nicer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/118 | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index ff3b2ae3e7..c4f4c213ca 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -53,21 +53,17 @@ class ChangeBaseClass(iotests.QMPTestCase):
         if not self.has_real_tray:
             return
=20
-        timeout =3D time.clock() + 3
-        while not self.has_opened and time.clock() < timeout:
-            self.process_events()
-        if not self.has_opened:
-            self.fail('Timeout while waiting for the tray to open')
+        with iotests.Timeout(3, 'Timeout while waiting for the tray to o=
pen'):
+            while not self.has_opened:
+                self.process_events()
=20
     def wait_for_close(self):
         if not self.has_real_tray:
             return
=20
-        timeout =3D time.clock() + 3
-        while not self.has_closed and time.clock() < timeout:
-            self.process_events()
-        if not self.has_opened:
-            self.fail('Timeout while waiting for the tray to close')
+        with iotests.Timeout(3, 'Timeout while waiting for the tray to c=
lose'):
+            while not self.has_closed:
+                self.process_events()
=20
 class GeneralChangeTestsBaseClass(ChangeBaseClass):
=20
--=20
2.19.1
