Received: from eggs.gnu.org ([2001:4830:134:3::10]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvPCH-0006Y2-Cm
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvP8b-0005g2-NX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvP8b-0005bU-Av
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UFdFJb030693
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:36 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp2120.oracle.com with ESMTP id 2m2y2pwhj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjYZd011026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:35 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UFjYIM017482
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:34 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Thu, 30 Aug 2018 16:47:11 +0100
Message-Id: <1535644031-848-9-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 8/8] qcow2: Read outside array bounds in
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
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 block/qcow2-refcount.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c539f02e5ec..6504e7421324 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2719,14 +2719,15 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
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
 
 /*
-- 
1.8.3.1
