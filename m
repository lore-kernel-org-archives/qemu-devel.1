Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvmOO-0000zd-Kn
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvmOI-00059j-H1
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvmOG-000544-7Q
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VGYRYc140240
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:17 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp2120.oracle.com with ESMTP id 2m2yrqvb9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7VGZGuZ020419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:17 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VGZGxc017696
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:16 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 17:36:54 +0100
Message-Id: <1535733414-6812-9-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 8/8] qcow2: Read outside array bounds in
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

The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_names[].
As a result, an array dereference of metadata_ol_names[8] in
qcow2_pre_write_overlap_check() could result in a read outside of the array bounds.

Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 block/qcow2-refcount.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c539f02e5ec..fb0de187cfd2 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2719,16 +2719,26 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
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
 
+
+/*
+ * Catch at compile time the case where an overlap detection bit
+ * was added to QCow2MetadataOverlap in block/qcow2.h but a
+ * corresponding entry to metadata_ol_names[] wasn't added.
+ */
+QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=
+    (sizeof(metadata_ol_names) / sizeof(metadata_ol_names[0])));
+
 /*
  * First performs a check for metadata overlaps (through
  * qcow2_check_metadata_overlap); if that fails with a negative value (error
-- 
1.8.3.1
