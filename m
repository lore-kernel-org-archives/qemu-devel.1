Received: from eggs.gnu.org ([2001:4830:134:3::10]:32815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvNV-0001Js-3M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvNQ-0005gc-Ii
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:22:45 -0500
Date: Mon, 18 Dec 2017 13:22:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218132208.GA16653@stefanha-x1.localdomain>
References: <1513385953-5466-1-git-send-email-deepa.srinivasan@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <1513385953-5466-1-git-send-email-deepa.srinivasan@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2] block: Fix qemu crash when using
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deepa Srinivasan <deepa.srinivasan@oracle.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 04:59:13PM -0800, Deepa Srinivasan wrote:
> Starting qemu with the following arguments causes qemu to segfault:
> ... -device lsi,id=3Dlsi0 -drive file=3Discsi:<...>,format=3Draw,if=3Dnon=
e,node-name=3D
> iscsi1 -device scsi-block,bus=3Dlsi0.0,id=3D<...>,drive=3Discsi1
>=20
> This patch fixes blk_aio_ioctl() so it does not pass stack addresses to
> blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() returns.=
 More
> details about the bug follow.
>=20
> blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
> coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
>=20
> When blk_aio_ioctl() is executed from within a coroutine context (e.g.
> iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entry) to
> the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
>=20
> When blk_aio_ioctl_entry() executes later, it accesses an invalid pointer:
> ....
>     BlkRwCo *rwco =3D &acb->rwco;
>=20
>     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
>                              rwco->qiov->iov[0].iov_base);  <--- qiov is
>                                                                  invalid =
here
> ...
>=20
> In the case when blk_aio_ioctl() is called from a non-coroutine context,
> blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() calls
> qemu_coroutine_yield(), blk_aio_ioctl() will return. When the coroutine
> execution is complete, control returns to blk_aio_ioctl_entry() after the=
 call
> to blk_co_ioctl(). There is no invalid reference after this point, but the
> function is still holding on to invalid pointers.
>=20
> The fix is to change blk_aio_prwv() to accept a void pointer for the IO b=
uffer
> rather than a QEMUIOVector. blk_aio_prwv() passes this through in BlkRwCo=
 and the
> coroutine function casts it to QEMUIOVector or uses the void pointer dire=
ctly.
>=20
> Signed-off-by: Deepa Srinivasan <deepa.srinivasan@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> ---
>  block/block-backend.c | 51 +++++++++++++++++++++++++--------------------=
------
>  1 file changed, 25 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8EAAAoJEJykq7OBq3PIHx4H/j0UvhdxAIKRnGM/vNUvVp9a
1cpAnDl4zbVC8DvFtPPUKhezMj4q3BKQua4byx0UolbupB5uVRbmk/lok35JiE2d
e6Nl6eIvoyih/NJQ7TIRkU9YgqyNlXyNmcF39+LAqmEi8Bf2Q0PScIhuc+yvNwjt
jqUOp75d+o6LJ2mzRggs1kPsuS+7rZTW9oGiNh9sGTSJ/TjK1nUHpENHhPyqSIHR
6NvdO3WohwkS1S5ECChruWKiqyQuv3ZuVDXIX+E7iF31+D68VMyXjqt4lJv1Silu
RRi1HAc4Q6zbLkimuZOKGEN+pT+JFEHTp911ZrLu+i1q0Zwxq916ZMOUkBM5kRQ=
=9mis
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
