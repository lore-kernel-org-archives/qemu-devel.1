Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIZqX-0005CM-Qg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIZqX-00078l-2N
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:13:57 -0400
Date: Wed, 7 Jun 2017 20:13:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170607121347.GD4314@lemon.lan>
References: <20170524025235.32190-1-famz@redhat.com>
	<20170524025235.32190-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524025235.32190-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 05/24 10:52, Fam Zheng wrote:
> What's done in the source's context change notifier is moving the
> target's context to follow the new one, so we request this permission
> here.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/backup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index a4fb288..546c5c5 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -636,7 +636,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>      }
>  
>      /* The target must match the source in size, so no resize here either */
> -    job->target = blk_new(BLK_PERM_WRITE,
> +    job->target = blk_new(BLK_PERM_WRITE | BLK_PERM_AIO_CONTEXT_CHANGE,
>                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
>                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
>      ret = blk_insert_bs(job->target, target, errp);

Since fc0932fdc we reuse @bs as the backing of @target if sync=none, and this
hunk causes problem: the device's BB probably doesn't permit
BLK_PERM_AIO_CONTEXT_CHANGE.

Still scratching my head on this.

Fam
