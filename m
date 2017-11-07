Received: from eggs.gnu.org ([2001:4830:134:3::10]:37702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA9-0007c3-SE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA9-0003WE-59
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:53 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:34 -0600
Message-Id: <20171107030236.23633-7-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] nbd-client: Short-circuit 0-length
 operations
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

The NBD spec is being clarified to state that clients should
not send 0-length requests to the server, as the server behavior
is undefined.  While such requests are unlikely to occur from
real guest behavior, qemu-io can force the driver to perform them;
avoid any questionable server implementations by short-circuiting
such operations as a no-op success (we are relying on the block
layer for already filtering out things like invalid offset, write
to a read-only volume, and so forth).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index c35aad59b0..d8ad2ba57c 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -673,6 +673,9 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,

     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
+    if (!bytes) {
+        return 0;
+    }

     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
@@ -705,6 +708,9 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,

     assert(bytes <= NBD_MAX_BUFFER_SIZE);

+    if (!bytes) {
+        return 0;
+    }
     return nbd_co_request(bs, &request, qiov);
 }

@@ -731,6 +737,9 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }

+    if (!bytes) {
+        return 0;
+    }
     return nbd_co_request(bs, &request, NULL);
 }

@@ -759,7 +768,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     };

     assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
     }

-- 
2.13.6
