Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uV-0007py-Pv
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uR-00041H-TM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:28999 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG6uR-000404-HG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 31 May 2017 19:55:33 +0300
Message-Id: <20170531165541.47338-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-1-vsementsov@virtuozzo.com>
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/12] nbd/server: get rid of ssize_t
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

Now nbd_read and friends return int, so get rid of ssize_t.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index b830cd23d3..8985df86b4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -625,11 +625,11 @@ fail:
     return rc;
 }
 
-static ssize_t nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
+static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];
     uint32_t magic;
-    ssize_t ret;
+    int ret;
 
     ret = nbd_read(ioc, buf, sizeof(buf), NULL);
     if (ret < 0) {
@@ -663,7 +663,7 @@ static ssize_t nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
     return 0;
 }
 
-static ssize_t nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
+static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
 {
     uint8_t buf[NBD_REPLY_SIZE];
 
@@ -969,11 +969,10 @@ void nbd_export_close_all(void)
     }
 }
 
-static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
-                                 int len)
+static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 {
     NBDClient *client = req->client;
-    ssize_t rc, ret;
+    int rc, ret;
 
     g_assert(qemu_in_coroutine());
     qemu_co_mutex_lock(&client->send_lock);
@@ -1003,11 +1002,10 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
  * and any other negative value to report an error to the client
  * (although the caller may still need to disconnect after reporting
  * the error).  */
-static ssize_t nbd_co_receive_request(NBDRequestData *req,
-                                      NBDRequest *request)
+static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 {
     NBDClient *client = req->client;
-    ssize_t rc;
+    int rc;
 
     g_assert(qemu_in_coroutine());
     assert(client->recv_coroutine == qemu_coroutine_self());
@@ -1105,7 +1103,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDRequestData *req;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     NBDReply reply;
-    ssize_t ret;
+    int ret;
     int flags;
 
     TRACE("Reading request.");
-- 
2.11.1
