Received: from eggs.gnu.org ([2001:4830:134:3::10]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5q-00044f-QX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5p-0008Ok-Ha
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:38 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Feb 2018 10:57:22 -0600
Message-Id: <20180226165723.17818-2-eblake@redhat.com>
In-Reply-To: <20180226165723.17818-1-eblake@redhat.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<20180226165723.17818-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] nbd: BLOCK_STATUS constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Expose the new constants and structs that will be used by both
server and client implementations of NBD_CMD_BLOCK_STATUS (the
command is currently experimental at
https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/proto.md
but will hopefully be stabilized soon).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
[eblake: split from larger patch on server implementation]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 31 +++++++++++++++++++++++++++++++
 nbd/common.c        | 10 ++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index ef1698914ba..53250d0979c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -41,6 +41,12 @@ struct NBDOptionReply {
 } QEMU_PACKED;
 typedef struct NBDOptionReply NBDOptionReply;

+typedef struct NBDOptionReplyMetaContext {
+    NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 4 */
+    uint32_t context_id;
+    /* meta context name follows */
+} QEMU_PACKED NBDOptionReplyMetaContext;
+
 /* Transmission phase structs
  *
  * Note: these are _NOT_ the same as the network representation of an NBD
@@ -105,6 +111,19 @@ typedef struct NBDStructuredError {
     uint16_t message_length;
 } QEMU_PACKED NBDStructuredError;

+/* Header of NBD_REPLY_TYPE_BLOCK_STATUS */
+typedef struct NBDStructuredMeta {
+    NBDStructuredReplyChunk h; /* h.length >= 12 (at least one extent) */
+    uint32_t context_id;
+    /* extents follows */
+} QEMU_PACKED NBDStructuredMeta;
+
+/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
+typedef struct NBDExtent {
+    uint32_t length;
+    uint32_t flags; /* NBD_STATE_* */
+} QEMU_PACKED NBDExtent;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
@@ -136,6 +155,8 @@ typedef struct NBDStructuredError {
 #define NBD_OPT_INFO              (6)
 #define NBD_OPT_GO                (7)
 #define NBD_OPT_STRUCTURED_REPLY  (8)
+#define NBD_OPT_LIST_META_CONTEXT (9)
+#define NBD_OPT_SET_META_CONTEXT  (10)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
@@ -143,6 +164,7 @@ typedef struct NBDStructuredError {
 #define NBD_REP_ACK             (1)    /* Data sending finished. */
 #define NBD_REP_SERVER          (2)    /* Export description. */
 #define NBD_REP_INFO            (3)    /* NBD_OPT_INFO/GO. */
+#define NBD_REP_META_CONTEXT    (4)    /* NBD_OPT_{LIST,SET}_META_CONTEXT */

 #define NBD_REP_ERR_UNSUP           NBD_REP_ERR(1)  /* Unknown option */
 #define NBD_REP_ERR_POLICY          NBD_REP_ERR(2)  /* Server denied */
@@ -163,6 +185,8 @@ typedef struct NBDStructuredError {
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
 #define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
 #define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */
+#define NBD_CMD_FLAG_REQ_ONE    (1 << 3) /* only one extent in BLOCK_STATUS
+                                          * reply chunk */

 /* Supported request types */
 enum {
@@ -173,6 +197,7 @@ enum {
     NBD_CMD_TRIM = 4,
     /* 5 reserved for failed experiment NBD_CMD_CACHE */
     NBD_CMD_WRITE_ZEROES = 6,
+    NBD_CMD_BLOCK_STATUS = 7,
 };

 #define NBD_DEFAULT_PORT	10809
@@ -200,9 +225,15 @@ enum {
 #define NBD_REPLY_TYPE_NONE          0
 #define NBD_REPLY_TYPE_OFFSET_DATA   1
 #define NBD_REPLY_TYPE_OFFSET_HOLE   2
+#define NBD_REPLY_TYPE_BLOCK_STATUS  3
 #define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)

+/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
+ * for base:allocation meta context */
+#define NBD_STATE_HOLE (1 << 0)
+#define NBD_STATE_ZERO (1 << 1)
+
 static inline bool nbd_reply_type_is_error(int type)
 {
     return type & (1 << 15);
diff --git a/nbd/common.c b/nbd/common.c
index 6295526dd14..8c95c1d606e 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -75,6 +75,10 @@ const char *nbd_opt_lookup(uint32_t opt)
         return "go";
     case NBD_OPT_STRUCTURED_REPLY:
         return "structured reply";
+    case NBD_OPT_LIST_META_CONTEXT:
+        return "list meta context";
+    case NBD_OPT_SET_META_CONTEXT:
+        return "set meta context";
     default:
         return "<unknown>";
     }
@@ -90,6 +94,8 @@ const char *nbd_rep_lookup(uint32_t rep)
         return "server";
     case NBD_REP_INFO:
         return "info";
+    case NBD_REP_META_CONTEXT:
+        return "meta context";
     case NBD_REP_ERR_UNSUP:
         return "unsupported";
     case NBD_REP_ERR_POLICY:
@@ -144,6 +150,8 @@ const char *nbd_cmd_lookup(uint16_t cmd)
         return "trim";
     case NBD_CMD_WRITE_ZEROES:
         return "write zeroes";
+    case NBD_CMD_BLOCK_STATUS:
+        return "block status";
     default:
         return "<unknown>";
     }
@@ -159,6 +167,8 @@ const char *nbd_reply_type_lookup(uint16_t type)
         return "data";
     case NBD_REPLY_TYPE_OFFSET_HOLE:
         return "hole";
+    case NBD_REPLY_TYPE_BLOCK_STATUS:
+        return "block status";
     case NBD_REPLY_TYPE_ERROR:
         return "generic error";
     case NBD_REPLY_TYPE_ERROR_OFFSET:
-- 
2.14.3
