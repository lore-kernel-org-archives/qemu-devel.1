Received: from eggs.gnu.org ([209.51.188.92]:33562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTd-0004MM-2x
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTb-0008NO-DV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:20 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:45 -0600
Message-Id: <20190117193658.16413-9-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/21] nbd/client: Refactor
 nbd_receive_list()
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

Right now, nbd_receive_list() is only called by
nbd_receive_query_exports(), which in turn is only called if the
server lacks NBD_OPT_GO but has working option negotiation, and is
merely used as a quality-of-implementation trick since servers
can't give decent errors for NBD_OPT_EXPORT_NAME.  However, servers
that lack NBD_OPT_GO are becoming increasingly rare (nbdkit was a
latecomer, in Aug 2018, but qemu has been such a server since commit
f37708f6 in July 2017 and released in 2.10), so it no longer makes
sense to micro-optimize that function for performance.

Furthermore, when debugging a server's implementation, tracing the
full reply (both names and descriptions) is useful, not to mention
that upcoming patches adding 'qemu-nbd --list' will want to collect
that data.  And when you consider that a server can send an export
name up to the NBD protocol length limit of 4k; but our current
NBD_MAX_NAME_SIZE is only 256, we can't trace all valid server
names without more storage, but 4k is large enough that the heap
is better than the stack for long names.

Thus, I'm changing the division of labor, with nbd_receive_list()
now always malloc'ing a result on success (the malloc is bounded
by the fact that we reject servers with a reply length larger
than 32M), and moving the comparison to 'wantname' to the caller.

There is a minor change in behavior where a server with 0 exports
(an immediate NBD_REP_ACK reply) is now no longer distinguished
from a server without LIST support (NBD_REP_ERR_UNSUP); this
information could be preserved with a complication to the calling
contract to provide a bit more information, but I didn't see the
point.  After all, the worst that can happen if our guess at a
match is wrong is that the caller will get a cryptic disconnect
when NBD_OPT_EXPORT_NAME fails (which is no different from what
would happen if we had not tried LIST), while treating an empty
list as immediate failure would prevent connecting to really old
servers that really did lack LIST.  Besides, NBD servers with 0
exports are rare (qemu can do it when using QMP nbd-server-start
without nbd-server-add - but qemu understands NBD_OPT_GO and
thus won't tickle this change in behavior).

Fix the spelling of foundExport to match coding standards while
in the area.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181215135324.152629-10-eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v3: comment tweak, s/listEmpty/list_empty/,
s/foundExport/found_export/ [Vladimir]
---
 nbd/client.c     | 91 ++++++++++++++++++++++++++++++------------------
 nbd/trace-events |  1 +
 2 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index f625c207c54..fd4ba8dec37 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -234,18 +234,24 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
     return result;
 }

