Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5YL4-0008DY-LU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5YKy-00063u-NJ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:31:54 -0400
Date: Fri, 20 Oct 2017 16:31:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020143124.GB3667@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012034720.11947-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/24] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the name of the function from bdrv_get_block_status() to
> bdrv_block_status() ensures that the compiler enforces that all
> callers are updated.  For now, the io.c layer still assert()s that
> all callers are sector-aligned, but that can be relaxed when a later
> patch implements byte-based block status in the drivers.
> 
> There was an inherent limitation in returning the offset via the
> return value: we only have room for BDRV_BLOCK_OFFSET_MASK bits, which
> means an offset can only be mapped for sector-aligned queries (or,
> if we declare that non-aligned input is at the same relative position
> modulo 512 of the answer), so the new interface also changes things to
> return the offset via output through a parameter by reference rather
> than mashed into the return value.  We'll have some glue code that
> munges between the two styles until we finish converting all uses.
> 
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_block_status(), coupled
> with the tweak in calling convention.  But some code, particularly
> bdrv_is_allocated(), gets a lot simpler because it no longer has to
> mess with sectors.
> 
> For ease of review, bdrv_get_block_status_above() will be tackled
> separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v6: redo interface to return byte-based offset by reference [Kevin]
> v5: drop pointless 'if (pnum)' [John], add comment
> v4: no change
> v3: clamp bytes to 32-bits, rather than asserting
> v2: rebase to earlier changes
> ---
>  include/block/block.h | 17 +++++++++--------
>  block/io.c            | 47 ++++++++++++++++++++++++++++++++++-------------
>  block/qcow2-cluster.c |  2 +-
>  qemu-img.c            | 25 ++++++++++++++-----------
>  4 files changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 440f3e9e39..7ac851f82f 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -121,7 +121,7 @@ typedef struct HDGeometry {
>  #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
> 
>  /*
> - * Allocation status flags for bdrv_get_block_status() and friends.
> + * Allocation status flags for bdrv_block_status() and friends.
>   *
>   * Public flags:
>   * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
> @@ -136,10 +136,11 @@ typedef struct HDGeometry {
>   *                 that the block layer recompute the answer from the returned
>   *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
>   *
> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
> - * represent the offset in the returned BDS that is allocated for the
> - * corresponding raw data; however, whether that offset actually contains
> - * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follows:
> + * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK) of
> + * the return value (old interface) or the entire map parameter (new
> + * interface) represent the offset in the returned BDS that is allocated for
> + * the corresponding raw data.

Are there any functions using the old interface left at the end of the
series or do we want a final patch that removes the old interface from
the description?

Kevin
