Received: from eggs.gnu.org ([2001:4830:134:3::10]:38373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMKks-0001P0-J8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMKkr-0004ZW-Kq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:32:26 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8022d6f6-46b7-cc9d-fafc-6f1c95bbd45b@redhat.com>
Date: Mon, 12 Nov 2018 16:32:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/11] block: Storage child access
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 8/9/18 5:31 PM, Max Reitz wrote:
> For completeness' sake, add a function for accessing a node's storage
> child, too.  For filters, this is there filtered child; for non-filters,

s/there/their/

> this is bs->file.
> 
> Some places are deliberately left unconverted:
> - BDS opening/closing functions where bs->file is handled specially
>    (which is basically wrong, but at least simplifies probing)
> - bdrv_co_block_status_from_file(), because its name implies that it
>    points to ->file

I'm wondering if we can clean up block_status to let filters have a NULL 
callback and io.c do the right thing automatically, rather than the 
current approach of filters assigning the callback to the common helper 
routine.  Maybe later in the series.

> - bdrv_snapshot_goto() in one places unrefs bs->file.  Such a

s/places/place/

>    modification is not covered by this patch and is therefore just
>    safeguarded by an additional assert(), but otherwise kept as-is.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/block/snapshot.c

> @@ -204,37 +207,38 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>           return ret;
>       }
>   
> -    if (bs->file) {
> -        BlockDriverState *file;
> +    storage_bs = bdrv_storage_bs(bs);
> +    if (storage_bs) {
>           QDict *options = qdict_clone_shallow(bs->options);
>           QDict *file_options;
>           Error *local_err = NULL;
>   
> -        file = bs->file->bs;
>           /* Prevent it from getting deleted when detached from bs */
> -        bdrv_ref(file);
> +        bdrv_ref(storage_bs);
>   
>           qdict_extract_subqdict(options, &file_options, "file.");
>           qobject_unref(file_options);
> -        qdict_put_str(options, "file", bdrv_get_node_name(file));
> +        qdict_put_str(options, "file", bdrv_get_node_name(storage_bs));
>   
>           drv->bdrv_close(bs);
> +
> +        assert(bs->file->bs == storage_bs);

At first glance, this assertion...

>           bdrv_unref_child(bs, bs->file);
>           bs->file = NULL;
>   
> -        ret = bdrv_snapshot_goto(file, snapshot_id, errp);
> +        ret = bdrv_snapshot_goto(storage_bs, snapshot_id, errp);
>           open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
>           qobject_unref(options);
>           if (open_ret < 0) {
> -            bdrv_unref(file);
> +            bdrv_unref(storage_bs);
>               bs->drv = NULL;
>               /* A bdrv_snapshot_goto() error takes precedence */
>               error_propagate(errp, local_err);
>               return ret < 0 ? ret : open_ret;
>           }
>   
> -        assert(bs->file->bs == file);
> -        bdrv_unref(file);
> +        assert(bs->file->bs == storage_bs);

...looks like a duplicate of this one. But looking closer, I see 
bs->file = NULL followed by drv->bdrv_open() in between which should 
reassign bs->file, so having the assertion on both ends makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
