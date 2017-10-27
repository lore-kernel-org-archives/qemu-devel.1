Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824N-0001Cc-OB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824M-0005a7-At
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:40:28 +0200
Message-Id: <20171027104037.8319-4-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-1-eblake@redhat.com>
References: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 03/12] nbd: Expose constants and structs for
 structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Upcoming patches will implement the NBD structured reply
extension [1] for both client and server roles.  Declare the
constants, structs, and lookup routines that will be valuable
whether the server or client code is backported in isolation.

This includes moving one constant from an internal header to
the public header, as part of the structured read processing
will be done in block/nbd-client.c rather than nbd/client.c.

[1]https://github.com/NetworkBlockDevice/nbd/blob/extension-structured-reply/doc/proto.md

Based on patches from Vladimir Sementsov-Ogievskiy.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v6: add R-b
---
 include/block/nbd.h | 41 +++++++++++++++++++++++++++++++++++++++++
 nbd/nbd-internal.h  |  2 +-
 nbd/common.c        | 27 +++++++++++++++++++++++++++
 nbd/server.c        |  2 ++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index dc62b5cd19..225e9575e4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -69,6 +69,28 @@ typedef struct NBDSimpleReply {
     uint64_t handle;
 } QEMU_PACKED NBDSimpleReply;

+/* Header of all structured replies */
+typedef struct NBDStructuredReplyChunk {
+    uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
+    uint16_t flags;  /* combination of NBD_REPLY_FLAG_* */
+    uint16_t type;   /* NBD_REPLY_TYPE_* */
+    uint64_t handle; /* request handle */
+    uint32_t length; /* length of payload */
+} QEMU_PACKED NBDStructuredReplyChunk;
+
+/* Header of NBD_REPLY_TYPE_OFFSET_DATA, complete NBD_REPLY_TYPE_OFFSET_HOLE */
+typedef struct NBDStructuredRead {
+    NBDStructuredReplyChunk h;
+    uint64_t offset;
+} QEMU_PACKED NBDStructuredRead;
+
+/* Header of all NBD_REPLY_TYPE_ERROR* errors */
+typedef struct NBDStructuredError {
+    NBDStructuredReplyChunk h;
+    uint32_t error;
+    uint16_t message_length;
+} QEMU_PACKED NBDStructuredError;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
@@ -79,6 +101,7 @@ typedef struct NBDSimpleReply {
                                                rotational media */
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
+#define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */

 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -125,6 +148,7 @@ typedef struct NBDSimpleReply {
 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
 #define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
+#define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */

 /* Supported request types */
 enum {
@@ -149,6 +173,22 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256

+/* Two types of reply structures */
+#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
+#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
+
+/* Structured reply flags */
+#define NBD_REPLY_FLAG_DONE          (1 << 0) /* This reply-chunk is last */
+
+/* Structured reply types */
+#define NBD_REPLY_ERR(value)         ((1 << 15) | (value))
+
+#define NBD_REPLY_TYPE_NONE          0
+#define NBD_REPLY_TYPE_OFFSET_DATA   1
+#define NBD_REPLY_TYPE_OFFSET_HOLE   2
+#define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
+#define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)
+
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
  * Everything else is squashed to EINVAL.
@@ -159,6 +199,7 @@ enum {
 #define NBD_ENOMEM     12
 #define NBD_EINVAL     22
 #define NBD_ENOSPC     28
+#define NBD_EOVERFLOW  75
 #define NBD_ESHUTDOWN  108

 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index df6c8b2f24..4f24d6e57d 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -47,7 +47,6 @@
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)

 #define NBD_REQUEST_MAGIC           0x25609513
-#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
 #define NBD_OPTS_MAGIC              0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC            0x0000420281861253LL
 #define NBD_REP_MAGIC               0x0003e889045565a9LL
@@ -114,6 +113,7 @@ const char *nbd_opt_lookup(uint32_t opt);
 const char *nbd_rep_lookup(uint32_t rep);
 const char *nbd_info_lookup(uint16_t info);
 const char *nbd_cmd_lookup(uint16_t info);
+const char *nbd_reply_type_lookup(uint16_t type);
 const char *nbd_err_lookup(int err);

 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
diff --git a/nbd/common.c b/nbd/common.c
index 593904f148..6047d71748 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -151,6 +151,28 @@ const char *nbd_cmd_lookup(uint16_t cmd)
 }


+const char *nbd_reply_type_lookup(uint16_t type)
+{
+    switch (type) {
+    case NBD_REPLY_TYPE_NONE:
+        return "none";
+    case NBD_REPLY_TYPE_OFFSET_DATA:
+        return "data";
+    case NBD_REPLY_TYPE_OFFSET_HOLE:
+        return "hole";
+    case NBD_REPLY_TYPE_ERROR:
+        return "generic error";
+    case NBD_REPLY_TYPE_ERROR_OFFSET:
+        return "error at offset";
+    default:
+        if (type & (1 << 15)) {
+            return "<unknown error>";
+        }
+        return "<unknown>";
+    }
+}
+
+
 const char *nbd_err_lookup(int err)
 {
     switch (err) {
@@ -166,6 +188,8 @@ const char *nbd_err_lookup(int err)
         return "EINVAL";
     case NBD_ENOSPC:
         return "ENOSPC";
+    case NBD_EOVERFLOW:
+        return "EOVERFLOW";
     case NBD_ESHUTDOWN:
         return "ESHUTDOWN";
     default:
@@ -193,6 +217,9 @@ int nbd_errno_to_system_errno(int err)
     case NBD_ENOSPC:
         ret = ENOSPC;
         break;
+    case NBD_EOVERFLOW:
+        ret = EOVERFLOW;
+        break;
     case NBD_ESHUTDOWN:
         ret = ESHUTDOWN;
         break;
diff --git a/nbd/server.c b/nbd/server.c
index 459e00c553..efb6003364 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -40,6 +40,8 @@ static int system_errno_to_nbd_errno(int err)
     case EFBIG:
     case ENOSPC:
         return NBD_ENOSPC;
+    case EOVERFLOW:
+        return NBD_EOVERFLOW;
     case ESHUTDOWN:
         return NBD_ESHUTDOWN;
     case EINVAL:
-- 
2.13.6
