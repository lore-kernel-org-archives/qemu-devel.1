Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY4-0007zJ-5q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY1-0002db-15
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:08 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:05 +0100
Message-Id: <1539981546-10596-8-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 7/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_names[].
As a result, an array dereference of metadata_ol_names[8] in
qcow2_pre_write_overlap_check() could result in a read outside of the array bounds.

Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c539f02e5ec..46082aeac1d6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2719,15 +2719,17 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
 }
 
 static const char *metadata_ol_names[] = {
-    [QCOW2_OL_MAIN_HEADER_BITNR]    = "qcow2_header",
-    [QCOW2_OL_ACTIVE_L1_BITNR]      = "active L1 table",
-    [QCOW2_OL_ACTIVE_L2_BITNR]      = "active L2 table",
-    [QCOW2_OL_REFCOUNT_TABLE_BITNR] = "refcount table",
-    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] = "refcount block",
-    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = "snapshot table",
-    [QCOW2_OL_INACTIVE_L1_BITNR]    = "inactive L1 table",
-    [QCOW2_OL_INACTIVE_L2_BITNR]    = "inactive L2 table",
+    [QCOW2_OL_MAIN_HEADER_BITNR]        = "qcow2_header",
+    [QCOW2_OL_ACTIVE_L1_BITNR]          = "active L1 table",
+    [QCOW2_OL_ACTIVE_L2_BITNR]          = "active L2 table",
+    [QCOW2_OL_REFCOUNT_TABLE_BITNR]     = "refcount table",
+    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]     = "refcount block",
+    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]     = "snapshot table",
+    [QCOW2_OL_INACTIVE_L1_BITNR]        = "inactive L1 table",
+    [QCOW2_OL_INACTIVE_L2_BITNR]        = "inactive L2 table",
+    [QCOW2_OL_BITMAP_DIRECTORY_BITNR]   = "bitmap directory",
 };
+QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR != ARRAY_SIZE(metadata_ol_names));
 
 /*
  * First performs a check for metadata overlaps (through
-- 
1.8.3.1
