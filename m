Received: from eggs.gnu.org ([2001:4830:134:3::10]:56993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uV-0007pt-PQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uR-000417-St
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27998 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG6uR-000403-H5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 31 May 2017 19:55:35 +0300
Message-Id: <20170531165541.47338-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-1-vsementsov@virtuozzo.com>
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/12] nbd/server: get rid of EAGAIN dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

For now nbd_read never returns EAGAIN. So, don't handle it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index dd6b241761..b0bb263596 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -997,11 +997,12 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
     return rc;
 }
 
-/* Collect a client request.  Return 0 if request looks valid, -EAGAIN
- * to keep trying the collection, -EIO to drop connection right away,
- * and any other negative value to report an error to the client
- * (although the caller may still need to disconnect after reporting
- * the error).  */
+/* nbd_co_receive_request
+ * Collect a client request. Return 0 if request looks valid, -EIO to drop
+ * connection right away, and any other negative value to report an error to
+ * the client (although the caller may still need to disconnect after reporting
+ * the error).
+ */
 static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 {
     NBDClient *client = req->client;
@@ -1011,9 +1012,7 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
     assert(client->recv_coroutine == qemu_coroutine_self());
     rc = nbd_receive_request(client->ioc, request);
     if (rc < 0) {
-        if (rc != -EAGAIN) {
-            rc = -EIO;
-        }
+        rc = -EIO;
         goto out;
     }
 
@@ -1114,9 +1113,6 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     req = nbd_request_get(client);
     ret = nbd_co_receive_request(req, &request);
-    if (ret == -EAGAIN) {
-        goto done;
-    }
     if (ret == -EIO) {
         goto out;
     }
-- 
2.11.1
