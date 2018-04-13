Received: from eggs.gnu.org ([2001:4830:134:3::10]:46544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f73D6-0005Vi-De
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f73D3-0007sS-7s
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:14:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 13 Apr 2018 21:13:59 +0300
Message-Id: <20180413181401.46318-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180413181401.46318-1-vsementsov@virtuozzo.com>
References: <20180413181401.46318-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/3] nbd/server: add nbd_meta_single_query
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jsnow@redhat.com

The helper will be reused for bitmaps namespace.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index cea158913b..c169c11b3e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -733,44 +733,58 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
     return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
 }
 
-/* nbd_meta_base_query
- *
- * Handle query to 'base' namespace. For now, only base:allocation context is
- * available in it.  'len' is the amount of text remaining to be read from
- * the current name, after the 'base:' portion has been stripped.
+/* Read @len bytes, and set @match to true if they match @pattern, or if @len
+ * is 0 and the client is performing _LIST_. @match is never set to false.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
-                               uint32_t len, Error **errp)
+static int nbd_meta_single_query(NBDClient *client, const char *pattern,
+                                 uint32_t len, bool *match, Error **errp)
 {
     int ret;
-    char query[sizeof("allocation") - 1];
-    size_t alen = strlen("allocation");
+    char *query;
 
     if (len == 0) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            meta->base_allocation = true;
+            *match = true;
         }
         return 1;
     }
 
-    if (len != alen) {
+    if (len != strlen(pattern)) {
         return nbd_opt_skip(client, len, errp);
     }
 
+    query = g_malloc(len);
     ret = nbd_opt_read(client, query, len, errp);
     if (ret <= 0) {
+        g_free(query);
         return ret;
     }
 
-    if (strncmp(query, "allocation", alen) == 0) {
-        meta->base_allocation = true;
+    if (strncmp(query, pattern, len) == 0) {
+        *match = true;
     }
+    g_free(query);
 
     return 1;
 }
 
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
+    return nbd_meta_single_query(client, "allocation", len,
+                                 &meta->base_allocation, errp);
+}
+
 /* nbd_negotiate_meta_query
  *
  * Parse namespace name and call corresponding function to parse body of the
-- 
2.11.1
