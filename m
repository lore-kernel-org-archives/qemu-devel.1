Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cat-0001jq-Va
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cat-0001H4-4F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:22 +0200
Message-Id: <1493411622-5343-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/34] iotests: Launch qemu-nbd with -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

There is no reason for the qemu-nbd server used for tests not to accept
an arbitrary number of clients. In fact, test 181 will require it to
accept two clients at the same time (and thus it fails before this
patch).

This patch updates common.rc to launch qemu-nbd with -e 42 which should
be enough for all of our current and future tests.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 62529ee..9fd3130 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -171,7 +171,9 @@ _make_test_img()
 
     # Start an NBD server on the image file, which is what we'll be talking to
     if [ $IMGPROTO = "nbd" ]; then
-        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE >/dev/null &"
+        # Pass a sufficiently high number to -e that should be enough for all
+        # tests
+        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42  $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
 
-- 
1.8.3.1
