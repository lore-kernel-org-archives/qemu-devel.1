Received: from eggs.gnu.org ([209.51.188.92]:42576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46t-0003SI-UX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46o-0004mG-1O
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46788
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46j-0004dB-7R
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4LrE054914
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97patp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:22 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:51 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:45 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-72-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 71/97] nbd/client: Send NBD_CMD_DISC if open
 fails after connect
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

If nbd_client_init() fails after we are already connected,
then the server will spam logs with:

Disconnect client, due to: Unexpected end-of-file before all bytes were read

unless we gracefully disconnect before closing the connection.

Ways to trigger this:

$ opts=driver=nbd,export=foo,server.type=inet,server.host=localhost,server.port=10809
$  qemu-img map --output=json --image-opts $opts,read-only=off
$  qemu-img map --output=json --image-opts $opts,x-dirty-bitmap=nosuch:

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit c688e6ca7b41a105241054853d250df64addbf8f)
*drop functional dep. on 6c2e581d4d7
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd-client.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index f8c42a6996..1b7b5b0a88 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -995,13 +995,15 @@ int nbd_client_init(BlockDriverState *bs,
     if (x_dirty_bitmap && !client->info.base_allocation) {
         error_setg(errp, "requested x-dirty-bitmap %s not found",
                    x_dirty_bitmap);
-        return -EINVAL;
+        ret = -EINVAL;
+        goto fail;
     }
     if (client->info.flags & NBD_FLAG_READ_ONLY &&
         !bdrv_is_read_only(bs)) {
         error_setg(errp,
                    "request for write access conflicts with read-only export");
-        return -EACCES;
+        ret = -EACCES;
+        goto fail;
     }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
@@ -1029,4 +1031,17 @@ int nbd_client_init(BlockDriverState *bs,
 
     logout("Established connection with NBD server\n");
     return 0;
+
+ fail:
+    /*
+     * We have connected, but must fail for other reasons. The
+     * connection is still blocking; send NBD_CMD_DISC as a courtesy
+     * to the server.
+     */
+    {
+        NBDRequest request = { .type = NBD_CMD_DISC };
+
+        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+        return ret;
+    }
 }
-- 
2.17.1
