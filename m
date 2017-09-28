Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dxgUY-0002GY-3x
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 17:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dxgUT-0004jt-6A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 17:37:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170925135735.25076-1-stefanha@redhat.com>
References: <20170925135735.25076-1-stefanha@redhat.com>
Date: Thu, 28 Sep 2017 23:36:26 +0200
Message-ID: <w51ing2v739.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] throttle-groups: cancel timers on
 restart
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>
List-ID: <qemu-devel.nongnu.org>

On Mon 25 Sep 2017 03:57:35 PM CEST, Stefan Hajnoczi <stefanha@redhat.com> wrote:

Hey Stefan,

sorry for the late reply but I've been looking a this for a while trying
to understand it.

> v3:
>  * Different approach this time, based on Berto's insight that another
>    TGM may need to be scheduled now that our TGM's timers have been
>    detached.
>
>    I realized the problem isn't the detach operation, it's the restart
>    operation that runs before detach.  Timers shouldn't be left active
>    across restart.

I'm not sure if I follow this paragraph, why is the problem in the
restart operation? I may have overlooked something after all the recent
changes in the throttling code, but the original point of restart was to
ensure that -after e.g. destroying and creating a new set of timers for
a drive- at least one throttled request would wake up so all I/O could
continue normally.

Restart itself doesn't care about timers in the ThrottleGroupMember, it
just takes a coroutine from the queue and restarts it. If there would be
already a timer set in the same tgm it wouldn't cause any trouble, after
all the timer callback simply restarts the queue.

>  void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
>  {
>      if (tgm->throttle_state) {
> +        ThrottleState *ts = tgm->throttle_state;
> +        ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
> +        ThrottleTimers *tt = &tgm->throttle_timers;
> +
> +        /* Cancel pending timers */
> +        qemu_mutex_lock(&tg->lock);
> +        if (timer_pending(tt->timers[0])) {
> +            timer_del(tt->timers[0]);
> +            tg->any_timer_armed[0] = false;
> +        }
> +        if (timer_pending(tt->timers[1])) {
> +            timer_del(tt->timers[1]);
> +            tg->any_timer_armed[1] = false;
> +        }
> +        qemu_mutex_unlock(&tg->lock);
> +
> +        /* This also schedules the next request in other TGMs, if necessary */
>          throttle_group_restart_queue(tgm, 0);
>          throttle_group_restart_queue(tgm, 1);
>      }

I think if you cancel the timers _after_ throttle_group_restart_queue()
it would work just the same, because as I said earlier that function
doesn't touch tgm->throttle_timers.

And if you cancel the timers after throttle_group_restart_queue() then
you get something similar to what you had in patch v2 (minus the
bdrv_drained_begin/end calls).

Berto
