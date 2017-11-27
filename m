Received: from eggs.gnu.org ([2001:4830:134:3::10]:40683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJL1p-0008BD-Bv
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJL1l-0001W8-DY
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eJL1l-0001Us-1Q
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:08:57 -0500
Date: Mon, 27 Nov 2017 15:08:52 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171127150852.GO32413@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171127145936.15676-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171127145936.15676-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] thread: move detach_thread from creating
 thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, arei.gonglei@huawei.com

On Mon, Nov 27, 2017 at 10:59:36PM +0800, linzhecheng wrote:
> If we create a thread with QEMU_THREAD_DETACHED mode, QEMU may get a segfault in a low probability.
> 
> The backtrace is:
> #0  0x00007f46c60291d7 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007f46c602a8c8 in __GI_abort () at abort.c:90
> #2  0x00000000008543c9 in PAT_abort ()
> #3  0x000000000085140d in patchIllInsHandler ()
> #4  <signal handler called>
> #5  pthread_detach (th=139933037614848) at pthread_detach.c:50
> #6  0x0000000000829759 in qemu_thread_create (thread=thread@entry=0x7ffdaa8205e0, name=name@entry=0x94d94a "io-task-worker", start_routine=start_routine@entry=0x7eb9a0 <qio_task_thread_worker>, 
>     arg=arg@entry=0x3f5cf70, mode=mode@entry=1) at util/qemu_thread_posix.c:512
> #7  0x00000000007ebc96 in qio_task_run_in_thread (task=0x31db2c0, worker=worker@entry=0x7e7e40 <qio_channel_socket_connect_worker>, opaque=0xcd23380, destroy=0x7f1180 <qapi_free_SocketAddress>)
>     at io/task.c:141
> #8  0x00000000007e7f33 in qio_channel_socket_connect_async (ioc=ioc@entry=0x626c0b0, addr=<optimized out>, callback=callback@entry=0x55e080 <qemu_chr_socket_connected>, opaque=opaque@entry=0x42862c0, 
>     destroy=destroy@entry=0x0) at io/channel_socket.c:194
> #9  0x000000000055bdd1 in socket_reconnect_timeout (opaque=0x42862c0) at qemu_char.c:4744
> #10 0x00007f46c72483b3 in g_timeout_dispatch () from /usr/lib64/libglib-2.0.so.0
> #11 0x00007f46c724799a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> #12 0x000000000076c646 in glib_pollfds_poll () at main_loop.c:228
> #13 0x000000000076c6eb in os_host_main_loop_wait (timeout=348000000) at main_loop.c:273
> #14 0x000000000076c815 in main_loop_wait (nonblocking=nonblocking@entry=0) at main_loop.c:521
> #15 0x000000000056a511 in main_loop () at vl.c:2076
> #16 0x0000000000420705 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4940
> 
> The root cause of this problem is a bug of glibc(version 2.17,the lastest version have the same bug),
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
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
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
>  
>  #ifdef _WIN32
>  #include "qemu/thread-win32.h"
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7306475899..8c72fb12a8 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -482,13 +482,34 @@ static void __attribute__((constructor)) qemu_thread_atexit_init(void)
>  /* Attempt to set the threads name; note that this is for debug, so
>   * we're not going to fail if we can't set it.
>   */
> -static void qemu_thread_set_name(QemuThread *thread, const char *name)
> +static void qemu_thread_set_name(pthread_t thread, const char *name)
>  {
>  #ifdef CONFIG_PTHREAD_SETNAME_NP
> -    pthread_setname_np(thread->thread, name);
> +    pthread_setname_np(thread, name);
>  #endif
>  }
>  
> +static void *qemu_thread_start(void *args)
> +{
> +    QemuThread_args *qemu_thread_args;
> +    void *ret;
> +
> +    qemu_thread_args = (QemuThread_args *)args;
> +    if (qemu_thread_args->name) {
> +        qemu_thread_set_name(pthread_self(), qemu_thread_args->name);
> +        g_free(qemu_thread_args->name);
> +    }
> +
> +    if (qemu_thread_args->mode == QEMU_THREAD_DETACHED) {
> +        pthread_detach(pthread_self());
> +    }
> +    ret = qemu_thread_args->start_routine(qemu_thread_args->arg);
> +
> +    g_free(qemu_thread_args);
> +    return ret;
> +}

This is way overkill. ...

> +
> +
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                         void *(*start_routine)(void*),
>                         void *arg, int mode)
> @@ -496,6 +517,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      sigset_t set, oldset;
>      int err;
>      pthread_attr_t attr;
> +    QemuThread_args *qemu_thread_args;
>  
>      err = pthread_attr_init(&attr);
>      if (err) {

We should just do

    if (mode == QEMU_THREAD_DETACHED) {
        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    }

> @@ -505,7 +527,15 @@ void qemu_thread_create(QemuThread *thread, const char *name,
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

There's code a few lines after this which still calls pthread_detach()



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
