Received: from eggs.gnu.org ([2001:4830:134:3::10]:45372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHZO3-00059L-4w
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHZO2-0003Ip-65
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:04:39 -0500
Date: Wed, 22 Nov 2017 19:04:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171122180426.GC10954@localhost.localdomain>
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
	<20171122170607.GA8217@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20171122170607.GA8217@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Deepa Srinivasan <deepa.srinivasan@oracle.com>, mreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.11.2017 um 18:06 hat Stefan Hajnoczi geschrieben:
> On Wed, Nov 22, 2017 at 07:33:28AM -0800, Deepa Srinivasan wrote:
> > Starting qemu with the following arguments causes qemu to segfault:
> > ... -device lsi,id=3Dlsi0 -drive file=3Discsi:<...>,format=3Draw,if=3Dn=
one,node-name=3D
> > iscsi1 -device scsi-block,bus=3Dlsi0.0,id=3D<...>,drive=3Discsi1
> >=20
> > This patch fixes blk_aio_ioctl() so it does not pass stack addresses to
> > blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() return=
s. More
> > details about the bug follow.
> >=20
> > blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
> > coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().
> >=20
> > When blk_aio_ioctl() is executed from within a coroutine context (e.g.
> > iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entry)=
 to
> > the current coroutine's wakeup queue. blk_aio_ioctl() then returns.
> >=20
> > When blk_aio_ioctl_entry() executes later, it accesses an invalid point=
er:
> > ....
> >     BlkRwCo *rwco =3D &acb->rwco;
> >=20
> >     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
> >                              rwco->qiov->iov[0].iov_base);  <--- qiov is
> >                                                                  invali=
d here
> > ...
> >=20
> > In the case when blk_aio_ioctl() is called from a non-coroutine context,
> > blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() calls
> > qemu_coroutine_yield(), blk_aio_ioctl() will return. When the coroutine
> > execution is complete, control returns to blk_aio_ioctl_entry() after t=
he call
> > to blk_co_ioctl(). There is no invalid reference after this point, but =
the
> > function is still holding on to invalid pointers.
> >=20
> > The fix is to allocate memory for the QEMUIOVector and struct iovec as =
part of
> > the request struct which the IO buffer is part of. The memory for this =
struct is
> > guaranteed to be valid till the AIO is completed.
>=20
> Thanks for the patch!
>=20
> AIO APIs currently don't require the caller to match qiov's lifetime to
> the I/O request lifetime.  This patch changes that for blk_aio_ioctl()
> only.  If we want to do this consistently then all aio callers need to
> be audited and fixed.
>=20
> The alternative is to make the API copy qiov when necessary.  That is
> less efficient but avoids modifying all callers.
>=20
> Either way, the lifetime of qiov must be consistent across all aio APIs,
> not just blk_aio_ioctl().

Don't all blk_aio_*() APIs that take a qiov pointer require that it
remains valid until the request completes? I don't think they are copied
anywhere for blk_aio_preadv/pwritev() before being passed to the block
driver.

So this does look consistent with the existing functions to me.

Kevin

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaFbwqAAoJEH8JsnLIjy/WsdMP/iMqoF+7fbePy6P5n9tMCQhk
7uXujFByLFqzavHbgmog1pqY38mdCYm6kK77JPstRdw8J+blhTW8rwf17igPGkLI
wTVGp57knzCdUOOyLfkFAVHBtUFWAXuON3Ovvn8DeMLEXSExlPvndTc7sQbmkfMj
L2DD+TZ6kCBKjr11Eumxj3+S6/I4SKXRgdzHIdKrxWZEzWRGgvHQj0h2L1WnkAZF
jptdCZf4HnDMlI8/55dabqke9Z4VCsUU4PsDd9hQJ2IC/Em6SmxBqfXDIjBwWoHZ
ShbYvzA1WkMQ+Aa+VFWchNQejliMxjZzNcJbvkNOLg1L2Z3Z7PAi1jJaK2osE5Rz
l5jA2jx3gD0ZDhk6ecZmICAolK2UKnpPsiEqvuVCUnUOC+UwpO2vybe9fhLVkAVK
DyQCZqY0jdq2LJOgcvdIKyPYjKwllFDyLG6tRxFhRN0pDpx/Y9BqGMwYh74qkkuF
EqX9yo3B+7nMx+nZMNWdqrPBUSQNoPoGd99ZpeDmb2Z4AKGq+c/y/GFEbC70vzMY
s1AZMjedbc+MYRPxLcTH05+kbcqq6B64J623uaHQXS9QuwfrCeEURJ6fJt4k/Ezp
IlHn5PHpnzeUwZlDipWDBEXWdHInbttMCWs5+384lfmDrl94fgPp65Fm70fahbjo
pG/ICnUSlYWlw1DyToMf
=n9Vh
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
