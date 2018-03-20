Received: from eggs.gnu.org ([2001:4830:134:3::10]:51583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBq-0000E9-NA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBp-0000So-W8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:24 +0100
Message-Id: <20180320173632.25480-5-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 04/12] qemu-iotests: Enable 025 for
 luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

We want to test resizing even for luks. The only change that is needed
is to explicitly zero out new space for luks because it's undefined.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/025 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f5e672e6b3..70dd5f10aa 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-_supported_fmt raw qcow2 qed
+_supported_fmt raw qcow2 qed luks
 _supported_proto file sheepdog rbd nfs
 _supported_os Linux
 
@@ -62,6 +62,13 @@ length
 EOF
 _check_test_img
 
+# bdrv_truncate() doesn't zero the new space, so we need to do that explicitly.
+# We still want to test automatic zeroing for other formats even though
+# bdrv_truncate() doesn't guarantee it.
+if [ "$IMGFMT" == "luks" ]; then
+    $QEMU_IO -c "write -z $small_size $((big_size - small_size))" "$TEST_IMG" > /dev/null
+fi
+
 echo
 echo "=== Verifying image size after reopen"
 $QEMU_IO -c "length" "$TEST_IMG"
-- 
2.13.6
