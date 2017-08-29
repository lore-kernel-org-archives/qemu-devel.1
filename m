Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCY-0001OO-G6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCV-0005bq-QC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCV-0005Yy-FY
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E68p090042
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:14 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvyehkkn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:14 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:12 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:19 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-45-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 44/79] block: Simplify BDRV_BLOCK_RAW recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eric Blake <eblake@redhat.com>

Since we are already in coroutine context during the body of
bdrv_co_get_block_status(), we can shave off a few layers of
wrappers when recursing to query the protocol when a format driver
returned BDRV_BLOCK_RAW.

Note that we are already using the correct recursion later on in
the same function, when probing whether the protocol layer is sparse
in order to find out if we can add BDRV_BLOCK_ZERO to an existing
BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170504173745.27414-1-eblake@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit ee29d6adefcca7e76abb124183814ed3acc74fac)
* prereq for 81c219a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index a7142e0..fe0c867 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1792,8 +1792,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
-        ret = bdrv_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                    *pnum, pnum, file);
+        ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
+                                       *pnum, pnum, file);
         goto out;
     }
 
-- 
2.7.4
