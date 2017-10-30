Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H77-0008Kb-H1
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H76-00010G-6R
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:56:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:26 +0100
Message-Id: <20171030205636.14236-3-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] nbd: Move nbd_errno_to_system_errno() to
 public header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is needed in preparation for structured reply handling,
as we will be performing the translation from NBD error to
system errno value higher in the stack at block/nbd-client.c.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171027104037.8319-3-eblake@redhat.com>
---
 include/block/nbd.h | 13 +++++++++++++
 nbd/nbd-internal.h  | 12 ------------
 nbd/client.c        | 32 --------------------------------
 nbd/common.c        | 34 ++++++++++++++++++++++++++++++++++
 nbd/trace-events    |  4 +++-
 5 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a6df5ce8b5..dc62b5cd19 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -149,6 +149,18 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256

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
 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
@@ -172,6 +184,7 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
+int nbd_errno_to_system_errno(int err);

 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 4bfe5be884..df6c8b2f24 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -64,18 +64,6 @@
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
diff --git a/nbd/client.c b/nbd/client.c
index 59d7c9d49f..50f36b511e 100644
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
diff --git a/nbd/common.c b/nbd/common.c
index 7456021f7e..593904f148 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -18,6 +18,7 @@

 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "nbd-internal.h"

 /* Discard length bytes from channel.  Return -errno on failure and 0 on
@@ -171,3 +172,36 @@ const char *nbd_err_lookup(int err)
         return "<unknown>";
     }
 }
+
+
+int nbd_errno_to_system_errno(int err)
+{
+    int ret;
+    switch (err) {
+    case NBD_SUCCESS:
+        ret = 0;
+        break;
+    case NBD_EPERM:
+        ret = EPERM;
+        break;
+    case NBD_EIO:
+        ret = EIO;
+        break;
+    case NBD_ENOMEM:
+        ret = ENOMEM;
+        break;
+    case NBD_ENOSPC:
+        ret = ENOSPC;
+        break;
+    case NBD_ESHUTDOWN:
+        ret = ESHUTDOWN;
+        break;
+    default:
+        trace_nbd_unknown_error(err);
+        /* fallthrough */
+    case NBD_EINVAL:
+        ret = EINVAL;
+        break;
+    }
+    return ret;
+}
diff --git a/nbd/trace-events b/nbd/trace-events
index 920c8a0e5e..ab3d7dad4f 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,5 +1,4 @@
 # nbd/client.c
-nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply 0x%" PRIx32" (%s), type 0x%" PRIx32" (%s), len %" PRIu32
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request 0x%" PRIx32 " (%s), attempting fallback"
@@ -31,6 +30,9 @@ nbd_client_clear_socket(void) "Clearing NBD socket"
 nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_reply(uint32_t magic, int32_t error, const char *errname, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = %" PRId32 " (%s), handle = %" PRIu64" }"

+# nbd/common.c
+nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
+
 # nbd/server.c
 nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=0x%" PRIx32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
 nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
-- 
2.13.6
