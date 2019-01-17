Received: from eggs.gnu.org ([209.51.188.92]:34000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUH-0004uT-AS
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDU5-0000Hd-EK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:53 -0600
Message-Id: <20190117193658.16413-17-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/21] nbd/client: Refactor nbd_opt_go() to
 support NBD_OPT_INFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Rename the function to nbd_opt_info_or_go() with an added parameter
and slight changes to comments and trace messages, in order to
reuse the function for NBD_OPT_INFO.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: split out new patch [Vladimir]
---
 nbd/client.c     | 36 ++++++++++++++++++++++--------------
 nbd/trace-events |  8 ++++----
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 6829c684fec..fa1657a1cb3 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -330,11 +330,16 @@ static int nbd_receive_list(QIOChannel *ioc, char *=
*name, char **description,
 }


-/* Returns -1 if NBD_OPT_GO proves the export @info->name cannot be
- * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
+/*
+ * nbd_opt_info_or_go:
+ * Send option for NBD_OPT_INFO or NBD_OPT_GO and parse the reply.
+ * Returns -1 if the option proves the export @info->name cannot be
+ * used, 0 if the option is unsupported (fall back to NBD_OPT_LIST and
  * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
- * go (with the rest of @info populated). */
-static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp=
)
+ * go (with the rest of @info populated).
+ */
+static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_t opt,
+                              NBDExportInfo *info, Error **errp)
 {
     NBDOptionReply reply;
     uint32_t len =3D strlen(info->name);
@@ -347,7 +352,8 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo =
*info, Error **errp)
      * flags still 0 is a witness of a broken server. */
     info->flags =3D 0;

-    trace_nbd_opt_go_start(info->name);
+    assert(opt =3D=3D NBD_OPT_GO || opt =3D=3D NBD_OPT_INFO);
+    trace_nbd_opt_info_go_start(nbd_opt_lookup(opt), info->name);
     buf =3D g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, info->name, len);
@@ -356,7 +362,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo =
*info, Error **errp)
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
-    error =3D nbd_send_option_request(ioc, NBD_OPT_GO,
+    error =3D nbd_send_option_request(ioc, opt,
                                     4 + len + 2 + 2 * info->request_size=
s,
                                     buf, errp);
     g_free(buf);
@@ -365,7 +371,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo =
*info, Error **errp)
     }

     while (1) {
-        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < 0)=
 {
+        if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }
         error =3D nbd_handle_reply_err(ioc, &reply, errp);
@@ -375,8 +381,10 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo=
 *info, Error **errp)
         len =3D reply.length;

         if (reply.type =3D=3D NBD_REP_ACK) {
-            /* Server is done sending info and moved into transmission
-               phase, but make sure it sent flags */
+            /*
+             * Server is done sending info, and moved into transmission
+             * phase for NBD_OPT_GO, but make sure it sent flags
+             */
             if (len) {
                 error_setg(errp, "server sent invalid NBD_REP_ACK");
                 return -1;
@@ -385,7 +393,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo =
*info, Error **errp)
                 error_setg(errp, "broken server omitted NBD_INFO_EXPORT"=
);
                 return -1;
             }
-            trace_nbd_opt_go_success();
+            trace_nbd_opt_info_go_success(nbd_opt_lookup(opt));
             return 1;
         }
         if (reply.type !=3D NBD_REP_INFO) {
@@ -479,12 +487,12 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInf=
o *info, Error **errp)
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            trace_nbd_opt_go_info_block_size(info->min_block, info->opt_=
block,
-                                             info->max_block);
+            trace_nbd_opt_info_block_size(info->min_block, info->opt_blo=
ck,
+                                          info->max_block);
             break;

         default:
-            trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
+            trace_nbd_opt_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
                 error_prepend(errp, "Failed to read info payload: ");
                 nbd_send_opt_abort(ioc);
@@ -993,7 +1001,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTL=
SCreds *tlscreds,
          * TLS).  If it is not available, fall back to
          * NBD_OPT_LIST for nicer error messages about a missing
          * export, then use NBD_OPT_EXPORT_NAME.  */
-        result =3D nbd_opt_go(ioc, info, errp);
+        result =3D nbd_opt_info_or_go(ioc, NBD_OPT_GO, info, errp);
         if (result < 0) {
             return -EINVAL;
         }
diff --git a/nbd/trace-events b/nbd/trace-events
index 663d11687ab..7f10ebd4e0b 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -4,10 +4,10 @@ nbd_receive_option_reply(uint32_t option, const char *o=
ptname, uint32_t type, co
 nbd_server_error_msg(uint32_t err, const char *type, const char *msg) "s=
erver reported error 0x%" PRIx32 " (%s) with additional message: %s"
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't u=
nderstand request %" PRIu32 " (%s), attempting fallback"
 nbd_receive_list(const char *name, const char *desc) "export list includ=
es '%s', description '%s'"
-nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s=
'"
-nbd_opt_go_success(void) "Export is good to go"
-nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown in=
fo %d (%s)"
-nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_=
t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
+nbd_opt_info_go_start(const char *opt, const char *name) "Attempting %s =
for export '%s'"
+nbd_opt_info_go_success(const char *opt) "Export is ready after %s reque=
st"
+nbd_opt_info_unknown(int info, const char *name) "Ignoring unknown info =
%d (%s)"
+nbd_opt_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t m=
aximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export l=
ist for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired e=
xport name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
--=20
2.20.1
