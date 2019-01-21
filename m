Received: from eggs.gnu.org ([209.51.188.92]:40318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO8-0001RS-0g
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO6-0005Ie-Lk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:49:04 -0600
Message-Id: <20190121224907.26634-19-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/21] nbd/client: Add meta contexts to
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
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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

Note: a malicious server could exhaust memory of a client by feeding
an unending loop of contexts; perhaps we could place a limit on how
many we are willing to receive. But this is no different from our
earlier analysis on a server sending an unending list of exports,
and the death of a client due to memory exhaustion when the client
was going to exit soon anyways is not really a denial of service
attack.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190117193658.16413-19-eblake@redhat.com>
---
 include/block/nbd.h |  2 ++
 nbd/client.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 19332b46715..4faf394e346 100644
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
index 8a32169970d..798b82f205a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -817,6 +817,36 @@ static int nbd_negotiate_simple_meta_context(QIOChan=
nel *ioc,
     return received;
 }

+/*
+ * nbd_list_meta_contexts:
+ * Request the server to list all meta contexts for export @info->name.
+ * return 0 if list is complete (even if empty),
+ *        -1 with errp set for any error
+ */
+static int nbd_list_meta_contexts(QIOChannel *ioc,
+                                  NBDExportInfo *info,
+                                  Error **errp)
+{
+    int ret;
+
+    if (nbd_send_meta_query(ioc, NBD_OPT_LIST_META_CONTEXT,
+                            info->name, NULL, errp) < 0) {
+        return -1;
+    }
+
+    while (1) {
+        char *context;
+
+        ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_META_CONT=
EXT,
+                                           &context, NULL, errp);
+        if (ret <=3D 0) {
+            return ret;
+        }
+        info->contexts =3D g_renew(char *, info->contexts, ++info->n_con=
texts);
+        info->contexts[info->n_contexts - 1] =3D context;
+    }
+}
+
 /*
  * nbd_start_negotiate:
  * Start the handshake to the server.  After a positive return, the serv=
er
@@ -1066,7 +1096,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
 /* Clean up result of nbd_receive_export_list */
 void nbd_free_export_list(NBDExportInfo *info, int count)
 {
-    int i;
+    int i, j;

     if (!info) {
         return;
@@ -1075,6 +1105,10 @@ void nbd_free_export_list(NBDExportInfo *info, int=
 count)
     for (i =3D 0; i < count; i++) {
         g_free(info[i].name);
         g_free(info[i].description);
+        for (j =3D 0; j < info[i].n_contexts; j++) {
+            g_free(info[i].contexts[j]);
+        }
+        g_free(info[i].contexts);
     }
     g_free(info);
 }
@@ -1144,7 +1178,10 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryp=
toTLSCreds *tlscreds,
                 break;
             }

-            /* TODO: Grab meta contexts */
+            if (result =3D=3D 3 &&
+                nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
+                goto out;
+            }
         }

         /* Send NBD_OPT_ABORT as a courtesy before hanging up */
--=20
2.20.1
