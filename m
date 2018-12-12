Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX9iP-0007Py-An
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX9iO-0003Wu-FC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:58:37 -0500
References: <1544532681-53370-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <445d8c4a-0e07-7ab8-f7b2-f065cf67d751@redhat.com>
Date: Wed, 12 Dec 2018 12:58:26 -0600
MIME-Version: 1.0
In-Reply-To: <1544532681-53370-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] qemu-img info lists bitmap directory
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
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 12/11/18 6:51 AM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
> 
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>      compat: 1.1
>      lazy refcounts: true
>      bitmaps:
>          [0]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: back-up1
>              unknown flags: 4
>              granularity: 65536
>          [1]:
>              flags:
>                  [0]: in-use
>                  [1]: auto
>              name: back-up2
>              unknown flags: 8
>              granularity: 65536
>      refcount bits: 16
>      corrupt: false
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---


> +
> +Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
> +                                                Error **errp)
> +{

Might be worth a function comment that this returns NULL...

> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm;
> +    Qcow2BitmapInfoList *list = NULL;
> +    Qcow2BitmapInfoList **plist = &list;
> +
> +    if (s->nb_bitmaps == 0) {
> +        return NULL;
> +    }

...both when errp is clear (for a 0-length list in the QMP),

> +
> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list == NULL) {
> +        return NULL;
> +    }

...and when errp is set (for a problem in obtaining the information, for 
omitting the list in QMP).

> +++ b/block/qcow2.c
> @@ -4270,6 +4270,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>               .refcount_bits      = s->refcount_bits,
>           };
>       } else if (s->qcow_version == 3) {
> +        Qcow2BitmapInfoList *bitmaps;
> +        Error *local_err = NULL;
> +
> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
>           *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
>               .compat             = g_strdup("1.1"),
>               .lazy_refcounts     = s->compatible_features &
> @@ -4279,7 +4283,12 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>                                     QCOW2_INCOMPAT_CORRUPT,
>               .has_corrupt        = true,
>               .refcount_bits      = s->refcount_bits,
> +            .has_bitmaps        = !local_err,
> +            .bitmaps            = bitmaps,
>           };
> +        /* TODO: Report the Error up to the caller when
> +         * an error propagation algorithm is implemented */
> +        error_free(local_err);

Otherwise, this works for me.  Up to John if he wants to add a comment 
as part of staging this, or require a v7, but either way, I'm happy with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
