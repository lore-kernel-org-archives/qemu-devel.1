Received: from eggs.gnu.org ([2001:4830:134:3::10]:33038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDr-0004YT-4r
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDn-00017i-2g
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:27 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 17 Nov 2017 09:05:56 -0600
Message-Id: <20171117150556.16947-5-eblake@redhat.com>
In-Reply-To: <20171117150556.16947-1-eblake@redhat.com>
References: <20171117150556.16947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] nbd/server: Fix error reporting for bad
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec says an attempt to NBD_CMD_TRIM on a read-only
export should fail with EPERM, as a trim has the potential
to change disk contents, but we were relying on the block
layer to catch that for us, which might not always give the
right error (and even if it does, it does not let us pass
back a sane message for structured replies).

The NBD spec says an attempt to NBD_CMD_WRITE_ZEROES out of
bounds should fail with ENOSPC, not EINVAL.

Our check for u64 offset + u32 length wraparound up front is
pointless; nothing uses offset until after the second round
of sanity checks, and we can just as easily ensure there is
no wraparound by checking whether offset is in bounds (since
a disk size cannot exceed off_t which is 63 bits, adding a
32-bit number for a valid offset can't overflow).  Bonus:
dropping the up-front check lets us keep the connection alive
after NBD_CMD_WRITE, whereas before we would drop the
connection (of course, any client sending a packet that would
trigger the failure is already buggy, so it's also okay to
drop the connection, but better quality-of-implementation
never hurts).

Solve all of these issues by some code motion and improved
request validation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171115213557.3548-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index df771fd42f..7d6801b427 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1366,15 +1366,6 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         return -EIO;
     }

-    /* Check for sanity in the parameters, part 1.  Defer as many
-     * checks as possible until after reading any NBD_CMD_WRITE
-     * payload, so we can try and keep the connection alive.  */
-    if ((request->from + request->len) < request->from) {
-        error_setg(errp,
-                   "integer overflow detected, you're probably being attacked");
-        return -EINVAL;
-    }
-
     if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE) {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
             error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
@@ -1399,12 +1390,21 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
                                                       request->len);
     }

-    /* Sanity checks, part 2. */
-    if (request->from + request->len > client->exp->size) {
+    /* Sanity checks. */
+    if (client->exp->nbdflags & NBD_FLAG_READ_ONLY &&
+        (request->type == NBD_CMD_WRITE ||
+         request->type == NBD_CMD_WRITE_ZEROES ||
+         request->type == NBD_CMD_TRIM)) {
+        error_setg(errp, "Export is read-only");
+        return -EROFS;
+    }
+    if (request->from > client->exp->size ||
+        request->from + request->len > client->exp->size) {
         error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
                    ", Size: %" PRIu64, request->from, request->len,
                    (uint64_t)client->exp->size);
-        return request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
+        return (request->type == NBD_CMD_WRITE ||
+                request->type == NBD_CMD_WRITE_ZEROES) ? -ENOSPC : -EINVAL;
     }
     valid_flags = NBD_CMD_FLAG_FUA;
     if (request->type == NBD_CMD_READ && client->structured_reply) {
@@ -1482,12 +1482,6 @@ static coroutine_fn void nbd_trip(void *opaque)

         break;
     case NBD_CMD_WRITE:
-        if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            error_setg(&local_err, "Export is read-only");
-            ret = -EROFS;
-            break;
-        }
-
         flags = 0;
         if (request.flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
@@ -1500,12 +1494,6 @@ static coroutine_fn void nbd_trip(void *opaque)

         break;
     case NBD_CMD_WRITE_ZEROES:
-        if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            error_setg(&local_err, "Export is read-only");
-            ret = -EROFS;
-            break;
-        }
-
         flags = 0;
         if (request.flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
-- 
2.13.6
