Received: from eggs.gnu.org ([2001:4830:134:3::10]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvS-0001OW-NF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvN-0008Sl-93
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:44 +0100
Message-Id: <1487689130-30373-49-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 48/54] nbd/server: Use real permissions for NBD
 exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

NBD can't cope with device size changes, so resize must be forbidden,
but otherwise we can tolerate anything. Depending on whether the export
is writable or not, we only require consistent reads and writes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 89362ba..924a1fe 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -891,10 +891,17 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
 {
     BlockBackend *blk;
     NBDExport *exp = g_malloc0(sizeof(NBDExport));
+    uint64_t perm;
     int ret;
 
-    /* FIXME Use real permissions */
-    blk = blk_new(0, BLK_PERM_ALL);
+    /* Don't allow resize while the NBD server is running, otherwise we don't
+     * care what happens with the node. */
+    perm = BLK_PERM_CONSISTENT_READ;
+    if ((nbdflags & NBD_FLAG_READ_ONLY) == 0) {
+        perm |= BLK_PERM_WRITE;
+    }
+    blk = blk_new(perm, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                        BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto fail;
-- 
1.8.3.1
