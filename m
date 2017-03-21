Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqN6d-0001vK-Vb
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqN6a-0005ZN-R3
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqN6a-0005YH-JX
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60CE17AEA1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 16:57:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Mar 2017 17:57:53 +0100
Message-Id: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com

It's been a long journey, but here we are.

x-blockdev-remove-medium, x-blockdev-insert-medium and
x-blockdev-change need a bit more work, so leave them alone for now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c             |  4 ++--
 qapi/block-core.json   | 14 +++++---------
 tests/qemu-iotests/139 |  8 ++++----
 tests/qemu-iotests/141 |  4 ++--
 tests/qemu-iotests/147 |  2 +-
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index c5b2c2c..040c152 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2835,7 +2835,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
 
     bs = bdrv_find_node(id);
     if (bs) {
-        qmp_x_blockdev_del(id, &local_err);
+        qmp_blockdev_del(id, &local_err);
         if (local_err) {
             error_report_err(local_err);
         }
@@ -3900,7 +3900,7 @@ fail:
     visit_free(v);
 }
 
-void qmp_x_blockdev_del(const char *node_name, Error **errp)
+void qmp_blockdev_del(const char *node_name, Error **errp)
 {
     AioContext *aio_context;
     BlockDriverState *bs;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f132fc..5d913d4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2907,11 +2907,7 @@
 # BlockBackend will be created; otherwise, @node-name is mandatory at the top
 # level and no BlockBackend will be created.
 #
-# Note: This command is still a work in progress.  It doesn't support all
-# block drivers among other things.  Stay away from it unless you want
-# to help with its development.
-#
-# Since: 1.7
+# Since: 2.9
 #
 # Example:
 #
@@ -2957,7 +2953,7 @@
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
 
 ##
-# @x-blockdev-del:
+# @blockdev-del:
 #
 # Deletes a block device that has been added using blockdev-add.
 # The command will fail if the node is attached to a device or is
@@ -2969,7 +2965,7 @@
 # experimental. Stay away from it unless you want to help with its
 # development.
 #
-# Since: 2.5
+# Since: 2.9
 #
 # Example:
 #
@@ -2985,13 +2981,13 @@
 #    }
 # <- { "return": {} }
 #
-# -> { "execute": "x-blockdev-del",
+# -> { "execute": "blockdev-del",
 #      "arguments": { "node-name": "node0" }
 #    }
 # <- { "return": {} }
 #
 ##
-{ 'command': 'x-blockdev-del', 'data': { 'node-name': 'str' } }
+{ 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
 # @blockdev-open-tray:
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 6d98e4f..175d8f0 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -1,6 +1,6 @@
 #!/usr/bin/env python
 #
-# Test cases for the QMP 'x-blockdev-del' command
+# Test cases for the QMP 'blockdev-del' command
 #
 # Copyright (C) 2015 Igalia, S.L.
 # Author: Alberto Garcia <berto@igalia.com>
@@ -79,7 +79,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Delete a BlockDriverState
     def delBlockDriverState(self, node, expect_error = False):
         self.checkBlockDriverState(node)
-        result = self.vm.qmp('x-blockdev-del', node_name = node)
+        result = self.vm.qmp('blockdev-del', node_name = node)
         if expect_error:
             self.assert_qmp(result, 'error/class', 'GenericError')
         else:
@@ -173,7 +173,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.wait_until_completed(id)
 
     # Add a BlkDebug node
-    # Note that the purpose of this is to test the x-blockdev-del
+    # Note that the purpose of this is to test the blockdev-del
     # sanity checks, not to create a usable blkdebug drive
     def addBlkDebug(self, debug, node):
         self.checkBlockDriverState(node, False)
@@ -191,7 +191,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(debug)
 
     # Add a BlkVerify node
-    # Note that the purpose of this is to test the x-blockdev-del
+    # Note that the purpose of this is to test the blockdev-del
     # sanity checks, not to create a usable blkverify drive
     def addBlkVerify(self, blkverify, test, raw):
         self.checkBlockDriverState(test, False)
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 6d8f0a1..27fb1cc 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -65,7 +65,7 @@ test_blockjob()
 
     # We want this to return an error because the block job is still running
     _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'x-blockdev-del',
+        "{'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}" \
         'error' | _filter_generated_node_ids
 
@@ -75,7 +75,7 @@ test_blockjob()
         "$3"
 
     _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'x-blockdev-del',
+        "{'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}" \
         'return'
 }
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 45469c9..cca75c5 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -57,7 +57,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
                                                     filename)
                 break
 
-        result = self.vm.qmp('x-blockdev-del', node_name='nbd-blockdev')
+        result = self.vm.qmp('blockdev-del', node_name='nbd-blockdev')
         self.assert_qmp(result, 'return', {})
 
 
-- 
2.7.4
