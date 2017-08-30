Received: from eggs.gnu.org ([2001:4830:134:3::10]:53195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Op-0001ze-4p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Oo-0001e2-A5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:09 -0500
Message-Id: <20170830180711.7974-10-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] block/nbd-client: get rid of ssize_t
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

Use int variable for nbd_co_send_request return value (as
nbd_co_send_request returns int).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170804151440.320927-6-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ea728fffc8..1e393cf26f 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -230,7 +230,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;

     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
@@ -254,7 +254,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;

     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
@@ -275,7 +275,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                 int bytes, BdrvRequestFlags flags)
 {
-    ssize_t ret;
+    int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
@@ -310,7 +310,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_FLUSH };
     NBDReply reply;
-    ssize_t ret;
+    int ret;

     if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
@@ -337,7 +337,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;

     if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
-- 
2.13.5
