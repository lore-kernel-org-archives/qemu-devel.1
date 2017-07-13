Received: from eggs.gnu.org ([2001:4830:134:3::10]:51494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3j-0001HF-0y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3h-0002nY-Pr
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:38 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3h-0002jD-EO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:37 -0400
Received: by mail-wr0-x243.google.com with SMTP id k67so9398830wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:28 +0200
Message-Id: <1499955874-10954-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/41] nbd: Refactor reply to NBD_OPT_EXPORT_NAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Reply directly in nbd_negotiate_handle_export_name(), rather than
waiting until nbd_negotiate_options() completes.  This will make it
easier to implement NBD_OPT_GO.  Pass additional parameters around,
rather than stashing things inside NBDClient.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-6-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 8e363d3..841986d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -84,7 +84,6 @@ struct NBDClient {
     int refcount;
     void (*close_fn)(NBDClient *client, bool negotiated);
 
-    bool no_zeroes;
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsaclname;
@@ -277,9 +276,13 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
 }
 
 static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
+                                            uint16_t myflags, bool no_zeroes,
                                             Error **errp)
 {
     char name[NBD_MAX_NAME_SIZE + 1];
+    char buf[8 + 4 + 124] = "";
+    size_t len;
+    int ret;
 
     /* Client sends:
         [20 ..  xx]   export name (length bytes)
@@ -303,6 +306,17 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
         return -EINVAL;
     }
 
+    trace_nbd_negotiate_new_style_size_flags(client->exp->size,
+                                             client->exp->nbdflags | myflags);
+    stq_be_p(buf, client->exp->size);
+    stw_be_p(buf + 8, client->exp->nbdflags | myflags);
+    len = no_zeroes ? 10 : sizeof(buf);
+    ret = nbd_write(client->ioc, buf, len, errp);
+    if (ret < 0) {
+        error_prepend(errp, "write failed: ");
+        return ret;
+    }
+
     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     nbd_export_get(client->exp);
 
@@ -373,14 +387,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
  * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
  *         errp is not set
  */
-static int nbd_negotiate_options(NBDClient *client, Error **errp)
+static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
+                                 Error **errp)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
+    bool no_zeroes = false;
 
     /* Client sends:
         [ 0 ..   3]   client flags
 
+       Then we loop until NBD_OPT_EXPORT_NAME:
         [ 0 ..   7]   NBD_OPTS_MAGIC
         [ 8 ..  11]   NBD option
         [12 ..  15]   Data length
@@ -403,7 +420,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         flags &= ~NBD_FLAG_C_FIXED_NEWSTYLE;
     }
     if (flags & NBD_FLAG_C_NO_ZEROES) {
-        client->no_zeroes = true;
+        no_zeroes = true;
         flags &= ~NBD_FLAG_C_NO_ZEROES;
     }
     if (flags != 0) {
@@ -503,7 +520,9 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 return 1;
 
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length, errp);
+                return nbd_negotiate_handle_export_name(client, length,
+                                                        myflags, no_zeroes,
+                                                        errp);
 
             case NBD_OPT_STARTTLS:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
@@ -546,7 +565,9 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
              */
             switch (option) {
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length, errp);
+                return nbd_negotiate_handle_export_name(client, length,
+                                                        myflags, no_zeroes,
+                                                        errp);
 
             default:
                 error_setg(errp, "Unsupported option 0x%" PRIx32 " (%s)",
@@ -572,7 +593,6 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
                               NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
                               NBD_FLAG_SEND_WRITE_ZEROES);
     bool oldStyle;
-    size_t len;
 
     /* Old style negotiation header without options
         [ 0 ..   7]   passwd       ("NBDMAGIC")
@@ -586,10 +606,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         [ 0 ..   7]   passwd       ("NBDMAGIC")
         [ 8 ..  15]   magic        (NBD_OPTS_MAGIC)
         [16 ..  17]   server flags (0)
-        ....options sent....
-        [18 ..  25]   size
-        [26 ..  27]   export flags
-        [28 .. 151]   reserved     (0, omit if no_zeroes)
+        ....options sent, ending in NBD_OPT_EXPORT_NAME....
      */
 
     qio_channel_set_blocking(client->ioc, false, NULL);
@@ -618,24 +635,13 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
             error_prepend(errp, "write failed: ");
             return -EINVAL;
         }
-        ret = nbd_negotiate_options(client, errp);
+        ret = nbd_negotiate_options(client, myflags, errp);
         if (ret != 0) {
             if (ret < 0) {
                 error_prepend(errp, "option negotiation failed: ");
             }
             return ret;
         }
-
-        trace_nbd_negotiate_new_style_size_flags(
-            client->exp->size, client->exp->nbdflags | myflags);
-        stq_be_p(buf + 18, client->exp->size);
-        stw_be_p(buf + 26, client->exp->nbdflags | myflags);
-        len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        ret = nbd_write(client->ioc, buf + 18, len, errp);
-        if (ret < 0) {
-            error_prepend(errp, "write failed: ");
-            return ret;
-        }
     }
 
     trace_nbd_negotiate_success();
-- 
1.8.3.1
