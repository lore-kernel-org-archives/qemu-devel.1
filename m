Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI1J-0006qN-JR
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI1H-0000qH-Px
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:29 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:43:02 +0100
Message-Id: <20171110224302.14424-5-mreitz@redhat.com>
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
References: <20171110224302.14424-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 4/4] blockdev: Mark BD-{remove,
 insert}-medium stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

Now that iotest 093 test proves that the throttling configuration
survives a blockdev-remove-medium/blockdev-insert-medium pair, the
original reason for declaring these commands experimental is gone
(see commit 6e0abc251dd4f8eba1f53656dfede12e5840e83b).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json   | 32 +++++++++++++-------------------
 blockdev.c             |  6 +++---
 tests/ahci-test.c      |  4 ++--
 tests/qemu-iotests/093 |  6 +++---
 tests/qemu-iotests/118 | 20 ++++++++++----------
 tests/qemu-iotests/139 |  2 +-
 6 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cf3f941999..8e6842e23e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3397,7 +3397,7 @@
             '*id': 'str' } }
 
 ##
-# @x-blockdev-remove-medium:
+# @blockdev-remove-medium:
 #
 # Removes a medium (a block driver state tree) from a block device. That block
 # device's tray must currently be open (unless there is no attached guest
@@ -3405,16 +3405,13 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no-op.
 #
-# @id:     The name or QOM path of the guest device (since: 2.8)
-#
-# Note: This command is still a work in progress and is considered experimental.
-# Stay away from it unless you want to help with its development.
+# @id:     The name or QOM path of the guest device
 #
-# Since: 2.5
+# Since: 2.12
 #
 # Example:
 #
-# -> { "execute": "x-blockdev-remove-medium",
+# -> { "execute": "blockdev-remove-medium",
 #      "arguments": { "id": "ide0-1-0" } }
 #
 # <- { "error": { "class": "GenericError",
@@ -3432,30 +3429,27 @@
 #
 # <- { "return": {} }
 #
-# -> { "execute": "x-blockdev-remove-medium",
+# -> { "execute": "blockdev-remove-medium",
 #      "arguments": { "id": "ide0-1-0" } }
 #
 # <- { "return": {} }
 #
 ##
-{ 'command': 'x-blockdev-remove-medium',
+{ 'command': 'blockdev-remove-medium',
   'data': { 'id': 'str' } }
 
 ##
-# @x-blockdev-insert-medium:
+# @blockdev-insert-medium:
 #
 # Inserts a medium (a block driver state tree) into a block device. That block
 # device's tray must currently be open (unless there is no attached guest
 # device) and there must be no medium inserted already.
 #
-# @id:        The name or QOM path of the guest device (since: 2.8)
+# @id:        The name or QOM path of the guest device
 #
 # @node-name: name of a node in the block driver state graph
 #
-# Note: This command is still a work in progress and is considered experimental.
-# Stay away from it unless you want to help with its development.
-#
-# Since: 2.5
+# Since: 2.12
 #
 # Example:
 #
@@ -3467,14 +3461,14 @@
 #                    "filename": "fedora.iso" } } }
 # <- { "return": {} }
 #
-# -> { "execute": "x-blockdev-insert-medium",
+# -> { "execute": "blockdev-insert-medium",
 #      "arguments": { "id": "ide0-1-0",
 #                     "node-name": "node0" } }
 #
 # <- { "return": {} }
 #
 ##
-{ 'command': 'x-blockdev-insert-medium',
+{ 'command': 'blockdev-insert-medium',
   'data': { 'id': 'str',
             'node-name': 'str'} }
 
@@ -3503,8 +3497,8 @@
 #
 # Changes the medium inserted into a block device by ejecting the current medium
 # and loading a new image file which is inserted as the new medium (this command
-# combines blockdev-open-tray, x-blockdev-remove-medium,
-# x-blockdev-insert-medium and blockdev-close-tray).
+# combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-medium
+# and blockdev-close-tray).
 #
 # @device:          Block device name (deprecated, use @id instead)
 #
diff --git a/blockdev.c b/blockdev.c
index a74224e8f8..fb93283334 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2441,7 +2441,7 @@ out:
     aio_context_release(aio_context);
 }
 
-void qmp_x_blockdev_remove_medium(const char *id, Error **errp)
+void qmp_blockdev_remove_medium(const char *id, Error **errp)
 {
     blockdev_remove_medium(false, NULL, true, id, errp);
 }
@@ -2519,8 +2519,8 @@ static void blockdev_insert_medium(bool has_device, const char *device,
     qmp_blockdev_insert_anon_medium(blk, bs, errp);
 }
 
-void qmp_x_blockdev_insert_medium(const char *id, const char *node_name,
-                                  Error **errp)
+void qmp_blockdev_insert_medium(const char *id, const char *node_name,
+                                Error **errp)
 {
     blockdev_insert_medium(false, NULL, true, id, node_name, errp);
 }
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 3635ea6d41..3934e62ef7 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1596,7 +1596,7 @@ static void test_atapi_tray(void)
     rsp = qmp_receive();
     QDECREF(rsp);
 
-    qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
+    qmp_discard_response("{'execute': 'blockdev-remove-medium', "
                          "'arguments': {'id': 'cd0'}}");
 
     /* Test the tray without a medium */
@@ -1612,7 +1612,7 @@ static void test_atapi_tray(void)
                                         "'driver': 'raw', "
                                         "'file': { 'driver': 'file', "
                                                   "'filename': %s }}}", iso);
