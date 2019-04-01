Received: from eggs.gnu.org ([209.51.188.92]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46t-0003SK-Uc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46o-0004mg-Uq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46858
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46k-0004dJ-DI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4JPN054757
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:29 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97pas2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:21 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:48 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:43 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-70-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 69/97] nbd/server: Advertise all contexts in
 response to bare LIST
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

The NBD spec, and even our code comment, says that if the client
asks for NBD_OPT_LIST_META_CONTEXT with 0 queries, then we should
reply with (a possibly-compressed representation of) ALL contexts
that we are willing to let them try.  But commit 3d068aff forgot
to advertise qemu:dirty-bitmap:FOO.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit e31d802479df9daff1994a7ed1e36bbc5bb19d03)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nbd/server.c b/nbd/server.c
index adcba66aa9..2193e16c68 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -978,6 +978,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
+        meta->bitmap = !!meta->exp->export_bitmap;
     } else {
         for (i = 0; i < nb_queries; ++i) {
             ret = nbd_negotiate_meta_query(client, meta, errp);
-- 
2.17.1
