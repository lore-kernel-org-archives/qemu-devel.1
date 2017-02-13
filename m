Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7J-0008Eo-6U
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7H-00032b-TJ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:49 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 19:12:38 +0100
Message-Id: <20170213181244.16297-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Make CoMutex/CoQueue/CoRwlock thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

This is yet another tiny bit of the multiqueue work, this time affecting
the synchronization infrastructure for coroutines.  Currently, coroutines
synchronize between the main I/O thread and the dataplane iothread through
the AioContext lock.  However, for multiqueue a single BDS will be used
by multiple iothreads and hence multiple AioContexts.  This calls for
a different approach to coroutine synchronization, and this series is my
attempt.

After the previous series, coroutines are already bound to an AioContext
while they wait on a CoMutex.  Of course currently a CoMutex is generally
not used across multiple iothreads, because you have to acquire/release
the AioContext around CoMutex critical sections.  This series is the
missing link between the aio_co_schedule/aio_co_wake infrastructure and
making BDS thread-safe: by making CoMutex thread-safe, it removes
the need for a "thread-based" mutex around it.

This will still need some changes in the formats because, for multiqueue,
CoMutexes would need to be used like "real" thread mutexes.  Code like
this:

    ...
    qemu_co_mutex_unlock()
    ... /* still access shared data, but don't yield */
    qemu_coroutine_yield()

might be required to use this other pattern:

    ... /* access shared data, but don't yield */
    qemu_co_mutex_unlock()
    qemu_coroutine_yield()

because adding a second AioContext is already introducing concurrency that
wasn't there before.  Still, even if you have to take concurrency into
account, multitasking between coroutines remains non-preemptive.  So for
example, it is easy to synchronize between qemu_co_mutex_lock's yield
and the qemu_coroutine_enter in aio_co_schedule's bottom half.

CoMutex puts coroutines to sleep with qemu_coroutine_yield and wake them
up with aio_co_wake.  I could have wrapped CoMutex's CoQueue with
a "regular" thread mutex or spinlock.  The resulting code would
have looked a lot like RFifoLock (with CoQueue replacing RFifoLock's
condition variable).  Instead, CoMutex is implemented from scratch and
CoQueue is made to depend on a CoMutex, similar to condition variables.
Most CoQueues already have a corresponding CoMutex so this is not a big
deal; converting the others is left for a future series, but a surprising
number of drivers actually need no change.

The mutex algorithm comes from OSv; it only needs two to four atomic ops
for a lock-unlock pair (two when uncontended) and if necessary
we could even take OSv's support for wait morphing (which avoids the
thundering herd problem) and add it to CoMutex and CoQueue.

Performance of CoMutex is comparable to pthread mutexes.  However, you
cannot make a direct comparison between CoMutex (fair) and pthread_mutex_t
(unfair).  For this reason the testcase also measures performance of
a quick-and-dirty implementation of a fair mutex, based on MCS locks
and futexes.

Paolo

Paolo Bonzini (6):
  coroutine-lock: make CoMutex thread-safe
  coroutine-lock: add limited spinning to CoMutex
  test-aio-multithread: add performance comparison with thread-based
    mutexes
  coroutine-lock: place CoMutex before CoQueue in header
  coroutine-lock: add mutex argument to CoQueue APIs
  coroutine-lock: make CoRwlock thread-safe and fair

 block/backup.c               |   2 +-
 block/io.c                   |   4 +-
 block/nbd-client.c           |   2 +-
 block/qcow2-cluster.c        |   4 +-
 block/sheepdog.c             |   2 +-
 block/throttle-groups.c      |   2 +-
 hw/9pfs/9p.c                 |   2 +-
 include/qemu/coroutine.h     |  84 +++++++++------
 tests/test-aio-multithread.c | 250 +++++++++++++++++++++++++++++++++++++++++++
 util/qemu-coroutine-lock.c   | 247 ++++++++++++++++++++++++++++++++++++++----
 util/qemu-coroutine.c        |   2 +-
 util/trace-events            |   1 +
 12 files changed, 537 insertions(+), 65 deletions(-)

-- 
2.9.3
