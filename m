Received: from eggs.gnu.org ([2001:4830:134:3::10]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flesT-0000VE-8W
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flesS-0005Cf-DX
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:41 -0400
References: <20180803174654.278336-1-vsementsov@virtuozzo.com>
	<20180803174654.278336-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5b4b099-de03-58e8-a9f7-59dd4a38b52b@redhat.com>
Date: Fri, 3 Aug 2018 13:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180803174654.278336-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, den@openvz.org

On 08/03/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Add bytes parameter to the function, to limit searched range.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/dirty-bitmap.h |  3 ++-
>   include/qemu/hbitmap.h       |  7 +++++--
>   block/backup.c               |  2 +-
>   block/dirty-bitmap.c         |  5 +++--
>   nbd/server.c                 |  2 +-
>   util/hbitmap.c               | 13 ++++++++++---
>   6 files changed, 22 insertions(+), 10 deletions(-)
> 

> +++ b/include/qemu/hbitmap.h
> @@ -295,10 +295,13 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
>   /* hbitmap_next_zero:
>    * @hb: The HBitmap to operate on
>    * @start: The bit to start from.
> + * @bytes: Range length to search in. If @bytes is zero, search up to the bitmap
> + *         end.
>    *
> - * Find next not dirty bit.
> + * Find next not dirty bit within range [@start, @start + @bytes), or from
> + * @start to the bitmap end if @bytes is zero.

Can @bytes (or rather, @start + @bytes) exceed the remaining bitmap 
length (in which case it is silently truncated to the remaining length)?

> +++ b/util/hbitmap.c
> @@ -192,16 +192,23 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first)
>       }
>   }
>   
> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start)
> +int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t bytes)
>   {
>       size_t pos = (start >> hb->granularity) >> BITS_PER_LEVEL;
>       unsigned long *last_lev = hb->levels[HBITMAP_LEVELS - 1];
> -    uint64_t sz = hb->sizes[HBITMAP_LEVELS - 1];
> +    uint64_t end_bit =
> +            bytes ? ((start + bytes - 1) >> hb->granularity) + 1 : hb->size;

This computation can overflow if bytes is too large...

> +    uint64_t sz = (end_bit + BITS_PER_LONG - 1) >> BITS_PER_LEVEL;
>       unsigned long cur = last_lev[pos];
>       unsigned start_bit_offset =
>               (start >> hb->granularity) & (BITS_PER_LONG - 1);
>       int64_t res;
>   
> +    assert(!bytes || start + bytes <= (hb->size << hb->granularity));

and only now are you asserting that bytes was in range.  You should at 
least document that bytes must be in range, and while I don't see any 
memory dereferences dependent on a potentially bogus end_bit value, it 
may also be worth hoisting the assert sooner in the function.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
