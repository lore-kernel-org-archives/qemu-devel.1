Received: from eggs.gnu.org ([2001:4830:134:3::10]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXn8-0001LA-S4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXn8-00025W-5L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLXn7-000248-VU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Jun 2017 17:38:12 +0100
Message-Id: <20170615163813.7255-5-stefanha@redhat.com>
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qemu-iotests: 068: use -drive/-device
 instead of -hda
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

The legacy -hda option does not support -drive/-device parameters.  They
will be required by the next patch that extends this test case.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/068 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 653e23c..7292643 100755
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
-    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" |\
+    $QEMU $platform_parm -nographic -monitor stdio -serial none \
+          -drive if=none,id=drive0,file="$TEST_IMG",format="$IMGFMT" \
+          -device $hba,id=hba0 \
+          -device scsi-hd,drive=drive0 \
           "$@" |\
     _filter_qemu | _filter_hmp
 }
-- 
2.9.4
