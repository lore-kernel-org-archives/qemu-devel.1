Received: from eggs.gnu.org ([2001:4830:134:3::10]:47013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdxtg-00077t-Uu
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdxtg-0007RX-2s
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:37:20 -0500
Date: Wed, 15 Feb 2017 19:37:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170215113711.GB1134@lemon.lan>
References: <20170213181244.16297-1-pbonzini@redhat.com>
	<20170213181244.16297-7-pbonzini@redhat.com>
	<20170215092341.GC26331@lemon.lan>
	<1effc0aa-c050-5f09-11f8-1e3f8ced5219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1effc0aa-c050-5f09-11f8-1e3f8ced5219@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 02/15 12:20, Paolo Bonzini wrote:
> 
> 
> On 15/02/2017 10:23, Fam Zheng wrote:
> > On Mon, 02/13 19:12, Paolo Bonzini wrote:
> >> This adds a CoMutex around the existing CoQueue.  Because the write-side
> > 
> > s/CoQueue/CoRwlock/
> 
> No, I meant that CoRwlock has a CoQueue, and after this patch it is
> wrapped by a CoMutex too.

OK.

> 
> 
> >> @@ -375,16 +384,20 @@ void qemu_co_rwlock_unlock(CoRwlock *lock)
> >>              qemu_co_queue_next(&lock->queue);
> >>          }
> >>      }
> >> -    self->locks_held--;
> >> +    qemu_co_mutex_unlock(&lock->mutex);
> >>  }
> >>  
> >>  void qemu_co_rwlock_wrlock(CoRwlock *lock)
> >>  {
> >> -    Coroutine *self = qemu_coroutine_self();
> >> -
> >> -    while (lock->writer || lock->reader) {
> >> -        qemu_co_queue_wait(&lock->queue, NULL);
> >> +    qemu_co_mutex_lock(&lock->mutex);
> >> +    lock->pending_writer++;
> >> +    while (lock->reader) {
> >> +        qemu_co_queue_wait(&lock->queue, &lock->mutex);
> >>      }
> >> -    lock->writer = true;
> >> -    self->locks_held++;
> >> +    lock->pending_writer--;
> >> +
> >> +    /* The rest of the write-side critical section is run with
> >> +     * the mutex taken, so that lock->reader remains zero.
> >> +     * There is no need to update self->locks_held.
> >> +     */
> > 
> > But is it still better to update self->locks_held anyway for the
> > 'assert(!co->locks_held)' in qemu_coroutine_enter? Or is the same thing checked
> > elsewhere?
> 
> self->locks_held is already incremented by the qemu_co_mutex_lock call
> at the beginning of qemu_co_rwlock_wrlock.  It is then decremented in
> qemu_co_rwlock_unlock.
> 
> For the read side, rdlock _unlocks_ lock->mutex before returning, so
> self->locks_held must be incremented by rdlock and decremented by unlock.

Makes sense.

Fam
