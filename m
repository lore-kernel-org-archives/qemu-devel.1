Received: from eggs.gnu.org ([2001:4830:134:3::10]:41406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFF-0007Gn-Ez
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFD-0005PS-VQ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:05 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 18:23:50 +0300
Message-Id: <20180608152353.98712-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180608152353.98712-1-vsementsov@virtuozzo.com>
References: <20180608152353.98712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 3/6] nbd/server: add
 nbd_meta_empty_or_pattern helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add nbd_meta_pattern() and nbd_meta_empty_or_pattern() helpers for
metadata query parsing. nbd_meta_pattern() will be reused for "qemu"
namespace in following patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 86 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 8593a6874b..d39a42cb7f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -733,52 +733,83 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
     return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
 }
 
-/* nbd_meta_base_query
- *
- * Handle query to 'base' namespace. For now, only base:allocation context is
- * available in it.  'len' is the amount of text remaining to be read from
- * the current name, after the 'base:' portion has been stripped.
+/* Read strlen(@pattern) bytes, and set @match to true if they match @pattern.
+ * @match is never set to false.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success.
  *
- * Note: return code = 1 doesn't mean that we've parsed "base:allocation"
- * namespace. It only means that there are no errors.*/
-static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
-                               uint32_t len, Error **errp)
+ * Note: return code = 1 doesn't mean that we've read exactly @pattern
+ * It only means that there are no errors. */
+static int nbd_meta_pattern(NBDClient *client, const char *pattern, bool *match,
+                            Error **errp)
 {
     int ret;
-    char query[sizeof("allocation") - 1];
-    size_t alen = strlen("allocation");
+    char *query;
+    int len = strlen(pattern);
 
-    if (len == 0) {
-        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            meta->base_allocation = true;
-        }
-        trace_nbd_negotiate_meta_query_parse("base:");
-        return 1;
-    }
-
-    if (len != alen) {
-        trace_nbd_negotiate_meta_query_skip("not base:allocation");
-        return nbd_opt_skip(client, len, errp);
-    }
+    assert(len);
 
+    query = g_malloc(len);
     ret = nbd_opt_read(client, query, len, errp);
     if (ret <= 0) {
+        g_free(query);
         return ret;
     }
 
-    if (strncmp(query, "allocation", alen) == 0) {
-        trace_nbd_negotiate_meta_query_parse("base:allocation");
-        meta->base_allocation = true;
+    if (strncmp(query, pattern, len) == 0) {
+        trace_nbd_negotiate_meta_query_parse(pattern);
+        *match = true;
     } else {
-        trace_nbd_negotiate_meta_query_skip("not base:allocation");
+        trace_nbd_negotiate_meta_query_skip(pattern);
     }
+    g_free(query);
 
     return 1;
 }
 
+/* Read @len bytes, and set @match to true if they match @pattern, or if @len
+ * is 0 and the client is performing _LIST_. @match is never set to false.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success.
+ *
+ * Note: return code = 1 doesn't mean that we've read exactly @pattern
+ * It only means that there are no errors. */
+static int nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
+                                     uint32_t len, bool *match, Error **errp)
+{
+    if (len == 0) {
+        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+            *match = true;
+        }
+        trace_nbd_negotiate_meta_query_parse("empty");
+        return 1;
+    }
+
+    if (len != strlen(pattern)) {
+        trace_nbd_negotiate_meta_query_skip("different lengths");
+        return nbd_opt_skip(client, len, errp);
+    }
+
+    return nbd_meta_pattern(client, pattern, match, errp);
+}
+
+/* nbd_meta_base_query
+ *
+ * Handle query to 'base' namespace. For now, only base:allocation context is
+ * available in it.  'len' is the amount of text remaining to be read from
+ * the current name, after the 'base:' portion has been stripped.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+                               uint32_t len, Error **errp)
+{
+    return nbd_meta_empty_or_pattern(client, "allocation", len,
+                                     &meta->base_allocation, errp);
+}
+
 /* nbd_negotiate_meta_query
  *
  * Parse namespace name and call corresponding function to parse body of the
@@ -822,6 +853,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
         return nbd_opt_skip(client, len, errp);
     }
 
+    trace_nbd_negotiate_meta_query_parse("base:");
     return nbd_meta_base_query(client, meta, len, errp);
 }
 
-- 
2.11.1
