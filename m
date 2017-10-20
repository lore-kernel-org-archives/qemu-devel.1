Received: from eggs.gnu.org ([2001:4830:134:3::10]:56877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e5Vis-0007Cy-0P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e5Vir-0006QK-7A
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:44:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1385265352-40801-1-git-send-email-sochin.jiang@huawei.com>
References: <1385265352-40801-1-git-send-email-sochin.jiang@huawei.com>
Date: Fri, 20 Oct 2017 13:43:25 +0200
Message-ID: <w51fuaenixu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle: fix a qemu crash
 problem when calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org

On Sun 24 Nov 2013 04:55:52 AM CET, sochin.jiang wrote:
       ^^^^^^^^^^^
I guess the date in your computer is wrong :-)

> commit 7ca7f0 moves the throttling related part of the BDS life cycle
> management to BlockBackend, adds call to
> throttle_timers_detach_aio_context in blk_remove_bs.  commit 1606e
> remove a block device from its throttle group in blk_delete by calling
> blk_io_limits_disable, this fix an easily reproducible qemu crash. But
> delete a BB without a BDS inserted could easily cause a qemu crash too
> by calling bdrv_drained_begin in blk_io_limits_disable. Say, a simply
> drive_add and then a drive_del command.

Thanks, I can reproduce this easily by running QEMU and doing

   drive_add 0 if=none,throttling.iops-total=5000

followed by

   drive_del none0

>  void bdrv_drained_begin(BlockDriverState *bs)
>  {
> +    if (!bs) {
> +        return;
> +    }
> +
>      if (qemu_in_coroutine()) {
>          bdrv_co_yield_to_drain(bs, true);
>          return;
> @@ -284,6 +288,10 @@ void bdrv_drained_begin(BlockDriverState *bs)
>  
>  void bdrv_drained_end(BlockDriverState *bs)
>  {
> +    if (!bs) {
> +        return;
> +    }
> +

I'd say that if someone calls bdrv_drained_begin() with a NULL pointer
then the problem is in the caller...

>  static void throttle_timer_destroy(QEMUTimer **timer)
>  {
> -    assert(*timer != NULL);
> -
>      timer_del(*timer);
>      timer_free(*timer);
>      *timer = NULL;
> @@ -258,7 +256,9 @@ void throttle_timers_detach_aio_context(ThrottleTimers *tt)
>      int i;
>  
>      for (i = 0; i < 2; i++) {
> -        throttle_timer_destroy(&tt->timers[i]);
> +        if (tt->timers[i]) {
> +            throttle_timer_destroy(&tt->timers[i]);
> +        }
>      }
>  }

Why is this part necessary? In what situation you end up calling
throttle_timers_detach_aio_context() twice?

Berto
