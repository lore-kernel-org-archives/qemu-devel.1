Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHYTY-0004pr-CA
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHYTX-0002xK-Ei
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:06:16 -0500
Date: Wed, 22 Nov 2017 17:06:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171122170607.GA8217@stefanha-x1.localdomain>
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 07:33:28AM -0800, Deepa Srinivasan wrote:
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
> The fix is to allocate memory for the QEMUIOVector and struct iovec as pa=
rt of
> the request struct which the IO buffer is part of. The memory for this st=
ruct is
> guaranteed to be valid till the AIO is completed.

Thanks for the patch!

AIO APIs currently don't require the caller to match qiov's lifetime to
the I/O request lifetime.  This patch changes that for blk_aio_ioctl()
only.  If we want to do this consistently then all aio callers need to
be audited and fixed.

The alternative is to make the API copy qiov when necessary.  That is
less efficient but avoids modifying all callers.

Either way, the lifetime of qiov must be consistent across all aio APIs,
not just blk_aio_ioctl().

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFa5+AAoJEJykq7OBq3PI9UEH/0/QptqDYoEPj34Oa4vePeCr
tG3U65O4P7dl0QpS6Jh5456kFg0FWm8vVVlPrISI9sPM3lAzHrT1uNLQcujp44W3
vSuTMrWqZqgRJ5uuoHhqZf+mzb9eaPkDMroofclxa84LKjoVLoE76eyJv94Bf2k2
fn8SNsYOmZ09nicbvM+GkbMG8YNz8kHD1ZEqATutuDSsrJeGh6qmDByDDm125dEP
j+y5/P6e1cTuiu5c4AV4UkSMjuBmubllsINgxxR9CXct/ARgFO/v9opU4vAQwGtk
kRnj0HenGi0bhzHqgd2aLlpP1eUBLaHo/Zvm9Uc8MrwuL6bMRa6U5+BkgY9jjn4=
=2gZg
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
