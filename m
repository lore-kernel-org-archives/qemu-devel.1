Received: from eggs.gnu.org ([2001:4830:134:3::10]:52232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dua1s-0000co-G4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dua1p-000225-5W
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:06:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170919155025.4098-1-stefanha@redhat.com>
References: <20170919155025.4098-1-stefanha@redhat.com>
Date: Wed, 20 Sep 2017 10:06:35 +0200
Message-ID: <w51mv5p23qs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

On Tue 19 Sep 2017 05:50:25 PM CEST, Stefan Hajnoczi wrote:
> Clear tg->any_timer_armed[] when throttling timers are destroy during
> AioContext attach/detach.  Failure to do so causes throttling to hang
> because we believe the timer is already scheduled!
>
> The following was broken at least since QEMU 2.10.0 with -drive
> iops=100:
>
>   $ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>
> Reported-by: Yongxue Hong <yhong@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/throttle-groups.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 6ba992c8d7..2bfd03faa0 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -592,7 +592,20 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
>  {
>      ThrottleTimers *tt = &tgm->throttle_timers;
> +    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
> +
>      throttle_timers_detach_aio_context(tt);
> +
> +    /* Forget about these timers, they have been destroyed */
> +    qemu_mutex_lock(&tg->lock);
> +    if (tg->tokens[0] == tgm) {
> +        tg->any_timer_armed[0] = false;
> +    }
> +    if (tg->tokens[1] == tgm) {
> +        tg->any_timer_armed[1] = false;
> +    }
> +    qemu_mutex_unlock(&tg->lock);

I think I'd rather check the timers directly using timer_pending().

See https://github.com/qemu/qemu/blob/dbe824cc5/block/throttle-groups.c#L426

Berto
