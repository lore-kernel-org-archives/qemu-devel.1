Received: from eggs.gnu.org ([2001:4830:134:3::10]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDrG-0005zr-1K
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDrB-0005SY-Ic
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:44:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 23 May 2017 12:44:20 -0500
Message-Id: <20170523174420.8903-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qapi: Fix some QMP documentation regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com

In the process of getting rid of docs/qmp-commands.txt, we managed
to regress on some of the text that changed after the point where
the move was first branched and when the move actually occurred.
For example, commit 3282eca for blockdev-snapshot re-added the
extra "options" layer which had been cleaned up in commit 0153d2f.

This clears up all regressions identified over the range
02b351d..bd6092e:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05127.html
as well as a cleanup to x-blockdev-remove-medium to prefer
'id' over 'device' (matching the cleanup for 'eject').

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
v2: add 'eject', 'x-blockdev-remove-medium' cleanups, thanks to
Markus' audit.

Can go in either via trivial or via qapi tree

 qapi/block-core.json | 28 ++++++++++++++--------------
 qapi/block.json      |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 309b1df..88a7471 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1206,11 +1206,11 @@
 # Example:
 #
 # -> { "execute": "blockdev-add",
-#      "arguments": { "options": { "driver": "qcow2",
-#                                  "node-name": "node1534",
-#                                  "file": { "driver": "file",
-#                                            "filename": "hd1.qcow2" },
-#                                  "backing": "" } } }
+#      "arguments": { "driver": "qcow2",
+#                     "node-name": "node1534",
+#                     "file": { "driver": "file",
+#                               "filename": "hd1.qcow2" },
+#                     "backing": "" } }
 #
 # <- { "return": {} }
 #
@@ -3214,7 +3214,7 @@
 # <- { "return": {} }
 #
 # -> { "execute": "x-blockdev-remove-medium",
-#      "arguments": { "device": "ide0-1-0" } }
+#      "arguments": { "id": "ide0-1-0" } }
 #
 # <- { "return": {} }
 #
@@ -3245,10 +3245,10 @@
 #
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": { "node-name": "node0",
-#                       "driver": "raw",
-#                       "file": { "driver": "file",
-#                                 "filename": "fedora.iso" } } } }
+#          "node-name": "node0",
+#          "driver": "raw",
+#          "file": { "driver": "file",
+#                    "filename": "fedora.iso" } } }
 # <- { "return": {} }
 #
 # -> { "execute": "x-blockdev-insert-medium",
@@ -3701,10 +3701,10 @@
 # 1. Add a new node to a quorum
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": { "driver": "raw",
-#                       "node-name": "new_node",
-#                        "file": { "driver": "file",
-#                                  "filename": "test.raw" } } } }
+#          "driver": "raw",
+#          "node-name": "new_node",
+#          "file": { "driver": "file",
+#                    "filename": "test.raw" } } }
 # <- { "return": {} }
 # -> { "execute": "x-blockdev-change",
 #      "arguments": { "parent": "disk1",
diff --git a/qapi/block.json b/qapi/block.json
index 6a2fdc7..414b61b 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -180,7 +180,7 @@
 #
 # Example:
 #
-# -> { "execute": "eject", "arguments": { "device": "ide1-0-1" } }
+# -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
 # <- { "return": {} }
 ##
 { 'command': 'eject',
-- 
2.9.4
