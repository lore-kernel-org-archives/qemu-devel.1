Received: from eggs.gnu.org ([2001:4830:134:3::10]:41019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRm6N-0003zC-Q2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 17:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRm6M-0002vQ-Tb
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 17:45:07 -0500
References: <1543322466-525229-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f0a48b9-f735-4b70-6ebf-d83f4da90736@redhat.com>
Date: Tue, 27 Nov 2018 16:44:58 -0600
MIME-Version: 1.0
In-Reply-To: <1543322466-525229-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 11/27/18 6:41 AM, Andrey Shinkevich wrote:
> The 'Format specific information' of qemu-img info command will show
> the name, flags and granularity for every QCOW2 bitmap.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> Dear colleagues,
> 
> With this patch, qemu-img info will display a name, flags and granularity
> information for every bitmap in the directory section of a QCOW2 image.
> That information appears in the 'Format specific information' section as
> it's shown in the following example:
> 
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>      compat: 1.1
>      lazy refcounts: true
>      refcount bits: 16
>      dirty bitmaps:
>          [0]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: {257b5ea5-38c5-410e-a457-71c76f763c60}
>              granularity: 65536
>          [1]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: back-up
>              granularity: 65536
>      corrupt: false

This example is worth including in the commit message proper (by putting 
it above the Signed-off-by and --- lines).

In addition to Vladimir's review (he's correct about using 4.0),

> +++ b/block/qcow2-bitmap.c
> @@ -1008,6 +1008,56 @@ fail:
>       return false;
>   }
>   
> +static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
> +{
> +    Qcow2BitmapInfoFlagsList *list = NULL;
> +    Qcow2BitmapInfoFlagsList **plist = &list;
> +
> +    if (flags & BME_FLAG_IN_USE) {
> +        Qcow2BitmapInfoFlagsList *entry = g_new0(Qcow2BitmapInfoFlagsList, 1);
> +        entry->value = QCOW2_BITMAP_INFO_FLAGS_IN_USE;
> +        *plist = entry;
> +        plist = &entry->next;
> +    }
> +    if (flags & BME_FLAG_AUTO) {
> +        Qcow2BitmapInfoFlagsList *entry = g_new0(Qcow2BitmapInfoFlagsList, 1);
> +        entry->value = QCOW2_BITMAP_INFO_FLAGS_AUTO;
> +        *plist = entry;
> +    }
> +    return list;
> +}

This implementation means that qemu won't report bits that are set but 
which qemu doesn't recognize.  Is that a problem?  I wouldn't 
over-engineer it unless we have a use case, but maybe one way would be 
to have an optional integer field alongside the array of known flags, 
where the integer is present only if there are unrecognized flags 
present.  But by the time we encounter an image with more than the two 
flags we currently recognize, we may have also patched this code to 
recognize a new flag.

> @@ -4279,6 +4287,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>                                     QCOW2_INCOMPAT_CORRUPT,
>               .has_corrupt        = true,
>               .refcount_bits      = s->refcount_bits,
> +            .has_bitmaps        = bitmaps ? true : false,

This looks awkward; I'd write it ' = !!bitmaps'.


> +++ b/qapi/block-core.json
> @@ -77,7 +77,8 @@
>         '*lazy-refcounts': 'bool',
>         '*corrupt': 'bool',
>         'refcount-bits': 'int',
> -      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
> +      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> +      '*bitmaps': ['Qcow2BitmapInfo']

Missing documentation on the new member, including a '(since 4.0)' tag.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
