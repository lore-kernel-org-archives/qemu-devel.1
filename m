Received: from eggs.gnu.org ([2001:4830:134:3::10]:57134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Ni5-00029N-GT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Ni0-0004pH-Pt
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:14:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 26 Apr 2017 16:14:07 +0200
Message-Id: <20170426141407.10161-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Launch qemu-nbd with -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

There is no reason for the qemu-nbd server used for tests not to accept
an arbitrary number of clients. In fact, test 181 will require it to
accept two clients at the same time (and thus it fails before this
patch).

This patch updates common.rc to launch qemu-nbd with -e 42 which should
be enough for all of our current and future tests.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 7d4781d4ad..31b888d4e9 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -168,7 +168,9 @@ _make_test_img()
 
     # Start an NBD server on the image file, which is what we'll be talking to
     if [ $IMGPROTO = "nbd" ]; then
-        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE >/dev/null &"
+        # Pass a sufficiently high number to -e that should be enough for all
+        # tests
+        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42  $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
 }
-- 
2.12.2
