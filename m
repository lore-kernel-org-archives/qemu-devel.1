Received: from eggs.gnu.org ([2001:4830:134:3::10]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW12R-0001LS-9n
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW12Q-0006qH-9n
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:58:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 21 Jun 2018 09:57:49 -0500
Message-Id: <20180621145749.191944-10-eblake@redhat.com>
In-Reply-To: <20180621145749.191944-1-eblake@redhat.com>
References: <20180621145749.191944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL v2 9/9] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Handle nbd CACHE command. Just do read, without sending read data back.
Cache mechanism should be done by exported node driver chain.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180413143156.11409-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: fix two missing case labels in switch statements]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  3 ++-
 nbd/common.c        |  2 ++
 nbd/server.c        | 11 +++++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 8bb9606c39b..daaeae61bf9 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -135,6 +135,7 @@ typedef struct NBDExtent {
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
 #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
+#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */

 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -195,7 +196,7 @@ enum {
     NBD_CMD_DISC = 2,
     NBD_CMD_FLUSH = 3,
     NBD_CMD_TRIM = 4,
-    /* 5 reserved for failed experiment NBD_CMD_CACHE */
+    NBD_CMD_CACHE = 5,
     NBD_CMD_WRITE_ZEROES = 6,
     NBD_CMD_BLOCK_STATUS = 7,
 };
diff --git a/nbd/common.c b/nbd/common.c
index 8c95c1d606e..41f5ed8d9fa 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -148,6 +148,8 @@ const char *nbd_cmd_lookup(uint16_t cmd)
         return "flush";
     case NBD_CMD_TRIM:
         return "trim";
+    case NBD_CMD_CACHE:
+        return "cache";
     case NBD_CMD_WRITE_ZEROES:
         return "write zeroes";
     case NBD_CMD_BLOCK_STATUS:
diff --git a/nbd/server.c b/nbd/server.c
index 2c2d62c6361..274604609f4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1252,7 +1252,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     int ret;
     const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
                               NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
-                              NBD_FLAG_SEND_WRITE_ZEROES);
+                              NBD_FLAG_SEND_WRITE_ZEROES | NBD_FLAG_SEND_CACHE);
     bool oldStyle;

     /* Old style negotiation header, no room for options
@@ -2034,7 +2034,9 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         return -EIO;
     }

-    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE) {
+    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
+        request->type == NBD_CMD_CACHE)
+    {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
             error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
                        request->len, NBD_MAX_BUFFER_SIZE);
@@ -2119,7 +2121,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     int ret;
     NBDExport *exp = client->exp;

-    assert(request->type == NBD_CMD_READ);
+    assert(request->type == NBD_CMD_READ || request->type == NBD_CMD_CACHE);

     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2138,7 +2140,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,

     ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
                     request->len);
-    if (ret < 0) {
+    if (ret < 0 || request->type == NBD_CMD_CACHE) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
     }
@@ -2171,6 +2173,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,

     switch (request->type) {
     case NBD_CMD_READ:
+    case NBD_CMD_CACHE:
         return nbd_do_cmd_read(client, request, data, errp);

     case NBD_CMD_WRITE:
-- 
2.14.4
