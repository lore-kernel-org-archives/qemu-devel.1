Received: from eggs.gnu.org ([2001:4830:134:3::10]:58037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSiFm-0008I7-UN
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSi25-00037B-B2
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:36:34 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3329707d-d16b-716e-88ac-e40ecfdd7290@redhat.com>
Date: Fri, 30 Nov 2018 13:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181129101801.6421-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N5DUwsBA3V6bTFnOg9RrvNtPxzksiezlW"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] mirror: fix dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N5DUwsBA3V6bTFnOg9RrvNtPxzksiezlW
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org
Message-ID: <3329707d-d16b-716e-88ac-e40ecfdd7290@redhat.com>
Subject: Re: [PATCH v2 1/2] mirror: fix dead-lock
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181129101801.6421-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
> Let start from the beginning:
>=20
> Commit b9e413dd375 (in 2.9)
> "block: explicitly acquire aiocontext in aio callbacks that need it"
> added pairs of aio_context_acquire/release to mirror_write_complete and=

> mirror_read_complete, when they were aio callbacks for blk_aio_* calls.=

>=20
> Then, commit 2e1990b26e5 (in 3.0) "block/mirror: Convert to coroutines"=

> dropped these blk_aio_* calls, than mirror_write_complete and
> mirror_read_complete are not callbacks more, and don't need additional
> aiocontext acquiring.

Yes, that alone makes enough sense to me.

> Furthermore, mirror_read_complete calls
> blk_co_pwritev inside these pair of aio_context_acquire/release, which
> leads to the following dead-lock with mirror:
>=20
>  (gdb) info thr
>    Id   Target Id         Frame
>    3    Thread (LWP 145412) "qemu-system-x86" syscall ()
>    2    Thread (LWP 145416) "qemu-system-x86" __lll_lock_wait ()
>  * 1    Thread (LWP 145411) "qemu-system-x86" __lll_lock_wait ()
>=20
>  (gdb) bt
>  #0  __lll_lock_wait ()
>  #1  _L_lock_812 ()
>  #2  __GI___pthread_mutex_lock
>  #3  qemu_mutex_lock_impl (mutex=3D0x561032dce420 <qemu_global_mutex>,
>      file=3D0x5610327d8654 "util/main-loop.c", line=3D236) at
>      util/qemu-thread-posix.c:66
>  #4  qemu_mutex_lock_iothread_impl
>  #5  os_host_main_loop_wait (timeout=3D480116000) at util/main-loop.c:2=
36
>  #6  main_loop_wait (nonblocking=3D0) at util/main-loop.c:497
>  #7  main_loop () at vl.c:1892
>  #8  main
>=20
> Printing contents of qemu_global_mutex, I see that "__owner =3D 145416"=
,
> so, thr1 is main loop, and now it wants BQL, which is owned by thr2.
>=20
>  (gdb) thr 2
>  (gdb) bt
>  #0  __lll_lock_wait ()
>  #1  _L_lock_870 ()
>  #2  __GI___pthread_mutex_lock
>  #3  qemu_mutex_lock_impl (mutex=3D0x561034d25dc0, ...
>  #4  aio_context_acquire (ctx=3D0x561034d25d60)
>  #5  dma_blk_cb
>  #6  dma_blk_io
>  #7  dma_blk_read
>  #8  ide_dma_cb
>  #9  bmdma_cmd_writeb
>  #10 bmdma_write
>  #11 memory_region_write_accessor
>  #12 access_with_adjusted_size
>  #15 flatview_write
>  #16 address_space_write
>  #17 address_space_rw
>  #18 kvm_handle_io
>  #19 kvm_cpu_exec
>  #20 qemu_kvm_cpu_thread_fn
>  #21 qemu_thread_start
>  #22 start_thread
>  #23 clone ()
>=20
> Printing mutex in fr 2, I see "__owner =3D 145411", so thr2 wants aio
> context mutex, which is owned by thr1. Classic dead-lock.
>=20
> Then, let's check that aio context is hold by mirror coroutine: just
> print coroutine stack of first tracked request in mirror job target:
>=20
>  (gdb) [...]
>  (gdb) qemu coroutine 0x561035dd0860
>  #0  qemu_coroutine_switch
>  #1  qemu_coroutine_yield
>  #2  qemu_co_mutex_lock_slowpath
>  #3  qemu_co_mutex_lock
>  #4  qcow2_co_pwritev
>  #5  bdrv_driver_pwritev
>  #6  bdrv_aligned_pwritev
>  #7  bdrv_co_pwritev
>  #8  blk_co_pwritev
>  #9  mirror_read_complete () at block/mirror.c:232
>  #10 mirror_co_read () at block/mirror.c:370
>  #11 coroutine_trampoline
>  #12 __start_context
>=20
> Yes it is mirror_read_complete calling blk_co_pwritev after acquiring
> aio context.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/mirror.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--N5DUwsBA3V6bTFnOg9RrvNtPxzksiezlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBLsgACgkQ9AfbAGHV
z0D2MggAqN6L5sqsqT5LFTtTAwSP6bXUG9gCzmaIqhswWkQwv1jQxq7cu0vLyPob
vlGPlK+Iemp4MLUiEpFCtXSPJza91cx+NHAp8Fzx10U9sLB4dZgjGCVi3lNpSKhg
/HdJFrThFLN59KCToMuwfXhOZIg0dyEtkdeoHJZgPJm3oAEOpNTSHbx1eICeyaww
NRkX+IyLrWT4KoRU/vf0AFq1DjonWE2+Rd3L2vlpG0uxU/D/vZ1FRorM0RwHWNX2
pNc5MNbbr2tte58gLormemWRX9jynSj9Ouj4f99+jhb2IgbZEj8iF9ZCs8GNGF07
q6r82Cvys9u+AHxC9k/K2BjLZ8Ow9g==
=HreZ
-----END PGP SIGNATURE-----

--N5DUwsBA3V6bTFnOg9RrvNtPxzksiezlW--
