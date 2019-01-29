Received: from eggs.gnu.org ([209.51.188.92]:41338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goW7x-00030V-Az
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goW7v-0002Ge-Sb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:20:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1goW7v-0002Fk-LF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:20:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1981EC059B7A
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 16:20:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190129051432.22023-1-peterx@redhat.com>
Date: Tue, 29 Jan 2019 17:20:40 +0100
In-Reply-To: <20190129051432.22023-1-peterx@redhat.com> (Peter Xu's message of
	"Tue, 29 Jan 2019 13:14:32 +0800")
Message-ID: <87lg33306f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iothread: fix iothread hang when stop too
 soon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Marc-Andr=C3=A9 (cc'ed) recently fixed a deadlock (commit 34f1f3e06d8
"monitor: avoid potential dead-lock when cleaning up").  Looks like we
got more.

Peter Xu <peterx@redhat.com> writes:

> Lukas reported an hard to reproduce QMP iothread hang on s390 that
> QEMU might hang at pthread_join() of the QMP monitor iothread before
> quitting:
>
>   Thread 1
>   #0  0x000003ffad10932c in pthread_join
>   #1  0x0000000109e95750 in qemu_thread_join
>       at /home/thuth/devel/qemu/util/qemu-thread-posix.c:570
>   #2  0x0000000109c95a1c in iothread_stop
>   #3  0x0000000109bb0874 in monitor_cleanup
>   #4  0x0000000109b55042 in main
>
> While the iothread is still in the main loop:
>
>   Thread 4
>   #0  0x000003ffad0010e4 in ??
>   #1  0x000003ffad553958 in g_main_context_iterate.isra.19
>   #2  0x000003ffad553d90 in g_main_loop_run
>   #3  0x0000000109c9585a in iothread_run
>       at /home/thuth/devel/qemu/iothread.c:74
>   #4  0x0000000109e94752 in qemu_thread_start
>       at /home/thuth/devel/qemu/util/qemu-thread-posix.c:502
>   #5  0x000003ffad10825a in start_thread
>   #6  0x000003ffad00dcf2 in thread_start
>
> IMHO it's because there's a race between the main thread and iothread
> when stopping the thread in following sequence:
>
>     main thread                       iothread
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                                       aio_poll()
>     iothread_get_g_main_context
>       set iothread->worker_context
>     iothread_stop
>       schedule iothread_stop_bh
>                                         execute iothread_stop_bh [1]
>                                           set iothread->running=3Dfalse
>                                           (since main_loop=3D=3DNULL so
>                                            skip to quit main loop.
>                                            Note: although main_loop is
>                                            NULL but worker_context is
>                                            not!)
>                                       atomic_read(&iothread->worker_conte=
xt) [2]
>                                         create main_loop object
>                                         g_main_loop_run() [3]
>     pthread_join() [4]
>
> We can see that when execute iothread_stop_bh() at [1] it's possible
> that main_loop is still NULL because it's only created until the first
> check of the worker_context later at [2].  Then the iothread will hang
> in the main loop [3] and it'll starve the main thread too [4].
>
> Here the simple solution should be that we check again the "running"
> variable before check against worker_context.
>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> This hasn't yet been verified on the initial s390 systems, but since I
> can reproduce it locally with this code clip:
>
>         IOThread *iothread =3D iothread_create("test", NULL);
>         iothread_get_g_main_context(iothread);
>         iothread_stop(iothread);
>
> so I'm still posting this out for review first in case it was hit by
> other users.
> ---
>  iothread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/iothread.c b/iothread.c
> index 2fb1cdf55d..e615b7ae52 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -63,7 +63,11 @@ static void *iothread_run(void *opaque)
>      while (iothread->running) {
>          aio_poll(iothread->ctx, true);
>=20=20
> -        if (atomic_read(&iothread->worker_context)) {
> +        /*
> +         * We must check the running state again in case it was
> +         * changed in previous aio_poll()
> +         */
> +        if (iothread->running && atomic_read(&iothread->worker_context))=
 {
>              GMainLoop *loop;
>=20=20
>              g_main_context_push_thread_default(iothread->worker_context);
