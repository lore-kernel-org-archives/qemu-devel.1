Received: from eggs.gnu.org ([2001:4830:134:3::10]:47898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCO-0001An-F5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCL-0005Od-B4
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCL-0005Ni-2o
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBYL042759
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmr8neywe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:04 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:02 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:37 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/79] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

We've been documenting the value in bytes since its introduction
in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.

Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
preparation for a rewrite to a list of dirty sectors in the next
commit 21b5683 in block.c, but the new code mistakenly started
reporting in sectors.

Fixes: https://bugzilla.redhat.com/1441460

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6c98c57af3f4fab85bdf5f01616c91322bd4312a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c..6d8ce5f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -345,7 +345,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
         BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
         BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
-        info->count = bdrv_get_dirty_count(bm);
+        info->count = bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
         info->granularity = bdrv_dirty_bitmap_granularity(bm);
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
-- 
2.7.4
