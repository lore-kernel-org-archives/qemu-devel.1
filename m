Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBI-000344-Qf
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBF-0000oI-2D
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:37 -0600
Message-Id: <20171109165939.23154-7-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] nbd-client: Short-circuit 0-length
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec was recently clarified to state that clients should
not send 0-length requests to the server, as the server behavior
is undefined [1].  We know that qemu-nbd's behavior is a successful
no-op (once it has filtered for read-only exports), but other NBD
implementations might return an error.  To avoid any questionable
server implementations, it is better to just short-circuit such
requests on the client side (we are relying on the block layer to
already filter out requests such as invalid offset, write to a
read-only volume, and so forth); do the short-circuit as late as
possible to still benefit from protections from assertions that
the block layer is not violating our assumptions.

[1] https://github.com/NetworkBlockDevice/nbd/commit/ee926037

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171108215703.9295-6-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index daa4392531..0a675d0fab 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -674,6 +674,9 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);

+    if (!bytes) {
+        return 0;
+    }
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         return ret;
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
