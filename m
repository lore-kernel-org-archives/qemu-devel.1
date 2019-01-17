Received: from eggs.gnu.org ([209.51.188.92]:34034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUL-00050x-Ro
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUD-0000Lg-Rt
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:51 -0600
Message-Id: <20190117193658.16413-15-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/21] nbd/client: Split handshake into two
 functions
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

An upcoming patch will add the ability for qemu-nbd to list
the services provided by an NBD server.  Share the common
code of the TLS handshake by splitting the initial exchange
into a separate function, leaving only the export handling
in the original function.  Functionally, there should be no
change in behavior in this patch, although some of the code
motion may be difficult to follow due to indentation changes
(view with 'git diff -w' for a smaller changeset).

I considered an enum for the return code coordinating state
between the two functions, but in the end just settled with
ample comments.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v4: move initialization of zeroes to single function [Vladimir], R-b kept
---
 nbd/client.c     | 145 +++++++++++++++++++++++++++++++----------------
 nbd/trace-events |   2 +-
 2 files changed, 96 insertions(+), 51 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 9028fd09397..77cc12356f2 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -809,22 +809,26 @@ static int nbd_negotiate_simple_meta_context(QIOCha=
nnel *ioc,
     return received;
 }

-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
-                          const char *hostname, QIOChannel **outioc,
-                          NBDExportInfo *info, Error **errp)
+/*
+ * nbd_start_negotiate:
+ * Start the handshake to the server.  After a positive return, the serv=
er
+ * is ready to accept additional NBD_OPT requests.
+ * Returns: negative errno: failure talking to server
+ *          0: server is oldstyle, client must still parse export size
+ *          1: server is newstyle, but can only accept EXPORT_NAME
+ *          2: server is newstyle, but lacks structured replies
+ *          3: server is newstyle and set up for structured replies
+ */
+static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscred=
s,
+                               const char *hostname, QIOChannel **outioc=
,
+                               bool structured_reply, bool *zeroes,
+                               Error **errp)
 {
     uint64_t magic;
-    bool zeroes =3D true;
-    bool structured_reply =3D info->structured_reply;
-    bool base_allocation =3D info->base_allocation;

-    trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>"=
);
-
-    assert(info->name);
-    trace_nbd_receive_negotiate_name(info->name);
-    info->structured_reply =3D false;
-    info->base_allocation =3D false;
+    trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");

+    *zeroes =3D true;
     if (outioc) {
         *outioc =3D NULL;
     }
@@ -868,7 +872,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
             clientflags |=3D NBD_FLAG_C_FIXED_NEWSTYLE;
         }
         if (globalflags & NBD_FLAG_NO_ZEROES) {
-            zeroes =3D false;
+            *zeroes =3D false;
             clientflags |=3D NBD_FLAG_C_NO_ZEROES;
         }
         /* client requested flags */
@@ -890,7 +894,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
             }
         }
         if (fixedNewStyle) {
-            int result;
+            int result =3D 0;

             if (structured_reply) {
                 result =3D nbd_request_simple_option(ioc,
@@ -899,39 +903,85 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
                 if (result < 0) {
                     return -EINVAL;
                 }
-                info->structured_reply =3D result =3D=3D 1;
             }
+            return 2 + result;
+        } else {
+            return 1;
+        }
+    } else if (magic =3D=3D NBD_CLIENT_MAGIC) {
+        if (tlscreds) {
+            error_setg(errp, "Server does not support STARTTLS");
+            return -EINVAL;
+        }
+        return 0;
+    } else {
+        error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic)=
;
+        return -EINVAL;
+    }
+}

-            if (info->structured_reply && base_allocation) {
-                result =3D nbd_negotiate_simple_meta_context(ioc, info, =
errp);
-                if (result < 0) {
-                    return -EINVAL;
-                }
-                info->base_allocation =3D result =3D=3D 1;
-            }
+/*
+ * nbd_receive_negotiate:
+ * Connect to server, complete negotiation, and move into transmission p=
hase.
+ * Returns: negative errno: failure talking to server
+ *          0: server is connected
+ */
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp)
+{
+    int result;
+    bool zeroes;
+    bool base_allocation =3D info->base_allocation;
+    uint32_t oldflags;
+
+    assert(info->name);
+    trace_nbd_receive_negotiate_name(info->name);
+
+    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
+                                 info->structured_reply, &zeroes, errp);
+
+    info->structured_reply =3D false;
+    info->base_allocation =3D false;
+    if (tlscreds && *outioc) {
+        ioc =3D *outioc;
+    }

