Received: from eggs.gnu.org ([2001:4830:134:3::10]:39640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBJ-00034y-Nn
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBJ-0000qH-22
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:57 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:38 -0600
Message-Id: <20171109165939.23154-8-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] nbd-client: Stricter enforcing of
 structured reply spec
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

Ensure that the server is not sending unexpected chunk lengths
for either the NONE or the OFFSET_DATA chunk, nor unexpected
hole length for OFFSET_HOLE.  This will flag any server as
broken that responds to a zero-length read with an OFFSET_DATA
(what our server currently does, but that's about to be fixed)
or with OFFSET_HOLE, even though we previously fixed our client
to never be able to send such a request over the wire.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171108215703.9295-7-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 0a675d0fab..bcfed0133d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -216,7 +216,7 @@ static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
     offset = payload_advance64(&payload);
     hole_size = payload_advance32(&payload);

-    if (offset < orig_offset || hole_size > qiov->size ||
+    if (!hole_size || offset < orig_offset || hole_size > qiov->size ||
         offset > orig_offset + qiov->size - hole_size) {
         error_setg(errp, "Protocol error: server sent chunk exceeding requested"
                          " region");
@@ -281,7 +281,8 @@ static int nbd_co_receive_offset_data_payload(NBDClientSession *s,

     assert(nbd_reply_is_structured(&s->reply));

-    if (chunk->length < sizeof(offset)) {
+    /* The NBD spec requires at least one byte of payload */
+    if (chunk->length <= sizeof(offset)) {
         error_setg(errp, "Protocol error: invalid payload for "
                          "NBD_REPLY_TYPE_OFFSET_DATA");
         return -EINVAL;
@@ -293,6 +294,7 @@ static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
     be64_to_cpus(&offset);

     data_size = chunk->length - sizeof(offset);
+    assert(data_size);
     if (offset < orig_offset || data_size > qiov->size ||
         offset > orig_offset + qiov->size - data_size) {
         error_setg(errp, "Protocol error: server sent chunk exceeding requested"
@@ -411,6 +413,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
                        " NBD_REPLY_FLAG_DONE flag set");
             return -EINVAL;
         }
+        if (chunk->length) {
+            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk with"
+                       " nonzero length");
+            return -EINVAL;
+        }
         return 0;
     }

-- 
2.13.6
