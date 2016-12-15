Received: from eggs.gnu.org ([2001:4830:134:3::10]:43068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCB-00045f-Sv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC9-0001Wo-9H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC8-0001Vy-V5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haKn056464
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:47 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90wk4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:47 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:47 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:44 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-51-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/67] qcow2: Inform block layer about discard
 boundaries
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

At the qcow2 layer, discard is only possible on a per-cluster
basis; at the moment, qcow2 silently rounds any unaligned
requests to this granularity.  However, an upcoming patch will
fix a regression in the block layer ignoring too much of an
unaligned discard request, by changing the block layer to
break up a discard request at alignment boundaries; for that
to work, the block layer must know about our limits.

However, we can't go one step further by changing
qcow2_discard_clusters() to assert that requests are always
aligned, since that helper function is reached on paths
outside of the block layer.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ecdbead659f037dc572bba9eb1cd31a5a1a9ad9a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 91ef4df..497df0f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1204,6 +1204,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.request_alignment = BDRV_SECTOR_SIZE;
     }
     bs->bl.pwrite_zeroes_alignment = s->cluster_size;
+    bs->bl.pdiscard_alignment = s->cluster_size;
 }
 
 static int qcow2_set_key(BlockDriverState *bs, const char *key)
-- 
1.9.1
