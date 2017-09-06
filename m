Received: from eggs.gnu.org ([2001:4830:134:3::10]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc92-0004GF-UE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8y-0007D1-TW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Sep 2017 10:21:07 -0500
Message-Id: <20170906152111.16958-2-eblake@redhat.com>
In-Reply-To: <20170906152111.16958-1-eblake@redhat.com>
References: <20170906152111.16958-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] iotests: rewrite 192 to use _launch_qemu to
 fix LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

The LUKS driver requires extra args to QEMU to setup passwords.
The _launch_qemu function takes care of this, so convert the
test to use this function and use correct -drive syntax

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170901105434.3288-2-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/192 | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index b50a2c0c8e..595f0d786a 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu

 _supported_fmt generic
 _supported_proto file
@@ -49,13 +50,21 @@ fi
 size=64M
 _make_test_img $size

-{
-echo "nbd_server_start unix:$TEST_DIR/nbd"
-echo "nbd_server_add -w drive0"
-echo "q"
-} | $QEMU -nodefaults -display none -monitor stdio \
-    -drive format=$IMGFMT,file=$TEST_IMG,if=ide,id=drive0 \
-    -incoming defer 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    DRIVE_ARG=if=ide,id=drive0,$TEST_IMG
+else
+    DRIVE_ARG=if=ide,id=drive0,format=$IMGFMT,file=$TEST_IMG
+fi
+
+qemu_comm_method="monitor"
+_launch_qemu -drive $DRIVE_ARG -incoming defer
+h=$QEMU_HANDLE
+QEMU_COMM_TIMEOUT=1
+
+_send_qemu_cmd $h "nbd_server_start unix:$TEST_DIR/nbd" "(qemu)"
+_send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
+_send_qemu_cmd $h "q" "(qemu)"

 # success, all done
 echo "*** done"
-- 
2.13.5
