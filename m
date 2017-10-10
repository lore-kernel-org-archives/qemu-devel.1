Received: from eggs.gnu.org ([2001:4830:134:3::10]:57064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1voF-0000Xg-QB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1voB-00058N-Qk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:03 -0400
Date: Tue, 10 Oct 2017 16:46:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010144644.GL4177@dhcp-200-186.str.redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004020048.26379-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/23] block: Convert
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
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
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
> Note that we have an inherent limitation in the BDRV_BLOCK_* return
> values: BDRV_BLOCK_OFFSET_VALID can only return the start of a
> sector, even if we later relax the interface to query for the status
> starting at an intermediate byte; document the obvious interpretation
> that valid offsets are always sector-relative.
> 
> Therefore, for the most part this patch is just the addition of scaling
> at the callers followed by inverse scaling at bdrv_block_status().  But
> some code, particularly bdrv_is_allocated(), gets a lot simpler because
> it no longer has to mess with sectors.
> 
> For ease of review, bdrv_get_block_status_above() will be tackled
> separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v5: drop pointless 'if (pnum)' [John], add comment
> v4: no change
> v3: clamp bytes to 32-bits, rather than asserting
> v2: rebase to earlier changes
> ---
>  include/block/block.h | 12 +++++++-----
>  block/io.c            | 35 +++++++++++++++++++++++------------
>  block/qcow2-cluster.c |  2 +-
>  qemu-img.c            | 20 +++++++++++---------
>  4 files changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index be49c4ae9d..4ecd2c4a65 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h

A bit above the first hunk:

 * Allocation status flags for bdrv_get_block_status() and friends.

This should be bdrv_block_status() now.

> @@ -138,8 +138,10 @@ typedef struct HDGeometry {
>   *
>   * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
>   * represent the offset in the returned BDS that is allocated for the
> - * corresponding raw data; however, whether that offset actually contains
> - * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follows:
> + * corresponding raw data.  Individual bytes are at the same sector-relative
> + * locations (and thus, this bit cannot be set for mappings which are
> + * not equivalent modulo 512).  However, whether that offset actually
> + * contains data also depends on BDRV_BLOCK_DATA, as follows:

This suggests to me that it was a bad idea to embed the offset in the
bitmask. In the long run, we should probably make flags and offset two
separate things (e.g. making offset a new by-reference parameter).

Kevin
