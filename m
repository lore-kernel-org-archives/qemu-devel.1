Received: from eggs.gnu.org ([2001:4830:134:3::10]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLo-0000yl-1E
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLk-0007Z3-Bo
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:12 +0200
Message-Id: <1498234919-27316-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/61] qemu-iotests: 068: use -drive/-device
 instead of -hda
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The legacy -hda option does not support -drive/-device parameters.  They
will be required by the next patch that extends this test case.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/068 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 61936d5..7292643 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -53,15 +53,20 @@ _make_test_img $IMG_SIZE
 case "$QEMU_DEFAULT_MACHINE" in
   s390-ccw-virtio)
       platform_parm="-no-shutdown"
+      hba=virtio-scsi-ccw
       ;;
   *)
       platform_parm=""
+      hba=virtio-scsi-pci
       ;;
 esac
 
 _qemu()
 {
-    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" \
+    $QEMU $platform_parm -nographic -monitor stdio -serial none \
+          -drive if=none,id=drive0,file="$TEST_IMG",format="$IMGFMT" \
+          -device $hba,id=hba0 \
+          -device scsi-hd,drive=drive0 \
           "$@" |\
     _filter_qemu | _filter_hmp
 }
-- 
1.8.3.1
