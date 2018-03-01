Received: from eggs.gnu.org ([2001:4830:134:3::10]:52079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM8-0005ix-FF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM7-00042E-BZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 15:02:46 -0600
Message-Id: <20180301210249.14872-2-eblake@redhat.com>
In-Reply-To: <20180301210249.14872-1-eblake@redhat.com>
References: <20180301210249.14872-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] nbd: Honor server's advertised minimum
 block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Commit 79ba8c98 (v2.7) changed the setting of request_alignment
to occur only during bdrv_refresh_limits(), rather than at at
bdrv_open() time; but at the time, NBD was unaffected, because
it still used sector-based callbacks, so the block layer
defaulted NBD to use 512 request_alignment.

Later, commit 70c4fb26 (also v2.7) changed NBD to use byte-based
callbacks, without setting request_alignment.  This resulted in
NBD using request_alignment of 1, which works great when the
server supports it (as is the case for qemu-nbd), but falls apart
miserably if the server requires alignment (but only if qemu
actually sends a sub-sector request; qemu-io can do it, but
most qemu operations still perform on sectors or larger).

Even later, the NBD protocol was updated to document that clients
should learn the server's minimum alignment during NBD_OPT_GO;
and recommended that clients should assume a minimum size of 512
unless the server understands NBD_OPT_GO and replied with a smaller
size.  Commit 081dd1fe (v2.10) attempted to do that, by assigning
request_alignment to whatever was learned from the server; but
it has two flaws: the assignment is done during bdrv_open() so
it gets unconditionally wiped out back to 1 during any later
bdrv_refresh_limits(); and the code is not using a default of 512
when the server did not report a minimum size.

Fix these issues by moving the assignment to request_alignment
to the right function, and by using a sane default when the
server does not advertise a minimum size.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180215032905.27146-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 3 ---
 block/nbd.c        | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9206652e45c..7b68499b76a 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -846,9 +846,6 @@ int nbd_client_init(BlockDriverState *bs,
     if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
-    if (client->info.min_block > bs->bl.request_alignment) {
-        bs->bl.request_alignment = client->info.min_block;
-    }

     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
diff --git a/block/nbd.c b/block/nbd.c
index ef81a9f53ba..69b5fd5e8fa 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -474,8 +474,10 @@ static int nbd_co_flush(BlockDriverState *bs)
 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     NBDClientSession *s = nbd_get_client_session(bs);
+    uint32_t min = s->info.min_block;
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);

+    bs->bl.request_alignment = min ? min : BDRV_SECTOR_SIZE;
     bs->bl.max_pdiscard = max;
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;
-- 
2.14.3
