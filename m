Received: from eggs.gnu.org ([2001:4830:134:3::10]:34547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOM-0004ya-4k
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOK-0008Hr-Ss
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:06 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:16 -0600
Message-Id: <20181215135324.152629-15-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/22] nbd/client: Split out
 nbd_receive_one_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Refactor nbd_negotiate_simple_meta_context() to more closely
resemble the pattern of nbd_receive_list(), separating the
argument validation for one pass from the caller making a loop
over passes. No major semantic change (although one error
message loses the original query).  The diff may be a bit hard
to follow due to indentation changes and handling ACK first
rather than last.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split patch into easier-to-review pieces [Rich, Vladimir]
---
 nbd/client.c     | 144 +++++++++++++++++++++++++++--------------------
 nbd/trace-events |   2 +-
 2 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 5b6b9964097..0e5a9d59dbd 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -669,6 +669,83 @@ static int nbd_send_one_meta_context(QIOChannel *ioc,
     return ret;
 }

+/* nbd_receive_one_meta_context:
+ * Called in a loop to receive and trace one set/list meta context reply.
+ * Pass non-NULL @name or @id to collect results back to the caller, which
+ * must eventually call g_free().
+ * return 1 if more contexts are expected,
+ *        0 if operation is complete,
+ *        -1 with errp set for any error
+ */
+static int nbd_receive_one_meta_context(QIOChannel *ioc,
+                                        uint32_t opt,
+                                        char **name,
+                                        uint32_t *id,
+                                        Error **errp)
+{
+    int ret;
+    NBDOptionReply reply;
+    char *local_name = NULL;
+    uint32_t local_id;
+
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
+        return -1;
+    }
+
+    ret = nbd_handle_reply_err(ioc, &reply, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    if (reply.type == NBD_REP_ACK) {
+        if (reply.length != 0) {
+            error_setg(errp, "Unexpected length to ACK response");
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+        return 0;
+    } else if (reply.type != NBD_REP_META_CONTEXT) {
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_META_CONTEXT, nbd_rep_lookup(NBD_REP_META_CONTEXT));
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    if (reply.length <= sizeof(local_id) ||
+        reply.length > NBD_MAX_BUFFER_SIZE) {
+        error_setg(errp, "Failed to negotiate meta context, server "
+                   "answered with unexpected length %" PRIu32,
+                   reply.length);
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    if (nbd_read(ioc, &local_id, sizeof(local_id), errp) < 0) {
+        return -1;
+    }
+    local_id = be32_to_cpu(local_id);
+
+    reply.length -= sizeof(local_id);
+    local_name = g_malloc(reply.length + 1);
+    if (nbd_read(ioc, local_name, reply.length, errp) < 0) {
+        g_free(local_name);
+        return -1;
+    }
+    local_name[reply.length] = '\0';
+    trace_nbd_opt_meta_reply(nbd_opt_lookup(opt), local_name, local_id);
+
+    if (name) {
+        *name = local_name;
+    } else {
+        g_free(local_name);
+    }
+    if (id) {
+        *id = local_id;
+    }
+    return 1;
+}
+
 /* nbd_negotiate_simple_meta_context:
  * Request the server to set the meta context for export @info->name
  * using @info->x_dirty_bitmap with a fallback to "base:allocation",
@@ -690,7 +767,6 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
      * function should lose the term _simple.
      */
     int ret;
-    NBDOptionReply reply;
     const char *context = info->x_dirty_bitmap ?: "base:allocation";
     bool received = false;

@@ -699,44 +775,17 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         return -1;
     }

-    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
-                                 errp) < 0)
-    {
-        return -1;
-    }
-
-    ret = nbd_handle_reply_err(ioc, &reply, errp);
-    if (ret <= 0) {
-        return ret;
-    }
-
-    while (reply.type == NBD_REP_META_CONTEXT) {
+    while (1) {
         char *name;

-        if (reply.length <= sizeof(info->context_id) ||
-            reply.length > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "Failed to negotiate meta context '%s', server "
-                       "answered with unexpected length %" PRIu32, context,
-                       reply.length);
-            nbd_send_opt_abort(ioc);
+        ret = nbd_receive_one_meta_context(ioc, NBD_OPT_SET_META_CONTEXT,
+                                           &name, &info->context_id, errp);
+        if (ret < 0) {
             return -1;
+        } else if (ret == 0) {
+            return received;
         }

-        if (nbd_read(ioc, &info->context_id, sizeof(info->context_id),
-                     errp) < 0) {
-            return -1;
-        }
-        info->context_id = be32_to_cpu(info->context_id);
-
-        reply.length -= sizeof(info->context_id);
-        name = g_malloc(reply.length + 1);
-        if (nbd_read(ioc, name, reply.length, errp) < 0) {
-            g_free(name);
-            return -1;
-        }
-        name[reply.length] = '\0';
-        trace_nbd_opt_meta_reply(name, info->context_id);
-
         if (received) {
             error_setg(errp, "Server replied with more than one context");
             g_free(name);
@@ -754,34 +803,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         }
         g_free(name);
         received = true;
-
-        /* receive NBD_REP_ACK */
-        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
-                                     errp) < 0)
-        {
-            return -1;
-        }
-
-        ret = nbd_handle_reply_err(ioc, &reply, errp);
-        if (ret <= 0) {
-            return ret;
-        }
     }
-
-    if (reply.type != NBD_REP_ACK) {
-        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s)",
-                   reply.type, nbd_rep_lookup(reply.type),
-                   NBD_REP_ACK, nbd_rep_lookup(NBD_REP_ACK));
-        nbd_send_opt_abort(ioc);
-        return -1;
-    }
-    if (reply.length) {
-        error_setg(errp, "Unexpected length to ACK response");
-        nbd_send_opt_abort(ioc);
-        return -1;
-    }
-
-    return received;
 }

 int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
diff --git a/nbd/trace-events b/nbd/trace-events
index 00872a6f9d4..02956c96042 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -12,7 +12,7 @@ nbd_receive_query_exports_success(const char *wantname) "Found desired export na
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_opt_meta_request(const char *optname, const char *context, const char *export) "Requesting %s %s for export %s"
-nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of context %s to id %" PRIu32
+nbd_opt_meta_reply(const char *optname, const char *context, uint32_t id) "Received %s mapping of %s to id %" PRIu32
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
-- 
2.17.2
