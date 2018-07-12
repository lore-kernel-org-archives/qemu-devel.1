Received: from eggs.gnu.org ([2001:4830:134:3::10]:56786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fdYI3-0006Jc-Cq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fdYI0-0000Wr-AE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:53:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fdYI0-0000V1-4Z
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:53:32 -0400
Date: Thu, 12 Jul 2018 10:53:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180712095327.GD2610@work-vm>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629080320.320144-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629080320.320144-4-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v0 3/7] threads: add infrastructure to
 process sigsegv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

* Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> Allows to define sigsegv handler temporary for all threads.
> This is useful to implement copy-on-write logic while
> linux usefaultfd doesn't support write-protected faults.
> In the future, switch to using WP userfaultfd when it's
> available.
> 
> It's going to be used on background snapshotting.

I'll leave the details of signal handling to someone else
(anyone knows how this would interact with qemu-user; or the
signalfd's in util/main-loop.c ? )

But also, I'd still like to understand how this works when the
kernel makes guest accesses for things like vhost.

> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  include/qemu/thread.h    |  5 ++++
>  util/qemu-thread-posix.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 9910f49b3a..886985d289 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -210,4 +210,9 @@ void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
>   */
>  unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
>  
> +
> +typedef void (*sigsegv_handler)(int v0, siginfo_t *v1, void *v2);
> +void sigsegv_user_handler_set(sigsegv_handler handler);
> +void sigsegv_user_handler_reset(void);
> +
>  #endif
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7306475899..e51abc9275 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -489,6 +489,45 @@ static void qemu_thread_set_name(QemuThread *thread, const char *name)
>  #endif
>  }
>  
> +static sigsegv_handler sigsegv_user_handler;
> +
> +void sigsegv_user_handler_set(sigsegv_handler handler)
> +{
> +    assert(handler);
> +    atomic_set(&sigsegv_user_handler, handler);
> +}
> +
> +static sigsegv_handler sigsegv_user_handler_get(void)
> +{
> +    return atomic_read(&sigsegv_user_handler);
> +}
> +
> +void sigsegv_user_handler_reset(void)
> +{
> +    atomic_set(&sigsegv_user_handler, NULL);
> +}
> +
> +static void sigsegv_default_handler(int v0, siginfo_t *v1, void *v2)

v0/v1/v2 aren't great names for the parameters.

> +{
> +    sigsegv_handler handler = sigsegv_user_handler_get();
> +
> +    if (!handler) {
> +        // remove the sigsegv handler if it's not set by user
> +        // this will lead to re-raising the error without a handler
> +        // and exiting from the program with "Sigmentation fault"

Style guide doesn't allow C99 comments.
(And typo: Sig->Seg)

Dave

> +        int err;
> +        struct sigaction act;
> +        memset(&act, 0, sizeof(act));
> +        act.sa_flags = SA_RESETHAND;
> +        err = sigaction(SIGSEGV, &act, NULL);
> +        if (err) {
> +            error_exit(err, __func__);
> +        }
> +    } else {
> +        handler(v0, v1, v2);
> +    }
> +}
> +
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                         void *(*start_routine)(void*),
>                         void *arg, int mode)
> @@ -496,14 +535,25 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      sigset_t set, oldset;
>      int err;
>      pthread_attr_t attr;
> +    struct sigaction act;
>  
>      err = pthread_attr_init(&attr);
>      if (err) {
>          error_exit(err, __func__);
>      }
>  
> +    memset(&act, 0, sizeof(act));
> +    act.sa_flags = SA_SIGINFO;
> +    act.sa_sigaction = sigsegv_default_handler;
> +    err = sigaction(SIGSEGV, &act, NULL);
> +    if (err) {
> +        error_exit(err, __func__);
> +    }
> +
>      /* Leave signal handling to the iothread.  */
>      sigfillset(&set);
> +    // ...all but SIGSEGV
> +    sigdelset(&set, SIGSEGV);
>      pthread_sigmask(SIG_SETMASK, &set, &oldset);
>      err = pthread_create(&thread->thread, &attr, start_routine, arg);
>      if (err)
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
