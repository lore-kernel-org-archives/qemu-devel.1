Received: from eggs.gnu.org ([2001:4830:134:3::10]:35974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5Q-0001FU-H8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5L-0002gA-PQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34473 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGo5L-0002ec-Dm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:01:55 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Jun 2017 18:01:43 +0300
Message-Id: <20170602150150.258222-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170602150150.258222-1-vsementsov@virtuozzo.com>
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 05/12] nbd/server: refactor nbd_co_send_reply
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

As nbd_write never returns value > 0, we can get rid of extra ret.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 8985df86b4..dd6b241761 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -972,7 +972,7 @@ void nbd_export_close_all(void)
 static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 {
     NBDClient *client = req->client;
-    int rc, ret;
+    int rc;
 
     g_assert(qemu_in_coroutine());
     qemu_co_mutex_lock(&client->send_lock);
@@ -983,9 +983,9 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
     } else {
         qio_channel_set_cork(client->ioc, true);
         rc = nbd_send_reply(client->ioc, reply);
-        if (rc >= 0) {
-            ret = nbd_write(client->ioc, req->data, len, NULL);
-            if (ret < 0) {
+        if (rc == 0) {
+            rc = nbd_write(client->ioc, req->data, len, NULL);
+            if (rc < 0) {
                 rc = -EIO;
             }
         }
-- 
2.11.1
