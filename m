Received: from eggs.gnu.org ([209.51.188.92]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45B-0001xt-DZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45A-0003oO-6k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB459-0003hi-Qz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L2ASC119045
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqt606pg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:51 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:50 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:44 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-71-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 70/97] nbd/client: Make x-dirty-bitmap more
 reliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

The implementation of x-dirty-bitmap in qemu 3.0 (commit 216ee365)
silently falls back to treating the server as not supporting
NBD_CMD_BLOCK_STATUS if a requested meta_context name was not
negotiated, which in turn means treating the _entire_ image as
data. Since our hack relied on using 'qemu-img map' to view
which portions of the image were dirty by seeing what the
redirected bdrv_block_status() treats as holes, this means
that our fallback treats the entire image as clean.  Better
would have been to treat the entire image as dirty, or to fail
to connect because the user's request for a specific context
could not be honored. This patch goes with the latter.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit 47829c40794160debdb33b4a042d182e776876d4)
*avoid context dep. on 6c2e581d
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9686ecbd5e..f8c42a6996 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -992,6 +992,11 @@ int nbd_client_init(BlockDriverState *bs,
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
+    if (x_dirty_bitmap && !client->info.base_allocation) {
+        error_setg(errp, "requested x-dirty-bitmap %s not found",
+                   x_dirty_bitmap);
+        return -EINVAL;
+    }
     if (client->info.flags & NBD_FLAG_READ_ONLY &&
         !bdrv_is_read_only(bs)) {
         error_setg(errp,
-- 
2.17.1