-    qmp_discard_response("{'execute': 'x-blockdev-insert-medium',"
+    qmp_discard_response("{'execute': 'blockdev-insert-medium',"
                           "'arguments': { 'id': 'cd0', "
                                          "'node-name': 'node0' }}");
 
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 7862f2ba94..a354c79bff 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -348,9 +348,9 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
         # Now eject cd0 and insert cd1
         result = self.vm.qmp("blockdev-open-tray", id = 'dev0')
         self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp("x-blockdev-remove-medium", id = 'dev0')
+        result = self.vm.qmp("blockdev-remove-medium", id = 'dev0')
         self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp("x-blockdev-insert-medium", id = 'dev0', node_name = 'cd1')
+        result = self.vm.qmp("blockdev-insert-medium", id = 'dev0', node_name = 'cd1')
         self.assert_qmp(result, 'return', {})
 
         # Check that the I/O limits are still the same
@@ -359,7 +359,7 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/inserted/bps',   50)
 
         # Eject cd1
-        result = self.vm.qmp("x-blockdev-remove-medium", id = 'dev0')
+        result = self.vm.qmp("blockdev-remove-medium", id = 'dev0')
         self.assert_qmp(result, 'return', {})
 
         # Check that we can't set limits if the device has no medium
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index ca6965d23c..a0469b570e 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -233,7 +233,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('x-blockdev-remove-medium',
+        result = self.vm.qmp('blockdev-remove-medium',
                              id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
@@ -242,7 +242,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('x-blockdev-insert-medium',
+        result = self.vm.qmp('blockdev-insert-medium',
                              id=self.device_name, node_name='new')
         self.assert_qmp(result, 'return', {})
 
@@ -271,7 +271,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if not self.has_real_tray:
             return
 
-        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
+        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_insert_on_closed(self):
@@ -285,7 +285,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
+        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -320,7 +320,7 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
 
         self.wait_for_open()
 
-        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
+        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -345,7 +345,7 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
 
         self.wait_for_open()
 
-        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
+        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
 
@@ -603,13 +603,13 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
+        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
+        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'return', {})
 
@@ -642,7 +642,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
 
         # For device-less BBs, calling blockdev-open-tray or blockdev-close-tray
         # is not necessary
-        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
+        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
@@ -655,7 +655,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
+        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
                                                        node_name='node0')
         self.assert_qmp(result, 'return', {})
 
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index f8f02808a9..cc7fe337f3 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -133,7 +133,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Insert a BlockDriverState
     def insertDrive(self, device, node):
         self.checkBlockDriverState(node)
-        result = self.vm.qmp('x-blockdev-insert-medium',
+        result = self.vm.qmp('blockdev-insert-medium',
                              id = device, node_name = node)
         self.assert_qmp(result, 'return', {})
         self.checkBlockDriverState(node)
-- 
2.13.6