-            /* Try NBD_OPT_GO first - if it works, we are done (it
-             * also gives us a good message if the server requires
-             * TLS).  If it is not available, fall back to
-             * NBD_OPT_LIST for nicer error messages about a missing
-             * export, then use NBD_OPT_EXPORT_NAME.  */
-            result =3D nbd_opt_go(ioc, info, errp);
+    switch (result) {
+    case 3: /* newstyle, with structured replies */
+        info->structured_reply =3D true;
+        if (base_allocation) {
+            result =3D nbd_negotiate_simple_meta_context(ioc, info, errp=
);
             if (result < 0) {
                 return -EINVAL;
             }
-            if (result > 0) {
-                return 0;
-            }
-            /* Check our desired export is present in the
-             * server export list. Since NBD_OPT_EXPORT_NAME
-             * cannot return an error message, running this
-             * query gives us better error reporting if the
-             * export name is not available.
-             */
-            if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
-                return -EINVAL;
-            }
+            info->base_allocation =3D result =3D=3D 1;
         }
+        /* fall through */
+    case 2: /* newstyle, try OPT_GO */
+        /* Try NBD_OPT_GO first - if it works, we are done (it
+         * also gives us a good message if the server requires
+         * TLS).  If it is not available, fall back to
+         * NBD_OPT_LIST for nicer error messages about a missing
+         * export, then use NBD_OPT_EXPORT_NAME.  */
+        result =3D nbd_opt_go(ioc, info, errp);
+        if (result < 0) {
+            return -EINVAL;
+        }
+        if (result > 0) {
+            return 0;
+        }
+        /* Check our desired export is present in the
+         * server export list. Since NBD_OPT_EXPORT_NAME
+         * cannot return an error message, running this
+         * query gives us better error reporting if the
+         * export name is not available.
+         */
+        if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
+            return -EINVAL;
+        }
+        /* fall through */
+    case 1: /* newstyle, but limited to EXPORT_NAME */
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->=
name,
                                     errp) < 0) {
@@ -950,17 +1000,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCrypto=
TLSCreds *tlscreds,
             return -EINVAL;
         }
         info->flags =3D be16_to_cpu(info->flags);
-    } else if (magic =3D=3D NBD_CLIENT_MAGIC) {
-        uint32_t oldflags;
-
+        break;
+    case 0: /* oldstyle, parse length and flags */
         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export n=
ames");
             return -EINVAL;
         }
-        if (tlscreds) {
-            error_setg(errp, "Server does not support STARTTLS");
-            return -EINVAL;
-        }

         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length: ");
@@ -978,9 +1023,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTL=
SCreds *tlscreds,
             return -EINVAL;
         }
         info->flags =3D oldflags;
-    } else {
-        error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic)=
;
-        return -EINVAL;
+        break;
+    default:
+        return result;
     }

     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
diff --git a/nbd/trace-events b/nbd/trace-events
index b4802c1570e..663d11687ab 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -14,7 +14,7 @@ nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_opt_meta_request(const char *optname, const char *context, const cha=
r *export) "Requesting %s %s for export %s"
 nbd_opt_meta_reply(const char *optname, const char *context, uint32_t id=
) "Received %s mapping of %s to id %" PRIu32
-nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving n=
egotiation tlscreds=3D%p hostname=3D%s"
+nbd_start_negotiate(void *tlscreds, const char *hostname) "Receiving neg=
otiation tlscreds=3D%p hostname=3D%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags a=
re 0x%" PRIx32
 nbd_receive_negotiate_name(const char *name) "Requesting NBD export name=
 '%s'"
--=20
2.20.1
