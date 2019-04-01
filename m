Received: from eggs.gnu.org ([209.51.188.92]:45978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcp-00027E-RX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxco-0004vW-BY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:09:00 -0500
Message-Id: <20190401140903.19186-12-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] nbd/client: Support qemu-img convert from
 unaligned size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

If an NBD server advertises a size that is not a multiple of a sector,
the block layer rounds up that size, even though we set info.size to
the exact byte value sent by the server. The block layer then proceeds
to let us read or query block status on the hole that it added past
EOF, which the NBD server is unlikely to be happy with. Fortunately,
qemu as a server never advertizes an unaligned size, so we generally
don't run into this problem; but the nbdkit server makes it easy to
test:

$ printf %1000d 1 > f1
$ ~/nbdkit/nbdkit -fv file f1 & pid=3D$!
$ qemu-img convert -f raw nbd://localhost:10809 f2
$ kill $pid
$ qemu-img compare f1 f2

Pre-patch, the server attempts a 1024-byte read, which nbdkit
rightfully rejects as going beyond its advertised 1000 byte size; the
conversion fails and the output files differ (not even the first
sector is copied, because qemu-img does not follow ddrescue's habit of
trying smaller reads to get as much information as possible in spite
of errors). Post-patch, the client's attempts to read (and query block
status, for new enough nbdkit) are properly truncated to the server's
length, with sane handling of the hole the block layer forced on
us. Although f2 ends up as a larger file (1024 bytes instead of 1000),
qemu-img compare shows the two images to have identical contents for
display to the guest.

I didn't add iotests coverage since I didn't want to add a dependency
on nbdkit in iotests. I also did NOT patch write, trim, or write
zeroes - these commands continue to fail (usually with ENOSPC, but
whatever the server chose), because we really can't write to the end
of the file, and because 'qemu-img convert' is the most common case
where we care about being tolerant (which is read-only). Perhaps we
could truncate the request if the client is writing zeros to the tail,
but that seems like more work, especially if the block layer is fixed
in 4.1 to track byte-accurate sizing (in which case this patch would
be reverted as unnecessary).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190329042750.14704-5-eblake@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/nbd-client.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 3edb508f668..409c2171bc3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -848,6 +848,25 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint6=
4_t offset,
     if (!bytes) {
         return 0;
     }
+    /*
+     * Work around the fact that the block layer doesn't do
+     * byte-accurate sizing yet - if the read exceeds the server's
+     * advertised size because the block layer rounded size up, then
+     * truncate the request to the server and tail-pad with zero.
+     */
+    if (offset >=3D client->info.size) {
+        assert(bytes < BDRV_SECTOR_SIZE);
+        qemu_iovec_memset(qiov, 0, 0, bytes);
+        return 0;
+    }
+    if (offset + bytes > client->info.size) {
+        uint64_t slop =3D offset + bytes - client->info.size;
+
+        assert(slop < BDRV_SECTOR_SIZE);
+        qemu_iovec_memset(qiov, bytes - slop, 0, slop);
+        request.len -=3D slop;
+    }
+
     ret =3D nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         return ret;
@@ -966,7 +985,8 @@ int coroutine_fn nbd_client_co_block_status(BlockDriv=
erState *bs,
         .from =3D offset,
         .len =3D MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
                                                 bs->bl.request_alignment=
),
-                                client->info.max_block), bytes),
+                                client->info.max_block),
+                   MIN(bytes, client->info.size - offset)),
         .flags =3D NBD_CMD_FLAG_REQ_ONE,
     };

@@ -977,6 +997,23 @@ int coroutine_fn nbd_client_co_block_status(BlockDri=
verState *bs,
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }

+    /*
+     * Work around the fact that the block layer doesn't do
+     * byte-accurate sizing yet - if the status request exceeds the
+     * server's advertised size because the block layer rounded size
+     * up, we truncated the request to the server (above), or are
+     * called on just the hole.
+     */
+    if (offset >=3D client->info.size) {
+        *pnum =3D bytes;
+        assert(bytes < BDRV_SECTOR_SIZE);
+        /* Intentionally don't report offset_valid for the hole */
+        return BDRV_BLOCK_ZERO;
+    }
+
+    if (client->info.min_block) {
+        assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
+    }
     ret =3D nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         return ret;
--=20
2.20.1
