Received: from eggs.gnu.org ([2001:4830:134:3::10]:60676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYbX-0002ku-7w
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYbW-0004b2-1m
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:38:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYbV-0004a4-OU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:38:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Nov 2017 10:37:21 +0000
Message-Id: <20171114103721.13869-6-stefanha@redhat.com>
In-Reply-To: <20171114103721.13869-1-stefanha@redhat.com>
References: <20171114103721.13869-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc2 5/5] qemu-iotests: Test I/O limits
 with removable media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alberto Garcia <berto@igalia.com>

This test hotplugs a CD drive to a VM and checks that I/O limits can
be set only when the drive has media inserted and that they are kept
when the media is replaced.

This also tests the removal of a device with valid I/O limits set but
no media inserted. This involves deleting and disabling the limits
of a BlockBackend without BlockDriverState, a scenario that has been
crashing until the fixes from the last couple of patches.

[Python PEP8 fixup: "Don't use spaces are the = sign when used to
indicate a keyword argument or a default parameter value"
--Stefan]

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/093     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/093.out |  4 +--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index ef3997206b..5c36a5fb4d 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -308,6 +308,68 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
             groupname = "group%d" % i
             self.verify_name(devname, groupname)
 
+class ThrottleTestRemovableMedia(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm = iotests.VM()
+        if iotests.qemu_default_machine == 's390-ccw-virtio':
+            self.vm.add_device("virtio-scsi-ccw,id=virtio-scsi")
+        else:
+            self.vm.add_device("virtio-scsi-pci,id=virtio-scsi")
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_removable_media(self):
+        # Add a couple of dummy nodes named cd0 and cd1
+        result = self.vm.qmp("blockdev-add", driver="null-aio",
+                             node_name="cd0")
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp("blockdev-add", driver="null-aio",
+                             node_name="cd1")
+        self.assert_qmp(result, 'return', {})
+
+        # Attach a CD drive with cd0 inserted
+        result = self.vm.qmp("device_add", driver="scsi-cd",
+                             id="dev0", drive="cd0")
+        self.assert_qmp(result, 'return', {})
+
+        # Set I/O limits
+        args = { "id": "dev0", "iops": 100, "iops_rd": 0, "iops_wr": 0,
+                                "bps":  50,  "bps_rd": 0,  "bps_wr": 0 }
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **args)
+        self.assert_qmp(result, 'return', {})
+
+        # Check that the I/O limits have been set
+        result = self.vm.qmp("query-block")
+        self.assert_qmp(result, 'return[0]/inserted/iops', 100)
+        self.assert_qmp(result, 'return[0]/inserted/bps',   50)
+
+        # Now eject cd0 and insert cd1
+        result = self.vm.qmp("blockdev-open-tray", id='dev0')
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp("x-blockdev-remove-medium", id='dev0')
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp("x-blockdev-insert-medium", id='dev0', node_name='cd1')
+        self.assert_qmp(result, 'return', {})
+
+        # Check that the I/O limits are still the same
+        result = self.vm.qmp("query-block")
+        self.assert_qmp(result, 'return[0]/inserted/iops', 100)
+        self.assert_qmp(result, 'return[0]/inserted/bps',   50)
+
+        # Eject cd1
+        result = self.vm.qmp("x-blockdev-remove-medium", id='dev0')
+        self.assert_qmp(result, 'return', {})
+
+        # Check that we can't set limits if the device has no medium
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **args)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+        # Remove the CD drive
+        result = self.vm.qmp("device_del", id='dev0')
+        self.assert_qmp(result, 'return', {})
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=["raw"])
diff --git a/tests/qemu-iotests/093.out b/tests/qemu-iotests/093.out
index 2f7d3902f2..594c16f49f 100644
--- a/tests/qemu-iotests/093.out
+++ b/tests/qemu-iotests/093.out
@@ -1,5 +1,5 @@
-.......
+........
 ----------------------------------------------------------------------
-Ran 7 tests
+Ran 8 tests
 
 OK
-- 
2.13.6
