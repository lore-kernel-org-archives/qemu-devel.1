Received: from eggs.gnu.org ([2001:4830:134:3::10]:60129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGi3e-0002Nj-IW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dGi3d-0005rY-6E
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dGi3c-0005r3-TV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:45 -0400
Date: Fri, 2 Jun 2017 09:35:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170602083536.GA29707@stefanha-x1.localdomain>
References: <20170601160847.23720-1-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20170601160847.23720-1-roman.penyaev@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 06:08:47PM +0200, Roman Pen wrote:
> Submission of requests on linux aio is a bit tricky and can lead to
> requests completions on submission path:
>=20
> 44713c9e8547 ("linux-aio: Handle io_submit() failure gracefully")
> 0ed93d84edab ("linux-aio: process completions from ioq_submit()")
>=20
> That means that any coroutine which has been yielded in order to wait
> for completion can be resumed from submission path and be eventually
> terminated (freed).
>=20
> The following use-after-free crash was observed when IO throttling
> was enabled:
>=20
>  Program received signal SIGSEGV, Segmentation fault.
>  [Switching to Thread 0x7f5813dff700 (LWP 56417)]
>  virtqueue_unmap_sg (elem=3D0x7f5804009a30, len=3D1, vq=3D<optimized out>=
) at virtio.c:252
>  (gdb) bt
>  #0  virtqueue_unmap_sg (elem=3D0x7f5804009a30, len=3D1, vq=3D<optimized =
out>) at virtio.c:252
>                               ^^^^^^^^^^^^^^
>                               remember the address
>=20
>  #1  virtqueue_fill (vq=3D0x5598b20d21b0, elem=3D0x7f5804009a30, len=3D1,=
 idx=3D0) at virtio.c:282
>  #2  virtqueue_push (vq=3D0x5598b20d21b0, elem=3Delem@entry=3D0x7f5804009=
a30, len=3D<optimized out>) at virtio.c:308
>  #3  virtio_blk_req_complete (req=3Dreq@entry=3D0x7f5804009a30, status=3D=
status@entry=3D0 '\000') at virtio-blk.c:61
>  #4  virtio_blk_rw_complete (opaque=3D<optimized out>, ret=3D0) at virtio=
-blk.c:126
>  #5  blk_aio_complete (acb=3D0x7f58040068d0) at block-backend.c:923
>  #6  coroutine_trampoline (i0=3D<optimized out>, i1=3D<optimized out>) at=
 coroutine-ucontext.c:78
>=20
>  (gdb) p * elem
>  $8 =3D {index =3D 77, out_num =3D 2, in_num =3D 1,
>        in_addr =3D 0x7f5804009ad8, out_addr =3D 0x7f5804009ae0,
>        in_sg =3D 0x0, out_sg =3D 0x7f5804009a50}
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>        'in_sg' and 'out_sg' are invalid.
>        e.g. it is impossible that 'in_sg' is zero,
>        instead its value must be equal to:
>=20
>        (gdb) p/x 0x7f5804009ad8 + sizeof(elem->in_addr[0]) + 2 * sizeof(e=
lem->out_addr[0])
>        $26 =3D 0x7f5804009af0
>=20
> Seems 'elem' was corrupted.  Meanwhile another thread raised an abort:
>=20
>  Thread 12 (Thread 0x7f57f2ffd700 (LWP 56426)):
>  #0  raise () from /lib/x86_64-linux-gnu/libc.so.6
>  #1  abort () from /lib/x86_64-linux-gnu/libc.so.6
>  #2  qemu_coroutine_enter (co=3D0x7f5804009af0) at qemu-coroutine.c:113
>  #3  qemu_co_queue_run_restart (co=3D0x7f5804009a30) at qemu-coroutine-lo=
ck.c:60
>  #4  qemu_coroutine_enter (co=3D0x7f5804009a30) at qemu-coroutine.c:119
>                            ^^^^^^^^^^^^^^^^^^
>                            WTF?? this is equal to elem from crashed thread
>=20
>  #5  qemu_co_queue_run_restart (co=3D0x7f57e7f16ae0) at qemu-coroutine-lo=
ck.c:60
>  #6  qemu_coroutine_enter (co=3D0x7f57e7f16ae0) at qemu-coroutine.c:119
>  #7  qemu_co_queue_run_restart (co=3D0x7f5807e112a0) at qemu-coroutine-lo=
ck.c:60
>  #8  qemu_coroutine_enter (co=3D0x7f5807e112a0) at qemu-coroutine.c:119
>  #9  qemu_co_queue_run_restart (co=3D0x7f5807f17820) at qemu-coroutine-lo=
ck.c:60
>  #10 qemu_coroutine_enter (co=3D0x7f5807f17820) at qemu-coroutine.c:119
>  #11 qemu_co_queue_run_restart (co=3D0x7f57e7f18e10) at qemu-coroutine-lo=
ck.c:60
>  #12 qemu_coroutine_enter (co=3D0x7f57e7f18e10) at qemu-coroutine.c:119
>  #13 qemu_co_enter_next (queue=3Dqueue@entry=3D0x5598b1e742d0) at qemu-co=
routine-lock.c:106
>  #14 timer_cb (blk=3D0x5598b1e74280, is_write=3D<optimized out>) at throt=
tle-groups.c:419
>=20
> Crash can be explained by access of 'co' object from the loop inside
> qemu_co_queue_run_restart():
>=20
>   while ((next =3D QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
>       QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
>                            ^^^^^^^^^^^^^^^^^^^^
>                            on each iteration 'co' is accessed,
>                            but 'co' can be already freed
>=20
>       qemu_coroutine_enter(next);
>   }
>=20
> When 'next' coroutine is resumed (entered) it can in its turn resume
> 'co', and eventually free it.  That's why we see 'co' (which was freed)
> has the same address as 'elem' from the first backtrace.
>=20
> The fix is obvious: use temporary queue and do not touch coroutine after
> first qemu_coroutine_enter() is invoked.
>=20
> The issue is quite rare and happens every ~12 hours on very high IO
> and CPU load (building linux kernel with -j512 inside guest) when IO
> throttling is enabled.  With the fix applied guest is running ~35 hours
> and is still alive so far.
>=20
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  v3:
>      Comments tweaks suggested by Stefan.
>  v2:
>      Comments tweaks suggested by Paolo.
>=20
>  util/qemu-coroutine-lock.c | 19 +++++++++++++++++--
>  util/qemu-coroutine.c      |  5 +++++
>  2 files changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZMSNYAAoJEJykq7OBq3PIMHgIALEPVbmDEgoNRey4nYtCJkzJ
Hy5uN6GnFSQf82Qs+myvHabV1vHhRWTGqA7+NGdJIfVzqwLY09x/vgeAQBW7U/BG
qb5FK+vWMnK7NltT69+p24ikb0lh1jrcnRkbTzWzIqA7316mbobLfhTUMvABIA86
AnXFRLBa9uG/OHdm7uAfQXesMCqgFJbjZejSQhLQ6tu6CBGDn5jd/bsWO6DlTWM6
IsK9z5Gg5gZ/jSC63AsLfBO5O5sZqWdXE+GX8YDQYAZqtbP7P7wzfvwDtJbH3Sru
1vfwtabmoQWfDUnHuI6E1YL5y6Y0CCUXND40qMT06i1vPymrTsKNJJvsYQYq2d4=
=qU7F
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
