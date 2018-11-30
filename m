Received: from eggs.gnu.org ([2001:4830:134:3::10]:56006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtJ-0004PG-4V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtH-0004FP-5x
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:05 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:36 -0600
Message-Id: <20181130220344.3350618-8-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] nbd/client: Refactor
 nbd_negotiate_simple_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Change the signature to make it easier for a future patch to
reuse this function for calling NBD_OPT_LIST_META_CONTEXT with
0 or 1 queries.  Also, always allocate space for the received
name, even if it doesn't match expected lengths (no point
trying to optimize the unlikely error case, and tracing the
received rather than expected name can help debug a server
implementation).

While there are now slightly different traces, and the error
message for a server replying with too many contexts is
different, there are no runtime-observable changes in behavior
for the more common case of the lone caller interacting with a
compliant server.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c     | 105 +++++++++++++++++++++++++++--------------------
 nbd/trace-events |   2 +-
 2 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b5818a99d21..1dc8f83e19a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -603,49 +603,57 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
 }

 /* nbd_negotiate_simple_meta_context:
- * Set one meta context. Simple means that reply must contain zero (not
- * negotiated) or one (negotiated) contexts. More contexts would be considered
- * as a protocol error. It's also implied that meta-data query equals queried
- * context name, so, if server replies with something different than @context,
- * it is considered an error too.
- * return 1 for successful negotiation, context_id is set
- *        0 if operation is unsupported,
+ * List or set meta context data for export @info->name, based on @opt.
+ * For list, leave @context NULL for 0 queries, or supplied for a single
+ * query; all replies are ignored, and the call merely traces server behavior.
+ * For set, @context must result in at most one matching server reply, in
+ * which case @info->meta_base_allocation_id is set to the resulting id.
+ * return 1 for successful negotiation,
+ *        0 if operation is unsupported or context unavailable,
  *        -1 with errp set for any other error
  */
 static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
-                                             const char *export,
+                                             int32_t opt,
                                              const char *context,
-                                             uint32_t *context_id,
+                                             NBDExportInfo *info,
                                              Error **errp)
 {
     int ret;
     NBDOptionReply reply;
     uint32_t received_id = 0;
     bool received = false;
-    uint32_t export_len = strlen(export);
-    uint32_t context_len = strlen(context);
-    uint32_t data_len = sizeof(export_len) + export_len +
-                        sizeof(uint32_t) + /* number of queries */
-                        sizeof(context_len) + context_len;
-    char *data = g_malloc(data_len);
-    char *p = data;
+    uint32_t export_len = strlen(info->name);
+    uint32_t context_len;
+    uint32_t data_len = sizeof(export_len) + export_len + sizeof(uint32_t);
+    char *data;
+    char *p;

-    trace_nbd_opt_meta_request(context, export);
+    if (!context) {
+        assert(opt == NBD_OPT_LIST_META_CONTEXT);
+    } else {
+        context_len = strlen(context);
+        data_len += sizeof(context_len) + context_len;
+    }
+    data = g_malloc(data_len);
+    p = data;
+
+    trace_nbd_opt_meta_request(nbd_opt_lookup(opt), context ?: "(all)",
+                               info->name);
     stl_be_p(p, export_len);
-    memcpy(p += sizeof(export_len), export, export_len);
-    stl_be_p(p += export_len, 1);
-    stl_be_p(p += sizeof(uint32_t), context_len);
-    memcpy(p += sizeof(context_len), context, context_len);
+    memcpy(p += sizeof(export_len), info->name, export_len);
+    stl_be_p(p += export_len, !!context);
+    if (context) {
+        stl_be_p(p += sizeof(uint32_t), context_len);
+        memcpy(p += sizeof(context_len), context, context_len);
+    }

-    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
-                                  errp);
+    ret = nbd_send_option_request(ioc, opt, data_len, data, errp);
     g_free(data);
     if (ret < 0) {
         return ret;
     }

-    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
-                                 errp) < 0)
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0)
     {
         return -1;
     }
@@ -655,10 +663,10 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         return ret;
     }

-    if (reply.type == NBD_REP_META_CONTEXT) {
+    while (reply.type == NBD_REP_META_CONTEXT) {
         char *name;

-        if (reply.length != sizeof(received_id) + context_len) {
+        if (reply.length <= sizeof(received_id)) {
             error_setg(errp, "Failed to negotiate meta context '%s', server "
                        "answered with unexpected length %" PRIu32, context,
                        reply.length);
@@ -678,23 +686,31 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
             return -1;
         }
         name[reply.length] = '\0';
-        if (strcmp(context, name)) {
-            error_setg(errp, "Failed to negotiate meta context '%s', server "
-                       "answered with different context '%s'", context,
-                       name);
-            g_free(name);
-            nbd_send_opt_abort(ioc);
-            return -1;
+
+        trace_nbd_opt_meta_reply(name, received_id);
+        if (opt == NBD_OPT_SET_META_CONTEXT) {
+            if (received) {
+                error_setg(errp, "Server replied with more than one context");
+                free(name);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+
+            if (strcmp(context, name)) {
+                error_setg(errp,
+                           "Failed to negotiate meta context '%s', server "
+                           "answered with different context '%s'", context,
+                           name);
+                g_free(name);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
         }
         g_free(name);
-
-        trace_nbd_opt_meta_reply(context, received_id);
         received = true;

         /* receive NBD_REP_ACK */
-        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
-                                     errp) < 0)
-        {
+        if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }

@@ -717,12 +733,11 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         return -1;
     }

-    if (received) {
-        *context_id = received_id;
-        return 1;
+    if (received && opt == NBD_OPT_SET_META_CONTEXT) {
+        info->meta_base_allocation_id = received_id;
     }

-    return 0;
+    return received || opt == NBD_OPT_LIST_META_CONTEXT;
 }

 int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
@@ -822,9 +837,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,

             if (info->structured_reply && base_allocation) {
                 result = nbd_negotiate_simple_meta_context(
-                        ioc, info->name,
+                        ioc, NBD_OPT_SET_META_CONTEXT,
                         info->x_dirty_bitmap ?: "base:allocation",
-                        &info->meta_base_allocation_id, errp);
+                        info, errp);
                 if (result < 0) {
                     goto fail;
                 }
diff --git a/nbd/trace-events b/nbd/trace-events
index 289337d0dc3..5d0d202fad2 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -10,7 +10,7 @@ nbd_receive_query_exports_start(const char *wantname) "Querying export list for
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
-nbd_opt_meta_request(const char *context, const char *export) "Requesting to set meta context %s for export %s"
+nbd_opt_meta_request(const char *opt, const char *context, const char *export) "Requesting to %s %s for export %s"
 nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of context %s to id %" PRIu32
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-- 
2.17.2
