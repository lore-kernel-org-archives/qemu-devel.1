Received: from eggs.gnu.org ([2001:4830:134:3::10]:43033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFat-0008If-Fv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFaj-0002ti-OR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Sep 2017 17:16:12 +0200
Message-Id: <20170905151614.31303-2-cohuck@redhat.com>
In-Reply-To: <20170905151614.31303-1-cohuck@redhat.com>
References: <20170905151614.31303-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] iotests: use -ccw on s390x for 040, 139,
 and 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The default cpu model on s390x does not provide zPCI, which is
not yet wired up on tcg. Moreover, virtio-ccw is the standard
on s390x, so use the -ccw instead of the -pci versions of virtio
devices on s390x.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/qemu-iotests/040 |  6 +++++-
 tests/qemu-iotests/139 | 12 ++++++++++--
 tests/qemu-iotests/182 | 13 +++++++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 95b7510571..c284d08796 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -82,7 +82,11 @@ class TestSingleDrive(ImageCommitTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
         self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=mid,backing.backing.node-name=base", interface="none")
-        self.vm.add_device("virtio-scsi-pci")
+        if iotests.qemu_default_machine == 's390-ccw-virtio':
+            self.vm.add_device("virtio-scsi-ccw")
+        else:
+            self.vm.add_device("virtio-scsi-pci")
+
         self.vm.add_device("scsi-hd,id=scsi0,drive=drive0")
         self.vm.launch()
 
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 50cf40fbd5..f8f02808a9 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -25,13 +25,21 @@ import time
 
 base_img = os.path.join(iotests.test_dir, 'base.img')
 new_img = os.path.join(iotests.test_dir, 'new.img')
+if iotests.qemu_default_machine == 's390-ccw-virtio':
+    default_virtio_blk = 'virtio-blk-ccw'
+else:
+    default_virtio_blk = 'virtio-blk-pci'
 
 class TestBlockdevDel(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
         self.vm = iotests.VM()
-        self.vm.add_device("virtio-scsi-pci,id=virtio-scsi")
+        if iotests.qemu_default_machine == 's390-ccw-virtio':
+            self.vm.add_device("virtio-scsi-ccw,id=virtio-scsi")
+        else:
+            self.vm.add_device("virtio-scsi-pci,id=virtio-scsi")
+
         self.vm.launch()
 
     def tearDown(self):
@@ -87,7 +95,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(node, expect_error)
 
     # Add a device model
-    def addDeviceModel(self, device, backend, driver = 'virtio-blk-pci'):
+    def addDeviceModel(self, device, backend, driver = default_virtio_blk):
         result = self.vm.qmp('device_add', id = device,
                              driver = driver, drive = backend)
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 7ecbb22604..2e078ceed8 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -45,17 +45,26 @@ _supported_os Linux
 
 size=32M
 
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      virtioblk=virtio-blk-ccw
+      ;;
+  *)
+      virtioblk=virtio-blk-pci
+      ;;
+esac
+
 _make_test_img $size
 
 echo "Starting QEMU"
 _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
-    -device virtio-blk-pci,drive=drive0
+    -device $virtioblk,drive=drive0
 
 echo
 echo "Starting a second QEMU using the same image should fail"
 echo 'quit' | $QEMU -monitor stdio \
     -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
-    -device virtio-blk-pci,drive=drive0 2>&1 | _filter_testdir 2>&1 |
+    -device $virtioblk,drive=drive0 2>&1 | _filter_testdir 2>&1 |
     _filter_qemu |
     sed -e '/falling back to POSIX file/d' \
         -e '/locks can be lost unexpectedly/d'
-- 
2.13.5
