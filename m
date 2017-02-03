Received: from eggs.gnu.org ([2001:4830:134:3::10]:36695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nZ-Bm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00081z-4U
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:42403 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007zf-P0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:43 +0300
Message-Id: <20170203154757.36140-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/18] nbd/client: refactor nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Split out nbd_receive_simple_option to be reused for structured reply
option.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c       | 54 +++++++++++++++++++++++++++++++++++-------------------
 nbd/nbd-internal.h | 14 ++++++++++++++
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index de5c9366c7..6caf6bda6d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -395,39 +395,55 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
     }
 }
 
-static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
-                                        QCryptoTLSCreds *tlscreds,
-                                        const char *hostname, Error **errp)
+static int nbd_receive_simple_option(QIOChannel *ioc, int opt,
+                                     bool abort_on_notsup, Error **errp)
 {
     nbd_opt_reply reply;
-    QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
 
-    TRACE("Requesting TLS from server");
-    if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) < 0) {
-        return NULL;
+    TRACE("Requesting '%s' option from server", nbd_opt_name(opt));
+    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
+        return -1;
     }
 
-    TRACE("Getting TLS reply from server");
-    if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) < 0) {
-        return NULL;
+    TRACE("Getting '%s' option reply from server", nbd_opt_name(opt));
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
+        return -1;
     }
 
     if (reply.type != NBD_REP_ACK) {
-        error_setg(errp, "Server rejected request to start TLS %" PRIx32,
-                   reply.type);
-        nbd_send_opt_abort(ioc);
-        return NULL;
+        error_setg(errp, "Server rejected request for '%s' option: %" PRIx32,
+                   nbd_opt_name(opt), reply.type);
+        if (abort_on_notsup) {
+            nbd_send_opt_abort(ioc);
+        }
+        return -1;
     }
 
     if (reply.length != 0) {
-        error_setg(errp, "Start TLS response was not zero %" PRIu32,
-                   reply.length);
-        nbd_send_opt_abort(ioc);
+        error_setg(errp, "'%s' option response was not zero %" PRIu32,
+                   nbd_opt_name(opt), reply.length);
+        if (abort_on_notsup) {
+            nbd_send_opt_abort(ioc);
+        }
+        return -1;
+    }
+
+    TRACE("%s 'option' approved", nbd_opt_name(opt));
+    return 0;
+}
+
+static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
+                                        QCryptoTLSCreds *tlscreds,
+                                        const char *hostname, Error **errp)
+{
+    QIOChannelTLS *tioc;
+    struct NBDTLSHandshakeData data = { 0 };
+
+    if (nbd_receive_simple_option(ioc, NBD_OPT_STARTTLS, true, errp) < 0) {
         return NULL;
     }
 
-    TRACE("TLS request approved, setting up TLS");
+    TRACE("Setting up TLS");
     tioc = qio_channel_tls_new_client(ioc, tlscreds, hostname, errp);
     if (!tioc) {
         return NULL;
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 489eeaf887..3284bfc85a 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -96,6 +96,20 @@
 #define NBD_ENOSPC     28
 #define NBD_ESHUTDOWN  108
 
+static inline const char *nbd_opt_name(int opt)
+{
+    switch (opt) {
+    case NBD_OPT_EXPORT_NAME: return "export_name";
+    case NBD_OPT_ABORT: return "abort";
+    case NBD_OPT_LIST: return "list";
+    case NBD_OPT_PEEK_EXPORT: return "peek_export";
+    case NBD_OPT_STARTTLS: return "tls";
+    case NBD_OPT_STRUCTURED_REPLY: return "structured_reply";
+    }
+
+    return "<unknown option>";
+}
+
 static inline ssize_t read_sync(QIOChannel *ioc, void *buffer, size_t size)
 {
     struct iovec iov = { .iov_base = buffer, .iov_len = size };
-- 
2.11.0
