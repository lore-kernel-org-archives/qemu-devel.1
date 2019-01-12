Received: from eggs.gnu.org ([209.51.188.92]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaS-0003cW-TB
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYM-0001rI-0n
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:58:05 -0600
Message-Id: <20190112175812.27068-13-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/19] nbd/client: Refactor return of
 nbd_receive_negotiate()
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

The function could only ever return 0 or -EINVAL; make this
clearer by dropping a useless 'fail:' label.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181215135324.152629-16-eblake@redhat.com>
---
 nbd/client.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 22505199d3b..fa931fd8e5d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -818,7 +818,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
                           NBDExportInfo *info, Error **errp)
 {
     uint64_t magic;
-    int rc;
     bool zeroes =3D true;
     bool structured_reply =3D info->structured_reply;
     bool base_allocation =3D info->base_allocation;
@@ -829,31 +828,30 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
     trace_nbd_receive_negotiate_name(info->name);
     info->structured_reply =3D false;
     info->base_allocation =3D false;
-    rc =3D -EINVAL;

     if (outioc) {
         *outioc =3D NULL;
     }
     if (tlscreds && !outioc) {
         error_setg(errp, "Output I/O channel required for TLS");
-        goto fail;
+        return -EINVAL;
     }

     if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
         error_prepend(errp, "Failed to read initial magic: ");
-        goto fail;
+        return -EINVAL;
     }
     magic =3D be64_to_cpu(magic);
     trace_nbd_receive_negotiate_magic(magic);

     if (magic !=3D NBD_INIT_MAGIC) {
         error_setg(errp, "Bad initial magic received: 0x%" PRIx64, magic=
);
-        goto fail;
+        return -EINVAL;
     }

     if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
         error_prepend(errp, "Failed to read server magic: ");
-        goto fail;
+        return -EINVAL;
     }
     magic =3D be64_to_cpu(magic);
     trace_nbd_receive_negotiate_magic(magic);
@@ -865,7 +863,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,

         if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) =
{
             error_prepend(errp, "Failed to read server flags: ");
-            goto fail;
+            return -EINVAL;
         }
         globalflags =3D be16_to_cpu(globalflags);
         trace_nbd_receive_negotiate_server_flags(globalflags);
@@ -881,18 +879,18 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
         clientflags =3D cpu_to_be32(clientflags);
         if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0)=
 {
             error_prepend(errp, "Failed to send clientflags field: ");
-            goto fail;
+            return -EINVAL;
         }
         if (tlscreds) {
             if (fixedNewStyle) {
                 *outioc =3D nbd_receive_starttls(ioc, tlscreds, hostname=
, errp);
                 if (!*outioc) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 ioc =3D *outioc;
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
-                goto fail;
+                return -EINVAL;
             }
         }
         if (fixedNewStyle) {
@@ -903,7 +901,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
                                                    NBD_OPT_STRUCTURED_RE=
PLY,
                                                    errp);
                 if (result < 0) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 info->structured_reply =3D result =3D=3D 1;
             }
@@ -911,7 +909,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
             if (info->structured_reply && base_allocation) {
                 result =3D nbd_negotiate_simple_meta_context(ioc, info, =
errp);
                 if (result < 0) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 info->base_allocation =3D result =3D=3D 1;
             }
@@ -923,7 +921,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
              * export, then use NBD_OPT_EXPORT_NAME.  */
             result =3D nbd_opt_go(ioc, info, errp);
             if (result < 0) {
-                goto fail;
+                return -EINVAL;
             }
             if (result > 0) {
                 return 0;
@@ -935,25 +933,25 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
              * export name is not available.
              */
             if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
-                goto fail;
+                return -EINVAL;
             }
         }
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->=
name,
                                     errp) < 0) {
-            goto fail;
+            return -EINVAL;
         }

         /* Read the response */
         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length: ");
-            goto fail;
+            return -EINVAL;
         }
         info->size =3D be64_to_cpu(info->size);

         if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) =
{
             error_prepend(errp, "Failed to read export flags: ");
-            goto fail;
+            return -EINVAL;
         }
         info->flags =3D be16_to_cpu(info->flags);
     } else if (magic =3D=3D NBD_CLIENT_MAGIC) {
@@ -961,43 +959,40 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,

         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export n=
ames");
-            goto fail;
+            return -EINVAL;
         }
         if (tlscreds) {
             error_setg(errp, "Server does not support STARTTLS");
-            goto fail;
+            return -EINVAL;
         }

         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length: ");
-            goto fail;
+            return -EINVAL;
         }
         info->size =3D be64_to_cpu(info->size);

         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags: ");
-            goto fail;
+            return -EINVAL;
         }
         oldflags =3D be32_to_cpu(oldflags);
         if (oldflags & ~0xffff) {
             error_setg(errp, "Unexpected export flags %0x" PRIx32, oldfl=
ags);
-            goto fail;
+            return -EINVAL;
         }
         info->flags =3D oldflags;
     } else {
         error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic)=
;
-        goto fail;
+        return -EINVAL;
     }

     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block: ");
-        goto fail;
+        return -EINVAL;
     }
-    rc =3D 0;
-
-fail:
-    return rc;
+    return 0;
 }

 #ifdef __linux__
--=20
2.20.1
