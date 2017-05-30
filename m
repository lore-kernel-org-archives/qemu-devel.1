Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005Q8-1O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000Q3-Pl
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33734 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NI-Uv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:39 +0300
Message-Id: <20170530143052.165002-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/19] nbd/server: remove NBDClientNewData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

"co" field of NBDClientNewData is unused, so let's just use client
pointer instead of extra structure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 546bf3ae61..3d4cd3d21c 100644
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
@@ -1268,16 +1262,15 @@ static void nbd_client_receive_next_request(NBDClient *client)
 
 static coroutine_fn void nbd_co_client_start(void *opaque)
 {
-    NBDClientNewData *data = opaque;
-    NBDClient *client = data->client;
+    NBDClient *client = opaque;
     NBDExport *exp = client->exp;
 
     if (exp) {
         nbd_export_get(exp);
     }
-    if (nbd_negotiate(data)) {
+    if (nbd_negotiate(client)) {
         client_close(client);
-        goto out;
+        return;
     }
     qemu_co_mutex_init(&client->send_lock);
 
@@ -1286,9 +1279,6 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
     }
 
     nbd_client_receive_next_request(client);
-
-out:
-    g_free(data);
 }
 
 void nbd_client_new(NBDExport *exp,
@@ -1298,7 +1288,7 @@ void nbd_client_new(NBDExport *exp,
                     void (*close_fn)(NBDClient *))
 {
     NBDClient *client;
-    NBDClientNewData *data = g_new(NBDClientNewData, 1);
+    Coroutine *co;
 
     client = g_malloc0(sizeof(NBDClient));
     client->refcount = 1;
@@ -1314,7 +1304,6 @@ void nbd_client_new(NBDExport *exp,
     object_ref(OBJECT(client->ioc));
     client->close = close_fn;
 
-    data->client = client;
-    data->co = qemu_coroutine_create(nbd_co_client_start, data);
-    qemu_coroutine_enter(data->co);
+    co = qemu_coroutine_create(nbd_co_client_start, client);
+    qemu_coroutine_enter(co);
 }
-- 
2.11.1
