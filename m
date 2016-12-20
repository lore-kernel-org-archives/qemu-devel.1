Received: from eggs.gnu.org ([2001:4830:134:3::10]:43423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cJJjL-0008JX-UF
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 07:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cJJjK-0003Fd-Qc
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 07:41:19 -0500
Message-ID: <585926E7.2020006@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 20:41:11 +0800
From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1480926904-17596-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/6] replication: Split out
 backup_do_checkpoint() from secondary_do_checkpoint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com

On 12/05/2016 04:35 PM, zhanghailiang wrote:
> The helper backup_do_checkpoint() will be used for primary related
> codes. Here we split it out from secondary_do_checkpoint().
>
> Besides, it is unnecessary to call backup_do_checkpoint() in
> replication starting and normally stop replication path.
> We only need call it while do real checkpointing.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   block/replication.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/block/replication.c b/block/replication.c
> index e87ae87..35e9ab3 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -332,20 +332,8 @@ static bool replication_recurse_is_first_non_filter(BlockDriverState *bs,
>
>   static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
>   {
> -    Error *local_err = NULL;
>       int ret;
>
> -    if (!s->secondary_disk->bs->job) {
> -        error_setg(errp, "Backup job was cancelled unexpectedly");
> -        return;
> -    }
> -
> -    backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>       ret = s->active_disk->bs->drv->bdrv_make_empty(s->active_disk->bs);
>       if (ret < 0) {
>           error_setg(errp, "Cannot make active disk empty");
> @@ -558,6 +546,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
>               return;
>           }
>           block_job_start(job);
> +
> +        secondary_do_checkpoint(s, errp);
>           break;
>       default:
>           aio_context_release(aio_context);
> @@ -566,10 +556,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
>
>       s->replication_state = BLOCK_REPLICATION_RUNNING;
>
> -    if (s->mode == REPLICATION_MODE_SECONDARY) {
> -        secondary_do_checkpoint(s, errp);
> -    }
> -
>       s->error = 0;
>       aio_context_release(aio_context);
>   }
> @@ -579,13 +565,29 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
>       BlockDriverState *bs = rs->opaque;
>       BDRVReplicationState *s;
>       AioContext *aio_context;
> +    Error *local_err = NULL;
>
>       aio_context = bdrv_get_aio_context(bs);
>       aio_context_acquire(aio_context);
>       s = bs->opaque;
>
> -    if (s->mode == REPLICATION_MODE_SECONDARY) {
> +    switch (s->mode) {
> +    case REPLICATION_MODE_PRIMARY:
> +        break;
> +    case REPLICATION_MODE_SECONDARY:
> +        if (!s->secondary_disk->bs->job) {
> +            error_setg(errp, "Backup job was cancelled unexpectedly");
> +            break;
> +        }
> +        backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            break;
> +        }
>           secondary_do_checkpoint(s, errp);
> +        break;
> +    default:
> +        abort();
>       }
>       aio_context_release(aio_context);
>   }
>

Looks good to me

Reviewed-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
