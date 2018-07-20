Received: from eggs.gnu.org ([2001:4830:134:3::10]:36056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNVE-0000hm-LG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNVB-0003Vf-Bw
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:58:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgNVB-0003V6-64
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:58:49 -0400
Date: Fri, 20 Jul 2018 12:58:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720045838.GN4071@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-4-dplotnikov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 03/17] threads: add infrastructure to
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
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:46PM +0300, Denis Plotnikov wrote:
> Allows to define sigsegv handler temporary for all threads.
> This is useful to implement copy-on-write logic while
> linux usefaultfd doesn't support write-protected faults.
> In the future, switch to using WP userfaultfd when it's
> available.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  include/qemu/thread.h    |  5 ++++
>  util/qemu-thread-posix.c | 52 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 9910f49b3a..d6fed833fa 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -210,4 +210,9 @@ void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockc=
nt);
>   */
>  unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
> =20
> +
> +typedef void (*sigsegv_handler)(int signum, siginfo_t *siginfo, void *=
sigctx);
> +void sigsegv_user_handler_set(sigsegv_handler handler);
> +void sigsegv_user_handler_reset(void);
> +
>  #endif
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7306475899..5424b7106d 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -489,6 +489,47 @@ static void qemu_thread_set_name(QemuThread *threa=
d, const char *name)
>  #endif
>  }
> =20
> +static sigsegv_handler sigsegv_user_handler;
> +
> +void sigsegv_user_handler_set(sigsegv_handler handler)
> +{
> +    assert(handler);

We can also assert !sigsegv_user_handler here to make sure there won't
accidentally be two users that want to specify a SIGSEGV handler in
parallel.

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
> +static void sigsegv_default_handler(int signum, siginfo_t *siginfo, vo=
id *sigctx)
> +{
> +    sigsegv_handler handler =3D sigsegv_user_handler_get();
> +
> +    if (!handler) {
> +        /*
> +         * remove the sigsegv handler if it's not set by user
> +         * this will lead to re-raising the error without a handler
> +         * and exiting from the program with "Segmentation fault"
> +         */
> +        int err;
> +        struct sigaction act;
> +        memset(&act, 0, sizeof(act));
> +        act.sa_flags =3D SA_RESETHAND;

I'm not sure whether this is the correct way to use SA_RESETHAND.

  SA_RESETHAND
        Restore the signal action to the default upon entry to the
        signal handler.  This flag is meaningful only when
        establishing a signal han=E2=80=90 dler.  SA_ONESHOT is an obsole=
te,
        nonstandard synonym for this flag.

My understanding is that it's used as a "oneshot" pattern, but here
you didn't really specify any handler.  My wild guess is that the
handler is actually specified to SIG_DFL (which is, 0) after you
bzero-ed the sigaction, hence got what we want.

I'm not sure whether we need this complexity - could we just unset the
handler outside itself when reset?

> +        err =3D sigaction(SIGSEGV, &act, NULL);
> +        if (err) {
> +            error_exit(err, __func__);
> +        }
> +    } else {
> +        handler(signum, siginfo, sigctx);

Here not sure whether we can return something from the user handler
showing that whether it correctly handled the SIGSEGV signal,
otherwise how could we identify it's an expected event or a real
SIGSEGV fault?

> +    }
> +}
> +
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                         void *(*start_routine)(void*),
>                         void *arg, int mode)
> @@ -496,14 +537,25 @@ void qemu_thread_create(QemuThread *thread, const=
 char *name,
>      sigset_t set, oldset;
>      int err;
>      pthread_attr_t attr;
> +    struct sigaction act;
> =20
>      err =3D pthread_attr_init(&attr);
>      if (err) {
>          error_exit(err, __func__);
>      }
> =20
> +    memset(&act, 0, sizeof(act));
> +    act.sa_flags =3D SA_SIGINFO;
> +    act.sa_sigaction =3D sigsegv_default_handler;
> +    err =3D sigaction(SIGSEGV, &act, NULL);
> +    if (err) {
> +        error_exit(err, __func__);
> +    }
> +
>      /* Leave signal handling to the iothread.  */
>      sigfillset(&set);
> +    /* ...all but SIGSEGV */
> +    sigdelset(&set, SIGSEGV);

Why we need to enable SIGSEGV on all threads explicitly?  Could we
just keep the old behavior just like what the other signals do?

>      pthread_sigmask(SIG_SETMASK, &set, &oldset);
>      err =3D pthread_create(&thread->thread, &attr, start_routine, arg)=
;
>      if (err)
> --=20
> 2.17.0
>=20
>=20

Regards,

--=20
Peter Xu
