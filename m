Received: from eggs.gnu.org ([2001:4830:134:3::10]:41059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPI-0008Vs-TJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPI-0007f1-8O
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:45 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPI-0007ej-2D
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:44 -0400
Received: by mail-wr0-x243.google.com with SMTP id y25so547807wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:49 +0200
Message-Id: <1497523981-38449-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/41] nbd/server: get rid of EAGAIN dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

For now nbd_read never returns EAGAIN. So, don't handle it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-7-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 8ceac89..00a19f6 100644
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
1.8.3.1
