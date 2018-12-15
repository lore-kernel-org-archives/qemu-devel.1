Received: from eggs.gnu.org ([2001:4830:134:3::10]:34749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOw-0005UO-Ff
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOu-0000N3-Pe
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:42 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:21 -0600
Message-Id: <20181215135324.152629-20-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/22] nbd/client: Add meta contexts to
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We want to be able to detect whether a given qemu NBD server is
exposing the right export(s) and dirty bitmaps, at least for
regression testing.  We could use 'nbd-client -l' from the upstream
NBD project to list exports, but it's annoying to rely on
out-of-tree binaries; furthermore, nbd-client doesn't necessarily
know about all of the qemu NBD extensions.  Thus, we plan on adding
a new mode to qemu-nbd that merely sniffs all possible information
from the server during handshake phase, then disconnects and dumps
the information.

This patch continues the work of the previous patch, by adding the
ability to track the list of available meta contexts into
NBDExportInfo.  It benefits from the recent refactoring patches
with a new nbd_list_meta_contexts() that reuses much of the same
framework as setting a meta context.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch to split out collection of meta context collection
s/free/g_free/ [Vladimir]
---
 include/block/nbd.h |  2 ++
 nbd/client.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 09d2157efe0..6d9fbb941d7 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -284,6 +284,8 @@ struct NBDExportInfo {

     /* Set by server results during nbd_receive_export_list() */
     char *description;
+    int n_contexts;
+    char **contexts;
 };
 typedef struct NBDExportInfo NBDExportInfo;

diff --git a/nbd/client.c b/nbd/client.c
index 0e6c575ccad..d392b5e8bee 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -808,6 +808,36 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     }
 }

+/*
+ * nbd_list_meta_contexts:
+ * Request the server to list all meta contexts for export @info->name.
+ * return 0 if list is complete (even if empty),
+ *        -1 with errp set for any other error
+ */
+static int nbd_list_meta_contexts(QIOChannel *ioc,
+                                  NBDExportInfo *info,
+                                  Error **errp)
+{
+    int ret;
+
+    if (nbd_send_one_meta_context(ioc, NBD_OPT_LIST_META_CONTEXT,
+                                  info->name, NULL, errp) < 0) {
+        return -1;
+    }
+
+    while (1) {
+        char *context;
+
+        ret = nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_META_CONTEXT,
+                                           &context, NULL, errp);
+        if (ret <= 0) {
+            return ret;
+        }
+        info->contexts = g_renew(char *, info->contexts, ++info->n_contexts);
+        info->contexts[info->n_contexts - 1] = context;
+    }
+}
+
 /*
  * nbd_start_negotiate:
  * Start the handshake to the server.  After a positive return, the server
@@ -1054,7 +1084,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
 /* Clean up result of nbd_receive_export_list */
 void nbd_free_export_list(NBDExportInfo *info, int count)
 {
-    int i;
+    int i, j;

     if (!info) {
         return;
@@ -1063,6 +1093,10 @@ void nbd_free_export_list(NBDExportInfo *info, int count)
     for (i = 0; i < count; i++) {
         g_free(info[i].name);
         g_free(info[i].description);
+        for (j = 0; j < info[i].n_contexts; j++) {
+            g_free(info[i].contexts[j]);
+        }
+        g_free(info[i].contexts);
     }
     g_free(info);
 }
@@ -1130,7 +1164,10 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                 break;
             }

-            /* TODO: Grab meta contexts */
+            if (result == 3 &&
+                nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
+                goto out;
+            }
         }

         /* Send NBD_OPT_ABORT as a courtesy before hanging up */
-- 
2.17.2
