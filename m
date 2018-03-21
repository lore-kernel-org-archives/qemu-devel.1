Received: from eggs.gnu.org ([2001:4830:134:3::10]:54980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eycib-00061d-3m
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyciW-0005ij-WB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Mar 2018 15:19:37 +0300
Message-Id: <20180321121940.39426-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180321121940.39426-1-vsementsov@virtuozzo.com>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] nbd/server: refactor
 nbd_negotiate_meta_query for several namespaces
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 60 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index cea158913b..b830997114 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -771,13 +771,19 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
     return 1;
 }
 
+struct {
+    const char *ns;
+    int (*func)(NBDClient *, NBDExportMetaContexts *, uint32_t, Error **);
+} meta_namespace_handlers[] = {
+    /* namespaces should go in non-decreasing order by name length */
+    {.ns = "base:", .func = nbd_meta_base_query},
+};
+
 /* nbd_negotiate_meta_query
  *
  * Parse namespace name and call corresponding function to parse body of the
  * query.
  *
- * The only supported namespace now is 'base'.
- *
  * The function aims not wasting time and memory to read long unknown namespace
  * names.
  *
@@ -787,9 +793,12 @@ static int nbd_negotiate_meta_query(NBDClient *client,
                                     NBDExportMetaContexts *meta, Error **errp)
 {
     int ret;
-    char query[sizeof("base:") - 1];
-    size_t baselen = strlen("base:");
+    int i;
     uint32_t len;
+    int bytes_done = 0;
+    char *query;
+    int nb_ns = sizeof(meta_namespace_handlers) /
+                sizeof(meta_namespace_handlers[0]);
 
     ret = nbd_opt_read(client, &len, sizeof(len), errp);
     if (ret <= 0) {
@@ -797,22 +806,39 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     }
     cpu_to_be32s(&len);
 
-    /* The only supported namespace for now is 'base'. So query should start
-     * with 'base:'. Otherwise, we can ignore it and skip the remainder. */
-    if (len < baselen) {
-        return nbd_opt_skip(client, len, errp);
-    }
+    query = g_malloc(strlen(meta_namespace_handlers[nb_ns - 1].ns));
 
-    len -= baselen;
-    ret = nbd_opt_read(client, query, baselen, errp);
-    if (ret <= 0) {
-        return ret;
-    }
-    if (strncmp(query, "base:", baselen) != 0) {
-        return nbd_opt_skip(client, len, errp);
+    for (i = 0; i < nb_ns; i++) {
+        const char *ns = meta_namespace_handlers[i].ns;
+        int ns_len = strlen(ns);
+        int diff_len = strlen(ns) - bytes_done;
+
+        assert(diff_len >= 0);
+
+        if (diff_len > 0) {
+            if (len < diff_len) {
+                ret = nbd_opt_skip(client, len, errp);
+                goto out;
+            }
+
+            len -= diff_len;
+            ret = nbd_opt_read(client, query + bytes_done, diff_len, errp);
+            if (ret <= 0) {
+                goto out;
+            }
+        }
+
+        if (!strncmp(query, ns, ns_len)) {
+            ret = meta_namespace_handlers[i].func(client, meta, len, errp);
+            goto out;
+        }
     }
 
-    return nbd_meta_base_query(client, meta, len, errp);
+    ret = nbd_opt_skip(client, len, errp);
+
+out:
+    g_free(query);
+    return ret;
 }
 
 /* nbd_negotiate_meta_queries
-- 
2.11.1
