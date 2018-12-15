Received: from eggs.gnu.org ([2001:4830:134:3::10]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOJ-0004vL-DW
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOG-0008Fp-W1
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:03 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:15 -0600
Message-Id: <20181215135324.152629-14-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/22] nbd/client: Split out
 nbd_send_one_meta_context()
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

Refactor nbd_negotiate_simple_meta_context() to pull out the
code that can be reused to send a LIST request for 0 or 1 query.
No semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split patch into easier-to-review pieces [Rich, Vladimir]
---
 nbd/client.c     | 64 ++++++++++++++++++++++++++++++++++--------------
 nbd/trace-events |  2 +-
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b6a85fc3ef8..5b6b9964097 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -627,6 +627,48 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }

+/* nbd_send_one_meta_context:
+ * Send 0 or 1 set/list meta context queries.
+ * return 0 on success, -1 with errp set for any error
+ */
+static int nbd_send_one_meta_context(QIOChannel *ioc,
+                                     uint32_t opt,
+                                     const char *export,
+                                     const char *query,
+                                     Error **errp)
+{
+    int ret;
+    uint32_t export_len = strlen(export);
+    uint32_t queries = !!query;
+    uint32_t context_len = 0;
+    uint32_t data_len;
+    char *data;
+    char *p;
+
+    data_len = sizeof(export_len) + export_len + sizeof(queries);
+    if (query) {
+        context_len = strlen(query);
+        data_len += sizeof(context_len) + context_len;
+    } else {
+        assert(opt == NBD_OPT_LIST_META_CONTEXT);
+    }
+    data = g_malloc(data_len);
+    p = data;
+
+    trace_nbd_opt_meta_request(nbd_opt_lookup(opt), query ?: "(all)", export);
+    stl_be_p(p, export_len);
+    memcpy(p += sizeof(export_len), export, export_len);
+    stl_be_p(p += export_len, queries);
+    if (query) {
+        stl_be_p(p += sizeof(uint32_t), context_len);
+        memcpy(p += sizeof(context_len), query, context_len);
+    }
+
+    ret = nbd_send_option_request(ioc, opt, data_len, data, errp);
+    g_free(data);
+    return ret;
+}
+
 /* nbd_negotiate_simple_meta_context:
  * Request the server to set the meta context for export @info->name
  * using @info->x_dirty_bitmap with a fallback to "base:allocation",
@@ -651,26 +693,10 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     NBDOptionReply reply;
     const char *context = info->x_dirty_bitmap ?: "base:allocation";
     bool received = false;
-    uint32_t export_len = strlen(info->name);
-    uint32_t context_len = strlen(context);
-    uint32_t data_len = sizeof(export_len) + export_len +
-                        sizeof(uint32_t) + /* number of queries */
-                        sizeof(context_len) + context_len;
-    char *data = g_malloc(data_len);
-    char *p = data;

-    trace_nbd_opt_meta_request(context, info->name);
-    stl_be_p(p, export_len);
-    memcpy(p += sizeof(export_len), info->name, export_len);
-    stl_be_p(p += export_len, 1);
-    stl_be_p(p += sizeof(uint32_t), context_len);
-    memcpy(p += sizeof(context_len), context, context_len);
-
-    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
-                                  errp);
-    g_free(data);
-    if (ret < 0) {
-        return ret;
+    if (nbd_send_one_meta_context(ioc, NBD_OPT_SET_META_CONTEXT,
+                                  info->name, context, errp) < 0) {
+        return -1;
     }

     if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
diff --git a/nbd/trace-events b/nbd/trace-events
index 446d10b8603..00872a6f9d4 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -11,7 +11,7 @@ nbd_receive_query_exports_start(const char *wantname) "Querying export list for
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
-nbd_opt_meta_request(const char *context, const char *export) "Requesting to set meta context %s for export %s"
+nbd_opt_meta_request(const char *optname, const char *context, const char *export) "Requesting %s %s for export %s"
 nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of context %s to id %" PRIu32
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-- 
2.17.2
