Received: from eggs.gnu.org ([2001:4830:134:3::10]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtR-0004W6-Ec
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtP-00058u-QW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:13 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:40 -0600
Message-Id: <20181130220344.3350618-12-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] nbd/client: Add nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

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
well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_go(),
in order to share as much code as possible when it comes to doing
validation of server replies.  The resulting information is stored
in an array of NBDExportInfo which has been expanded to hold more
members, along with a convenience function for freeing the list.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  15 +++-
 nbd/client.c        | 166 ++++++++++++++++++++++++++++++++++++++++++--
 nbd/trace-events    |   2 +-
 3 files changed, 174 insertions(+), 9 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 65feff8ba96..74d006b8d62 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
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
@@ -277,12 +281,21 @@ struct NBDExportInfo {
     uint32_t max_block;

     uint32_t meta_base_allocation_id;
+
+    /* Set by server results during nbd_receive_export_list() */
+    char *description;
+    int n_contexts;
+    char **contexts;
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
index a282712724d..6292de560ee 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -351,7 +351,8 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
  * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
  * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
  * go (with the rest of @info populated). */
-static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
+static int nbd_opt_info_go(QIOChannel *ioc, uint32_t opt,
+                           NBDExportInfo *info, Error **errp)
 {
     NBDOptionReply reply;
     uint32_t len = strlen(info->name);
@@ -364,7 +365,8 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
      * flags still 0 is a witness of a broken server. */
     info->flags = 0;

-    trace_nbd_opt_go_start(info->name);
+    assert(opt == NBD_OPT_GO || opt == NBD_OPT_INFO);
+    trace_nbd_opt_go_start(nbd_opt_lookup(opt), info->name);
     buf = g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, info->name, len);
@@ -373,7 +375,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
-    error = nbd_send_option_request(ioc, NBD_OPT_GO,
+    error = nbd_send_option_request(ioc, opt,
                                     4 + len + 2 + 2 * info->request_sizes,
                                     buf, errp);
     g_free(buf);
@@ -382,7 +384,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
     }

     while (1) {
-        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < 0) {
+        if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }
         error = nbd_handle_reply_err(ioc, &reply, errp);
@@ -733,8 +735,12 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
+            g_free(name);
+        } else {
+            info->contexts = g_renew(char *, info->contexts,
+                                     ++info->n_contexts);
+            info->contexts[info->n_contexts - 1] = name;
         }
-        g_free(name);
         received = true;

         /* receive NBD_REP_ACK */
@@ -828,7 +834,9 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
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
@@ -921,7 +929,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
          * TLS).  If it is not available, fall back to
          * NBD_OPT_LIST for nicer error messages about a missing
          * export, then use NBD_OPT_EXPORT_NAME.  */
-        result = nbd_opt_go(ioc, info, errp);
+        result = nbd_opt_info_go(ioc, NBD_OPT_GO, info, errp);
         if (result < 0) {
             return -EINVAL;
         }
@@ -993,6 +1001,150 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     return 0;
 }

+/* Clean up result of nbd_receive_export_list */
+void nbd_free_export_list(NBDExportInfo *info, int count)
+{
+    int i, j;
+
+    for (i = 0; info && i < count; i++) {
+        free(info[i].name);
+        free(info[i].description);
+        for (j = 0; j < info[i].n_contexts; j++) {
+            free(info[i].contexts[j]);
+        }
+        free(info[i].contexts);
+    }
+    free(info);
+}
+
+/* Query details about a server's exports, then disconnect without
+ * going into transmission phase. Return a count of the exports listed
+ * in @info by the server, or -1 on error. Caller must free @info. */
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
+    uint32_t oldflags;
+    QIOChannel *sioc = NULL;
+    bool try_context = true;
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
+        /* meta contexts are only useful with structured reply */
+        try_context = false;
+        /* fall through */
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
+            rc = nbd_receive_list(ioc, NULL, NULL, &name, &desc, errp);
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
+            rc = nbd_opt_info_go(ioc, NBD_OPT_INFO, &array[i], errp);
+            if (rc < 0) {
+                goto out;
+            } else if (rc == 0) {
+                /* Pointless to try rest of loop. If OPT_INFO doesn't work,
+                 * it's unlikely that meta contexts work either */
+                break;
+            }
+
+            if (try_context) {
+                rc = nbd_negotiate_simple_meta_context(
+                    ioc, NBD_OPT_LIST_META_CONTEXT, NULL, &array[i], errp);
+                if (rc < 0) {
+                    goto out;
+                } else if (rc == 0) {
+                    try_context = false;
+                }
+            }
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
+        if (nbd_read(ioc, &array->size, sizeof(array->size), errp) < 0) {
+            error_prepend(errp, "Failed to read export length: ");
+            goto out;
+        }
+        array->size = be64_to_cpu(array->size);
+
+        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
+            error_prepend(errp, "Failed to read export flags: ");
+            goto out;
+        }
+        oldflags = be32_to_cpu(oldflags);
+        if (oldflags & ~0xffff) {
+            error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
+            goto out;
+        }
+        array->flags = oldflags;
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
index 570b04997ff..2cf83ebed15 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -2,7 +2,7 @@
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIu32" (%s), type %" PRIu32" (%s), len %" PRIu32
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIu32 " (%s), attempting fallback"
-nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
+nbd_opt_go_start(const char *opt, const char *name) "Attempting %s for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
-- 
2.17.2
