Received: from eggs.gnu.org ([2001:4830:134:3::10]:57881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9u-0003cf-HC
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9k-0005sj-SW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:42 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:44 +0100
Message-Id: <20180123140201.31163-13-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/29] qcow2: No persistent dirty bitmaps for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Persistent dirty bitmaps require a properly functioning
autoclear_features field, or we cannot track when an unsupporting
program might overwrite them.  Therefore, we cannot support them for
compat=0.10 images.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 10 ++++++++++
 block/qcow2.c        | 14 +++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f45e46cfbd..efa10c6663 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1449,6 +1449,16 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
     bool found;
     Qcow2BitmapList *bm_list;
 
+    if (s->qcow_version < 3) {
+        /* Without autoclear_features, we would always have to assume
+         * that a program without persistent dirty bitmap support has
+         * accessed this qcow2 file when opening it, and would thus
+         * have to drop all dirty bitmaps (defeating their purpose).
+         */
+        error_setg(errp, "Cannot store dirty bitmaps in qcow2 v2 files");
+        goto fail;
+    }
+
     if (check_constraints_on_bitmap(bs, name, granularity, errp) != 0) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c0c5..1f80961e1b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -302,9 +302,17 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
 
             if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
-                warn_report("a program lacking bitmap support "
-                            "modified this file, so all bitmaps are now "
-                            "considered inconsistent");
+                if (s->qcow_version < 3) {
+                    /* Let's be a bit more specific */
+                    warn_report("This qcow2 v2 image contains bitmaps, but "
+                                "they may have been modified by a program "
+                                "without persistent bitmap support; so now "
+                                "they must all be considered inconsistent");
+                } else {
+                    warn_report("a program lacking bitmap support "
+                                "modified this file, so all bitmaps are now "
+                                "considered inconsistent");
+                }
                 error_printf("Some clusters may be leaked, "
                              "run 'qemu-img check -r' on the image "
                              "file to fix.");
-- 
2.13.6
