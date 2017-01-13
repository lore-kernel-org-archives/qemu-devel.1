Received: from eggs.gnu.org ([2001:4830:134:3::10]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS1mA-00013D-Kw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS1m6-0003V9-JA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cS1m6-0003Ur-Av
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:20:10 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E35C7F0A3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 13:20:10 +0000 (UTC)
Date: Fri, 13 Jan 2017 13:20:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170113132007.GB10706@stefanha-x1.localdomain>
References: <20170112180800.21085-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/10] aio_context_acquire/release
 pushdown, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 07:07:50PM +0100, Paolo Bonzini wrote:
> This is the first step of pushing down the AioContext lock.  Bottom halves
> are already protected by their own lock, use it also for walking_bh
> and for the handlers list (including walking_handlers).  The (lock,
> walking_foo) pair is wrapped into the QemuLockCnt primitive.
>=20
> The only difference from v3 is a smattering of tiny nice improvements
> to QemuLockCnt.
>=20
> Paolo
>=20
> v4->v5:
>         remove stray tabs [patchew]
>=20
> v3->v4:
>         Avoid useless atomic_mb_read in non-futex lockcnt [Stefan]
>         Use atomic_read in qemu_lockcnt_count [Stefan]
>         Tweak comment for qemu_lockcnt_cmpxchg_or_wait [Fam]
>         Use if/else in qemu_lockcnt_dec_and_lock [Fam]
>         Comment QEMU_LOCKCNT_STATE_* definitions [Fam]
>=20
> v2->v3:
>         fix missing unlock
>=20
> v1->v2:
>         rebased on top of polling patches
>         moved documentation to include/
>         new patch "aio-posix: split aio_dispatch_handlers out of aio_disp=
atch"
>         replaced atomic_read with atomic_mb_read in qemu_lockcnt_inc
>         replaced futex* function and macro names with qemu_futex*
>         removed atomic access to node->pfd.revents (because there is no
>           concurrent aio_poll anymore after the BDRV_POLL_WHILE series)
>         left "aio: push aio_context_acquire/release down to dispatching"
>           to a later series
>=20
> Paolo Bonzini (10):
>   aio: rename bh_lock to list_lock
>   qemu-thread: introduce QemuLockCnt
>   aio: make ctx->list_lock a QemuLockCnt, subsuming ctx->walking_bh
>   qemu-thread: optimize QemuLockCnt with futexes on Linux
>   aio-posix: split aio_dispatch_handlers out of aio_dispatch
>   aio: tweak walking in dispatch phase
>   aio-posix: remove walking_handlers, protecting AioHandler list with
>     list_lock
>   aio-win32: remove walking_handlers, protecting AioHandler list with
>     list_lock
>   aio: document locking
>   async: optimize aio_bh_poll
>=20
>  aio-posix.c                 | 116 +++++++------
>  aio-win32.c                 |  83 +++++----
>  async.c                     |  45 ++---
>  docs/lockcnt.txt            | 277 +++++++++++++++++++++++++++++++
>  docs/multiple-iothreads.txt |  13 +-
>  include/block/aio.h         |  38 ++---
>  include/qemu/futex.h        |  36 ++++
>  include/qemu/thread.h       | 112 +++++++++++++
>  util/Makefile.objs          |   1 +
>  util/lockcnt.c              | 397 ++++++++++++++++++++++++++++++++++++++=
++++++
>  util/qemu-thread-posix.c    |  35 +---
>  util/qemu-thread-win32.c    |   2 +-
>  util/trace-events           |  10 ++
>  13 files changed, 1006 insertions(+), 159 deletions(-)
>  create mode 100644 docs/lockcnt.txt
>  create mode 100644 include/qemu/futex.h
>  create mode 100644 util/lockcnt.c
>=20
> --=20
> 2.9.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYeNQHAAoJEJykq7OBq3PITkUH/0oTj+zb9zB1wJ1eiN68FpRo
5e0/0+mtJ72JOK/VnPu5RjnoG3JT7Fw9mEl2JMK0Ekj2RBgS7pf2Xe/4trfA1/wK
k8w4fmz2M7Mm1T5jmgeCMwNXHp80KHD3SxepnPFSFPFxbIp6NHQDeR4qPiSlJS/D
wQD8cjMm+gkdLBjmzv5jbpp0LuNeT/Ti2MtTSvgQg6hARDKEjoKOdepDxZPJAWyk
YzAKAmvLolEmQolyllGvstm6G4yYJ70kS4HAnOv7Ewmnd7QOkHmnjndYo9oKDkhR
45mVNDDqdtxU+K+Yp6dOHSI3T1C7R3+SYqurR4Sak2spgjVlQWhWy3ziRAVN7NE=
=pSrI
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
