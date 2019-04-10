Received: from eggs.gnu.org ([209.51.188.92]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEcm-00042U-F4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEcl-0008EC-Aa
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:54:52 -0400
Date: Wed, 10 Apr 2019 15:54:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190410145444.GA11035@stefanha-x1.localdomain>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
	<468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
	<20190408100442.GA11997@linux.fritz.box>
	<20190408101449.GB11997@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20190408101449.GB11997@linux.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 12:14:49PM +0200, Kevin Wolf wrote:
> Am 08.04.2019 um 12:04 hat Kevin Wolf geschrieben:
> > Am 08.04.2019 um 11:44 hat Andrey Shinkevich geschrieben:
> > >=20
> > >=20
> > > On 06/04/2019 01:50, John Snow wrote:
> > > >=20
> > > >=20
> > > > On 4/5/19 10:24 AM, Andrey Shinkevich wrote:
> > > >> On a file system used by the customer, fallocate() returns an error
> > > >> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> > > >> fails. We can handle that case the same way as it is done for the
> > > >> unsupported cases, namely, call to bdrv_driver_pwritev() that writ=
es
> > > >> zeroes to an image for the unaligned chunk of the block.
> > > >>
> > > >> Suggested-by: Denis V. Lunev <den@openvz.org>
> > > >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > > >> ---
> > > >>   block/io.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/block/io.c b/block/io.c
> > > >> index dfc153b..0412a51 100644
> > > >> --- a/block/io.c
> > > >> +++ b/block/io.c
> > > >> @@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_ze=
roes(BlockDriverState *bs,
> > > >>               assert(!bs->supported_zero_flags);
> > > >>           }
> > > >>  =20
> > > >> -        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK=
)) {
> > > >> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
> > > >>               /* Fall back to bounce buffer if write zeroes is uns=
upported */
> > > >>               BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_Z=
ERO_WRITE;
> > > >>  =20
> > > >>
> > > >=20
> > > > I suppose that if fallocate fails for any reason and we're allowing
> > > > fallback, we're either going to succeed ... or fail again very soon
> > > > thereafter.
> > > >=20
> > > > Are there any cases where it is vital to not ignore the first fallo=
cate
> > > > failure? I'm a little wary of ignoring the return code from
> > > > bdrv_co_pwrite_zeroes, but I am assuming that if there is a "real"
> > > > failure here that the following bounce writes will also fail "safel=
y."
> > > >=20
> > > > I'm not completely confident, but I have no tangible objections:
> > > > Reviewed-by: John Snow <jsnow@redhat.com>
> > > >=20
> > >=20
> > > Thank you for your review, John!
> > >=20
> > > Let me clarify the circumstances and quote the bug report:
> > > "Customer had Win-2012 VM with 50GB system disk which was later resiz=
ed=20
> > > to 256GB without resizing the partition inside VM.
> > > Now, while trying to resize to 50G, the following error will appear
> > > 'Failed to reduce the number of L2 tables: Invalid argument'
> > > It was found that it is possible to shrink the disk to 128G and any s=
ize=20
> > > above that number, but size below 128G will bring the mentioned error=
=2E"
> > >=20
> > > The fallocate() returns no error on that file system if the offset and
> > > the (offset + bytes) parameters of the bdrv_co_do_pwrite_zeroes() both
> > > are aligned to 4K.
> >=20
> > What is the return value you get from this file system?
> >=20
> > Maybe turning that into ENOTSUP in file-posix would be less invasive.
> > Just falling back for any error gives me the vague feeling that it could
> > cause problems sooner or later.
>=20
> Also, which file system is this? This seems to be a file system bug.
> fallocate() isn't documented to possibly have alignment restrictions for
> FALLOC_FL_ZERO_RANGE (if this is the operation you're talking about).
> FALLOC_FL_PUNCH_HOLE even explicitly mentions the behaviour for partial
> blocks, so there is no doubt that operations for partial blocks are
> considered valid. Operations that may impose restrictions are explicitly
> documented as such.
>=20
> So in any case, this would only be a workaround for a buggy file system.
> The real bug needs to be fixed there.

I agree regarding the root cause of the bug, but the fallback behavior
is reasonable IMO.

Andrey: If you update the patch with a more specific errno I'll queue
that patch instead.

Stefan

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgO0AAoJEJykq7OBq3PINnIIAKa/FHkhOU/Ig9ItoT/P43Sf
IvgoBgvK4A4evNGF+wYDPhTTS+pwXvdstPNu/CgKTeOHAXK2UasgC3gmoBc4TvMR
CaK6eqtpIT83bk6ef+6JROOCJguWh6MxtLOUs4l9q4PJG9AMQytveaPrag42pFzC
CxNc1YaDzkRxgDqiWYVI0hXgi3d79C00e5SzUpn4rwRDeGGpbUOnP9WCRvITiyTF
0xv1hIoPB6dH+bpssjjgBcanIUYlwicwS8sbUeZGTWpCswOsrI88BEIU+jPtCDny
+r1Ftwm9x4COrnExIIp/OuyzDCrInq4PWA8lBVv5TwS8Q6+LAuSFjKw5EQYy0/s=
=4zWi
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
