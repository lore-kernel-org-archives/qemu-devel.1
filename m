Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6DMD-0006PC-O6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6DMD-0004x1-1E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:47:33 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-14-pbonzini@redhat.com>
	<20170504073949.GA4725@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c794eeb-3128-80a8-a8c4-0573be9a643c@redhat.com>
Date: Thu, 4 May 2017 11:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170504073949.GA4725@lemon.lan>
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



On 04/05/2017 09:39, Fam Zheng wrote:
> On Thu, 04/20 14:00, Paolo Bonzini wrote:
>> +    if (atomic_cmpxchg(&mutex->locked, waiters, waiters + 1) != waiters) {
> 
> Is it still useful to try the fast path again if there are now even more
> waiters, i.e.  "atomic_cmpxchg(...) > waiters"?

Probably not.

Paolo

>> +        goto retry_fast_path;
>> +    }
>> +
>> +    qemu_co_mutex_lock_slowpath(ctx, mutex);
>> +    qemu_co_mutex_unlock(mutex);
>> +}
>> +
>>  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
>>  {
>>      Coroutine *self = qemu_coroutine_self();
>> -- 
>> 2.9.3
>>
>>
>>
