Received: from eggs.gnu.org ([2001:4830:134:3::10]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPO-0000BG-Fs
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPK-0007gV-LO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:50 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPK-0007g8-Ei
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:46 -0400
Received: by mail-wr0-x243.google.com with SMTP id y25so548045wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:51 +0200
Message-Id: <1497523981-38449-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/41] nbd/server: remove NBDClientNewData
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

"co" field of NBDClientNewData has never been used, all the way back to
its declaration in commit 1a6245a5. So let's just use client pointer
instead of extra structure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-9-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9fb03ce..d526827 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -535,14 +535,8 @@ static int nbd_negotiate_options(NBDClient *client)
     }
 }
 
-typedef struct {
-    NBDClient *client;
-    Coroutine *co;
-} NBDClientNewData;
-
-static coroutine_fn int nbd_negotiate(NBDClientNewData *data)
+static coroutine_fn int nbd_negotiate(NBDClient *client)
 {
-    NBDClient *client = data->client;
     char buf[8 + 8 + 8 + 128];
     int rc;
     const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
@@ -1268,8 +1262,7 @@ static void nbd_client_receive_next_request(NBDClient *client)
 
 static coroutine_fn void nbd_co_client_start(void *opaque)
 {
-    NBDClientNewData *data = opaque;
-    NBDClient *client = data->client;
+    NBDClient *client = opaque;
     NBDExport *exp = client->exp;
 
     if (exp) {
@@ -1278,15 +1271,12 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
     }
     qemu_co_mutex_init(&client->send_lock);
 
-    if (nbd_negotiate(data)) {
+    if (nbd_negotiate(client)) {
         client_close(client, false);
-        goto out;
+        return;
     }
 
     nbd_client_receive_next_request(client);
-
-out:
-    g_free(data);
 }
 
 /*
@@ -1302,7 +1292,7 @@ void nbd_client_new(NBDExport *exp,
                     void (*close_fn)(NBDClient *, bool))
 {
     NBDClient *client;
-    NBDClientNewData *data = g_new(NBDClientNewData, 1);
+    Coroutine *co;
 
     client = g_malloc0(sizeof(NBDClient));
     client->refcount = 1;
@@ -1318,7 +1308,6 @@ void nbd_client_new(NBDExport *exp,
     object_ref(OBJECT(client->ioc));
     client->close_fn = close_fn;
 
-    data->client = client;
-    data->co = qemu_coroutine_create(nbd_co_client_start, data);
-    qemu_coroutine_enter(data->co);
+    co = qemu_coroutine_create(nbd_co_client_start, client);
+    qemu_coroutine_enter(co);
 }
-- 
1.8.3.1
