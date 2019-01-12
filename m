Received: from eggs.gnu.org ([209.51.188.92]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaN-0003XG-Hh
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYS-0001ze-TK
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:58:03 -0600
Message-Id: <20190112175812.27068-11-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
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

Refactor nbd_negotiate_simple_meta_context() to pull out the
code that can be reused to send a LIST request for 0 or 1 query.
No semantic change.  The old comment about 'sizeof(uint32_t)'
being equivalent to '/* number of queries */' is no longer
needed, now that we are computing 'sizeof(queries)' instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181215135324.152629-14-eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

---
v3: Improve commit message [Rich], formatting tweak [checkpatch],
rebase to dropped patch
---
 nbd/client.c     | 67 +++++++++++++++++++++++++++++++++---------------
 nbd/trace-events |  2 +-
 2 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 77993890f04..3c716be2719 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -629,6 +629,49 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *=
ioc,
     return QIO_CHANNEL(tioc);
 }

+/*
+ * nbd_send_one_meta_context:
+ * Send 0 or 1 set/list meta context queries.
+ * Return 0 on success, -1 with errp set for any error
+ */
+static int nbd_send_one_meta_context(QIOChannel *ioc,
+                                     uint32_t opt,
+                                     const char *export,
+                                     const char *query,
+                                     Error **errp)
+{
+    int ret;
+    uint32_t export_len =3D strlen(export);
+    uint32_t queries =3D !!query;
+    uint32_t context_len =3D 0;
+    uint32_t data_len;
+    char *data;
+    char *p;
+
+    data_len =3D sizeof(export_len) + export_len + sizeof(queries);
+    if (query) {
+        context_len =3D strlen(query);
+        data_len +=3D sizeof(context_len) + context_len;
+    } else {
+        assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
+    }
+    data =3D g_malloc(data_len);
+    p =3D data;
+
+    trace_nbd_opt_meta_request(nbd_opt_lookup(opt), query ?: "(all)", ex=
port);
+    stl_be_p(p, export_len);
+    memcpy(p +=3D sizeof(export_len), export, export_len);
+    stl_be_p(p +=3D export_len, queries);
+    if (query) {
+        stl_be_p(p +=3D sizeof(uint32_t), context_len);
+        memcpy(p +=3D sizeof(context_len), query, context_len);
+    }
+
+    ret =3D nbd_send_option_request(ioc, opt, data_len, data, errp);
+    g_free(data);
+    return ret;
+}
+
 /* nbd_negotiate_simple_meta_context:
  * Request the server to set the meta context for export @info->name
  * using @info->x_dirty_bitmap with a fallback to "base:allocation",
@@ -653,26 +696,10 @@ static int nbd_negotiate_simple_meta_context(QIOCha=
nnel *ioc,
     NBDOptionReply reply;
     const char *context =3D info->x_dirty_bitmap ?: "base:allocation";
     bool received =3D false;
-    uint32_t export_len =3D strlen(info->name);
-    uint32_t context_len =3D strlen(context);
-    uint32_t data_len =3D sizeof(export_len) + export_len +
-                        sizeof(uint32_t) + /* number of queries */
-                        sizeof(context_len) + context_len;
-    char *data =3D g_malloc(data_len);
-    char *p =3D data;

-    trace_nbd_opt_meta_request(context, info->name);
-    stl_be_p(p, export_len);
-    memcpy(p +=3D sizeof(export_len), info->name, export_len);
-    stl_be_p(p +=3D export_len, 1);
-    stl_be_p(p +=3D sizeof(uint32_t), context_len);
-    memcpy(p +=3D sizeof(context_len), context, context_len);
-
-    ret =3D nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_=
len, data,
-                                  errp);
-    g_free(data);
-    if (ret < 0) {
-        return ret;
+    if (nbd_send_one_meta_context(ioc, NBD_OPT_SET_META_CONTEXT,
+                                  info->name, context, errp) < 0) {
+        return -1;
     }

     if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
@@ -689,7 +716,7 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
     if (reply.type =3D=3D NBD_REP_META_CONTEXT) {
         char *name;

-        if (reply.length !=3D sizeof(info->context_id) + context_len) {
+        if (reply.length !=3D sizeof(info->context_id) + strlen(context)=
) {
             error_setg(errp, "Failed to negotiate meta context '%s', ser=
ver "
                        "answered with unexpected length %" PRIu32, conte=
xt,
                        reply.length);
diff --git a/nbd/trace-events b/nbd/trace-events
index c3966d2b653..59521e47a3d 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -12,7 +12,7 @@ nbd_receive_query_exports_start(const char *wantname) "=
Querying export list for
 nbd_receive_query_exports_success(const char *wantname) "Found desired e=
xport name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
-nbd_opt_meta_request(const char *context, const char *export) "Requestin=
g to set meta context %s for export %s"
+nbd_opt_meta_request(const char *optname, const char *context, const cha=
r *export) "Requesting %s %s for export %s"
 nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping o=
f context %s to id %" PRIu32
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving n=
egotiation tlscreds=3D%p hostname=3D%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
--=20
2.20.1
