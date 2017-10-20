Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5YqM-0006oq-Aa
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5YqG-00078t-K9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:04:14 -0400
Date: Fri, 20 Oct 2017 17:03:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020150349.GC3667@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-13-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012034720.11947-13-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/24] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the name of the function from bdrv_get_block_status_above()
> to bdrv_block_status_above() ensures that the compiler enforces that
> all callers are updated.  Likewise, since it a byte interface allows
> an offset mapping that might not be sector aligned, split the mapping
> out of the return value and into a pass-by-reference parameter.  For
> now, the io.c layer still assert()s that all uses are sector-aligned,
> but that can be relaxed when a later patch implements byte-based
> block status in the drivers.
> 
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_block_status(), plus
> updates for the new split return interface.  But some code,
> particularly bdrv_block_status(), gets a lot simpler because it no
> longer has to mess with sectors.  Likewise, mirror code no longer
> computes s->granularity >> BDRV_SECTOR_BITS, and can therefore drop
> an assertion about alignment because the loop no longer depends on
> alignment (never mind that we don't really have a driver that
> reports sub-sector alignments, so it's not really possible to test
> the effect of sub-sector mirroring).  Fix a neighboring assertion to
> use is_power_of_2 while there.
> 
> For ease of review, bdrv_get_block_status() was tackled separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

>  int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                        int64_t *pnum, int64_t *map, BlockDriverState **file)
>  {
> -    int64_t ret;
> -    int n;
> -
> -    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
> -    assert(pnum);
> -    /*
> -     * The contract allows us to return pnum smaller than bytes, even
> -     * if the next query would see the same status; we truncate the
> -     * request to avoid overflowing the driver's 32-bit interface.
> -     */
> -    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);

Is the limitation to BDRV_REQUEST_MAX_BYTES going away without being
replaced by a new one in bdrv_co_block_status()? What protects us now
from 32-bit truncation?

Kevin
