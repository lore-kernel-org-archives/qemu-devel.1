Received: from eggs.gnu.org ([2001:4830:134:3::10]:58817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1est7x-0000bs-IF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1est7w-00041k-I3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:38:17 -0500
Date: Mon, 5 Mar 2018 16:38:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305163805.GA26426@stefanha-x1.localdomain>
References: <1513385953-5466-1-git-send-email-deepa.srinivasan@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
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


--n8g4imXOkfNTN/H1
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

There has been no activity after pings, I'm merging this now although
technically it should go via Kevin's tree.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanXJtAAoJEJykq7OBq3PIReAH/3eyY5Lckb5sBj+l+7qQRHEc
n4YtZMA27Nr/vl8Os//9z100Bu71bz/Rjaf+KlElc2TJ9Ux0EHjj9t6Ns1oSss2O
41sDDhI2XhOVb76D4NYROjPfw3ct0E2jKKXSXoTNcm1Lc9uNWiAR+4zJqefnvqeg
gXWP2TwqFKnsUkQZ9mtVRWCYW0l0WvGjRxqIAyvkIb+ANnWKB/oqLnfImTRfjKGJ
dF3vVwmWxtrp8a8EKC3lAQqKLdErnANfktoLESOenF9Zxgpj1Zux3g3Bt0bOvojy
nOIxvQyaNhU5UvmuVDUWNQHpKYmkw7HLsr+wV3D4ySAI6WC0Ieq+CQB8vjOUu6c=
=16YS
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
