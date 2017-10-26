Received: from eggs.gnu.org ([2001:4830:134:3::10]:59342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3y-0001Ay-Qs
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3u-0002au-6Q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:38 +0200
Message-Id: <20171026131741.5059-33-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/35] qcow2: Emit errp when truncating the
 image tail
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

bdrv_truncate() has an errp parameter which is always set when an error
occurs.  Let's use that instead of a plain strerror().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009155431.14093-1-mreitz@redhat.com
Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f77b490cc6..d3e114bce5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3145,12 +3145,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
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
