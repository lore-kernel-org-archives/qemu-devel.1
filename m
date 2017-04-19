Received: from eggs.gnu.org ([2001:4830:134:3::10]:53019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAm-0004pJ-Ch
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAl-0005y8-LE
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:16 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:54 +0800
Message-Id: <20170419094356.19826-15-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/16] nbd: Allow
 BLK_PERM_AIO_CONTEXT_CHANGE on BB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is safe because of the aio context notifier we'll register on this
node. So allow it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 nbd/server.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 924a1fe..a8f58fb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -900,8 +900,10 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
     if ((nbdflags & NBD_FLAG_READ_ONLY) == 0) {
         perm |= BLK_PERM_WRITE;
     }
-    blk = blk_new(perm, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                        BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
+    blk = blk_new(perm,
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD |
+                  BLK_PERM_AIO_CONTEXT_CHANGE);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto fail;
-- 
2.9.3
