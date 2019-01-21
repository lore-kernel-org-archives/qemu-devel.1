Received: from eggs.gnu.org ([209.51.188.92]:39996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNw-0001Iv-9A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNu-00057v-Ax
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:49:03 -0600
Message-Id: <20190121224907.26634-18-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/21] nbd/client: Add nbd_receive_export_list()
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

This patch adds the low-level client code for grabbing the list
of exports.  It benefits from the recent refactoring patches, in
order to share as much code as possible when it comes to doing
validation of server replies.  The resulting information is stored
in an array of NBDExportInfo which has been expanded to any
description string, along with a convenience function for freeing
the list.

Note: a malicious server could exhaust memory of a client by feeding
an unending loop of exports; perhaps we should place a limit on how
many we are willing to receive. But note that a server could
reasonably be serving an export for every file in a large directory,
where an arbitrary limit in the client means we can't list anything
from such a server; the same happens if we just run until the client
fails to malloc() and thus dies by an abort(), where the limit is
no longer arbitrary but determined by available memory.  Since the
client is already planning on being short-lived, it's hard to call
this a denial of service attack that would starve off other uses,
so it does not appear to be a security issue.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-18-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  15 ++++-
 nbd/client.c        | 132 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index be19aac2fc7..19332b46715 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2017 Red Hat, Inc.
+ *  Copyright (C) 2016-2019 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -262,6 +262,9 @@ struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
     char *x_dirty_bitmap;
+
+    /* Set by client before nbd_receive_negotiate(), or by server result=
s
+     * during nbd_receive_export_list() */
     char *name; /* must be non-NULL */

     /* In-out fields, set by client before nbd_receive_negotiate() and
@@ -269,7 +272,8 @@ struct NBDExportInfo {
     bool structured_reply;
     bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_S=
TATUS */

-    /* Set by server results during nbd_receive_negotiate() */
+    /* Set by server results during nbd_receive_negotiate() and
+     * nbd_receive_export_list() */
     uint64_t size;
     uint16_t flags;
     uint32_t min_block;
@@ -277,12 +281,19 @@ struct NBDExportInfo {
     uint32_t max_block;

     uint32_t context_id;
+
+    /* Set by server results during nbd_receive_export_list() */
+    char *description;
 };
 typedef struct NBDExportInfo NBDExportInfo;

 int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp);
+void nbd_free_export_list(NBDExportInfo *info, int count);
+int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                            const char *hostname, NBDExportInfo **info,
+                            Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
diff --git a/nbd/client.c b/nbd/client.c
index fa1657a1cb3..8a32169970d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -836,7 +836,9 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryp=
toTLSCreds *tlscreds,

     trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");

-    *zeroes =3D true;
+    if (zeroes) {
+        *zeroes =3D true;
+    }
     if (outioc) {
         *outioc =3D NULL;
     }
@@ -880,7 +882,9 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryp=
toTLSCreds *tlscreds,
             clientflags |=3D NBD_FLAG_C_FIXED_NEWSTYLE;
         }
         if (globalflags & NBD_FLAG_NO_ZEROES) {
-            *zeroes =3D false;
+            if (zeroes) {
+                *zeroes =3D false;
+            }
             clientflags |=3D NBD_FLAG_C_NO_ZEROES;
         }
         /* client requested flags */
@@ -1059,6 +1063,130 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCrypt=
oTLSCreds *tlscreds,
     return 0;
 }

+/* Clean up result of nbd_receive_export_list */
+void nbd_free_export_list(NBDExportInfo *info, int count)
+{
+    int i;
+
+    if (!info) {
+        return;
+    }
+
+    for (i =3D 0; i < count; i++) {
+        g_free(info[i].name);
+        g_free(info[i].description);
+    }
+    g_free(info);
+}
+
+/*
+ * nbd_receive_export_list:
+ * Query details about a server's exports, then disconnect without
+ * going into transmission phase. Return a count of the exports listed
+ * in @info by the server, or -1 on error. Caller must free @info using
+ * nbd_free_export_list().
+ */
+int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                            const char *hostname, NBDExportInfo **info,
+                            Error **errp)
+{
+    int result;
+    int count =3D 0;
+    int i;
+    int rc;
+    int ret =3D -1;
+    NBDExportInfo *array =3D NULL;
+    QIOChannel *sioc =3D NULL;
+
+    *info =3D NULL;
+    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true,=
 NULL,
+                                 errp);
+    if (tlscreds && sioc) {
+        ioc =3D sioc;
+    }
+
+    switch (result) {
+    case 2:
+    case 3:
+        /* newstyle - use NBD_OPT_LIST to populate array, then try
+         * NBD_OPT_INFO on each array member. If structured replies
+         * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
+        if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < =
0) {
+            goto out;
+        }
+        while (1) {
+            char *name;
+            char *desc;
+
+            rc =3D nbd_receive_list(ioc, &name, &desc, errp);
+            if (rc < 0) {
+                goto out;
+            } else if (rc =3D=3D 0) {
+                break;
+            }
+            array =3D g_renew(NBDExportInfo, array, ++count);
+            memset(&array[count - 1], 0, sizeof(*array));
+            array[count - 1].name =3D name;
+            array[count - 1].description =3D desc;
+            array[count - 1].structured_reply =3D result =3D=3D 3;
+        }
+
+        for (i =3D 0; i < count; i++) {
+            array[i].request_sizes =3D true;
+            rc =3D nbd_opt_info_or_go(ioc, NBD_OPT_INFO, &array[i], errp=
);
+            if (rc < 0) {
+                goto out;
+            } else if (rc =3D=3D 0) {
+                /*
+                 * Pointless to try rest of loop. If OPT_INFO doesn't wo=
rk,
+                 * it's unlikely that meta contexts work either
+                 */
+                break;
+            }
+
+            /* TODO: Grab meta contexts */
+        }
+
+        /* Send NBD_OPT_ABORT as a courtesy before hanging up */
+        nbd_send_opt_abort(ioc);
+        break;
+    case 1: /* newstyle, but limited to EXPORT_NAME */
+        error_setg(errp, "Server does not support export lists");
+        /* We can't even send NBD_OPT_ABORT, so merely hang up */
+        goto out;
+    case 0: /* oldstyle, parse length and flags */
+        array =3D g_new0(NBDExportInfo, 1);
+        array->name =3D g_strdup("");
+        count =3D 1;
+
+        if (nbd_negotiate_finish_oldstyle(ioc, array, errp) < 0) {
+            goto out;
+        }
+
+        /* Send NBD_CMD_DISC as a courtesy to the server, but ignore all
+         * errors now that we have the information we wanted. */
+        if (nbd_drop(ioc, 124, NULL) =3D=3D 0) {
+            NBDRequest request =3D { .type =3D NBD_CMD_DISC };
+
+            nbd_send_request(ioc, &request);
+        }
+        break;
+    default:
+        goto out;
+    }
+
+    *info =3D array;
+    array =3D NULL;
+    ret =3D count;
+
+ out:
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    qio_channel_close(ioc, NULL);
+    object_unref(OBJECT(sioc));
+    nbd_free_export_list(array, count);
+    return ret;
+}
+
 #ifdef __linux__
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp)
--=20
2.20.1
