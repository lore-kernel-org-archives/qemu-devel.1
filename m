Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dopMx-0002Nw-Fx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dopMs-0002Mm-Cq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:16:43 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Mon,  4 Sep 2017 13:16:16 +0200
Message-Id: <20170904111616.21333-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Make test 192 use QMP;
 convert it to Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, kwolf@redhat.com, dgilbert@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

The test 192 ("Test NBD export with '-incoming' (non-shared
storage migration use case from libvirt")) is currently using HMP.
Replace the HMP usage with QMP, as the upstream preference seems to be:
"Use QMP where possible, unless you're explicitly testing something
related to HMP".

While at it, convert the test from Bash to Python.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 tests/qemu-iotests/192     | 78 ++++++++++++++++++----------------------------
 tests/qemu-iotests/192.out | 14 ++++-----
 2 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index b50a2c0c8e2fccdddfae4ac58ca35937c5f784c6..692475f0a8c80c81396587d3289d4b32c0ee0d21 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -1,7 +1,4 @@
-#!/bin/bash
-#
-# Test NBD export with -incoming (non-shared storage migration use case from
-# libvirt)
+#!/usr/bin/env python
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
@@ -18,46 +15,33 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-
-# creator
-owner=famz@redhat.com
-
-seq=`basename $0`
-echo "QA output created by $seq"
-
-here=`pwd`
-status=1	# failure is the default!
-
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-
-_supported_fmt generic
-_supported_proto file
-_supported_os Linux
-
-if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
-    _notrun "Requires a PC machine"
-fi
-
-size=64M
-_make_test_img $size
-
-{
-echo "nbd_server_start unix:$TEST_DIR/nbd"
-echo "nbd_server_add -w drive0"
-echo "q"
-} | $QEMU -nodefaults -display none -monitor stdio \
-    -drive format=$IMGFMT,file=$TEST_IMG,if=ide,id=drive0 \
-    -incoming defer 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
-
-# success, all done
-echo "*** done"
-rm -f $seq.full
-status=0
+# Author: Kashyap Chamarthy <kchamart@redhat.com>
+#         [Converted to Python from the original Bash version by Fam
+#         Zheng (<famz@redhat.com)]
+#
+# Purpose: Test NBD export with '-incoming' (non-shared storage
+# migration use case from libvirt)
+
+import os
+import atexit
+import iotests
+
+iotests.verify_platform(['linux'])
+
+img_size = '1G'
+test_img_path = os.path.join(iotests.test_dir, 'dest.img')
+iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, test_img_path, img_size)
+
+iotests.log('Launching VM...')
+nbd_sock_path = os.path.join(iotests.test_dir, 'nbd.sock')
+dest_vm = (iotests.VM('dest').add_drive(test_img_path)
+                               .add_incoming('defer'))
+dest_vm.launch()
+atexit.register(dest_vm.shutdown)
+
+iotests.log('Launching NBD server on destination...')
+iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
+iotests.log('Exporting the block device to NBD server...')
+iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
+iotests.log('Stopping the NBD server on destination...')
+iotests.log(dest_vm.qmp('nbd-server-stop'))
diff --git a/tests/qemu-iotests/192.out b/tests/qemu-iotests/192.out
index 1e0be4c4d7a891f81c2536b87c5a29a21d39138c..f62b94c5641f1a1e60f17090aeb20ed0bc037afd 100644
--- a/tests/qemu-iotests/192.out
+++ b/tests/qemu-iotests/192.out
@@ -1,7 +1,7 @@
-QA output created by 192
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:TEST_DIR/nbd
-(qemu) nbd_server_add -w drive0
-(qemu) q
-*** done
+Launching VM...
+Launching NBD server on destination...
+{u'return': {}}
+Exporting the block device to NBD server...
+{u'return': {}}
+Stopping the NBD server on destination...
+{u'return': {}}
-- 
2.9.5
