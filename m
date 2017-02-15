Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdxd3-0000pX-Uq
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdxd3-0007mm-1C
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:20:09 -0500
References: <20170213181244.16297-1-pbonzini@redhat.com>
	<20170213181244.16297-7-pbonzini@redhat.com>
	<20170215092341.GC26331@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1effc0aa-c050-5f09-11f8-1e3f8ced5219@redhat.com>
Date: Wed, 15 Feb 2017 12:20:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170215092341.GC26331@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] coroutine-lock: make CoRwlock
 thread-safe and fair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org



On 15/02/2017 10:23, Fam Zheng wrote:
> On Mon, 02/13 19:12, Paolo Bonzini wrote:
>> This adds a CoMutex around the existing CoQueue.  Because the write-side
> 
> s/CoQueue/CoRwlock/

No, I meant that CoRwlock has a CoQueue, and after this patch it is
wrapped by a CoMutex too.


>> @@ -375,16 +384,20 @@ void qemu_co_rwlock_unlock(CoRwlock *lock)
>>              qemu_co_queue_next(&lock->queue);
>>          }
>>      }
>> -    self->locks_held--;
>> +    qemu_co_mutex_unlock(&lock->mutex);
>>  }
>>  
>>  void qemu_co_rwlock_wrlock(CoRwlock *lock)
>>  {
>> -    Coroutine *self = qemu_coroutine_self();
>> -
>> -    while (lock->writer || lock->reader) {
>> -        qemu_co_queue_wait(&lock->queue, NULL);
>> +    qemu_co_mutex_lock(&lock->mutex);
>> +    lock->pending_writer++;
>> +    while (lock->reader) {
>> +        qemu_co_queue_wait(&lock->queue, &lock->mutex);
>>      }
>> -    lock->writer = true;
>> -    self->locks_held++;
>> +    lock->pending_writer--;
>> +
>> +    /* The rest of the write-side critical section is run with
>> +     * the mutex taken, so that lock->reader remains zero.
>> +     * There is no need to update self->locks_held.
>> +     */
> 
> But is it still better to update self->locks_held anyway for the
> 'assert(!co->locks_held)' in qemu_coroutine_enter? Or is the same thing checked
> elsewhere?

self->locks_held is already incremented by the qemu_co_mutex_lock call
at the beginning of qemu_co_rwlock_wrlock.  It is then decremented in
qemu_co_rwlock_unlock.

For the read side, rdlock _unlocks_ lock->mutex before returning, so
self->locks_held must be incremented by rdlock and decremented by unlock.

Paolo
