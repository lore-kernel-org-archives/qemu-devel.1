Received: from eggs.gnu.org ([2001:4830:134:3::10]:39803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eGoj0-0001Kj-2i
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eGoiu-0002Km-7z
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:15:10 -0500
References: <20171120145006.551-1-kwolf@redhat.com>
	<20171120145006.551-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <062bb311-ec52-b91e-70c2-97598b35ff8a@virtuozzo.com>
Date: Mon, 20 Nov 2017 19:14:57 +0300
MIME-Version: 1.0
In-Reply-To: <20171120145006.551-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/3] block: Add errp to
 bdrv_all_goto_snapshot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org, qemu-devel@nongnu.org

20.11.2017 17:50, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/snapshot.h |  3 ++-
>   block/snapshot.c         | 11 ++++++-----
>   migration/savevm.c       |  6 +++---
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/block/snapshot.h b/include/block/snapshot.h
> index aeb80405e8..9407799941 100644
> --- a/include/block/snapshot.h
> +++ b/include/block/snapshot.h
> @@ -84,7 +84,8 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
>   bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
>   int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
>                                Error **err);
> -int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bsd_bs);
> +int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
> +                           Error **errp);
>   int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs);
>   int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
>                                BlockDriverState *vm_state_bs,
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 9c941e638d..13ec3b1c8c 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -467,9 +467,10 @@ fail:
>   }
>   
>   
> -int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
> +int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
> +                           Error **errp)
>   {
> -    int err = 0;
> +    int ret = 0;
>       BlockDriverState *bs;
>       BdrvNextIterator it;
>   
> @@ -478,10 +479,10 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
>   
>           aio_context_acquire(ctx);
>           if (bdrv_can_snapshot(bs)) {
> -            err = bdrv_snapshot_goto(bs, name, NULL);
> +            ret = bdrv_snapshot_goto(bs, name, errp);
>           }
>           aio_context_release(ctx);
> -        if (err < 0) {
> +        if (ret < 0) {
>               bdrv_next_cleanup(&it);
>               goto fail;
>           }
> @@ -489,7 +490,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
>   
>   fail:
>       *first_bad_bs = bs;
> -    return err;
> +    return ret;
>   }
>   
>   int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a88228614..192f2d82cd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2346,10 +2346,10 @@ int load_snapshot(const char *name, Error **errp)
>       /* Flush all IO requests so they don't interfere with the new state.  */
>       bdrv_drain_all_begin();
>   
> -    ret = bdrv_all_goto_snapshot(name, &bs);
> +    ret = bdrv_all_goto_snapshot(name, &bs, errp);
>       if (ret < 0) {
> -        error_setg(errp, "Error %d while activating snapshot '%s' on '%s'",
> -                     ret, name, bdrv_get_device_name(bs));
> +        error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
> +                      name, bdrv_get_device_name(bs));

possible resulting msg: "Could not load snapshot 'snap0' on 'dev0': 
Failed to load snapshot". a bit weird. with this fixed or not:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>           goto err_drain;
>       }
>   


-- 
Best regards,
Vladimir
