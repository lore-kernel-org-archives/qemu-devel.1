Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD8hB-0003uO-0X
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eD8hA-0004wz-5U
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:46:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
References: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
Date: Fri, 10 Nov 2017 13:45:15 +0100
Message-ID: <w51zi7uti90.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: all I/O should be
 completed before removing throttle timers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui Li <lizhengui@huawei.com>, kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com
Cc: lina.lulina@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com

On Sat 21 Oct 2017 07:34:00 AM CEST, Zhengui Li wrote:
> From: Zhengui <lizhengui@huawei.com>
>
> In blk_remove_bs, all I/O should be completed before removing throttle
> timers. If there has inflight I/O, removing throttle timers here will
> cause the inflight I/O never return.
> This patch add bdrv_drained_begin before throttle_timers_detach_aio_context
> to let all I/O completed before removing throttle timers.
>
> Signed-off-by: Zhengui <lizhengui@huawei.com>
> ---
>  block/block-backend.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 45d9101..9edc452 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -660,7 +660,11 @@ void blk_remove_bs(BlockBackend *blk)
>      notifier_list_notify(&blk->remove_bs_notifiers, blk);
>      if (blk->public.throttle_group_member.throttle_state) {
>          tt = &blk->public.throttle_group_member.throttle_timers;
> +        BlockDriverState *bs;
> +        bs = blk_bs(blk);
> +        bdrv_drained_begin(bs);
>          throttle_timers_detach_aio_context(tt);
> +        bdrv_drained_end(bs);

You can keep my R-b, but seeing this in context I think you should
define BlockDriverState either at the beginning of the block or together
with ThrottleTimers at the beginning of the function.

Berto
