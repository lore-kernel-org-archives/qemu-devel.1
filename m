Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5Q-0001FV-Hb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5L-0002gV-U8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23239 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGo5L-0002f6-HV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:01:55 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Jun 2017 18:01:48 +0300
Message-Id: <20170602150150.258222-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170602150150.258222-1-vsementsov@virtuozzo.com>
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 10/12] nbd/server: get rid of fail: return rc
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

"goto fail" error handling scheme is not needed for just returning
error code. Better is return it immediately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ec163ad829..2f1c5b0a5b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -265,7 +265,6 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
 
 static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 {
-    int rc = -EINVAL;
     char name[NBD_MAX_NAME_SIZE + 1];
 
     /* Client sends:
@@ -274,11 +273,11 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
     TRACE("Checking length");
     if (length >= sizeof(name)) {
         LOG("Bad length received");
-        goto fail;
+        return -EINVAL;
     }
     if (nbd_read(client->ioc, name, length, NULL) < 0) {
         LOG("read failed");
-        goto fail;
+        return -EINVAL;
     }
     name[length] = '\0';
 
@@ -287,14 +286,13 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
     client->exp = nbd_export_find(name);
     if (!client->exp) {
         LOG("export not found");
-        goto fail;
+        return -EINVAL;
     }
 
     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     nbd_export_get(client->exp);
-    rc = 0;
-fail:
-    return rc;
+
+    return 0;
 }
 
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
@@ -564,7 +562,6 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
      */
 
     qio_channel_set_blocking(client->ioc, false, NULL);
-    rc = -EINVAL;
 
     TRACE("Beginning negotiation.");
     memset(buf, 0, sizeof(buf));
@@ -585,21 +582,21 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
     if (oldStyle) {
         if (client->tlscreds) {
             TRACE("TLS cannot be enabled with oldstyle protocol");
-            goto fail;
+            return -EINVAL;
         }
         if (nbd_write(client->ioc, buf, sizeof(buf), NULL) < 0) {
             LOG("write failed");
-            goto fail;
+            return -EINVAL;
         }
     } else {
         if (nbd_write(client->ioc, buf, 18, NULL) < 0) {
             LOG("write failed");
-            goto fail;
+            return -EINVAL;
         }
         rc = nbd_negotiate_options(client);
         if (rc != 0) {
             LOG("option negotiation failed");
-            goto fail;
+            return rc;
         }
 
         TRACE("advertising size %" PRIu64 " and flags %x",
@@ -610,14 +607,13 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         rc = nbd_write(client->ioc, buf + 18, len, NULL);
         if (rc < 0) {
             LOG("write failed");
-            goto fail;
+            return rc;
         }
     }
 
     TRACE("Negotiation succeeded.");
-    rc = 0;
-fail:
-    return rc;
+
+    return 0;
 }
 
 static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
-- 
2.11.1
