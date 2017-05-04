Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6DRN-00026E-3j
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6DRM-0008GO-BU
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:52:53 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-14-pbonzini@redhat.com>
	<20170504073949.GA4725@lemon.lan>
	<6c794eeb-3128-80a8-a8c4-0573be9a643c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d84712c7-aef5-bea9-d0a2-1ffe397c6c57@redhat.com>
Date: Thu, 4 May 2017 11:52:41 +0200
MIME-Version: 1.0
In-Reply-To: <6c794eeb-3128-80a8-a8c4-0573be9a643c@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/17] coroutine-lock: introduce
 qemu_co_mutex_lock_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 11:47, Paolo Bonzini wrote:
> 
> 
> On 04/05/2017 09:39, Fam Zheng wrote:
>> On Thu, 04/20 14:00, Paolo Bonzini wrote:
>>> +    if (atomic_cmpxchg(&mutex->locked, waiters, waiters + 1) != waiters) {
>>
>> Is it still useful to try the fast path again if there are now even more
>> waiters, i.e.  "atomic_cmpxchg(...) > waiters"?
> 
> Probably not.

... but when this happens, we don't enter the fast path loop:

 retry_fast_path:
    waiters = atomic_read(&mutex->locked);
    if (waiters == 0) {
        /* Provide same memory ordering semantics as mutex lock/unlock.  */
        smp_mb_acquire();
        smp_mb_release();
        return;
    }

    i = 0;
    while (waiters == 1 && ++i < 1000) {
        if (atomic_read(&mutex->ctx) == ctx) {
            break;
        }
        waiters = atomic_read(&mutex->locked);
        if (waiters == 0) {
            smp_mb_acquire();
            smp_mb_release();
            return;
        }
        cpu_relax();
    }

    if (atomic_cmpxchg(&mutex->locked, waiters, waiters + 1) != waiters) {
        goto retry_fast_path;
    }

    qemu_co_mutex_lock_slowpath(ctx, mutex);
    qemu_co_mutex_unlock(mutex);

The "if (waiters == 0)" fails, and the "while (waiters == 1 && ...)" won't
happen either if atomic_cmpxchg returns > 1.  So really what you get is
a retry of the atomic_cmpxchg.

We should introduce atomic_try_cmpxchg.  Linux added it recently, too,
and it simplifies the code because you don't need to redo the atomic_read.
Like this:

    waiters = atomic_read(&mutex->locked);
 retry_fast_path:
    if (waiters == 0) {
        ...
    }
    i = 0;
    while (waiters == 1 && ++i < 1000) {
        ...
    }
    if (!atomic_cmpxchg(&mutex->locked, &waiters, waiters + 1)) {
        goto retry_fast_path;
    }

    qemu_co_mutex_lock_slowpath(ctx, mutex);
    qemu_co_mutex_unlock(mutex);


Paolo


> Paolo
> 
>>> +        goto retry_fast_path;
>>> +    }
>>> +
>>> +    qemu_co_mutex_lock_slowpath(ctx, mutex);
>>> +    qemu_co_mutex_unlock(mutex);
>>> +}
>>> +
>>>  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
>>>  {
>>>      Coroutine *self = qemu_coroutine_self();
>>> -- 
>>> 2.9.3
>>>
>>>
>>>
> 
> 
