Received: from eggs.gnu.org ([2001:4830:134:3::10]:56415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz23U-0001oM-7k
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz23O-0002Xd-A1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:50:48 -0400
Date: Mon, 2 Oct 2017 16:50:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002145030.GC4362@localhost.localdomain>
References: <150680635276.96.4363000165685666262@b58463cdfd5f>
	<4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.10.2017 um 00:05 hat Eric Blake geschrieben:
> On 09/30/2017 04:19 PM, no-reply@patchew.org wrote:
> > Hi,
> >=20
> > This series failed build test on s390x host. Please find the details be=
low.
> >=20
>=20
> > /var/tmp/patchew-tester-tmp-a2p2tpcc/src/block/io.c: In function =E2=80=
=98bdrv_aligned_preadv=E2=80=99:
> > /var/tmp/patchew-tester-tmp-a2p2tpcc/src/block/io.c:955:9: error: =E2=
=80=98ret=E2=80=99 may be used uninitialized in this function [-Werror=3Dma=
ybe-uninitialized]
> >      int ret;
> >          ^~~
>=20
> Blah - I compiled with -g instead of -O2, which masks this warning in my
> setup.
>=20
> The warning is a false negative (the error message is actually pointing
> to a line in bdrv_co_do_copy_on_readv - but the compiler must have
> inlined it into bdrv_aligned_preadv) - the function is only ever called
> with non-zero bytes, and therefore the 'while (cluster_bytes)' loop will
> execute at least once, and ret always gets assigned.  But the compiler
> can't see that, so I'll squash this in:

Well, you could help the compiler with this:

    assert(cluster_bytes > 0);

Then it compiles. Unfortunately, the compiler was right and you weren't:

    $ ./qemu-io -C -c 'read 0 0' /tmp/test.qcow2
    qemu-io: block/io.c:988: bdrv_co_do_copy_on_readv: Assertion `cluster_b=
ytes > 0' failed.
    Abgebrochen (Speicherabzug geschrieben)

Maybe a case to add to the test?

> commit a201636c3133827bd632d5fdd9eb1f5df81d0e0e
> Author: Eric Blake <eblake@redhat.com>
> Date:   Sat Sep 30 14:27:51 2017 -0500
>=20
>     fixup! block: Perform copy-on-read in loop
>=20
>     Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> diff --git a/block/io.c b/block/io.c
> index 5ef5adc7a7..e7519464bb 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -952,7 +952,7 @@ static int coroutine_fn
> bdrv_co_do_copy_on_readv(BdrvChild *child,
>      int64_t cluster_offset;
>      unsigned int cluster_bytes;
>      size_t skip_bytes;
> -    int ret;
> +    int ret =3D 0;
>      int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer,
>                                      BDRV_REQUEST_MAX_BYTES);
>      unsigned int progress =3D 0;

I would prefer a ret =3D 0 immediately before err: so that we'll still get
warning if we forget assigning ret in any future error path.

Kevin

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ0lI2AAoJEH8JsnLIjy/Wk4cP/2n6BYMotCihTemRfDEWpZJ4
7iYeLkHDcW31nkY1KHn6VX5HB9jVtEWmbC1uX5jyR59mW39SrasXFia0nwxjgDUJ
hMM8SB0Pfgxdj7GJlElgTj+5hHDz4Pa1f5+f8QBMYlBeJ/onzuHrmrYxRnxRNdFM
qP/UAB6KlqshAkZhyPHYfoqNmeYdX2ON/1KrCMszY8gHQ9bEaXvuOw4nH6vAzHWe
w5Ug6gD+9wBfJJiy/r8g9uIFiJ40j8EklPryaPOR7qaAeZ9RFPqLJMyLX/cwIkrh
urA//Nj0jsW6OMh5cqKLVnsQhAuB3kxthw8afXHLDMbUAs8V/NDme62BArsvaErK
FsnamIVCUiBticubJsvSri49Fd3ghaMvfyb60iKoxul33jOZsOfVGikkA8uNzqqb
GEjXCYz/yWI11d4/KDzGxEetEjoto5Y/45OwqDvBNNB3PPaZQeYjrbAj8ejR627p
eubJ7SkifG3EI6s6Y3K8CR6jm8ox0V5JWskMZLIucd212ZB7VO0QNyU5CAeZKvKC
mgCKQ+PgNTyh7svJsp9wDjaPb0/UEecKcdISPLX396FVFCWlD+dAhrxgZg/47Oaq
lihDvBBFqQ09/5cPStYOD0bP4g30Ekn1rbQsknKE/4nowyvvg4L2WtHWfIByfHne
zxcPDJlFzxYCNM4NP8UK
=b3cq
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
