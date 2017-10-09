Received: from eggs.gnu.org ([2001:4830:134:3::10]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq4-0000Ux-WA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq0-0004d9-Rq
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25393 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004Z5-GB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:21 +0300
Message-Id: <20171009172723.190282-16-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 08/10] nbd: share some nbd entities to be
 reused in block/nbd-client.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 nbd/nbd-internal.h  | 25 -------------------------
 nbd/client.c        | 32 --------------------------------
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index dd261f66f0..09e4592971 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -77,6 +77,9 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;
 
+#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
+#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
+
 typedef struct NBDStructuredRead {
     NBDStructuredReplyChunk h;
     uint64_t offset;
@@ -182,6 +185,40 @@ enum {
 #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
 #define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
 
+/* NBD errors are based on errno numbers, so there is a 1:1 mapping,
+ * but only a limited set of errno values is specified in the protocol.
+ * Everything else is squashed to EINVAL.
+ */
+#define NBD_SUCCESS    0
+#define NBD_EPERM      1
+#define NBD_EIO        5
+#define NBD_ENOMEM     12
+#define NBD_EINVAL     22
+#define NBD_ENOSPC     28
+#define NBD_ESHUTDOWN  108
+
+static inline int nbd_errno_to_system_errno(int err)
+{
+    switch (err) {
+    case NBD_SUCCESS:
+        return 0;
+    case NBD_EPERM:
+        return EPERM;
+    case NBD_EIO:
+        return EIO;
+    case NBD_ENOMEM:
+        return ENOMEM;
+    case NBD_ENOSPC:
+        return ENOSPC;
+    case NBD_ESHUTDOWN:
+        return ESHUTDOWN;
+    case NBD_EINVAL:
+        return EINVAL;
+    }
+
+    return EINVAL;
+}
+
 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
@@ -235,4 +272,15 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       Error **errp);
 
+/* nbd_read
+ * Reads @size bytes from @ioc. Returns 0 on success.
+ */
+static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
+                           Error **errp)
+{
+    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
+}
+
+int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
+
 #endif
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 6b0d1183ba..9f7b6b68e8 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -47,8 +47,6 @@
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
 
 #define NBD_REQUEST_MAGIC           0x25609513
-#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
-#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
 #define NBD_OPTS_MAGIC              0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC            0x0000420281861253LL
 #define NBD_REP_MAGIC               0x0003e889045565a9LL
@@ -65,18 +63,6 @@
 #define NBD_SET_TIMEOUT             _IO(0xab, 9)
 #define NBD_SET_FLAGS               _IO(0xab, 10)
 
-/* NBD errors are based on errno numbers, so there is a 1:1 mapping,
- * but only a limited set of errno values is specified in the protocol.
- * Everything else is squashed to EINVAL.
- */
-#define NBD_SUCCESS    0
-#define NBD_EPERM      1
-#define NBD_EIO        5
-#define NBD_ENOMEM     12
-#define NBD_EINVAL     22
-#define NBD_ENOSPC     28
-#define NBD_ESHUTDOWN  108
-
 /* nbd_read_eof
  * Tries to read @size bytes from @ioc.
  * Returns 1 on success
@@ -96,15 +82,6 @@ static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
     return ret;
 }
 
-/* nbd_read
- * Reads @size bytes from @ioc. Returns 0 on success.
- */
-static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
-                           Error **errp)
-{
-    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
-}
-
 /* nbd_write
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
@@ -137,6 +114,4 @@ const char *nbd_rep_lookup(uint32_t rep);
 const char *nbd_info_lookup(uint16_t info);
 const char *nbd_cmd_lookup(uint16_t info);
 
-int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
-
 #endif
diff --git a/nbd/client.c b/nbd/client.c
index c8702a80b1..f0f3075569 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -22,38 +22,6 @@
 #include "trace.h"
 #include "nbd-internal.h"
 
-static int nbd_errno_to_system_errno(int err)
-{
-    int ret;
-    switch (err) {
-    case NBD_SUCCESS:
-        ret = 0;
-        break;
-    case NBD_EPERM:
-        ret = EPERM;
-        break;
-    case NBD_EIO:
-        ret = EIO;
-        break;
-    case NBD_ENOMEM:
-        ret = ENOMEM;
-        break;
-    case NBD_ENOSPC:
-        ret = ENOSPC;
-        break;
-    case NBD_ESHUTDOWN:
-        ret = ESHUTDOWN;
-        break;
-    default:
-        trace_nbd_unknown_error(err);
-        /* fallthrough */
-    case NBD_EINVAL:
-        ret = EINVAL;
-        break;
-    }
-    return ret;
-}
-
 /* Definitions for opaque data types */
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
-- 
2.11.1
