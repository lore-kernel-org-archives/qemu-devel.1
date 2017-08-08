Received: from eggs.gnu.org ([2001:4830:134:3::10]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1detkG-0005ud-8t
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1detkB-0000hD-Il
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:55:44 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-29-git-send-email-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <993e9832-d7f0-9523-9143-5286d3b0ba33@redhat.com>
Date: Mon, 7 Aug 2017 21:55:21 -0400
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-29-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 28/56] block: Widen dirty bitmap
 granularity to uint64_t for safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com



On 08/07/2017 10:45 AM, Markus Armbruster wrote:
> Block dirty bitmaps represent granularity in bytes as uint32_t.  It
> must be a power of two and a multiple of BDRV_SECTOR_SIZE.
> 
> The trouble with uint32_t is computations like this one in
> mirror_do_read():
> 
>     uint64_t max_bytes;
> 
>     max_bytes = s->granularity * s->max_iov;
> 
> The operands of * are uint32_t and int, so the product is computed in
> uint32_t (assuming 32 bit int), then zero-extended to uint64_t.
> 
> Since granularity is generally combined with 64 bit file offsets, it's
> best to make it 64 bits, too.  Less opportunity to screw up.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[bweeooop]

> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c

[buuuuweeeep]

> @@ -506,16 +506,11 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
>      return granularity;
>  }
>  
> -uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
> +uint64_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
>  {
>      return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
>  }
>  
> -uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap)
> -{
> -    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->meta);
> -}

Why? Unused? Not cool enough to mention?
