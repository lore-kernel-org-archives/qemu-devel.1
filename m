Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJWaJ-0003KJ-V1
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 22:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJWaF-0005mQ-73
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 22:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJWaE-0005mG-Un
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 22:29:19 -0500
Date: Tue, 28 Nov 2017 11:29:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171128032912.GC3242@lemon>
References: <20171128015039.19060-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128015039.19060-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] thread: move detach_thread from
 creating thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, pbonzini@redhat.com, aliguori@us.ibm.com

On Tue, 11/28 09:50, linzhecheng wrote:
> If we create a thread with QEMU_THREAD_DETACHED mode, QEMU may get a segfault in a low probability.
> 
> The backtrace is:
>     arg=arg@entry=0x3f5cf70, mode=mode@entry=1) at util/qemu_thread_posix.c:512
>     at io/task.c:141
>     destroy=destroy@entry=0x0) at io/channel_socket.c:194
> 
> The root cause of this problem is a bug of glibc(version 2.17,the latest version have the same bug),
> let's see what happened in glibc's code.
> Here is the code slice of pthread_detach.c
> 
> 25 int
> 26 pthread_detach (pthread_t th)
> 27 {
> 28  struct pthread *pd = (struct pthread *) th;
> 29
> 30  /* Make sure the descriptor is valid.  */
> 31  if (INVALID_NOT_TERMINATED_TD_P (pd))
> 32    /* Not a valid thread handle.  */
> 34    return ESRCH;
> 35
> 36  int result = 0;
> 37  /* Mark the thread as detached.  */
> 38  if (atomic_compare_and_exchange_bool_acq (&pd->joinid, pd, NULL))
> 39    {
> 40      /* There are two possibilities here.  First, the thread might
> 41	 already be detached.  In this case we return EINVAL.
> 42	 Otherwise there might already be a waiter.  The standard does
> 43	 not mention what happens in this case.  */
> 44     if (IS_DETACHED (pd))
> 45	 result = EINVAL;
> 46    }
> 47  else
> 48    /* Check whether the thread terminated meanwhile.  In this case we
> 49       will just free the TCB.  */
> 50    if ((pd->cancelhandling & EXITING_BITMASK) != 0)
> 51      /* Note that the code in __free_tcb makes sure each thread
> 52	 control block is freed only once.  */
> 53      __free_tcb (pd);
> 
> 54  return result;
> 55}
> 
> QEMU get a segfault at line 50, becasue pd is an invalid address.
> pd is still valid at line 38 when set pd->joinid = pd, at this moment,
> created thread is just exiting(only keeps runing for a short time),
> created thread is running in code of start_thread:
> 
> 404  /* If the thread is detached free the TCB.  */
> 405  if (IS_DETACHED (pd))
> 406    /* Free the TCB.  */
> 407    __free_tcb (pd);
> created thread found that pd is detached, so it freed pd, in this case,
> pd became an invalid address.
> 
> I rewrite qemu_thread_create to move detach_thread from creating thread to created
> to avoid this concurrency problem.
> 
> Change-Id: I2293d5be1526241cf58785d701b922f2ffc6491b
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> ---
>  include/qemu/thread-posix.h |  8 ++++++++
>  include/qemu/thread.h       |  1 +
>  util/qemu-thread-posix.c    | 45 ++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index f3f47e426f..d855c15dab 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -44,4 +44,12 @@ struct QemuThread {
>      pthread_t thread;
>  };
>  
> +struct QemuThread_args {

QemuThreadArgs please.

> +    void *(*start_routine)(void *);
> +    void *arg;
> +    char *name;
> +    int mode;
> +};
> +
> +
>  #endif
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 9910f49b3a..db365242da 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -10,6 +10,7 @@ typedef struct QemuSemaphore QemuSemaphore;
>  typedef struct QemuEvent QemuEvent;
>  typedef struct QemuLockCnt QemuLockCnt;
>  typedef struct QemuThread QemuThread;
> +typedef struct QemuThread_args QemuThread_args;

This struct is internal to qemu-thread-posix.c so it doesn't need to go into the
header.

>  
>  #ifdef _WIN32
>  #include "qemu/thread-win32.h"
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7306475899..07b5838862 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -489,6 +489,30 @@ static void qemu_thread_set_name(QemuThread *thread, const char *name)
>  #endif
>  }
>  
> +static void *qemu_thread_start(void *args)
> +{
> +    QemuThread_args *qemu_thread_args;
> +    void *ret;
> +    QemuThread qemu_thread;
> +
> +    qemu_thread_args = (QemuThread_args *)args;

Type casting is not needed for void * pointers in C.

> +    qemu_thread_get_self(&qemu_thread);
> +
> +    if (qemu_thread_args->name) {
> +        qemu_thread_set_name(&qemu_thread, qemu_thread_args->name);
> +        g_free(qemu_thread_args->name);
> +    }
> +
> +    if (qemu_thread_args->mode == QEMU_THREAD_DETACHED) {
> +        pthread_detach(qemu_thread.thread);
> +    }
> +    ret = qemu_thread_args->start_routine(qemu_thread_args->arg);
> +
> +    g_free(qemu_thread_args);
> +    return ret;
> +}
> +
> +
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                         void *(*start_routine)(void*),
>                         void *arg, int mode)
> @@ -496,6 +520,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      sigset_t set, oldset;
>      int err;
>      pthread_attr_t attr;
> +    QemuThread_args *qemu_thread_args;
>  
>      err = pthread_attr_init(&attr);
>      if (err) {
> @@ -505,20 +530,18 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      /* Leave signal handling to the iothread.  */
>      sigfillset(&set);
>      pthread_sigmask(SIG_SETMASK, &set, &oldset);
> -    err = pthread_create(&thread->thread, &attr, start_routine, arg);
> +
> +    qemu_thread_args = g_new0(QemuThread_args, 1);
> +    qemu_thread_args->mode = mode;
> +    qemu_thread_args->name = name_threads ? g_strdup_printf("%s", name) : NULL;
> +    qemu_thread_args->start_routine = start_routine;
> +    qemu_thread_args->arg = arg;
> +
> +    err = pthread_create(&thread->thread, &attr,
> +                         qemu_thread_start, qemu_thread_args);
>      if (err)
>          error_exit(err, __func__);
>  
> -    if (name_threads) {
> -        qemu_thread_set_name(thread, name);
> -    }
> -
> -    if (mode == QEMU_THREAD_DETACHED) {
> -        err = pthread_detach(thread->thread);
> -        if (err) {
> -            error_exit(err, __func__);
> -        }
> -    }
>      pthread_sigmask(SIG_SETMASK, &oldset, NULL);
>  
>      pthread_attr_destroy(&attr);
> -- 
> 2.12.2.windows.2
> 
> 

If you fix the above nits, you can add my:

Reviewed-by: Fam Zheng <famz@redhat.com>
