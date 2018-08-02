Received: from eggs.gnu.org ([2001:4830:134:3::10]:36422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuG-0002GW-59
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuF-00006B-9v
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  2 Aug 2018 09:48:34 -0500
Message-Id: <20180802144834.520904-5-eblake@redhat.com>
In-Reply-To: <20180802144834.520904-1-eblake@redhat.com>
References: <20180802144834.520904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] nbd/client: Deal with unaligned size from
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

When a server advertises an unaligned size but no block sizes,
the code was rounding up to a sector-aligned size (a known
limitation of bdrv_getlength()), then assuming a request_alignment
of 512 (the recommendation of the NBD spec for maximum portability).
However, this means that qemu will actually attempt to access the
padding bytes of the trailing partial sector.

An easy demonstration, using nbdkit as the server:
$ nbdkit -fv random size=1023
$ qemu-io -r -f raw -c 'r -v 0 1023' nbd://localhost:10809
read failed: Invalid argument

because the client rounded the request up to 1024 bytes, which
nbdkit then rejected as beyond the advertised size of 1023.

Note that qemu as the server refuses to send an unaligned size, as
it has already rounded the unaligned image up to sector size, and
then happily resizes the image on access (at least when serving a
POSIX file over NBD).

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73b..a3e6889c57f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -473,7 +473,16 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
     uint32_t min = s->info.min_block;
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);

-    bs->bl.request_alignment = min ? min : BDRV_SECTOR_SIZE;
+    /*
+     * If the server did not advertise an alignment, then pick the
+     * largest power of 2 that evenly divides the advertised size, but
+     * does not exceed a sector.
+     */
+    if (!min) {
+        min = 1 << ctz32(BDRV_SECTOR_SIZE | s->info.size);
+    }
+
+    bs->bl.request_alignment = min;
     bs->bl.max_pdiscard = max;
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;
-- 
2.14.4
