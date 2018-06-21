Received: from eggs.gnu.org ([2001:4830:134:3::10]:52614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8s-0006SS-6g
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8q-0001eW-US
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:53 -0500
Message-Id: <20180621031957.134718-4-eblake@redhat.com>
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] nbd/server: refactor NBDExportMetaContexts
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

Use NBDExport pointer instead of just export name: there is no need to
store a duplicated name in the struct; moreover, NBDExport will be used
further.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180609151758.17343-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message grammar tweak]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e71301b8cd7..bbdc3c01b9f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -88,7 +88,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
  * NBD_OPT_LIST_META_CONTEXT. */
 typedef struct NBDExportMetaContexts {
-    char export_name[NBD_MAX_NAME_SIZE + 1];
+    NBDExport *exp;
     bool valid; /* means that negotiation of the option finished without
                    errors */
     bool base_allocation; /* export base:allocation context (block status) */
@@ -399,10 +399,9 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
     return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
 }

-static void nbd_check_meta_export_name(NBDClient *client)
+static void nbd_check_meta_export(NBDClient *client)
 {
-    client->export_meta.valid &= !strcmp(client->exp->name,
-                                         client->export_meta.export_name);
+    client->export_meta.valid &= client->exp == client->export_meta.exp;
 }

 /* Send a reply to NBD_OPT_EXPORT_NAME.
@@ -456,7 +455,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,

     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     nbd_export_get(client->exp);
-    nbd_check_meta_export_name(client);
+    nbd_check_meta_export(client);

     return 0;
 }
@@ -650,7 +649,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         client->exp = exp;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
-        nbd_check_meta_export_name(client);
+        nbd_check_meta_export(client);
         rc = 1;
     }
     return rc;
@@ -835,7 +834,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
                                       NBDExportMetaContexts *meta, Error **errp)
 {
     int ret;
-    NBDExport *exp;
+    char export_name[NBD_MAX_NAME_SIZE + 1];
     NBDExportMetaContexts local_meta;
     uint32_t nb_queries;
     int i;
@@ -854,15 +853,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,

     memset(meta, 0, sizeof(*meta));

-    ret = nbd_opt_read_name(client, meta->export_name, NULL, errp);
+    ret = nbd_opt_read_name(client, export_name, NULL, errp);
     if (ret <= 0) {
         return ret;
     }

-    exp = nbd_export_find(meta->export_name);
-    if (exp == NULL) {
+    meta->exp = nbd_export_find(export_name);
+    if (meta->exp == NULL) {
         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
-                            "export '%s' not present", meta->export_name);
+                            "export '%s' not present", export_name);
     }

     ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
@@ -871,7 +870,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     }
     cpu_to_be32s(&nb_queries);
     trace_nbd_negotiate_meta_context(nbd_opt_lookup(client->opt),
-                                     meta->export_name, nb_queries);
+                                     export_name, nb_queries);

     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
-- 
2.14.4
