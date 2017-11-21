Received: from eggs.gnu.org ([2001:4830:134:3::10]:40251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHBaK-0003T7-DN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHBaJ-0003HK-ID
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:39:44 -0500
Date: Tue, 21 Nov 2017 16:39:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121163933.GB32089@stefanha-x1.localdomain>
References: <cover.1511278397.git.jcody@redhat.com>
	<ccb6b6368f2ba5198f786559acc92c8432c7a936.1511278397.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <ccb6b6368f2ba5198f786559acc92c8432c7a936.1511278397.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2017 at 10:38:51AM -0500, Jeff Cody wrote:
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index d6095c1..9e4ed43 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -107,8 +107,21 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Corou=
tine *co)
>      Coroutine *self =3D qemu_coroutine_self();
>      CoroutineAction ret;
> =20
> +    /* Prior read of co protected by callers - e.g., aio_co_wake */
> +    const char *scheduled =3D atomic_read(&co->scheduled);

Consider: user code -> qemu_coroutine_enter() ->
qemu_aio_coroutine_enter().  Unlike the
aio_co_wake() code path, there is no read barrier here.

I think atomic_mb_read() is needed to guarantee the thread sees the
latest value.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFFbFAAoJEJykq7OBq3PIwccH/3qvB4dl1oyJKv+18xArJKnO
hWQucBcs5AzSwdcaxE2/l1xWjqFYWfmbnYDwuDyzyTid21Xj3g+nCd9ogG1betjf
ne+NMn9oB3MEdeQh94KvL4vFwQ67wn9FKV6IoxF0/ZFHku8LydSWaz0Gm7SA1drw
e8a25mNBGjN3trXNK7a8fP/1NE4FMGgEYXIKO5kV8F12mbtaaDcSDT0DxI+RIfzo
Ywu6ATyBipzp8qbojJsFdetzBcEEe+eoX+V+0RsBSvHAyFVW9Yi1ONr88YX75p6x
EMMLCCGd2tVLbyN8Z5FYhxJ6Wp1swe53inHTHKR9PqJo+a0TidEJKKp+KwCep1s=
=OWVP
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
