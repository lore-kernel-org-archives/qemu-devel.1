Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXnD-0001Po-Vs
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXnA-00026B-IB
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLXnA-00025r-Bh
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Jun 2017 17:38:13 +0100
Message-Id: <20170615163813.7255-6-stefanha@redhat.com>
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] qemu-iotests: 068: test iothread mode
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

Perform the savevm/loadvm test with both iothread on and off.  This
covers the recently found savevm/loadvm hang when iothread is enabled.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/068     | 23 ++++++++++++++---------
 tests/qemu-iotests/068.out | 11 ++++++++++-
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 7292643..3801b65 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -45,11 +45,6 @@ _supported_os Linux
 IMGOPTS="compat=1.1"
 IMG_SIZE=128K
 
-echo
-echo "=== Saving and reloading a VM state to/from a qcow2 image ==="
-echo
-_make_test_img $IMG_SIZE
-
 case "$QEMU_DEFAULT_MACHINE" in
   s390-ccw-virtio)
       platform_parm="-no-shutdown"
@@ -71,10 +66,20 @@ _qemu()
     _filter_qemu | _filter_hmp
 }
 
-# Give qemu some time to boot before saving the VM state
-bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
-# Now try to continue from that VM state (this should just work)
-echo quit | _qemu -loadvm 0
+for extra_args in \
+    "" \
+    "-object iothread,id=iothread0 -set device.hba0.iothread=iothread0"; do
+    echo
+    echo "=== Saving and reloading a VM state to/from a qcow2 image ($extra_args) ==="
+    echo
+
+    _make_test_img $IMG_SIZE
+
+    # Give qemu some time to boot before saving the VM state
+    bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu $extra_args
+    # Now try to continue from that VM state (this should just work)
+    echo quit | _qemu $extra_args -loadvm 0
+done
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/068.out b/tests/qemu-iotests/068.out
index 0fa5340..aa063cf 100644
--- a/tests/qemu-iotests/068.out
+++ b/tests/qemu-iotests/068.out
@@ -1,6 +1,15 @@
 QA output created by 068
 
-=== Saving and reloading a VM state to/from a qcow2 image ===
+=== Saving and reloading a VM state to/from a qcow2 image () ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm 0
+(qemu) quit
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+=== Saving and reloading a VM state to/from a qcow2 image (-object iothread,id=iothread0 -set device.hba0.iothread=iothread0) ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.9.4
