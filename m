Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eihwI-0007eM-9y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eihwC-0000vx-D6
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:40:10 -0500
Date: Mon, 5 Feb 2018 14:39:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205143949.GB28241@stefanha-x1.localdomain>
References: <20180203153935.8056-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20180203153935.8056-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/5] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2018 at 10:39:30AM -0500, Paolo Bonzini wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use a
> CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
> right now is rolling its own list of Coroutines) and will happen in
> Fam's NVMe driver as well.
>=20
> This series extracts the idea of a polymorphic lockable object
> from my "scoped lock guard" proposal, and applies it to CoQueue.
> The implementation of QemuLockable is similar to C11 _Generic, but
> redone using the preprocessor and GCC builtins for compatibility.
>=20
> In general, while a bit on the esoteric side, the functionality used
> to emulate _Generic is fairly old in GCC, and the builtins are already
> used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
> Damn Small Linux via http) and CentOS 6 (compiled only).
>=20
> Paolo
>=20
> v4->v5: fix checkpatch complaints
>=20
> v3->v4: fix -O0 compilation [Fam]
>         typos and copyright dates [Eric, Fam]
>         improve CoQueue comments [Stefan]
>=20
> Paolo Bonzini (5):
>   test-coroutine: add simple CoMutex test
>   lockable: add QemuLockable
>   coroutine-lock: convert CoQueue to use QemuLockable
>   coroutine-lock: make qemu_co_enter_next thread-safe
>   curl: convert to CoQueue
>=20
>  block/curl.c                | 20 ++--------
>  fsdev/qemu-fsdev-throttle.c |  4 +-
>  include/qemu/compiler.h     | 40 +++++++++++++++++++
>  include/qemu/coroutine.h    | 29 +++++++++-----
>  include/qemu/lockable.h     | 96 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/qemu/thread.h       |  5 +--
>  include/qemu/typedefs.h     |  4 ++
>  tests/test-coroutine.c      | 75 ++++++++++++++++++++++++++++++++++-
>  util/qemu-coroutine-lock.c  | 22 +++++++----
>  9 files changed, 256 insertions(+), 39 deletions(-)
>  create mode 100644 include/qemu/lockable.h
>=20
> --=20
> 2.14.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeGy1AAoJEJykq7OBq3PIbJ0IAJ39fiooM28+YPKKFBTKxr3F
NUQa3Ne8d+2rrKQjp8vrON51vrQ28x2dIVzS8QAg0ZOpl4lFuxdVKBw/Gec926gb
pGiDS+08TncA6MOysEXhTZjLPV+fKk5r+GsobPifGvFZmQijbwaQ2Dy+P4u9lOTf
kkG6YRGgrpZvzKX8lgEaKVsymUqmiglWayupSUv9yy3BURSDido/cxB/BE+jXZvm
i0iMXSqlhR37hYLwNs9VkPrE711ysbeQQyISJVGlg0gOlpCikeADMJD4HgxbEel1
H6icy/DLRWnOzsng4vFh8lQJ3urR2BJyXTpoFTXtq3i+7ETfySSQ2oCXK2Uq6P4=
=pwhR
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
