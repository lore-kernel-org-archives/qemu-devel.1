Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTFz6-0001FS-4X
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTFz5-0003kz-54
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:14:56 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-4-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6e033077-4988-70e2-13f6-afc113cf9da1@redhat.com>
Date: Thu, 6 Jul 2017 19:14:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/17] qcow2: Ensure bitmap
 serialization is aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> When subdividing a bitmap serialization, the code in hbitmap.c
> enforces that start/count parameters are aligned (except that
> count can end early at end-of-bitmap).  We exposed this required
> alignment through bdrv_dirty_bitmap_serialization_align(), but
> forgot to actually check that we comply with it.
> 
> Fortunately, qcow2 is never dividing bitmap serialization smaller
> than one cluster (which is a minimum of 512 bytes); so we are
> always compliant with the serialization alignment (which insists
> that we partition at least 64 bits per chunk) because we are doing
> at least 4k bits per chunk.
> 
> Still, it's safer to add an assertion (for the unlikely case that
> we'd ever support a cluster smaller than 512 bytes, or if the
> hbitmap implementation changes what it considers to be aligned),
> rather than leaving bdrv_dirty_bitmap_serialization_align()
> without a caller.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> 
> ---
> v4: new patch
> ---
>  block/qcow2-bitmap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 8448bec..75ee238 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -274,10 +274,13 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
>  static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
>                                                    const BdrvDirtyBitmap *bitmap)
>  {
> -    uint32_t sector_granularity =
> +    uint64_t sector_granularity =
>              bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
> +    uint64_t sbc = sector_granularity * (s->cluster_size << 3);
> 
> -    return (uint64_t)sector_granularity * (s->cluster_size << 3);
> +    assert(QEMU_IS_ALIGNED(sbc,
> +                           bdrv_dirty_bitmap_serialization_align(bitmap)));
> +    return sbc;
>  }
> 
>  /* load_bitmap_data
> 
