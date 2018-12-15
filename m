Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOx-0005VF-4l
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOv-0000NX-4s
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:20 -0600
Message-Id: <20181215135324.152629-19-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/22] nbd/client: Add
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

This patch adds the low-level client code for grabbing the list
of exports.  It benefits from the recent refactoring patches, as
well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_or_go(),
in order to share as much code as possible when it comes to doing
validation of server replies.  The resulting information is stored
in an array of NBDExportInfo which has been expanded to any
description string, along with a convenience function for freeing
the list.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split out oldstyle size computation into earlier patch [Vladimir]
rename nbd_opt_info_or_go [Rich]
split out collection of meta context collection into later patch
---
 include/block/nbd.h |  15 ++++-
 nbd/client.c        | 138 ++++++++++++++++++++++++++++++++++++++++++--
 nbd/trace-events    |   2 +-
 3 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index ae5fe28f486..09d2157efe0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2017 Red Hat, Inc.
+ *  Copyright (C) 2016-2018 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -262,6 +262,9 @@ struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
     char *x_dirty_bitmap;
+
+    /* Set by client before nbd_receive_negotiate(), or by server results
+     * during nbd_receive_export_list() */
     char *name; /* must be non-NULL */

     /* In-out fields, set by client before nbd_receive_negotiate() and
@@ -269,7 +272,8 @@ struct NBDExportInfo {
     bool structured_reply;
     bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_STATUS */

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
index 4bdfba43068..0e6c575ccad 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -332,7 +332,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
  * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
  * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
  * go (with the rest of @info populated). */
-static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
+static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_t opt,
+                              NBDExportInfo *info, Error **errp)
 {
     NBDOptionReply reply;
     uint32_t len = strlen(info->name);
@@ -345,7 +346,8 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
      * flags still 0 is a witness of a broken server. */
     info->flags = 0;

-    trace_nbd_opt_go_start(info->name);
+    assert(opt == NBD_OPT_GO || opt == NBD_OPT_INFO);
+    trace_nbd_opt_go_start(nbd_opt_lookup(opt), info->name);
     buf = g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, info->name, len);
@@ -354,7 +356,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
-    error = nbd_send_option_request(ioc, NBD_OPT_GO,
+    error = nbd_send_option_request(ioc, opt,
                                     4 + len + 2 + 2 * info->request_sizes,
                                     buf, errp);
     g_free(buf);
@@ -363,7 +365,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
     }

     while (1) {
-        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < 0) {
+        if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }
         error = nbd_handle_reply_err(ioc, &reply, errp);
@@ -868,7 +870,9 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             clientflags |= NBD_FLAG_C_FIXED_NEWSTYLE;
         }
         if (globalflags & NBD_FLAG_NO_ZEROES) {
-            *zeroes = false;
+            if (zeroes) {
+                *zeroes = false;
+            }
             clientflags |= NBD_FLAG_C_NO_ZEROES;
         }
         /* client requested flags */
@@ -989,7 +993,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
          * TLS).  If it is not available, fall back to
          * NBD_OPT_LIST for nicer error messages about a missing
          * export, then use NBD_OPT_EXPORT_NAME.  */
-        result = nbd_opt_go(ioc, info, errp);
+        result = nbd_opt_info_or_go(ioc, NBD_OPT_GO, info, errp);
         if (result < 0) {
             return -EINVAL;
         }
@@ -1047,6 +1051,128 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
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
+    for (i = 0; i < count; i++) {
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
+    int count = 0;
+    int i;
+    int rc;
+    int ret = -1;
+    NBDExportInfo *array = NULL;
+    QIOChannel *sioc = NULL;
+
+    *info = NULL;
+    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true, NULL,
+                                 errp);
+    if (tlscreds && sioc) {
+        ioc = sioc;
+    }
+
+    switch (result) {
+    case 2:
+    case 3:
+        /* newstyle - use NBD_OPT_LIST to populate array, then try
+         * NBD_OPT_INFO on each array member. If structured replies
+         * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
+        if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < 0) {
+            goto out;
+        }
+        while (1) {
+            char *name;
+            char *desc;
+
+            rc = nbd_receive_list(ioc, &name, &desc, errp);
+            if (rc < 0) {
+                goto out;
+            } else if (rc == 0) {
+                break;
+            }
+            array = g_renew(NBDExportInfo, array, ++count);
+            memset(&array[count - 1], 0, sizeof(*array));
+            array[count - 1].name = name;
+            array[count - 1].description = desc;
+            array[count - 1].structured_reply = result == 3;
+        }
+
+        for (i = 0; i < count; i++) {
+            array[i].request_sizes = true;
+            rc = nbd_opt_info_or_go(ioc, NBD_OPT_INFO, &array[i], errp);
+            if (rc < 0) {
+                goto out;
+            } else if (rc == 0) {
+                /* Pointless to try rest of loop. If OPT_INFO doesn't work,
+                 * it's unlikely that meta contexts work either */
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
+        array = g_new0(NBDExportInfo, 1);
+        array->name = g_strdup("");
+        count = 1;
+
+        if (nbd_negotiate_finish_oldstyle(ioc, array, errp) < 0) {
+            return -EINVAL;
+        }
+
+        /* Send NBD_CMD_DISC as a courtesy to the server, but ignore all
+         * errors now that we have the information we wanted. */
+        if (nbd_drop(ioc, 124, NULL) == 0) {
+            NBDRequest request = { .type = NBD_CMD_DISC };
+
+            nbd_send_request(ioc, &request);
+        }
+        break;
+    default:
+        goto out;
+    }
+
+    *info = array;
+    array = NULL;
+    ret = count;
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
diff --git a/nbd/trace-events b/nbd/trace-events
index 922b36d1843..a66bf891cc9 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -3,7 +3,7 @@ nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending o
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIu32" (%s), type %" PRIu32" (%s), len %" PRIu32
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIu32 " (%s), attempting fallback"
 nbd_receive_list(const char *name, const char *desc) "export list includes '%s', description '%s'"
-nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
+nbd_opt_go_start(const char *opt, const char *name) "Attempting %s for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
-- 
2.17.2
