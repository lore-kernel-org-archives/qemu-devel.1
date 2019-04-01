Received: from eggs.gnu.org ([209.51.188.92]:45939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxco-000257-BU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcl-0004rP-4q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:57 -0500
Message-Id: <20190401140903.19186-9-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] nbd/client: Lower min_block for
 block-status, unaligned size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

We have a latent bug in our NBD client code, tickled by the brand new
nbdkit 1.11.10 block status support:

$ nbdkit --filter=3Dlog --filter=3Dtruncate -U - \
           data data=3D"1" size=3D511 truncate=3D64K logfile=3D/dev/stdou=
t \
           --run 'qemu-img convert $nbd /var/tmp/out'
...
qemu-img: block/io.c:2122: bdrv_co_block_status: Assertion `*pnum && QEMU=
_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset' failed.

The culprit? Our implementation of .bdrv_co_block_status can return
unaligned block status for any server that operates with a lower
actual alignment than what we tell the block layer in
request_alignment, in violation of the block layer's constraints. To
date, we've been unable to trip the bug, because qemu as NBD server
always advertises block sizing (at which point it is a server bug if
the server sends unaligned status - although qemu 3.1 is such a server
and I've sent separate patches for 4.0 both to get the server to obey
the spec, and to let the client to tolerate server oddities at EOF).

But nbdkit does not (yet) advertise block sizing, and therefore is not
in violation of the spec for returning block status at whatever
boundaries it wants, and those unaligned results can occur anywhere
rather than just at EOF. While we are still wise to avoid sending
sub-sector read/write requests to a server of unknown origin, we MUST
consider that a server telling us block status without an advertised
block size is correct.  So, we either have to munge unaligned answers
from the server into aligned ones that we hand back to the block
layer, or we have to tell the block layer about a smaller alignment.

Similarly, if the server advertises an image size that is not
sector-aligned, we might as well assume that the server intends to let
us access those tail bytes, and therefore supports a minimum block
size of 1, regardless of whether the server supports block status
(although we still need more patches to fix the problem that with an
unaligned image, we can send read or block status requests that exceed
EOF to the server). Again, qemu as server cannot trip this problem
(because it rounds images to sector alignment), but nbdkit advertised
unaligned size even before it gained block status support.

Solve both alignment problems at once by using better heuristics on
what alignment to report to the block layer when the server did not
give us something to work with. Note that very few NBD servers
implement block status (to date, only qemu and nbdkit are known to do
so); and as the NBD spec mentioned block sizing constraints prior to
documenting block status, it can be assumed that any future
implementations of block status are aware that they must advertise
block size if they want a minimum size other than 1.

We've had a long history of struggles with picking the right alignment
to use in the block layer, as evidenced by the commit message of
fd8d372d (v2.12) that introduced the current choice of forced 512-byte
alignment.

There is no iotest coverage for this fix, because qemu can't provoke
it, and I didn't want to make test 241 dependent on nbdkit.

Fixes: fd8d372d
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190329042750.14704-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/nbd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 2e72df528ac..208be596027 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -437,7 +437,24 @@ static void nbd_refresh_limits(BlockDriverState *bs,=
 Error **errp)
     uint32_t min =3D s->info.min_block;
     uint32_t max =3D MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block=
);

-    bs->bl.request_alignment =3D min ? min : BDRV_SECTOR_SIZE;
+    /*
+     * If the server did not advertise an alignment:
+     * - a size that is not sector-aligned implies that an alignment
+     *   of 1 can be used to access those tail bytes
+     * - advertisement of block status requires an alignment of 1, so
+     *   that we don't violate block layer constraints that block
+     *   status is always aligned (as we can't control whether the
+     *   server will report sub-sector extents, such as a hole at EOF
+     *   on an unaligned POSIX file)
+     * - otherwise, assume the server is so old that we are safer avoidi=
ng
+     *   sub-sector requests
+     */
+    if (!min) {
+        min =3D (!QEMU_IS_ALIGNED(s->info.size, BDRV_SECTOR_SIZE) ||
+               s->info.base_allocation) ? 1 : BDRV_SECTOR_SIZE;
+    }
+
+    bs->bl.request_alignment =3D min;
     bs->bl.max_pdiscard =3D max;
     bs->bl.max_pwrite_zeroes =3D max;
     bs->bl.max_transfer =3D max;
--=20
2.20.1
