Received: from eggs.gnu.org ([2001:4830:134:3::10]:40683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYwyI-0001uu-7J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYwyG-0007Yt-Vb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:14:10 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e2a17a5-ed8d-42d0-dba9-b7e6c4580643@redhat.com>
Date: Fri, 29 Jun 2018 12:13:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180629151524.138542-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] blockdev-backup: enable non-root
 nodes for backup source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org

On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is needed to implement image-fleecing scheme, when we create
> a temporary node, mark our active node to be backing for the temp,
> and start backup(sync=none) from active node to the temp node.
> Temp node then represents a kind of snapshot and may be used
> for external backup through NBD.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   blockdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 58d7570932..72f5347df5 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1859,7 +1859,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
>       assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
>       backup = common->action->u.blockdev_backup.data;
>   
> -    bs = qmp_get_root_bs(backup->device, errp);
> +    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
>       if (!bs) {
>           return;
>       }

This hunk is new,

> @@ -3517,7 +3517,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
>           backup->compress = false;
>       }
>   
> -    bs = qmp_get_root_bs(backup->device, errp);
> +    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
>       if (!bs) {
>           return NULL;
>       }
> 

but this hunk is identical to John's patch:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08593.html

I guess yours adds additional code needed to work under a transaction, 
as opposed to separate QMP commands.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
