Received: from eggs.gnu.org ([209.51.188.92]:41180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44r-0001cv-Ue
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44q-0003dA-W6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44q-0003X2-NT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1sVE095992
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:34 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegxm0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:33 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:32 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:27 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-54-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/97] nbd/server: fix NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We should not go to structured-read branch on CACHE command, fix that.

Bug introduced in bc37b06a5cde24 "nbd/server: introduce NBD_CMD_CACHE"
with the whole feature and affects 3.0.0 release.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: qemu-stable@nongnu.org
Message-Id: <20181003144738.70670-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message typo fix]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 2f454defc23e1be78f2a96bad2877ce7829f61b4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 12f721482d..adcba66aa9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2138,7 +2138,8 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 
     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len) {
+        request->len && request->type != NBD_CMD_CACHE)
+    {
         return nbd_co_send_sparse_read(client, request->handle, request->from,
                                        data, request->len, errp);
     }
-- 
2.17.1
