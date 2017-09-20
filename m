Received: from eggs.gnu.org ([2001:4830:134:3::10]:43277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDJ-0004Hg-2p
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDD-0002gQ-4v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170920101740.12490-1-stefanha@redhat.com>
References: <20170920101740.12490-1-stefanha@redhat.com>
Date: Wed, 20 Sep 2017 13:08:52 +0200
Message-ID: <w51fubh1vaz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] throttle-groups: update
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

On Wed 20 Sep 2017 12:17:40 PM CEST, Stefan Hajnoczi wrote:
> @@ -592,6 +592,17 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
>  {
>      ThrottleTimers *tt = &tgm->throttle_timers;
> +    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
> +
> +    qemu_mutex_lock(&tg->lock);
> +    if (timer_pending(tt->timers[0])) {
> +        tg->any_timer_armed[0] = false;
> +    }
> +    if (timer_pending(tt->timers[1])) {
> +        tg->any_timer_armed[1] = false;
> +    }
> +    qemu_mutex_unlock(&tg->lock);
> +
>      throttle_timers_detach_aio_context(tt);
>      tgm->aio_context = NULL;
>  }

I'm sorry that I didn't noticed this in my previous e-mail, but after
this call you might have destroyed the timer that was set for that
throttling group, so if there are pending requests waiting it can happen
that no one wakes them up.

I think that the queue needs to be restarted after this, probably after
having reattached the context (or actually after detaching it already,
but then what happens if you try to restart the queue while aio_context
is NULL?).

Berto
