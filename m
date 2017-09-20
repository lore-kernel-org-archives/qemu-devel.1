Received: from eggs.gnu.org ([2001:4830:134:3::10]:43328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDL-0004KK-N9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDK-0002m6-GC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:55 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170920113902.ljcsl3y5c6kvo4eq@postretch>
References: <20170920101740.12490-1-stefanha@redhat.com>
	<w51fubh1vaz.fsf@maestria.local.igalia.com>
	<20170920113902.ljcsl3y5c6kvo4eq@postretch>
Date: Wed, 20 Sep 2017 14:17:51 +0200
Message-ID: <w51d16l1s40.fsf@maestria.local.igalia.com>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Wed 20 Sep 2017 01:39:02 PM CEST, Manos Pitsidianakis wrote:
>>>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
>>>  {
>>>      ThrottleTimers *tt = &tgm->throttle_timers;
>>> +    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
>>> +
>>> +    qemu_mutex_lock(&tg->lock);
>>> +    if (timer_pending(tt->timers[0])) {
>>> +        tg->any_timer_armed[0] = false;
>>> +    }
>>> +    if (timer_pending(tt->timers[1])) {
>>> +        tg->any_timer_armed[1] = false;
>>> +    }
>>> +    qemu_mutex_unlock(&tg->lock);
>>> +
>>>      throttle_timers_detach_aio_context(tt);
>>>      tgm->aio_context = NULL;
>>>  }
>>
>>I'm sorry that I didn't noticed this in my previous e-mail, but after
>>this call you might have destroyed the timer that was set for that
>>throttling group, so if there are pending requests waiting it can
>>happen that no one wakes them up.
>>
>>I think that the queue needs to be restarted after this, probably
>>after having reattached the context (or actually after detaching it
>>already, but then what happens if you try to restart the queue while
>>aio_context is NULL?).
>
> aio_co_enter in the restart queue function requires that aio_context
> is non-NULL. Perhaps calling throttle_group_restart_tgm in
> throttle_group_attach_aio_context will suffice.

But can we guarantee that everything is safe between the _detach() and
_attach() calls?

Berto
