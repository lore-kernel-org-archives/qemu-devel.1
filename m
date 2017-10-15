Received: from eggs.gnu.org ([2001:4830:134:3::10]:52216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3WzA-0006dY-Bx
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz9-0003u4-JH
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:31 -0500
Message-Id: <20171015004033.3248-8-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] nbd/server: refactor
 nbd_co_send_simple_reply parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Pass client and buffer (*data) parameters directly, to make the function
consistent with further structured reply sending functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171012095319.136610-7-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 06aeadcfbb..3fcc3d3c7c 100644
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
     int nbd_err = system_errno_to_nbd_errno(error);
     int ret;
@@ -1220,7 +1221,7 @@ static int nbd_co_send_simple_reply(NBDRequestData *req,
         qio_channel_set_cork(client->ioc, true);
         ret = nbd_write(client->ioc, &simple_reply, sizeof(simple_reply), errp);
         if (ret == 0) {
-            ret = nbd_write(client->ioc, req->data, len, errp);
+            ret = nbd_write(client->ioc, data, len, errp);
             if (ret < 0) {
                 ret = -EIO;
             }
@@ -1447,9 +1448,9 @@ reply:
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
2.13.6
