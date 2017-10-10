Received: from eggs.gnu.org ([2001:4830:134:3::10]:45338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1vJd-00011s-NA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1vJc-0002w1-72
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:15:25 -0400
Date: Tue, 10 Oct 2017 16:15:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010141505.GK4177@dhcp-200-186.str.redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004020048.26379-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/23] qcow2: Switch is_zero_sectors()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change), and rename it to is_zero() in the
> process.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> ---
> v3-v5: no change
> v2: rename function, rebase to upstream changes
> ---
>  block/qcow2.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index bcd5c4a34c..e0de46f530 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2972,21 +2972,28 @@ finish:
>  }
> 
> 
> -static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
> -                            uint32_t count)
> +static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
>  {
>      int nr;
>      int64_t res;
> +    int64_t start;
> 
> -    if (start + count > bs->total_sectors) {
> -        count = bs->total_sectors - start;
> +    /* Widen to sector boundaries, then clamp to image length, before
> +     * checking status of underlying sectors */
> +    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> +    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;

Why do we still widen to sector boundaries after this series is fully
applied? Isn't the whole point that we don't have to do this any more?

> +    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
> +        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
>      }
> 
> -    if (!count) {
> +    if (!bytes) {
>          return true;
>      }
> -    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
> -    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
> +    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
> +                                      bytes >> BDRV_SECTOR_BITS, &nr, NULL);
> +    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
> +        nr * BDRV_SECTOR_SIZE == bytes;
>  }

Kevin
