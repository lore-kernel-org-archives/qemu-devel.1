Received: from eggs.gnu.org ([2001:4830:134:3::10]:34615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOe-0005EW-S5
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOd-0008TR-GS
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:17 -0600
Message-Id: <20181215135324.152629-16-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/22] nbd/client: Refactor return of
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
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

The function could only ever return 0 or -EINVAL; make this
clearer by dropping a useless 'fail:' label.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 0e5a9d59dbd..64a0e5760c3 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -811,7 +811,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                           NBDExportInfo *info, Error **errp)
 {
     uint64_t magic;
-    int rc;
     bool zeroes = true;
     bool structured_reply = info->structured_reply;
     bool base_allocation = info->base_allocation;
@@ -822,31 +821,30 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     trace_nbd_receive_negotiate_name(info->name);
     info->structured_reply = false;
     info->base_allocation = false;
-    rc = -EINVAL;

     if (outioc) {
         *outioc = NULL;
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
     magic = be64_to_cpu(magic);
     trace_nbd_receive_negotiate_magic(magic);

     if (magic != NBD_INIT_MAGIC) {
         error_setg(errp, "Bad initial magic received: 0x%" PRIx64, magic);
-        goto fail;
+        return -EINVAL;
     }

     if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
         error_prepend(errp, "Failed to read server magic: ");
-        goto fail;
+        return -EINVAL;
     }
     magic = be64_to_cpu(magic);
     trace_nbd_receive_negotiate_magic(magic);
@@ -858,7 +856,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,

         if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
             error_prepend(errp, "Failed to read server flags: ");
-            goto fail;
+            return -EINVAL;
         }
         globalflags = be16_to_cpu(globalflags);
         trace_nbd_receive_negotiate_server_flags(globalflags);
@@ -874,18 +872,18 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         clientflags = cpu_to_be32(clientflags);
         if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
             error_prepend(errp, "Failed to send clientflags field: ");
-            goto fail;
+            return -EINVAL;
         }
         if (tlscreds) {
             if (fixedNewStyle) {
                 *outioc = nbd_receive_starttls(ioc, tlscreds, hostname, errp);
                 if (!*outioc) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 ioc = *outioc;
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
-                goto fail;
+                return -EINVAL;
             }
         }
         if (fixedNewStyle) {
@@ -896,7 +894,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                                                    NBD_OPT_STRUCTURED_REPLY,
                                                    errp);
                 if (result < 0) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 info->structured_reply = result == 1;
             }
@@ -904,7 +902,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             if (info->structured_reply && base_allocation) {
                 result = nbd_negotiate_simple_meta_context(ioc, info, errp);
                 if (result < 0) {
-                    goto fail;
+                    return -EINVAL;
                 }
                 info->base_allocation = result == 1;
             }
@@ -916,7 +914,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
              * export, then use NBD_OPT_EXPORT_NAME.  */
             result = nbd_opt_go(ioc, info, errp);
             if (result < 0) {
-                goto fail;
+                return -EINVAL;
             }
             if (result > 0) {
                 return 0;
@@ -928,25 +926,25 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
              * export name is not available.
              */
             if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
-                goto fail;
+                return -EINVAL;
             }
         }
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
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
         info->size = be64_to_cpu(info->size);

         if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags: ");
-            goto fail;
+            return -EINVAL;
         }
         info->flags = be16_to_cpu(info->flags);
     } else if (magic == NBD_CLIENT_MAGIC) {
@@ -954,43 +952,40 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,

         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export names");
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
         info->size = be64_to_cpu(info->size);

         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags: ");
-            goto fail;
+            return -EINVAL;
         }
         oldflags = be32_to_cpu(oldflags);
         if (oldflags & ~0xffff) {
             error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
-            goto fail;
+            return -EINVAL;
         }
         info->flags = oldflags;
     } else {
         error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic);
-        goto fail;
+        return -EINVAL;
     }

     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block: ");
-        goto fail;
+        return -EINVAL;
     }
-    rc = 0;
-
-fail:
-    return rc;
+    return 0;
 }

 #ifdef __linux__
-- 
2.17.2
