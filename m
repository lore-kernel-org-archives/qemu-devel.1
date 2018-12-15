Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOG-0004rG-3w
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOE-0008Dw-IY
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:00 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:11 -0600
Message-Id: <20181215135324.152629-10-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/22] nbd/client: Refactor
 nbd_receive_list()
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

Right now, nbd_receive_list() is only called by
nbd_receive_query_exports(), which in turn is only called if the
server lacks NBD_OPT_GO but has working option negotiation, and is
merely used as a quality-of-implementation trick since servers
can't give decent errors for NBD_OPT_EXPORT_NAME.  However, servers
that lack NBD_OPT_GO are becoming increasingly rare (nbdkit was a
latecomer, in Aug 2018, but qemu has been such a server since commit
f37708f6 in July 2017 and released in 2.10), so it no longer makes
sense to micro-optimize that function for performance.

Furthermore, when debugging a server's implementation, tracing the
full reply (both names and descriptions) is useful, not to mention
that upcoming patches adding 'qemu-nbd --list' will want to collect
that data.  And when you consider that a server can send an export
name up to the NBD protocol length limit of 4k; but our current
NBD_MAX_NAME_SIZE is only 256, we can't trace all valid server
names without more storage, but 4k is large enough that the heap
is better than the stack for long names.

Thus, I'm changing the division of labor, with nbd_receive_list()
now always malloc'ing a result on success (the malloc is bounded
by the fact that we reject servers with a reply length larger
than 32M), and moving the comparison to 'wantname' to the caller.

There is a minor change in behavior where a server with 0 exports
(an immediate NBD_REP_ACK reply) is now no longer distinguished
from a server without LIST support (NBD_REP_ERR_UNSUP); this
information could be preserved with a complication to the calling
contract to provide a bit more information, but I didn't see the
point.  After all, the worst that can happen if our guess at a
match is wrong is that the caller will get a cryptic disconnect
when NBD_OPT_EXPORT_NAME fails (which is no different from what
would happen if we had not tried LIST), while treating an empty
list as immediate failure would prevent connecting to really old
servers that really did lack LIST.  Besides, NBD servers with 0
exports are rare (qemu can do it when using QMP nbd-server-start
without nbd-server-add - but qemu understands NBD_OPT_GO and
thus won't tickle this change in behavior).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Rewrite in a different manner (move the comparison to the
caller)
Fix free to g_free [Vladimir]
---
 nbd/client.c     | 89 +++++++++++++++++++++++++++++++-----------------
 nbd/trace-events |  1 +
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 1a3a620fb6d..28f5a286cba 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -232,18 +232,24 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
     return result;
 }

-/* Process another portion of the NBD_OPT_LIST reply.  Set *@match if
- * the current reply matches @want or if the server does not support
- * NBD_OPT_LIST, otherwise leave @match alone.  Return 0 if iteration
- * is complete, positive if more replies are expected, or negative
- * with @errp set if an unrecoverable error occurred. */
-static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
+/* nbd_receive_list:
+ * Process another portion of the NBD_OPT_LIST reply, populating any
+ * name received into *@name. If @description is non-NULL, and the
+ * server provided a description, that is also populated. The caller
+ * must eventually call g_free() on success.
+ * Returns 1 if a name was received and iteration must continue,
+ *         0 if iteration is complete,
+ *         -1 with @errp set if an unrecoverable error occurred.
+ */
+static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
                             Error **errp)
 {
+    int ret = -1;
     NBDOptionReply reply;
     uint32_t len;
     uint32_t namelen;
-    char name[NBD_MAX_NAME_SIZE + 1];
+    char *local_name = NULL;
+    char *local_desc = NULL;
     int error;

     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
@@ -251,9 +257,6 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     }
     error = nbd_handle_reply_err(ioc, &reply, errp);
     if (error <= 0) {
-        /* The server did not support NBD_OPT_LIST, so set *match on
-         * the assumption that any name will be accepted.  */
-        *match = true;
         return error;
     }
     len = reply.length;
@@ -290,33 +293,38 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (namelen != strlen(want)) {
-        if (nbd_drop(ioc, len, errp) < 0) {
-            error_prepend(errp,
-                          "failed to skip export name with wrong length: ");
-            nbd_send_opt_abort(ioc);
-            return -1;
-        }
-        return 1;
-    }

-    assert(namelen < sizeof(name));
-    if (nbd_read(ioc, name, namelen, errp) < 0) {
+    local_name = g_malloc(namelen + 1);
+    if (nbd_read(ioc, local_name, namelen, errp) < 0) {
         error_prepend(errp, "failed to read export name: ");
         nbd_send_opt_abort(ioc);
-        return -1;
+        goto out;
     }
-    name[namelen] = '\0';
+    local_name[namelen] = '\0';
     len -= namelen;
-    if (nbd_drop(ioc, len, errp) < 0) {
-        error_prepend(errp, "failed to read export description: ");
-        nbd_send_opt_abort(ioc);
-        return -1;
+    if (len) {
+        local_desc = g_malloc(len + 1);
+        if (nbd_read(ioc, local_desc, len, errp) < 0) {
+            error_prepend(errp, "failed to read export description: ");
+            nbd_send_opt_abort(ioc);
+            goto out;
+        }
+        local_desc[len] = '\0';
     }
-    if (!strcmp(name, want)) {
-        *match = true;
+
+    trace_nbd_receive_list(local_name, local_desc ?: "");
+    *name = local_name;
+    local_name = NULL;
+    if (description) {
+        *description = local_desc;
+        local_desc = NULL;
     }
-    return 1;
+    ret = 1;
+
+ out:
+    g_free(local_name);
+    g_free(local_desc);
+    return ret;
 }


@@ -491,6 +499,7 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
                                      const char *wantname,
                                      Error **errp)
 {
+    bool listEmpty = true;
     bool foundExport = false;

     trace_nbd_receive_query_exports_start(wantname);
@@ -499,14 +508,25 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
     }

     while (1) {
-        int ret = nbd_receive_list(ioc, wantname, &foundExport, errp);
+        char *name;
+        int ret = nbd_receive_list(ioc, &name, NULL, errp);

         if (ret < 0) {
             /* Server gave unexpected reply */
             return -1;
         } else if (ret == 0) {
             /* Done iterating. */
-            if (!foundExport) {
+            if (listEmpty) {
+                /*
+                 * We don't have enough context to tell a server that
+                 * sent an empty list apart from a server that does
+                 * not support the list command; but as this function
+                 * is just used to trigger a nicer error message
+                 * before trying NBD_OPT_EXPORT_NAME, assume the
+                 * export is available.
+                 */
+                return 0;
+            } else if (!foundExport) {
                 error_setg(errp, "No export with name '%s' available",
                            wantname);
                 nbd_send_opt_abort(ioc);
@@ -515,6 +535,11 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
             trace_nbd_receive_query_exports_success(wantname);
             return 0;
         }
+        listEmpty = false;
+        if (!strcmp(name, wantname)) {
+            foundExport = true;
+        }
+        g_free(name);
     }
 }

diff --git a/nbd/trace-events b/nbd/trace-events
index 5e1d4afe8e6..8e9fc024c28 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -2,6 +2,7 @@
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIu32" (%s), type %" PRIu32" (%s), len %" PRIu32
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIu32 " (%s), attempting fallback"
+nbd_receive_list(const char *name, const char *desc) "export list includes '%s', description '%s'"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
-- 
2.17.2
