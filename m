Received: from eggs.gnu.org ([2001:4830:134:3::10]:38921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTpri-0004gK-BB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTprh-00018Y-EO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:38:14 -0400
Date: Fri, 15 Jun 2018 15:38:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615143805.GA12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] file-posix: Fix EINTR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:04:12PM +0800, Fam Zheng wrote:
> EINTR should be checked against errno, not ret. While fixing the bug,
> collecting the branches with a switch block.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 513d371bb1..c6dae38f94 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1473,20 +1473,20 @@ static ssize_t handle_aiocb_copy_range(RawPosixAI=
OData *aiocb)
>          ssize_t ret =3D copy_file_range(aiocb->aio_fildes, &in_off,
>                                        aiocb->aio_fd2, &out_off,
>                                        bytes, 0);
> -        if (ret =3D=3D -EINTR) {
> -            continue;
> -        }
> -        if (ret < 0) {
> -            if (errno =3D=3D ENOSYS) {
> +        if (ret <=3D 0) {
> +            switch (errno) {
> +            case 0:
> +                /* No progress (e.g. when beyond EOF), let the caller fa=
ll back
> +                 * to buffer I/O. */
> +                /* fall through */

The C11 standard says:

  The value of errno in the initial thread is zero at program startup
  (the initial value of errno in other threads is an indeterminate
  value), but is never set to zero by any library function.

So this code is buggy because it assumes copy_file_range(2) sets errno
to 0 on success.  errno could actually contain a stale value from a
previous function).

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI89NAAoJEJykq7OBq3PIrt8H/1p24pgPvYgJWTEQegpTWfiN
fL/1W3B7mrBWegDAuk1pJVFITNqIVJluzLEw9ujva6Pj6iyX1zorPo2g2yh7lMHw
8RgnoUm6E0E7eyMEzGcRVfWbDNrPPapaAe+DMTqSDHz4qjm62B7yH9eX/jLLc6Hq
wp4qXpGugpjboMBzGzp84wKTcvC6VgN3vUQX7lPclSzwEPgivUUgNneQBLJzP4xT
iqYPZfl3R/5Hso2mTeJB7enXw0zJgf2MMrP7oT6abQJFR1Fo0zCuN53GE4xLYgsD
2/e5xTiDpYHV5wK0gL511gdfhrBWMYkb6javXok5fuXd4nZJg+wZN7U7LN5cM/I=
=hrod
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