-/* Process another portion of the NBD_OPT_LIST reply.  Set *@match if
- * the current reply matches @want or if the server does not support
- * NBD_OPT_LIST, otherwise leave @match alone.  Return 0 if iteration
- * is complete, positive if more replies are expected, or negative
- * with @errp set if an unrecoverable error occurred. */
-static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *mat=
ch,
+/* nbd_receive_list:
+ * Process another portion of the NBD_OPT_LIST reply, populating any
+ * name received into *@name. If @description is non-NULL, and the
+ * server provided a description, that is also populated. The caller
+ * must eventually call g_free() on success.
+ * Returns 1 if name and description were set and iteration must continu=
e,
+ *         0 if iteration is complete (including if OPT_LIST unsupported=
),
+ *         -1 with @errp set if an unrecoverable error occurred.
+ */
+static int nbd_receive_list(QIOChannel *ioc, char **name, char **descrip=
tion,
                             Error **errp)
 {
+    int ret =3D -1;
     NBDOptionReply reply;
     uint32_t len;
     uint32_t namelen;
-    char name[NBD_MAX_NAME_SIZE + 1];
+    char *local_name =3D NULL;
+    char *local_desc =3D NULL;
     int error;

     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
@@ -253,9 +259,6 @@ static int nbd_receive_list(QIOChannel *ioc, const ch=
ar *want, bool *match,
     }
     error =3D nbd_handle_reply_err(ioc, &reply, errp);
     if (error <=3D 0) {
-        /* The server did not support NBD_OPT_LIST, so set *match on
-         * the assumption that any name will be accepted.  */
-        *match =3D true;
         return error;
     }
     len =3D reply.length;
@@ -292,33 +295,38 @@ static int nbd_receive_list(QIOChannel *ioc, const =
char *want, bool *match,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (namelen !=3D strlen(want)) {
-        if (nbd_drop(ioc, len, errp) < 0) {
-            error_prepend(errp,
-                          "failed to skip export name with wrong length:=
 ");
-            nbd_send_opt_abort(ioc);
-            return -1;
-        }
-        return 1;
-    }

-    assert(namelen < sizeof(name));
-    if (nbd_read(ioc, name, namelen, errp) < 0) {
+    local_name =3D g_malloc(namelen + 1);
+    if (nbd_read(ioc, local_name, namelen, errp) < 0) {
         error_prepend(errp, "failed to read export name: ");
         nbd_send_opt_abort(ioc);
-        return -1;
+        goto out;
     }
-    name[namelen] =3D '\0';
+    local_name[namelen] =3D '\0';
     len -=3D namelen;
-    if (nbd_drop(ioc, len, errp) < 0) {
-        error_prepend(errp, "failed to read export description: ");
-        nbd_send_opt_abort(ioc);
-        return -1;
+    if (len) {
+        local_desc =3D g_malloc(len + 1);
+        if (nbd_read(ioc, local_desc, len, errp) < 0) {
+            error_prepend(errp, "failed to read export description: ");
+            nbd_send_opt_abort(ioc);
+            goto out;
+        }
+        local_desc[len] =3D '\0';
     }
-    if (!strcmp(name, want)) {
-        *match =3D true;
+
+    trace_nbd_receive_list(local_name, local_desc ?: "");
+    *name =3D local_name;
+    local_name =3D NULL;
+    if (description) {
+        *description =3D local_desc;
+        local_desc =3D NULL;
     }
-    return 1;
+    ret =3D 1;
+
+ out:
+    g_free(local_name);
+    g_free(local_desc);
+    return ret;
 }


@@ -493,7 +501,8 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
                                      const char *wantname,
                                      Error **errp)
 {
-    bool foundExport =3D false;
+    bool list_empty =3D true;
+    bool found_export =3D false;

     trace_nbd_receive_query_exports_start(wantname);
     if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < 0) {
@@ -501,14 +510,25 @@ static int nbd_receive_query_exports(QIOChannel *io=
c,
     }

     while (1) {
-        int ret =3D nbd_receive_list(ioc, wantname, &foundExport, errp);
+        char *name;
+        int ret =3D nbd_receive_list(ioc, &name, NULL, errp);

         if (ret < 0) {
             /* Server gave unexpected reply */
             return -1;
         } else if (ret =3D=3D 0) {
             /* Done iterating. */
-            if (!foundExport) {
+            if (list_empty) {
+                /*
+                 * We don't have enough context to tell a server that
+                 * sent an empty list apart from a server that does
+                 * not support the list command; but as this function
+                 * is just used to trigger a nicer error message
+                 * before trying NBD_OPT_EXPORT_NAME, assume the
+                 * export is available.
+                 */
+                return 0;
+            } else if (!found_export) {
                 error_setg(errp, "No export with name '%s' available",
                            wantname);
                 nbd_send_opt_abort(ioc);
@@ -517,6 +537,11 @@ static int nbd_receive_query_exports(QIOChannel *ioc=
,
             trace_nbd_receive_query_exports_success(wantname);
             return 0;
         }
+        list_empty =3D false;
+        if (!strcmp(name, wantname)) {
+            found_export =3D true;
+        }
+        g_free(name);
     }
 }

diff --git a/nbd/trace-events b/nbd/trace-events
index 5492042acbf..d1e1ca64ee5 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -3,6 +3,7 @@ nbd_send_option_request(uint32_t opt, const char *name, u=
int32_t len) "Sending o
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t =
type, const char *typename, uint32_t length) "Received option reply %" PR=
Iu32" (%s), type %" PRIu32" (%s), len %" PRIu32
 nbd_server_error_msg(uint32_t err, const char *type, const char *msg) "s=
erver reported error 0x%" PRIx32 " (%s) with additional message: %s"
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't u=
nderstand request %" PRIu32 " (%s), attempting fallback"
+nbd_receive_list(const char *name, const char *desc) "export list includ=
es '%s', description '%s'"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s=
'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown in=
fo %d (%s)"
--=20
2.20.1
