Received: from eggs.gnu.org ([2001:4830:134:3::10]:41191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPP-0000D7-Mk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPN-0007ic-Pk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPN-0007i7-Js
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:49 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so2764721wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:54 +0200
Message-Id: <1497523981-38449-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/41] nbd/server: rename rc to ret
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

For consistency use 'ret' name for saving return code everywhere
in the file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-12-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3b46038..f19f5fd 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -211,15 +211,15 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
     uint32_t len;
     const char *name = exp->name ? exp->name : "";
     const char *desc = exp->description ? exp->description : "";
-    int rc;
+    int ret;
 
     TRACE("Advertising export name '%s' description '%s'", name, desc);
     name_len = strlen(name);
     desc_len = strlen(desc);
     len = name_len + desc_len + sizeof(len);
-    rc = nbd_negotiate_send_rep_len(ioc, NBD_REP_SERVER, NBD_OPT_LIST, len);
-    if (rc < 0) {
-        return rc;
+    ret = nbd_negotiate_send_rep_len(ioc, NBD_REP_SERVER, NBD_OPT_LIST, len);
+    if (ret < 0) {
+        return ret;
     }
 
     len = cpu_to_be32(name_len);
@@ -536,7 +536,7 @@ static int nbd_negotiate_options(NBDClient *client)
 static coroutine_fn int nbd_negotiate(NBDClient *client)
 {
     char buf[8 + 8 + 8 + 128];
-    int rc;
+    int ret;
     const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
                               NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
                               NBD_FLAG_SEND_WRITE_ZEROES);
@@ -593,10 +593,10 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
             LOG("write failed");
             return -EINVAL;
         }
-        rc = nbd_negotiate_options(client);
-        if (rc != 0) {
+        ret = nbd_negotiate_options(client);
+        if (ret != 0) {
             LOG("option negotiation failed");
-            return rc;
+            return ret;
         }
 
         TRACE("advertising size %" PRIu64 " and flags %x",
@@ -604,10 +604,10 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        rc = nbd_write(client->ioc, buf + 18, len, NULL);
-        if (rc < 0) {
+        ret = nbd_write(client->ioc, buf + 18, len, NULL);
+        if (ret < 0) {
             LOG("write failed");
-            return rc;
+            return ret;
         }
     }
 
@@ -963,21 +963,21 @@ void nbd_export_close_all(void)
 static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 {
     NBDClient *client = req->client;
-    int rc;
+    int ret;
 
     g_assert(qemu_in_coroutine());
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
 
     if (!len) {
-        rc = nbd_send_reply(client->ioc, reply);
+        ret = nbd_send_reply(client->ioc, reply);
     } else {
         qio_channel_set_cork(client->ioc, true);
-        rc = nbd_send_reply(client->ioc, reply);
-        if (rc == 0) {
-            rc = nbd_write(client->ioc, req->data, len, NULL);
-            if (rc < 0) {
-                rc = -EIO;
+        ret = nbd_send_reply(client->ioc, reply);
+        if (ret == 0) {
+            ret = nbd_write(client->ioc, req->data, len, NULL);
+            if (ret < 0) {
+                ret = -EIO;
             }
         }
         qio_channel_set_cork(client->ioc, false);
@@ -985,7 +985,7 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 
     client->send_coroutine = NULL;
     qemu_co_mutex_unlock(&client->send_lock);
-    return rc;
+    return ret;
 }
 
 /* nbd_co_receive_request
-- 
1.8.3.1
