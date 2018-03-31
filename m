Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FbO-0005nD-2M
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FbM-00010B-6k
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:27:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 31 Mar 2018 07:27:08 -0500
Message-Id: <20180331122708.1954245-1-eblake@redhat.com>
In-Reply-To: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
References: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
Subject: [Qemu-devel] [PATCH qemu] RFC: nbd: Separate namespace from
 leaf-name for metadata contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: nbd@other.debian.org, vsementsov@virtuozzo.com, w@uter.be, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

During implementation of NBD_CMD_BLOCK_STATUS, we found that parsing
for the colon that separates namespaces from leaf-names can get
awkward.  Simplify things slightly by passing the two as separate
fields, and noting that since strings are capped to 4k, a 16-bit
rather than 32-bit length field is sufficient.  On the request
(NBD_OPT_{LIST,SET}_META_CONTEXT), the client can send more than
one query in a single wire packet, so must include the length of
the namespace and leaf per query.  On reply (NBD_REP_META_CONTEXT),
each context is set as a separate wire packet, and therefore the
header length is sufficient to reconstruct the leaf length without
having to redundantly send it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

As mentioned in the cover letter, this has to go in at the same
time as the corresponding NBD patch, and prior to the qemu 2.12
release, if we like it.  Or we can ignore it.

 include/block/nbd.h |  9 ++++---
 nbd/client.c        | 72 +++++++++++++++++++++++++++++++++++------------------
 nbd/server.c        | 71 +++++++++++++++++++++++++++++++++-------------------
 nbd/trace-events    |  7 +++---
 4 files changed, 103 insertions(+), 56 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fcdcd545023..2060c0c666d 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -42,9 +42,11 @@ struct NBDOptionReply {
 typedef struct NBDOptionReply NBDOptionReply;

 typedef struct NBDOptionReplyMetaContext {
-    NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 4 */
+    NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 7 */
     uint32_t context_id;
-    /* meta context name follows */
+    uint16_t namespace_len; /* Must be nonzero */
+    /* namespace follows, length given by namespace_len */
+    /* leaf-name follows, length computed by h.length - 6 - namespace_len */
 } QEMU_PACKED NBDOptionReplyMetaContext;

 /* Transmission phase structs
@@ -156,7 +158,8 @@ typedef struct NBDExtent {
 #define NBD_OPT_GO                (7)
 #define NBD_OPT_STRUCTURED_REPLY  (8)
 #define NBD_OPT_LIST_META_CONTEXT (9)
-#define NBD_OPT_SET_META_CONTEXT  (10)
+/* #define NBD_OPT_OLD_META_CONTEXT (10) not in use */
+#define NBD_OPT_SET_META_CONTEXT  (11)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
diff --git a/nbd/client.c b/nbd/client.c
index 478b6085df7..1858289ad4f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -599,15 +599,16 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
  * Set one meta context. Simple means that reply must contain zero (not
  * negotiated) or one (negotiated) contexts. More contexts would be considered
  * as a protocol error. It's also implied that meta-data query equals queried
- * context name, so, if server replies with something different than @context,
- * it is considered an error too.
+ * context name, so, if server replies with something different than
+ * the same @namespace and @leaf, it is considered an error too.
  * return 1 for successful negotiation, context_id is set
  *        0 if operation is unsupported,
  *        -1 with errp set for any other error
  */
 static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
                                              const char *export,
-                                             const char *context,
+                                             const char *namespace,
+                                             const char *leaf,
                                              uint32_t *context_id,
                                              Error **errp)
 {
@@ -616,19 +617,23 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     uint32_t received_id;
     bool received;
     uint32_t export_len = strlen(export);
-    uint32_t context_len = strlen(context);
+    uint16_t namespace_len = strlen(namespace);
+    uint16_t leaf_len = strlen(leaf);
     uint32_t data_len = sizeof(export_len) + export_len +
                         sizeof(uint32_t) + /* number of queries */
-                        sizeof(context_len) + context_len;
+                        sizeof(namespace_len) + namespace_len +
+                        sizeof(leaf_len) + leaf_len;
     char *data = g_malloc(data_len);
     char *p = data;

-    trace_nbd_opt_meta_request(context, export);
+    trace_nbd_opt_meta_request(namespace, leaf, export);
     stl_be_p(p, export_len);
     memcpy(p += sizeof(export_len), export, export_len);
     stl_be_p(p += export_len, 1);
-    stl_be_p(p += sizeof(uint32_t), context_len);
-    memcpy(p += sizeof(context_len), context, context_len);
+    stw_be_p(p += sizeof(uint32_t), namespace_len);
+    memcpy(p += sizeof(namespace_len), namespace, namespace_len);
+    stw_be_p(p += namespace_len, leaf_len);
+    memcpy(p += sizeof(leaf_len), leaf, leaf_len);

     ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
                                   errp);
