Received: from eggs.gnu.org ([209.51.188.92]:48572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h2G3E-0006aP-Om
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h2G39-00059t-Db
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:00:40 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Fri, 08 Mar 2019 15:00:09 +0100
Message-ID: <w51va0to49i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] block-stream: include base into job
 node list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Thu 21 Feb 2019 04:26:39 PM CET, Andrey Shinkevich wrote:
> The block-stream job needs to own the base node as the limiter
> of the copy-on-read operation. So, the base node is included in
> the job node list (block_job_add_bdrv).
> Also, the block-stream job would not allow the base node to go
> away due to the graph modification, e.g. when a filter node is
> inserted between the bottom node and the base node.
> For that reason, the flag BLK_PERM_GRAPH_MOD is unset in the
> shared permission bit mask of the base node.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/block/stream.c b/block/stream.c
> index 7a49ac0..c8f93d4 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -259,6 +259,15 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>                             &error_abort);
>      }
>  
> +    if (base) {
> +        /*
> +         * The base node should not disappear during the job.
> +         */
> +        block_job_add_bdrv(&s->common, "base", base, 0,
> +                           BLK_PERM_ALL & ~BLK_PERM_GRAPH_MOD,
> +                           &error_abort);

I'm not sure if I understand the ~BLK_PERM_GRAPH_MOD bit, what's the
consequence of not removing that permission?

Berto
