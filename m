Received: from eggs.gnu.org ([2001:4830:134:3::10]:41045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPH-0008U7-JF
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPG-0007eM-Q1
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:43 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPG-0007dz-Jn
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:42 -0400
Received: by mail-wr0-x243.google.com with SMTP id y25so547693wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:48 +0200
Message-Id: <1497523981-38449-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/41] nbd/server: refactor nbd_co_send_reply
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

As nbd_write never returns value > 0, we can get rid of extra ret.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-6-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 895cd7f..8ceac89 100644
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
1.8.3.1
