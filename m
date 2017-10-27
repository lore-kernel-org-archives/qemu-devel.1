Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824c-0001Tt-DM
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824b-0005nE-F1
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:41:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:40:34 +0200
Message-Id: <20171027104037.8319-10-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-1-eblake@redhat.com>
References: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/12] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Split out nbd_request_simple_option to be reused for structured reply
option.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: error message tweak [Vladimir]
v5: only check length for ACK responses
v4: reduce redundant traces, typo fix in commit message
---
 nbd/client.c     | 70 ++++++++++++++++++++++++++++++++++++++------------------
 nbd/trace-events |  4 +---
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 50f36b511e..9acf745b79 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -508,35 +508,61 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
     }
 }

+/* nbd_request_simple_option: Send an option request, and parse the reply
+ * return 1 for successful negotiation,
+ *        0 if operation is unsupported,
+ *        -1 with errp set for any other error
+ */
+static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)
+{
+    nbd_opt_reply reply;
+    int error;
+
+    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
+        return -1;
+    }
+
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
+        return -1;
+    }
+    error = nbd_handle_reply_err(ioc, &reply, errp);
+    if (error <= 0) {
+        return error;
+    }
+
+    if (reply.type != NBD_REP_ACK) {
+        error_setg(errp, "Server answered option %d (%s) with unexpected "
+                   "reply %" PRIx32 " (%s)", opt, nbd_opt_lookup(opt),
+                   reply.type, nbd_rep_lookup(reply.type));
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    if (reply.length != 0) {
+        error_setg(errp, "Option %d ('%s') response length is %" PRIu32
+                   " (it should be zero)", opt, nbd_opt_lookup(opt),
+                   reply.length);
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    return 1;
+}
+
 static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
                                         QCryptoTLSCreds *tlscreds,
                                         const char *hostname, Error **errp)
 {
-    nbd_opt_reply reply;
+    int ret;
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data = { 0 };

-    trace_nbd_receive_starttls_request();
-    if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) < 0) {
-        return NULL;
-    }
-
-    trace_nbd_receive_starttls_reply();
-    if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) < 0) {
-        return NULL;
-    }
-
-    if (reply.type != NBD_REP_ACK) {
-        error_setg(errp, "Server rejected request to start TLS %" PRIx32,
-                   reply.type);
-        nbd_send_opt_abort(ioc);
-        return NULL;
-    }
-
-    if (reply.length != 0) {
-        error_setg(errp, "Start TLS response was not zero %" PRIu32,
-                   reply.length);
-        nbd_send_opt_abort(ioc);
+    ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);
+    if (ret <= 0) {
+        if (ret == 0) {
+            error_setg(errp, "Server don't support STARTTLS option");
+            nbd_send_opt_abort(ioc);
+        }
         return NULL;
     }

diff --git a/nbd/trace-events b/nbd/trace-events
index 52150bd738..596df96575 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -8,9 +8,7 @@ nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
-nbd_receive_starttls_request(void) "Requesting TLS from server"
-nbd_receive_starttls_reply(void) "Getting TLS reply from server"
-nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
+nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-- 
2.13.6
