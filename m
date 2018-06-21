Received: from eggs.gnu.org ([2001:4830:134:3::10]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8s-0006TC-Tz
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8r-0001fT-NJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:54 -0500
Message-Id: <20180621031957.134718-5-eblake@redhat.com>
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] nbd/server: add nbd_meta_empty_or_pattern
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add nbd_meta_pattern() and nbd_meta_empty_or_pattern() helpers for
metadata query parsing. nbd_meta_pattern() will be reused for the
"qemu" namespace in following patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180609151758.17343-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: comment tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 101 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 33 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index bbdc3c01b9f..cea5192addb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -733,6 +733,71 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
     return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
 }

+/* Read strlen(@pattern) bytes, and set @match to true if they match @pattern.
+ * @match is never set to false.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success.
+ *
+ * Note: return code = 1 doesn't mean that we've read exactly @pattern.
+ * It only means that there are no errors.
+ */
+static int nbd_meta_pattern(NBDClient *client, const char *pattern, bool *match,
+                            Error **errp)
+{
+    int ret;
+    char *query;
+    size_t len = strlen(pattern);
+
+    assert(len);
+
+    query = g_malloc(len);
+    ret = nbd_opt_read(client, query, len, errp);
+    if (ret <= 0) {
+        g_free(query);
+        return ret;
+    }
+
+    if (strncmp(query, pattern, len) == 0) {
+        trace_nbd_negotiate_meta_query_parse(pattern);
+        *match = true;
+    } else {
+        trace_nbd_negotiate_meta_query_skip("pattern not matched");
+    }
+    g_free(query);
+
+    return 1;
+}
+
+/*
+ * Read @len bytes, and set @match to true if they match @pattern, or if @len
+ * is 0 and the client is performing _LIST_. @match is never set to false.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success.
+ *
+ * Note: return code = 1 doesn't mean that we've read exactly @pattern.
+ * It only means that there are no errors.
+ */
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
 /* nbd_meta_base_query
  *
  * Handle queries to 'base' namespace. For now, only the base:allocation
@@ -741,43 +806,12 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success.
- *
- * Note: return code = 1 doesn't mean that we've parsed the "base:allocation"
- * namespace. It only means that there are no errors.
  */
 static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                uint32_t len, Error **errp)
 {
-    int ret;
-    char query[sizeof("allocation") - 1];
-    size_t alen = strlen("allocation");
-
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
-
-    ret = nbd_opt_read(client, query, len, errp);
-    if (ret <= 0) {
-        return ret;
-    }
-
-    if (strncmp(query, "allocation", alen) == 0) {
-        trace_nbd_negotiate_meta_query_parse("base:allocation");
-        meta->base_allocation = true;
-    } else {
-        trace_nbd_negotiate_meta_query_skip("not base:allocation");
-    }
-
-    return 1;
+    return nbd_meta_empty_or_pattern(client, "allocation", len,
+                                     &meta->base_allocation, errp);
 }

 /* nbd_negotiate_meta_query
@@ -823,6 +857,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
         return nbd_opt_skip(client, len, errp);
     }

+    trace_nbd_negotiate_meta_query_parse("base:");
     return nbd_meta_base_query(client, meta, len, errp);
 }

-- 
2.14.4