@@ -650,14 +655,16 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,

     if (reply.type == NBD_REP_META_CONTEXT) {
         char *name;
-        size_t len;
+        uint16_t len;

-        if (reply.length != sizeof(received_id) + context_len) {
-            error_setg(errp, "Failed to negotiate meta context '%s', server "
-                       "answered with unexpected length %u", context,
-                       reply.length);
-            nbd_send_opt_abort(ioc);
-            return -1;
+        if (reply.length != sizeof(received_id) + sizeof(len) +
+            namespace_len + leaf_len) {
+            /* Name can't match, silently ignore this reply */
+            if (nbd_drop(ioc, reply.length, errp) < 0) {
+                return -1;
+            }
+            trace_nbd_opt_meta_skip("size mismatch compared to header");
+            goto next;
         }

         if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
@@ -665,16 +672,32 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         }
         be32_to_cpus(&received_id);

-        len = reply.length - sizeof(received_id);
-        name = g_malloc(len + 1);
-        if (nbd_read(ioc, name, len, errp) < 0) {
+        if (nbd_read(ioc, &len, sizeof(len), errp) < 0) {
+            return -1;
+        }
+        be16_to_cpus(&len);
+        if (len != namespace_len) {
+            /* Name can't match, silently ignore this reply */
+            if (nbd_drop(ioc, reply.length - sizeof(received_id) - sizeof(len),
+                         errp) < 0) {
+                return -1;
+            }
+            trace_nbd_opt_meta_skip("size mismatch on namespace");
+            goto next;
+        }
+
+        name = g_malloc(namespace_len + leaf_len + 1);
+        if (nbd_read(ioc, name,
+                     reply.length - sizeof(received_id) - sizeof(len),
+                     errp) < 0) {
             g_free(name);
             return -1;
         }
-        name[len] = '\0';
-        if (strcmp(context, name)) {
-            error_setg(errp, "Failed to negotiate meta context '%s', server "
-                       "answered with different context '%s'", context,
+        name[namespace_len + leaf_len] = '\0';
+        if (strncmp(namespace, name, namespace_len) ||
+            strcmp(leaf, name + namespace_len)) {
+            error_setg(errp, "Failed to negotiate meta context '%s:%s', server "
+                       "answered with different context '%s'", namespace, leaf,
                        name);
             g_free(name);
             nbd_send_opt_abort(ioc);
@@ -682,9 +705,10 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         }
         g_free(name);

-        trace_nbd_opt_meta_reply(context, received_id);
+        trace_nbd_opt_meta_reply(namespace, leaf, received_id);
         received = true;

+    next:
         /* receive NBD_REP_ACK */
         if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
                                      errp) < 0)
@@ -826,7 +850,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,

             if (info->structured_reply && base_allocation) {
                 result = nbd_negotiate_simple_meta_context(
-                        ioc, name, "base:allocation",
+                        ioc, name, "base", "allocation",
                         &info->meta_base_allocation_id, errp);
                 if (result < 0) {
                     goto fail;
diff --git a/nbd/server.c b/nbd/server.c
index 9e1f2271784..21614ab89c0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -712,42 +712,52 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
  * For NBD_OPT_LIST_META_CONTEXT @context_id is ignored, 0 is used instead.
  */
 static int nbd_negotiate_send_meta_context(NBDClient *client,
-                                           const char *context,
+                                           const char *namespace,
+                                           const char *leaf,
                                            uint32_t context_id,
                                            Error **errp)
 {
     NBDOptionReplyMetaContext opt;
     struct iovec iov[] = {
         {.iov_base = &opt, .iov_len = sizeof(opt)},
-        {.iov_base = (void *)context, .iov_len = strlen(context)}
+        {.iov_base = (void *)namespace, .iov_len = strlen(namespace)},
+        {.iov_base = (void *)leaf, .iov_len = strlen(leaf)},
     };

     if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
         context_id = 0;
     }

-    trace_nbd_negotiate_meta_query_reply(context, context_id);
+    trace_nbd_negotiate_meta_query_reply(namespace, leaf, context_id);
     set_be_option_rep(&opt.h, client->opt, NBD_REP_META_CONTEXT,
-                      sizeof(opt) - sizeof(opt.h) + iov[1].iov_len);
+                      sizeof(opt) - sizeof(opt.h) + iov[1].iov_len +
+                      iov[2].iov_len);
     stl_be_p(&opt.context_id, context_id);
+    stw_be_p(&opt.namespace_len, iov[1].iov_len);

-    return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
+    return qio_channel_writev_all(client->ioc, iov, 3, errp) < 0 ? -EIO : 0;
 }

 /* nbd_meta_base_query
  *
  * Handle query to 'base' namespace. For now, only base:allocation context is
- * available in it.  'len' is the amount of text remaining to be read from
- * the current name, after the 'base:' portion has been stripped.
+ * available in it.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
 static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
-                               uint32_t len, Error **errp)
+                               Error **errp)
 {
     int ret;
-    char query[sizeof("allocation") - 1];
-    size_t alen = strlen("allocation");
+    char query[] = "allocation";
+    size_t alen = strlen(query);
+    uint16_t len;
+
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be16s(&len);

     if (len == 0) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
@@ -767,7 +777,7 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
         return ret;
     }

-    if (strncmp(query, "allocation", alen) == 0) {
+    if (!strcmp(query, "allocation")) {
         meta->base_allocation = true;
     }

@@ -791,34 +801,43 @@ static int nbd_negotiate_meta_query(NBDClient *client,
                                     NBDExportMetaContexts *meta, Error **errp)
 {
     int ret;
-    char query[sizeof("base:") - 1];
-    size_t baselen = strlen("base:");
-    uint32_t len;
+    char query[] = "base";
+    size_t baselen = strlen(query);
+    uint16_t len;

     ret = nbd_opt_read(client, &len, sizeof(len), errp);
     if (ret <= 0) {
         return ret;
     }
-    cpu_to_be32s(&len);
+    cpu_to_be16s(&len);

-    /* The only supported namespace for now is 'base'. So query should start
-     * with 'base:'. Otherwise, we can ignore it and skip the remainder. */
-    if (len < baselen) {
-        trace_nbd_negotiate_meta_query_skip("length too short");
-        return nbd_opt_skip(client, len, errp);
+    /* The only supported namespace for now is 'base'. Ignore any other
+     * namespace */
+    if (len != baselen) {
+        trace_nbd_negotiate_meta_query_skip("not for base: namespace");
+        ret = nbd_opt_skip(client, len, errp);
+        if (ret <= 0) {
+            return ret;
+        }
+        goto skip_leaf;
     }

-    len -= baselen;
-    ret = nbd_opt_read(client, query, baselen, errp);
+    ret = nbd_opt_read(client, query, len, errp);
     if (ret <= 0) {
         return ret;
     }
-    if (strncmp(query, "base:", baselen) != 0) {
+    if (!strcmp(query, "base")) {
         trace_nbd_negotiate_meta_query_skip("not for base: namespace");
-        return nbd_opt_skip(client, len, errp);
+        return nbd_meta_base_query(client, meta, errp);
     }

-    return nbd_meta_base_query(client, meta, len, errp);
+ skip_leaf:
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be16s(&len);
+    return nbd_opt_skip(client, len, errp);
 }

 /* nbd_negotiate_meta_queries
@@ -880,7 +899,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     }

     if (meta->base_allocation) {
-        ret = nbd_negotiate_send_meta_context(client, "base:allocation",
+        ret = nbd_negotiate_send_meta_context(client, "base", "allocation",
                                               NBD_META_ID_BASE_ALLOCATION,
                                               errp);
         if (ret < 0) {
diff --git a/nbd/trace-events b/nbd/trace-events
index cfdbe04b447..585ca7e809d 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -10,8 +10,9 @@ nbd_receive_query_exports_start(const char *wantname) "Querying export list for
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
-nbd_opt_meta_request(const char *context, const char *export) "Requesting to set meta context %s for export %s"
-nbd_opt_meta_reply(const char *context, int id) "Received mapping of context %s to id %d"
+nbd_opt_meta_request(const char *namespace, const char *leaf, const char *export) "Requesting to set meta context %s:%s for export %s"
+nbd_opt_meta_skip(const char *reason) "Could not parse server reply: %s"
+nbd_opt_meta_reply(const char *namespace, const char *leaf, int id) "Received mapping of context %s:%s to id %d"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
@@ -49,7 +50,7 @@ nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_meta_context(const char *optname, const char *export, int queries) "Client requested %s for export %s, with %d queries"
 nbd_negotiate_meta_query_skip(const char *reason) "Skipping meta query: %s"
 nbd_negotiate_meta_query_parse(const char *query) "Parsed meta query '%s'"
-nbd_negotiate_meta_query_reply(const char *context, unsigned int id) "Replying with meta context '%s' id %d"
+nbd_negotiate_meta_query_reply(const char *namespace, const char *leaf, unsigned int id) "Replying with meta context '%s:%s' id %d"
 nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
 nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %" PRIu32 " (%s)"
-- 
2.14.3
