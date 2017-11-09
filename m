Received: from eggs.gnu.org ([2001:4830:134:3::10]:39569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBE-0002zO-Kb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBD-0000my-OW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:36 -0600
Message-Id: <20171109165939.23154-6-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] nbd: Fix struct name for structured reads
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

A closer read of the NBD spec shows that a structured reply chunk
for a hole is not quite identical to the prefix of a data chunk,
because the hole has to also send a 32-bit size field.  Although
we do not yet send holes, we should fix the misleading information
in our header and make it easier for a future patch to support
sparse reads.  Messed up in commit bae245d1.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171108215703.9295-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 18 +++++++++++++-----
 nbd/server.c        |  2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 92d1723d7c..113c707a5e 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -86,15 +86,23 @@ typedef union NBDReply {
     } QEMU_PACKED;
 } NBDReply;

-/* Header of NBD_REPLY_TYPE_OFFSET_DATA, complete NBD_REPLY_TYPE_OFFSET_HOLE */
-typedef struct NBDStructuredRead {
-    NBDStructuredReplyChunk h;
+/* Header of chunk for NBD_REPLY_TYPE_OFFSET_DATA */
+typedef struct NBDStructuredReadData {
+    NBDStructuredReplyChunk h; /* h.length >= 9 */
     uint64_t offset;
-} QEMU_PACKED NBDStructuredRead;
+    /* At least one byte of data payload follows, calculated from h.length */
+} QEMU_PACKED NBDStructuredReadData;
+
+/* Complete chunk for NBD_REPLY_TYPE_OFFSET_HOLE */
+typedef struct NBDStructuredReadHole {
+    NBDStructuredReplyChunk h; /* h.length == 12 */
+    uint64_t offset;
+    uint32_t length;
+} QEMU_PACKED NBDStructuredReadHole;

 /* Header of all NBD_REPLY_TYPE_ERROR* errors */
 typedef struct NBDStructuredError {
-    NBDStructuredReplyChunk h;
+    NBDStructuredReplyChunk h; /* h.length >= 6 */
     uint32_t error;
     uint16_t message_length;
 } QEMU_PACKED NBDStructuredError;
diff --git a/nbd/server.c b/nbd/server.c
index bcf0cdb47c..6ebb7d9c2e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1280,7 +1280,7 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
                                                     size_t size,
                                                     Error **errp)
 {
-    NBDStructuredRead chunk;
+    NBDStructuredReadData chunk;
     struct iovec iov[] = {
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = data, .iov_len = size}
-- 
2.13.6
