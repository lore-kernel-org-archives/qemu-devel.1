Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSNiN-0000VJ-AT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSNiL-0002lS-6r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:18:03 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:35816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSNiL-0002lG-1S
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:18:01 -0400
Received: by mail-io0-x241.google.com with SMTP id 84so11323461iop.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 06:18:00 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170704122325.25634-1-famz@redhat.com>
References: <20170704122325.25634-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 4 Jul 2017 10:17:58 -0300
Message-ID: <CAAdtpL4jsqLm7q9zx34J9MVnf96HWxQLgohwuHy56zkYzUO0+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jul 4, 2017 at 9:23 AM, Fam Zheng <famz@redhat.com> wrote:
> Not all platforms check whether a lock is initialized before used.  In
> particular Linux seems to be more permissive than OSX.
>
> Check initialization state explicitly in our code to catch such bugs
> earlier.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  include/qemu/thread-posix.h |  4 ++++
>  include/qemu/thread-win32.h |  5 +++++
>  util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
>  util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index 09d1e15..e5e3a0f 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -12,10 +12,12 @@ typedef QemuMutex QemuRecMutex;
>
>  struct QemuMutex {
>      pthread_mutex_t lock;
> +    bool initialized;
>  };
>
>  struct QemuCond {
>      pthread_cond_t cond;
> +    bool initialized;
>  };
>
>  struct QemuSemaphore {
> @@ -26,6 +28,7 @@ struct QemuSemaphore {
>  #else
>      sem_t sem;
>  #endif
> +    bool initialized;
>  };
>
>  struct QemuEvent {
> @@ -34,6 +37,7 @@ struct QemuEvent {
>      pthread_cond_t cond;
>  #endif
>      unsigned value;
> +    bool initialized;
>  };
>
>  struct QemuThread {
> diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
> index 4c4a261..3a05e3b 100644
> --- a/include/qemu/thread-win32.h
> +++ b/include/qemu/thread-win32.h
> @@ -5,11 +5,13 @@
>
>  struct QemuMutex {
>      SRWLOCK lock;
> +    bool initialized;
>  };
>
>  typedef struct QemuRecMutex QemuRecMutex;
>  struct QemuRecMutex {
>      CRITICAL_SECTION lock;
> +    bool initialized;
>  };
>
>  void qemu_rec_mutex_destroy(QemuRecMutex *mutex);
> @@ -19,15 +21,18 @@ void qemu_rec_mutex_unlock(QemuRecMutex *mutex);
>
>  struct QemuCond {
>      CONDITION_VARIABLE var;
> +    bool initialized;
>  };
>
>  struct QemuSemaphore {
>      HANDLE sema;
> +    bool initialized;
>  };
>
>  struct QemuEvent {
>      int value;
>      HANDLE event;
> +    bool initialized;
>  };
>
>  typedef struct QemuThreadData QemuThreadData;
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index eacd99e..4e95d27 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -43,12 +43,15 @@ void qemu_mutex_init(QemuMutex *mutex)
>      err =3D pthread_mutex_init(&mutex->lock, NULL);
>      if (err)
>          error_exit(err, __func__);
> +    mutex->initialized =3D true;
>  }
>
>  void qemu_mutex_destroy(QemuMutex *mutex)
>  {
>      int err;
>
> +    assert(mutex->initialized);
> +    mutex->initialized =3D false;
>      err =3D pthread_mutex_destroy(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> @@ -58,6 +61,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
>  {
>      int err;
>
> +    assert(mutex->initialized);
>      err =3D pthread_mutex_lock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> @@ -69,6 +73,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
>  {
>      int err;
>
> +    assert(mutex->initialized);
>      err =3D pthread_mutex_trylock(&mutex->lock);
>      if (err =3D=3D 0) {
>          trace_qemu_mutex_locked(mutex);
> @@ -84,6 +89,7 @@ void qemu_mutex_unlock(QemuMutex *mutex)
>  {
>      int err;
>
> +    assert(mutex->initialized);
>      trace_qemu_mutex_unlocked(mutex);
>      err =3D pthread_mutex_unlock(&mutex->lock);
>      if (err)
> @@ -102,6 +108,7 @@ void qemu_rec_mutex_init(QemuRecMutex *mutex)
>      if (err) {
>          error_exit(err, __func__);
>      }
> +    mutex->initialized =3D true;
>  }
>
>  void qemu_cond_init(QemuCond *cond)
> @@ -111,12 +118,15 @@ void qemu_cond_init(QemuCond *cond)
>      err =3D pthread_cond_init(&cond->cond, NULL);
>      if (err)
>          error_exit(err, __func__);
> +    cond->initialized =3D true;
>  }
>
>  void qemu_cond_destroy(QemuCond *cond)
>  {
>      int err;
>
> +    assert(cond->initialized);
> +    cond->initialized =3D false;
>      err =3D pthread_cond_destroy(&cond->cond);
>      if (err)
>          error_exit(err, __func__);
> @@ -126,6 +136,7 @@ void qemu_cond_signal(QemuCond *cond)
>  {
>      int err;
>
> +    assert(cond->initialized);
>      err =3D pthread_cond_signal(&cond->cond);
>      if (err)
>          error_exit(err, __func__);
> @@ -135,6 +146,7 @@ void qemu_cond_broadcast(QemuCond *cond)
>  {
>      int err;
>
> +    assert(cond->initialized);
>      err =3D pthread_cond_broadcast(&cond->cond);
>      if (err)
>          error_exit(err, __func__);
> @@ -144,6 +156,7 @@ void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
>  {
>      int err;
>
> +    assert(cond->initialized);
>      trace_qemu_mutex_unlocked(mutex);
>      err =3D pthread_cond_wait(&cond->cond, &mutex->lock);
>      trace_qemu_mutex_locked(mutex);
> @@ -174,12 +187,15 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
>          error_exit(errno, __func__);
>      }
>  #endif
> +    sem->initialized =3D true;
>  }
>
>  void qemu_sem_destroy(QemuSemaphore *sem)
>  {
>      int rc;
>
> +    assert(sem->initialized);
> +    sem->initialized =3D false;
>  #if defined(__APPLE__) || defined(__NetBSD__)
>      rc =3D pthread_cond_destroy(&sem->cond);
>      if (rc < 0) {
> @@ -201,6 +217,7 @@ void qemu_sem_post(QemuSemaphore *sem)
>  {
>      int rc;
>
> +    assert(sem->initialized);
>  #if defined(__APPLE__) || defined(__NetBSD__)
>      pthread_mutex_lock(&sem->lock);
>      if (sem->count =3D=3D UINT_MAX) {
> @@ -238,6 +255,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
>      int rc;
>      struct timespec ts;
>
> +    assert(sem->initialized);
>  #if defined(__APPLE__) || defined(__NetBSD__)
>      rc =3D 0;
>      compute_abs_deadline(&ts, ms);
> @@ -285,6 +303,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
>  {
>      int rc;
>
> +    assert(sem->initialized);
>  #if defined(__APPLE__) || defined(__NetBSD__)
>      pthread_mutex_lock(&sem->lock);
>      while (sem->count =3D=3D 0) {
> @@ -310,6 +329,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
>  #else
>  static inline void qemu_futex_wake(QemuEvent *ev, int n)
>  {
> +    assert(ev->initialized);
>      pthread_mutex_lock(&ev->lock);
>      if (n =3D=3D 1) {
>          pthread_cond_signal(&ev->cond);
> @@ -321,6 +341,7 @@ static inline void qemu_futex_wake(QemuEvent *ev, int=
 n)
>
>  static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
>  {
> +    assert(ev->initialized);
>      pthread_mutex_lock(&ev->lock);
>      if (ev->value =3D=3D val) {
>          pthread_cond_wait(&ev->cond, &ev->lock);
> @@ -355,10 +376,13 @@ void qemu_event_init(QemuEvent *ev, bool init)
>  #endif
>
>      ev->value =3D (init ? EV_SET : EV_FREE);
> +    ev->initialized =3D true;
>  }
>
>  void qemu_event_destroy(QemuEvent *ev)
>  {
> +    assert(ev->initialized);
> +    ev->initialized =3D false;
>  #ifndef __linux__
>      pthread_mutex_destroy(&ev->lock);
>      pthread_cond_destroy(&ev->cond);
> @@ -370,6 +394,7 @@ void qemu_event_set(QemuEvent *ev)
>      /* qemu_event_set has release semantics, but because it *loads*
>       * ev->value we need a full memory barrier here.
>       */
> +    assert(ev->initialized);
>      smp_mb();
>      if (atomic_read(&ev->value) !=3D EV_SET) {
>          if (atomic_xchg(&ev->value, EV_SET) =3D=3D EV_BUSY) {
> @@ -383,6 +408,7 @@ void qemu_event_reset(QemuEvent *ev)
>  {
>      unsigned value;
>
> +    assert(ev->initialized);
>      value =3D atomic_read(&ev->value);
>      smp_mb_acquire();
>      if (value =3D=3D EV_SET) {
> @@ -398,6 +424,7 @@ void qemu_event_wait(QemuEvent *ev)
>  {
>      unsigned value;
>
> +    assert(ev->initialized);
>      value =3D atomic_read(&ev->value);
>      smp_mb_acquire();
>      if (value !=3D EV_SET) {
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 653f29f..94f3491 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -46,15 +46,19 @@ static void error_exit(int err, const char *msg)
>  void qemu_mutex_init(QemuMutex *mutex)
>  {
>      InitializeSRWLock(&mutex->lock);
> +    mutex->initialized =3D true;
>  }
>
>  void qemu_mutex_destroy(QemuMutex *mutex)
>  {
> +    assert(mutex->initialized);
> +    mutex->initialized =3D false;
>      InitializeSRWLock(&mutex->lock);
>  }
>
>  void qemu_mutex_lock(QemuMutex *mutex)
>  {
> +    assert(mutex->initialized);
>      AcquireSRWLockExclusive(&mutex->lock);
>      trace_qemu_mutex_locked(mutex);
>  }
> @@ -63,6 +67,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
>  {
>      int owned;
>
> +    assert(mutex->initialized);
>      owned =3D TryAcquireSRWLockExclusive(&mutex->lock);
>      if (owned) {
>          trace_qemu_mutex_locked(mutex);
> @@ -73,6 +78,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
>
>  void qemu_mutex_unlock(QemuMutex *mutex)
>  {
> +    assert(mutex->initialized);
>      trace_qemu_mutex_unlocked(mutex);
>      ReleaseSRWLockExclusive(&mutex->lock);
>  }
> @@ -80,25 +86,31 @@ void qemu_mutex_unlock(QemuMutex *mutex)
>  void qemu_rec_mutex_init(QemuRecMutex *mutex)
>  {
>      InitializeCriticalSection(&mutex->lock);
> +    mutex->initialized =3D true;
>  }
>
>  void qemu_rec_mutex_destroy(QemuRecMutex *mutex)
>  {
> +    assert(mutex->initialized);
> +    mutex->initialized =3D false;
>      DeleteCriticalSection(&mutex->lock);
>  }
>
>  void qemu_rec_mutex_lock(QemuRecMutex *mutex)
>  {
> +    assert(mutex->initialized);
>      EnterCriticalSection(&mutex->lock);
>  }
>
>  int qemu_rec_mutex_trylock(QemuRecMutex *mutex)
>  {
> +    assert(mutex->initialized);
>      return !TryEnterCriticalSection(&mutex->lock);
>  }
>
>  void qemu_rec_mutex_unlock(QemuRecMutex *mutex)
>  {
> +    assert(mutex->initialized);
>      LeaveCriticalSection(&mutex->lock);
>  }
>
> @@ -106,25 +118,31 @@ void qemu_cond_init(QemuCond *cond)
>  {
>      memset(cond, 0, sizeof(*cond));
>      InitializeConditionVariable(&cond->var);
> +    cond->initialized =3D true;
>  }
>
>  void qemu_cond_destroy(QemuCond *cond)
>  {
> +    assert(cond->initialized);
> +    cond->initialized =3D false;
>      InitializeConditionVariable(&cond->var);
>  }
>
>  void qemu_cond_signal(QemuCond *cond)
>  {
> +    assert(cond->initialized);
>      WakeConditionVariable(&cond->var);
>  }
>
>  void qemu_cond_broadcast(QemuCond *cond)
>  {
> +    assert(cond->initialized);
>      WakeAllConditionVariable(&cond->var);
>  }
>
>  void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
>  {
> +    assert(cond->initialized);
>      trace_qemu_mutex_unlocked(mutex);
>      SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
>      trace_qemu_mutex_locked(mutex);
> @@ -134,21 +152,28 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
>  {
>      /* Manual reset.  */
>      sem->sema =3D CreateSemaphore(NULL, init, LONG_MAX, NULL);
> +    sem->initialized =3D true;
>  }
>
>  void qemu_sem_destroy(QemuSemaphore *sem)
>  {
> +    assert(sem->initialized);
> +    sem->initialized =3D false;
>      CloseHandle(sem->sema);
>  }
>
>  void qemu_sem_post(QemuSemaphore *sem)
>  {
> +    assert(sem->initialized);
>      ReleaseSemaphore(sem->sema, 1, NULL);
>  }
>
>  int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
>  {
> -    int rc =3D WaitForSingleObject(sem->sema, ms);
> +    int rc;
> +
> +    assert(sem->initialized);
> +    rc =3D WaitForSingleObject(sem->sema, ms);
>      if (rc =3D=3D WAIT_OBJECT_0) {
>          return 0;
>      }
> @@ -160,6 +185,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
>
>  void qemu_sem_wait(QemuSemaphore *sem)
>  {
> +    assert(sem->initialized);
>      if (WaitForSingleObject(sem->sema, INFINITE) !=3D WAIT_OBJECT_0) {
>          error_exit(GetLastError(), __func__);
>      }
> @@ -193,15 +219,19 @@ void qemu_event_init(QemuEvent *ev, bool init)
>      /* Manual reset.  */
>      ev->event =3D CreateEvent(NULL, TRUE, TRUE, NULL);
>      ev->value =3D (init ? EV_SET : EV_FREE);
> +    ev->initialized =3D true;
>  }
>
>  void qemu_event_destroy(QemuEvent *ev)
>  {
> +    assert(ev->initialized);
> +    ev->initialized =3D false;
>      CloseHandle(ev->event);
>  }
>
>  void qemu_event_set(QemuEvent *ev)
>  {
> +    assert(ev->initialized);
>      /* qemu_event_set has release semantics, but because it *loads*
>       * ev->value we need a full memory barrier here.
>       */
> @@ -218,6 +248,7 @@ void qemu_event_reset(QemuEvent *ev)
>  {
>      unsigned value;
>
> +    assert(ev->initialized);
>      value =3D atomic_read(&ev->value);
>      smp_mb_acquire();
>      if (value =3D=3D EV_SET) {
> @@ -232,6 +263,7 @@ void qemu_event_wait(QemuEvent *ev)
>  {
>      unsigned value;
>
> +    assert(ev->initialized);
>      value =3D atomic_read(&ev->value);
>      smp_mb_acquire();
>      if (value !=3D EV_SET) {
> --
> 2.9.4
>
>
