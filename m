Received: from eggs.gnu.org ([2001:4830:134:3::10]:58085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJaC-0005D2-BT
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJaB-0007Sr-8Q
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJaB-0007Qw-2T
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:41 +0000
Message-Id: <20171219151144.11120-21-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/23] blockdev: add x-blockdev-set-iothread
 force boolean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

When a node is already associated with a BlockBackend the
x-blockdev-set-iothread command refuses to set the IOThread.  This is to
prevent accidentally changing the IOThread when the nodes are in use.

When the nodes are created with -drive they automatically get a
BlockBackend.  In that case we know nothing is using them yet and it's
safe to set the IOThread.  Add a force boolean to override the check.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171207201320.19284-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json |  6 +++++-
 blockdev.c           | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741d6c4367..a8cdbc300b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3962,6 +3962,9 @@
 #
 # @iothread: the name of the IOThread object or null for the main loop
 #
+# @force: true if the node and its children should be moved when a BlockBackend
+#         is already attached
+#
 # Note: this command is experimental and intended for test cases that need
 # control over IOThreads only.
 #
@@ -3984,4 +3987,5 @@
 ##
 { 'command': 'x-blockdev-set-iothread',
   'data' : { 'node-name': 'str',
-             'iothread': 'StrOrNull' } }
+             'iothread': 'StrOrNull',
+             '*force': 'bool' } }
diff --git a/blockdev.c b/blockdev.c
index f75c01f664..9c3a430cfb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4131,7 +4131,7 @@ BlockJobInfoList *qmp_query_block_jobs(Error **errp)
 }
 
 void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
-                                 Error **errp)
+                                 bool has_force, bool force, Error **errp)
 {
     AioContext *old_context;
     AioContext *new_context;
@@ -4143,10 +4143,11 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
         return;
     }
 
-    /* If we want to allow more extreme test scenarios this guard could be
-     * removed.  For now it protects against accidents. */
-    if (bdrv_has_blk(bs)) {
-        error_setg(errp, "Node %s is in use", node_name);
+    /* Protects against accidents. */
+    if (!(has_force && force) && bdrv_has_blk(bs)) {
+        error_setg(errp, "Node %s is associated with a BlockBackend and could "
+                         "be in use (use force=true to override this check)",
+                         node_name);
         return;
     }
 
-- 
2.14.3
