Received: from eggs.gnu.org ([2001:4830:134:3::10]:44670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRLGj-0003rc-14
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRLGf-0003a6-Ti
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:33:45 -0400
References: <20180608152353.98712-1-vsementsov@virtuozzo.com>
	<20180608152353.98712-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a6e8081-7e3b-31da-ead8-8e6a3165f8f3@virtuozzo.com>
Date: Fri, 8 Jun 2018 20:33:33 +0300
MIME-Version: 1.0
In-Reply-To: <20180608152353.98712-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

08.06.2018 18:23, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
>
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

[...]

> +static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
> +                                  uint64_t length, NBDExtent *extents,
> +                                  unsigned nb_extents)
> +{
> +    uint64_t begin = offset, end;
> +    uint64_t overall_end = offset + length;
> +    unsigned i = 0;
> +    BdrvDirtyBitmapIter *it;
> +    bool dirty;
> +
> +    bdrv_dirty_bitmap_lock(bitmap);
> +
> +    it = bdrv_dirty_iter_new(bitmap);
> +    dirty = bdrv_get_dirty_locked(NULL, bitmap, offset);
> +
> +    while (begin < overall_end && i < nb_extents) {
> +        if (dirty) {
> +            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
> +        } else {
> +            bdrv_set_dirty_iter(it, begin);
> +            end = bdrv_dirty_iter_next(it);
> +        }
> +        if (end == -1) {
> +            end = overall_end;

here better is bdrv_dirty_bitmap_size()

> +        }

and here we should crop it to overall_end in case of REQ_ONE

> +
> +        i += add_extents(extents + i, nb_extents - i, end - begin,
> +                         dirty ? NBD_STATE_DIRTY : 0);
> +        begin = end;
> +        dirty = !dirty;
> +    }
> +
> +    bdrv_dirty_iter_free(it);
> +
> +    bdrv_dirty_bitmap_unlock(bitmap);
> +
> +    return i;
> +}

-- 
Best regards,
Vladimir
