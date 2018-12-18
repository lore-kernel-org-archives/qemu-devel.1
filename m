Received: from eggs.gnu.org ([2001:4830:134:3::10]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZG8b-0005XJ-Nr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZG8X-0004Ee-5o
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:14:20 -0500
Date: Tue, 18 Dec 2018 14:14:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181218141401.GF18767@stefanha-x1.localdomain>
References: <20181217164847.24411-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20181217164847.24411-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v3] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 05:48:47PM +0100, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
>=20
> It is possible for an io_poll callback to be concurrently executed along
> with an aio_set_fd_handlers. This can cause all sorts of problems, like
> a NULL callback or a bad opaque pointer.
>=20
> This changes set_fd_handlers so that it no longer modify existing handlers
> entries and instead, always insert those after having proper initialisati=
on.
>=20
> Also, we do not call aio_epoll_update for deleted handlers as this has
> no impact whatsoever.
>=20
> Signed-off-by: Remy Noel <remy.noel@blade-group.com>
> ---

Please include a changelog in future patches.  For example:

v3:
 * Don't drop revents when a handler is modified [Stefan]

That way reviewers know what to look for and which issues you have
addressed.

>  util/aio-posix.c | 86 ++++++++++++++++++++++++++++--------------------
>  util/aio-win32.c | 67 ++++++++++++++++---------------------
>  2 files changed, 79 insertions(+), 74 deletions(-)
>=20
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 51c41ed3c9..d658cf3007 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c

Thanks!  The worst case I can now imagine is if an fd is handled twice
due to a concurrent aio_set_fd_handler() call, but spurious
->io_read()/->io_write() should not cause problems.

I will wait for Paolo to review this because he is most familiar with
the lockcnt abstraction.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGQCpAAoJEJykq7OBq3PI+7YH/jUSBe/1TNSnd2FXWCY3n/Rz
qzMR2Vn28hH/lMTh8HmQBd9/ufgbZxECGDRZAw+WV3zPlLkQaB28MHpqbNIbyIZw
MTI3CF+a/2L0L+9fhq/+x/JrOaagLIoEmUnjbKmbCotdP4v8MOhR7z+o1G8inFCC
hVZNQV6IkE9yqFMYhjqGj/YICnBfsCVoJFNugVQmKH/nYA5MUqr4MAZY1w3dMWkt
uTaX0/WjaAqJh+Ymw6JqojM+muR3gMuPrUqTUYlQQTSR/g6myAZqW8R2XjQ9XvJd
kS4VIyYX91oavgz/espRYo9JOu0hrlKKyiHuO45xUSzbbcyo2HBeXC6cY0+uXQk=
=5/VM
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
