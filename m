Received: from eggs.gnu.org ([208.118.235.92]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gfQwc-0004qQ-4i
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gfQwW-0003bt-OY
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:59:29 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9c2119e3-d471-a770-852b-04d2103a40d4@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
	<20181211164317.32893-5-vsementsov@virtuozzo.com>
	<af0ed3b1-bb0e-3575-0e3a-7097cd75b621@redhat.com>
	<9c2119e3-d471-a770-852b-04d2103a40d4@virtuozzo.com>
Date: Fri, 04 Jan 2019 15:59:03 +0100
Message-ID: <w51tvio5v0o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/8] qcow2-threads: split out generic
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Fri 14 Dec 2018 09:51:12 AM CET, Vladimir Sementsov-Ogievskiy wrote:
> 14.12.2018 2:28, Paolo Bonzini wrote:
>> On 11/12/18 17:43, Vladimir Sementsov-Ogievskiy wrote:
>>> +    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
>>> +
>>> +    while (s->nb_threads >= QCOW2_MAX_THREADS) {
>>> +        qemu_co_queue_wait(&s->thread_task_queue, NULL);
>>> +    }
>>> +
>>> +    s->nb_threads++;
>>> +    ret = thread_pool_submit_co(pool, func, arg);
>>> +    s->nb_threads--;
>>> +
>>> +    qemu_co_queue_next(&s->thread_task_queue);
>> 
>> What lock is protecting this manipulation?  I'd rather avoid adding more
>> users of the AioContext lock, especially manipulation of CoQueues.
>> 
>> One possibility is to do the s->lock unlock/lock here, and then also
>> rely on that in patch 8.
>
> Hm, can you please give more details? It's refactoring commit, so, do
> you mean that there is an existing bug?

I think there's an existing problem but not a currently reproducible bug
as such: accesses to the qcow2 BlockDriverState are protected by the
same AioContext lock, but as soon as you want to implement multiqueue
you'll have multiple iothreads (and contexts) accessing the same BDS.

For that to work you need that the in-memory qcow2 metadata is properly
locked, and that's what s->lock is for. However this CoQueue here is not
protected by any lock (s->lock is taken _after_ the data is compressed
in qcow2_co_pwritev_compressed()).

And I think that's it in a nutshell, Paolo correct me if I'm wrong.

Berto
