Received: from eggs.gnu.org ([209.51.188.92]:49639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goUpI-0005VH-DH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goUiB-0001Bd-Ew
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:50:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1goUdi-0000da-EE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:50:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A95FBA402E
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 14:44:19 +0000 (UTC)
References: <20190129051432.22023-1-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd92ce4d-e78f-1ad2-18d0-f50a0343e990@redhat.com>
Date: Tue, 29 Jan 2019 15:44:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190129051432.22023-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-29 06:14, Peter Xu wrote:
> Lukas reported an hard to reproduce QMP iothread hang on s390 that
> QEMU might hang at pthread_join() of the QMP monitor iothread before
> quitting:
>=20
>   Thread 1
>   #0  0x000003ffad10932c in pthread_join
>   #1  0x0000000109e95750 in qemu_thread_join
>       at /home/thuth/devel/qemu/util/qemu-thread-posix.c:570
>   #2  0x0000000109c95a1c in iothread_stop
>   #3  0x0000000109bb0874 in monitor_cleanup
>   #4  0x0000000109b55042 in main
>=20
> While the iothread is still in the main loop:
>=20
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
>=20
> IMHO it's because there's a race between the main thread and iothread
> when stopping the thread in following sequence:
>=20
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
>                                       atomic_read(&iothread->worker_con=
text) [2]
>                                         create main_loop object
>                                         g_main_loop_run() [3]
>     pthread_join() [4]
>=20
> We can see that when execute iothread_stop_bh() at [1] it's possible
> that main_loop is still NULL because it's only created until the first
> check of the worker_context later at [2].  Then the iothread will hang
> in the main loop [3] and it'll starve the main thread too [4].
>=20
> Here the simple solution should be that we check again the "running"
> variable before check against worker_context.
>=20
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
>=20
> This hasn't yet been verified on the initial s390 systems, but since I
> can reproduce it locally with this code clip:
>=20
>         IOThread *iothread =3D iothread_create("test", NULL);
>         iothread_get_g_main_context(iothread);
>         iothread_stop(iothread);
>=20
> so I'm still posting this out for review first in case it was hit by
> other users.
> ---
>  iothread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/iothread.c b/iothread.c
> index 2fb1cdf55d..e615b7ae52 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -63,7 +63,11 @@ static void *iothread_run(void *opaque)
>      while (iothread->running) {
>          aio_poll(iothread->ctx, true);
> =20
> -        if (atomic_read(&iothread->worker_context)) {
> +        /*
> +         * We must check the running state again in case it was
> +         * changed in previous aio_poll()
> +         */
> +        if (iothread->running && atomic_read(&iothread->worker_context=
)) {
>              GMainLoop *loop;
> =20
>              g_main_context_push_thread_default(iothread->worker_contex=
t);
>=20

I ran this on s390x with Luk=C3=A1=C5=A1' reproducer for a while now, and=
 so far I
haven't seen any hangs anymore. Thus this seems to fix the issue as far
as I can see, thanks!

Tested-by: Thomas Huth <thuth@redhat.com>
