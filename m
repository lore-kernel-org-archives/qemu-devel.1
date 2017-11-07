Received: from eggs.gnu.org ([2001:4830:134:3::10]:37672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA9-0007a3-1i
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA4-0003SG-Dn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:53 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:32 -0600
Message-Id: <20171107030236.23633-5-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] nbd-client: Honor server read-only
 advertisement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD spec says that clients should not try to write/trim to
an export advertised as read-only by the server.  But we failed
to inform the block layer of what we learned from the server,
meaning that we were depending on the server sending a proper
EPERM failure for various commands.  In fact, this was noticeable
in the case of a 0-length write: we had a difference in behavior
depending on whether we were writing zero (silent success
locally, because the driver is not invoked from the block layer)
or normal writes (noisy failure, because we sent a 0-length
request across the wire and the server flagged it as invalid);
now we always fail locally without sending anything over the wire.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index de6c153328..c35aad59b0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -697,6 +697,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
@@ -717,6 +718,7 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
     }
@@ -756,6 +758,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
     }
@@ -814,6 +817,12 @@ int nbd_client_init(BlockDriverState *bs,
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
+    if (client->info.flags & NBD_FLAG_READ_ONLY) {
+        ret = bdrv_set_read_only(bs, true, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
         bs->supported_zero_flags |= BDRV_REQ_FUA;
-- 
2.13.6
