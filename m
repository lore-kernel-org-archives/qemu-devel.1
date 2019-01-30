Received: from eggs.gnu.org ([209.51.188.92]:37211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gogXt-0001Hu-PV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gogXs-0001iN-OJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:28:13 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gogXs-0001iC-Hm
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:28:12 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so10393601plb.5
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 19:28:12 -0800 (PST)
Date: Wed, 30 Jan 2019 11:28:07 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190130032807.GC20241@stefanha-x1.localdomain>
References: <20190129051432.22023-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20190129051432.22023-1-peterx@redhat.com>
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
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 01:14:32PM +0800, Peter Xu wrote:
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
>                                       atomic_read(&iothread->worker_conte=
xt) [2]
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

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcURnHAAoJEJykq7OBq3PIyU8H/RhtFVZDU0YzX2g13duAqK7u
RPza+hv1OoaauQRsI6sdtNWmxSE1e8C1TSIISE1DU89ItYk+MmRRaHZrwHQLQ446
QVnnaG9nOMu+LFq/RJIVCCBgP1m5vHKurg7cXVibQV3bo6McUWnMkkV/LJNkPt2R
GYWsh1e/6DXuPDgzhG5gU+BUt3TBZzYds92u8lL+Np4mafPCZ2Mapf9auiUuL+mu
hsiz2IZ9Q656S1W8IRiuuzz46lTCMJMjzezCqaiw8DSbR/4CIM5WdLIdQ45va9Fz
InCPjz8AQXBHEb7RKMNHAQYuNBHxnskznYezv/YzcbTlcXUQYlbkOlLkhrnTumw=
=5Qi9
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
