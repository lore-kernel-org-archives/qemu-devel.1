Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTu2-0006bN-Af
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtv-0007Dk-Tc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21547 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007CH-Ex
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:58:00 +0300
Message-Id: <20170925135801.144261-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/8] nbd/client: refactor nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Hmreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split out nbd_receive_simple_option to be reused for structured reply
option.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c     | 64 ++++++++++++++++++++++++++++++++++++++++----------------
 nbd/trace-events |  7 ++++---
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index cd5a2c80ac..51ae492e92 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -540,35 +540,63 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
     }
 }
 
-static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
-                                        QCryptoTLSCreds *tlscreds,
-                                        const char *hostname, Error **errp)
+/* nbd_request_simple_option
+ * return 1 for successful negotiation,
+ *        0 if operation is unsupported,
+ *        -1 with errp set for any other error
+ */
+static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)
 {
     nbd_opt_reply reply;
-    QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
 
-    trace_nbd_receive_starttls_request();
-    if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) < 0) {
-        return NULL;
+    trace_nbd_receive_simple_option_request(opt, nbd_opt_lookup(opt));
+    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
+        return -1;
     }
 
-    trace_nbd_receive_starttls_reply();
-    if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) < 0) {
-        return NULL;
+    trace_nbd_receive_simple_option_reply(opt, nbd_opt_lookup(opt));
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
+        return -1;
     }
 
-    if (reply.type != NBD_REP_ACK) {
-        error_setg(errp, "Server rejected request to start TLS %" PRIx32,
-                   reply.type);
+    if (reply.length != 0) {
+        error_setg(errp, "Option %d ('%s') response length is %" PRIu32
+                   " (it should be zero)", opt, nbd_opt_lookup(opt),
+                   reply.length);
         nbd_send_opt_abort(ioc);
-        return NULL;
+        return -1;
     }
 
-    if (reply.length != 0) {
-        error_setg(errp, "Start TLS response was not zero %" PRIu32,
-                   reply.length);
+    if (reply.type == NBD_REP_ERR_UNSUP) {
+        return 1;
+    }
+
+    if (reply.type != NBD_REP_ACK) {
+        error_setg(errp, "Server rejected request for option %d (%s) "
+                   "with reply %" PRIx32 " (%s)", opt, nbd_opt_lookup(opt),
+                   reply.type, nbd_rep_lookup(reply.type));
         nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    trace_nbd_receive_simple_option_approved(opt, nbd_opt_lookup(opt));
+    return 0;
+}
+
+static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
+                                        QCryptoTLSCreds *tlscreds,
+                                        const char *hostname, Error **errp)
+{
+    int ret;
+    QIOChannelTLS *tioc;
+    struct NBDTLSHandshakeData data = { 0 };
+
+    ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);
+    if (ret <= 0) {
+        if (ret == 0) {
+            error_setg(errp, "Server don't support STARTTLS option");
+            nbd_send_opt_abort(ioc);
+        }
         return NULL;
     }
 
diff --git a/nbd/trace-events b/nbd/trace-events
index 48a4f27682..ea44e6963f 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -9,9 +9,10 @@ nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
-nbd_receive_starttls_request(void) "Requesting TLS from server"
-nbd_receive_starttls_reply(void) "Getting TLS reply from server"
-nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
+nbd_receive_simple_option_request(int opt, const char *name) "Requesting option %d (%s) from server"
+nbd_receive_simple_option_reply(int opt, const char *name) "Getting reply for option %d (%s) from server"
+nbd_receive_simple_option_approved(int opt, const char *name) "Option %d (%s) approved"
+nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-- 
2.11.1
