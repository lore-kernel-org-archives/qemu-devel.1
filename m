Received: from eggs.gnu.org ([2001:4830:134:3::10]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eycib-00061e-3y
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyciW-0005ic-VE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Mar 2018 15:19:38 +0300
Message-Id: <20180321121940.39426-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180321121940.39426-1-vsementsov@virtuozzo.com>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] nbd/server: add nbd_meta_single_query
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
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

The helper will be reused for bitmaps namespace.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index b830997114..8fe53ffd4b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -733,44 +733,59 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
     return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
 }
 
-/* nbd_meta_base_query
- *
- * Handle query to 'base' namespace. For now, only base:allocation context is
- * available in it.  'len' is the amount of text remaining to be read from
- * the current name, after the 'base:' portion has been stripped.
+/* Read len bytes and check matching to the pattern.
+ * @match is set to true on empty query for _LIST_ and for query matching the
+ * @pattern. @match is never set to false.
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
 struct {
     const char *ns;
     int (*func)(NBDClient *, NBDExportMetaContexts *, uint32_t, Error **);
-- 
2.11.1
