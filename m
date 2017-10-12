Received: from eggs.gnu.org ([2001:4830:134:3::10]:35449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001Fb-6K
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBF-0000IG-LQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:31073 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBF-0000Db-8I
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:12 +0300
Message-Id: <20171012095319.136610-7-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 06/13] nbd/server: refactor
 nbd_co_send_simple_reply parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Pass client and buffer (*data) parameters directly, to make the function
consistent with further structured reply sending functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3878145f63..afc127bbd9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1196,12 +1196,13 @@ static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
     stq_be_p(&reply->handle, handle);
 }
 
-static int nbd_co_send_simple_reply(NBDRequestData *req,
+static int nbd_co_send_simple_reply(NBDClient *client,
                                     uint64_t handle,
                                     uint32_t error,
-                                    int len, Error **errp)
+                                    void *data,
+                                    size_t len,
+                                    Error **errp)
 {
-    NBDClient *client = req->client;
     NBDSimpleReply simple_reply;
     int ret;
 
@@ -1221,7 +1222,7 @@ static int nbd_co_send_simple_reply(NBDRequestData *req,
         qio_channel_set_cork(client->ioc, true);
         ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), NULL);
         if (ret == 0) {
-            ret = nbd_write(client->ioc, req->data, len, errp);
+            ret = nbd_write(client->ioc, data, len, errp);
             if (ret < 0) {
                 ret = -EIO;
             }
@@ -1448,9 +1449,9 @@ reply:
         local_err = NULL;
     }
 
-    if (nbd_co_send_simple_reply(req, request.handle,
+    if (nbd_co_send_simple_reply(req->client, request.handle,
                                  ret < 0 ? -ret : 0,
-                                 reply_data_len, &local_err) < 0)
+                                 req->data, reply_data_len, &local_err) < 0)
     {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.11.1
