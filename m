Received: from eggs.gnu.org ([2001:4830:134:3::10]:50786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1aO9-0007vM-Od
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1aO9-00068Q-1P
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:54:41 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Oct 2017 17:54:31 +0200
Message-Id: <20171009155431.14093-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] qcow2: Emit errp when truncating the image tail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

bdrv_truncate() has an errp parameter which is always set when an error
occurs.  Let's use that instead of a plain strerror().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dff903e05c..2f6a8e1ff8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3150,12 +3150,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
             return last_cluster;
         }
         if ((last_cluster + 1) * s->cluster_size < old_file_size) {
-            ret = bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
-                                PREALLOC_MODE_OFF, NULL);
-            if (ret < 0) {
-                warn_report("Failed to truncate the tail of the image: %s",
-                            strerror(-ret));
-                ret = 0;
+            Error *local_err = NULL;
+
+            bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
+                          PREALLOC_MODE_OFF, &local_err);
+            if (local_err) {
+                warn_reportf_err(local_err,
+                                 "Failed to truncate the tail of the image: ");
             }
         }
     } else {
-- 
2.13.6
