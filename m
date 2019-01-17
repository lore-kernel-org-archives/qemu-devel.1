Received: from eggs.gnu.org ([209.51.188.92]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUK-0004zS-Te
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDU8-0000J8-He
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:57 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:49 -0600
Message-Id: <20190117193658.16413-13-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/21] nbd/client: Split out
 nbd_receive_one_meta_context()
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

Extract portions of nbd_negotiate_simple_meta_context() to
a new function nbd_receive_one_meta_context() that copies the
pattern of nbd_receive_list() for performing the argument
validation of one reply.  The error message when the server
replies with more than one context changes slightly, but
that shouldn't happen in the common case.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v4: s/&name/NULL/ on error path [Vladimir]
v3: rebase, without changing into a loop
---
 nbd/client.c     | 147 +++++++++++++++++++++++++++++------------------
 nbd/trace-events |   2 +-
 2 files changed, 91 insertions(+), 58 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 96da68ee18a..c7bb7081553 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -669,7 +669,86 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint=
32_t opt,
     return ret;
 }

-/* nbd_negotiate_simple_meta_context:
+/*
+ * nbd_receive_one_meta_context:
+ * Called in a loop to receive and trace one set/list meta context reply=
.
+ * Pass non-NULL @name or @id to collect results back to the caller, whi=
ch
+ * must eventually call g_free().
+ * return 1 if name is set and iteration must continue,
+ *        0 if iteration is complete (including if option is unsupported=
),
+ *        -1 with errp set for any error
+ */
+static int nbd_receive_one_meta_context(QIOChannel *ioc,
+                                        uint32_t opt,
+                                        char **name,
+                                        uint32_t *id,
+                                        Error **errp)
+{
+    int ret;
+    NBDOptionReply reply;
+    char *local_name =3D NULL;
+    uint32_t local_id;
+
+    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
+        return -1;
+    }
+
+    ret =3D nbd_handle_reply_err(ioc, &reply, errp);
+    if (ret <=3D 0) {
+        return ret;
+    }
+
+    if (reply.type =3D=3D NBD_REP_ACK) {
+        if (reply.length !=3D 0) {
+            error_setg(errp, "Unexpected length to ACK response");
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+        return 0;
+    } else if (reply.type !=3D NBD_REP_META_CONTEXT) {
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s=
)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_META_CONTEXT, nbd_rep_lookup(NBD_REP_META_CON=
TEXT));
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    if (reply.length <=3D sizeof(local_id) ||
+        reply.length > NBD_MAX_BUFFER_SIZE) {
+        error_setg(errp, "Failed to negotiate meta context, server "
+                   "answered with unexpected length %" PRIu32,
+                   reply.length);
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+
+    if (nbd_read(ioc, &local_id, sizeof(local_id), errp) < 0) {
+        return -1;
+    }
+    local_id =3D be32_to_cpu(local_id);
+
+    reply.length -=3D sizeof(local_id);
+    local_name =3D g_malloc(reply.length + 1);
+    if (nbd_read(ioc, local_name, reply.length, errp) < 0) {
+        g_free(local_name);
+        return -1;
+    }
+    local_name[reply.length] =3D '\0';
+    trace_nbd_opt_meta_reply(nbd_opt_lookup(opt), local_name, local_id);
+
+    if (name) {
+        *name =3D local_name;
+    } else {
+        g_free(local_name);
+    }
+    if (id) {
+        *id =3D local_id;
+    }
+    return 1;
+}
+
+/*
+ * nbd_negotiate_simple_meta_context:
  * Request the server to set the meta context for export @info->name
  * using @info->x_dirty_bitmap with a fallback to "base:allocation",
  * setting @info->context_id to the resulting id. Fail if the server
@@ -690,50 +769,21 @@ static int nbd_negotiate_simple_meta_context(QIOCha=
nnel *ioc,
      * function should lose the term _simple.
      */
     int ret;
-    NBDOptionReply reply;
     const char *context =3D info->x_dirty_bitmap ?: "base:allocation";
     bool received =3D false;
+    char *name =3D NULL;

     if (nbd_send_meta_query(ioc, NBD_OPT_SET_META_CONTEXT,
                             info->name, context, errp) < 0) {
         return -1;
     }

-    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
-                                 errp) < 0)
-    {
+    ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_SET_META_CONTEXT,
+                                       &name, &info->context_id, errp);
+    if (ret < 0) {
         return -1;
     }
-
-    ret =3D nbd_handle_reply_err(ioc, &reply, errp);
-    if (ret <=3D 0) {
-        return ret;
-    }
-
-    if (reply.type =3D=3D NBD_REP_META_CONTEXT) {
-        char *name;
-
-        if (reply.length !=3D sizeof(info->context_id) + strlen(context)=
) {
-            error_setg(errp, "Failed to negotiate meta context '%s', ser=
ver "
-                       "answered with unexpected length %" PRIu32, conte=
xt,
-                       reply.length);
-            nbd_send_opt_abort(ioc);
-            return -1;
-        }
-
-        if (nbd_read(ioc, &info->context_id, sizeof(info->context_id),
-                     errp) < 0) {
-            return -1;
-        }
-        info->context_id =3D be32_to_cpu(info->context_id);
-
-        reply.length -=3D sizeof(info->context_id);
-        name =3D g_malloc(reply.length + 1);
-        if (nbd_read(ioc, name, reply.length, errp) < 0) {
-            g_free(name);
-            return -1;
-        }
-        name[reply.length] =3D '\0';
+    if (ret =3D=3D 1) {
         if (strcmp(context, name)) {
             error_setg(errp, "Failed to negotiate meta context '%s', ser=
ver "
                        "answered with different context '%s'", context,
@@ -743,36 +793,19 @@ static int nbd_negotiate_simple_meta_context(QIOCha=
nnel *ioc,
             return -1;
         }
         g_free(name);
-
-        trace_nbd_opt_meta_reply(context, info->context_id);
         received =3D true;

-        /* receive NBD_REP_ACK */
-        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &rep=
ly,
-                                     errp) < 0)
-        {
+        ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_SET_META_CONTE=
XT,
+                                           NULL, NULL, errp);
+        if (ret < 0) {
             return -1;
         }
-
-        ret =3D nbd_handle_reply_err(ioc, &reply, errp);
-        if (ret <=3D 0) {
-            return ret;
-        }
     }
-
-    if (reply.type !=3D NBD_REP_ACK) {
-        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s=
)",
-                   reply.type, nbd_rep_lookup(reply.type),
-                   NBD_REP_ACK, nbd_rep_lookup(NBD_REP_ACK));
+    if (ret !=3D 0) {
+        error_setg(errp, "Server answered with more than one context");
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (reply.length) {
-        error_setg(errp, "Unexpected length to ACK response");
-        nbd_send_opt_abort(ioc);
-        return -1;
-    }
-
     return received;
 }

diff --git a/nbd/trace-events b/nbd/trace-events
index 59521e47a3d..b4802c1570e 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -13,7 +13,7 @@ nbd_receive_query_exports_success(const char *wantname)=
 "Found desired export na
 nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_opt_meta_request(const char *optname, const char *context, const cha=
r *export) "Requesting %s %s for export %s"
-nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping o=
f context %s to id %" PRIu32
+nbd_opt_meta_reply(const char *optname, const char *context, uint32_t id=
) "Received %s mapping of %s to id %" PRIu32
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving n=
egotiation tlscreds=3D%p hostname=3D%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags a=
re 0x%" PRIx32
--=20
2.20.1
