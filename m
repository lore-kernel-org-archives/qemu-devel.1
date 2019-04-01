Received: from eggs.gnu.org ([209.51.188.92]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43y-0000pW-KA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43v-000344-IA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43678
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43v-00033Y-5v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrbRZ029013
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:46 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97p9ny-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:46 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:45 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:51 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-18-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 17/97] block/qapi: Fix memory leak in
 qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

For BlockBackends that are skipped in query-blockstats, we would leak
info since commit 567dcb31. Allocate info only later to avoid the memory
leak.

Fixes: CID 1394727
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
(cherry picked from commit f62492bb8d1ea7f7e156ffbdf411de46107072c5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index 339727f0f4..c66f949db8 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -594,7 +594,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
         }
     } else {
         for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
-            BlockStatsList *info = g_malloc0(sizeof(*info));
+            BlockStatsList *info;
             AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
             char *qdev;
@@ -619,6 +619,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
             bdrv_query_blk_stats(s->stats, blk);
             aio_context_release(ctx);
 
+            info = g_malloc0(sizeof(*info));
             info->value = s;
             *p_next = info;
             p_next = &info->next;
-- 
2.17.1
