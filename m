Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK7-00011E-U3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK2-0001lT-CT
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:08 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGK2-0001l2-53
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:02 -0500
Received: by mail-wr0-x244.google.com with SMTP id z34so10397988wrz.10
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:48 +0100
Message-Id: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an attempt to make a C API that resembles the C++
std::unique_lock (mostly untested).  The idea is that you can write

    QEMU_LOCK_GUARD(QemuMutex, guard_name, &some_mutex);

instead of

    qemu_mutex_lock(&some_mutex);
    ...
out:
    qemu_mutex_unlock(&some_mutex);

and the mutex will be unlocked on all exit paths.  In C++ that
would be "std::unique_lock<QemuMutex> guard_name(some_mutex);".
Likewise,

    QEMU_WITH_LOCK(QemuMutex, guard_name, &some_mutex) {
        ...
    }

is the same as

    qemu_mutex_lock(&some_mutex);
    ...
    qemu_mutex_unlock(&some_mutex);

except that any returns within the region will unlock the mutex.
It's possible to use QemuLockGuard also with a spinlock or a
CoMutex.  However, it is _not_ possible to return a QemuLockGuard
since C doesn't have an equivalent of C++'s "move semantics", so
there are other "constructor" macros such as QEMU_ADOPT_LOCK
and QEMU_TAKEN_LOCK.

On the positive side, I checked that the entire abstraction
is removed by the compiler, the generated code is more or less
the same.  Also, it would let us for example change block/curl.c
to use a CoQueue instead of a home-grown list+QemuMutex.

However, I am still not sure about the readability, and it doesn't play
well with another common idiom in QEMU, which is to wrap global mutexes
with function such as

    static void block_job_lock(void)
    {
        qemu_mutex_lock(&block_job_mutex);
    }

    static void block_job_unlock(void)
    {
        qemu_mutex_unlock(&block_job_mutex);
    }

So I'm a bit underwhelmed by this experiment.  Other opinions?

Paolo

Paolo Bonzini (5):
  compiler: add a helper for C99 inline functions
  lock-guard: add scoped lock implementation
  qemu-timer: convert to use lock guards
  qht: convert to use lock guards
  thread-pool: convert to use lock guards

 include/qemu/compiler.h   | 15 +++++++
 include/qemu/coroutine.h  |  4 ++
 include/qemu/lock-guard.h | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h     |  7 ++++
 util/Makefile.objs        |  1 +
 util/qemu-thread.c        | 17 ++++++++
 util/qemu-timer.c         | 84 ++++++++++++++++++++--------------------
 util/qht.c                | 59 ++++++++++++++--------------
 util/thread-pool.c        | 26 ++++++-------
 9 files changed, 225 insertions(+), 87 deletions(-)
 create mode 100644 include/qemu/lock-guard.h
 create mode 100644 util/qemu-thread.c

-- 
2.14.3
