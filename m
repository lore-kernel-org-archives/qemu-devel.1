Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d3mA1-0006lV-5J
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d3m9y-0002oL-FJ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:20:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44893
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d3m9y-0002o2-8S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:20:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3RGIboa147049
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 12:20:48 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a3jjkmbg0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 12:20:47 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 13:20:45 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3RGKb2Q32833620
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 13:20:42 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3RGKMdD003141
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 13:20:22 -0300
Date: Thu, 27 Apr 2017 13:20:07 -0300
From: joserz@linux.vnet.ibm.com
References: <1493054398-26013-1-git-send-email-joserz@linux.vnet.ibm.com>
	<e0285ff8-d878-82a0-4b68-3b37b933dce6@redhat.com>
	<20170427145926.GA32606@pacoca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427145926.GA32606@pacoca>
Message-Id: <20170427162007.GB32606@pacoca>
Subject: Re: [Qemu-devel] [PATCH v2] trace: add qemu mutex lock and unlock
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com

On Thu, Apr 27, 2017 at 11:59:26AM -0300, joserz@linux.vnet.ibm.com wrote:
> On Thu, Apr 27, 2017 at 10:55:04AM +0200, Paolo Bonzini wrote:
> > 
> > 
> > On 24/04/2017 19:19, Jose Ricardo Ziviani wrote:
> > > These trace events were very useful to help me to understand and find a
> > > reordering issue in vfio, for example:
> > > 
> > > qemu_mutex_lock locked mutex 0x10905ad8
> > >   vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2020c, 4)
> > > qemu_mutex_unlock unlocked mutex 0x10905ad8
> > > qemu_mutex_lock locked mutex 0x10905ad8
> > >   vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
> > > qemu_mutex_unlock unlocked mutex 0x10905ad8
> > > 
> > > that also helped me to see the desired result after the fix:
> > > 
> > > qemu_mutex_lock locked mutex 0x10905ad8
> > >   vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
> > >   vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
> > > qemu_mutex_unlock unlocked mutex 0x10905ad8
> > > 
> > > So it could be a good idea to have these traces implemented. It's worth
> > > mentioning that they should be surgically enabled during the debugging,
> > > otherwise it can flood the trace logs with lock/unlock messages.
> > > 
> > > How to use it:
> > > trace-event qemu_mutex_lock on|off
> > > trace-event qemu_mutex_unlock on|off
> > > or
> > > trace-event qemu_mutex* on|off
> > > 
> > > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > 
> > Some improvements:
> > 
> > 1) handle trylock and Win32 too
> > 
> > 2) pass mutex instead of &mutex->lock, it is the same but the latter is
> > unnecessarily obfuscated
> > 
> > 3) also trace unlock/lock around cond_wait
> > 
> > 4) trace "unlocked" before calling pthread_mutex_unlock, so that it is
> > always placed before the next "locked" tracepoint.
> 
> I'm working on it
> Thanks for your review!

Ops! just saw you already did it. Thanks.

Reviewed-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> 
> > 
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index bf5756763d..46f4c08e6d 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -62,7 +62,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
> >      if (err)
> >          error_exit(err, __func__);
> > 
> > -    trace_qemu_mutex_lock(&mutex->lock);
> > +    trace_qemu_mutex_locked(mutex);
> >  }
> > 
> >  int qemu_mutex_trylock(QemuMutex *mutex)
> > @@ -71,7 +71,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
> > 
> >      err = pthread_mutex_trylock(&mutex->lock);
> >      if (err == 0) {
> > -        trace_qemu_mutex_lock(&mutex->lock);
> > +        trace_qemu_mutex_locked(mutex);
> >          return 0;
> >      }
> >      if (err == EBUSY) {
> > @@ -84,11 +84,10 @@ void qemu_mutex_unlock(QemuMutex *mutex)
> >  {
> >      int err;
> > 
> > +    trace_qemu_mutex_unlocked(mutex);
> >      err = pthread_mutex_unlock(&mutex->lock);
> >      if (err)
> >          error_exit(err, __func__);
> > -
> > -    trace_qemu_mutex_unlock(&mutex->lock);
> >  }
> > 
> >  void qemu_rec_mutex_init(QemuRecMutex *mutex)
> > @@ -145,7 +144,9 @@ void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
> >  {
> >      int err;
> > 
> > +    trace_qemu_mutex_unlocked(mutex);
> >      err = pthread_cond_wait(&cond->cond, &mutex->lock);
> > +    trace_qemu_mutex_locked(mutex);
> >      if (err)
> >          error_exit(err, __func__);
> >  }
> > diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> > index d3c87bc89e..0dc3ae7756 100644
> > --- a/util/qemu-thread-win32.c
> > +++ b/util/qemu-thread-win32.c
> > @@ -55,6 +55,7 @@ void qemu_mutex_destroy(QemuMutex *mutex)
> >  void qemu_mutex_lock(QemuMutex *mutex)
> >  {
> >      AcquireSRWLockExclusive(&mutex->lock);
> > +    trace_qemu_mutex_locked(mutex);
> >  }
> > 
> >  int qemu_mutex_trylock(QemuMutex *mutex)
> > @@ -64,6 +64,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
> > 
> >      owned = TryAcquireSRWLockExclusive(&mutex->lock);
> >      if (owned) {
> > +        trace_qemu_mutex_locked(mutex);
> >          return 0;
> >      }
> >      return -EBUSY;
> > @@ -72,6 +72,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
> > 
> >  void qemu_mutex_unlock(QemuMutex *mutex)
> >  {
> > +    trace_qemu_mutex_unlocked(mutex);
> >      ReleaseSRWLockExclusive(&mutex->lock);
> >  }
> > 
> > @@ -124,7 +124,9 @@ void qemu_cond_broadcast(QemuCond *cond)
> > 
> >  void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
> >  {
> > +    trace_qemu_mutex_unlocked(mutex);
> >      SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
> > +    trace_qemu_mutex_locked(mutex);
> >  }
> > 
> >  void qemu_sem_init(QemuSemaphore *sem, int init)
> > diff --git a/util/trace-events b/util/trace-events
> > index 70f62124e1..fa540c620b 100644
> > --- a/util/trace-events
> > +++ b/util/trace-events
> > @@ -57,5 +57,5 @@ lockcnt_futex_wait_resume(const void *lockcnt, int
> > new) "lockcnt %p after wait:
> >  lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
> > 
> >  # util/qemu-thread-posix.c
> > -qemu_mutex_lock(void *lock) "locked mutex %p"
> > -qemu_mutex_unlock(void *lock) "unlocked mutex %p"
> > +qemu_mutex_locked(void *lock) "locked mutex %p"
> > +qemu_mutex_unlocked(void *lock) "unlocked mutex %p"
> > 
