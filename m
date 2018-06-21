Received: from eggs.gnu.org ([2001:4830:134:3::10]:40221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVxx0-0008I3-Qc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVxwx-0004HI-MT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVxwx-0004H0-Eo
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBCC181A4EAB
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 11:40:26 +0000 (UTC)
References: <152955929417.819.6336496286507533586@d39dc562802a>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e6b7078-0717-ac19-287b-2e26bfd80bba@redhat.com>
Date: Thu, 21 Jun 2018 06:40:25 -0500
MIME-Version: 1.0
In-Reply-To: <152955929417.819.6336496286507533586@d39dc562802a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/7] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

On 06/21/2018 12:34 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 

> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
> /tmp/qemu-test/src/nbd/server.c:1979:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>       *length = end - offset;
>                 ~~~~^~~~~~~~
> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>       uint64_t begin = offset, end;
>                                ^~~

This gcc is too stupid to see that end is always initialized:

> 
> +/*
> + * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
> + * final extent may exceed the original @length. Store in @length the
> + * byte length encoded (which may be smaller or larger than the
> + * original), and return the number of extents used.
> + */
> +static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
> +                                      uint64_t *length, NBDExtent *extents,
> +                                      unsigned int nb_extents,
> +                                      bool dont_fragment)
> +{
> +    uint64_t begin = offset, end;
> +    uint64_t overall_end = offset + *length;

On input, *length is a non-zero 32-bit number (gcc can't see that)...

> +    unsigned int i = 0;
> +    BdrvDirtyBitmapIter *it;
> +    bool dirty;
> +
> +    bdrv_dirty_bitmap_lock(bitmap);
> +
> +    it = bdrv_dirty_iter_new(bitmap);
> +    dirty = bdrv_get_dirty_locked(NULL, bitmap, offset);
> +
> +    while (begin < overall_end && i < nb_extents) {

...so this loop always iterates at least once...

> +        if (dirty) {
> +            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
> +        } else {
> +            bdrv_set_dirty_iter(it, begin);
> +            end = bdrv_dirty_iter_next(it);
> +        }

...and end is always initialized...

> +        if (end == -1) {
> +            /* Cap to an aligned value < 4G beyond begin. */
> +            end = MIN(bdrv_dirty_bitmap_size(bitmap),
> +                      begin + 0x100000000ULL -
> +                      bdrv_dirty_bitmap_granularity(bitmap));
> +        }
> +        if (dont_fragment && end > overall_end) {
> +            end = overall_end;
> +        }
> +
> +        extents[i].length = cpu_to_be32(end - begin);
> +        extents[i].flags = cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
> +        i++;
> +        begin = end;
> +        dirty = !dirty;
> +    }
> +
> +    bdrv_dirty_iter_free(it);
> +
> +    bdrv_dirty_bitmap_unlock(bitmap);
> +
> +    *length = end - offset;

...but gcc didn't know that.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
