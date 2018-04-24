Received: from eggs.gnu.org ([2001:4830:134:3::10]:56270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1bM-0005ng-FN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1bL-0002uW-4M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:19:36 -0400
Date: Tue, 24 Apr 2018 19:19:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424171920.GI4080@localhost.localdomain>
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-4-eblake@redhat.com>
	<20180424155205.GD4080@localhost.localdomain>
	<f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] null: Switch to byte-based read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.04.2018 um 19:00 hat Eric Blake geschrieben:
> On 04/24/2018 10:52 AM, Kevin Wolf wrote:
> > Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
> >> We are gradually moving away from sector-based interfaces, towards
> >> byte-based.  Make the change for the last few sector-based callbacks
> >> in the null-co and null-aio drivers.
> >>
> >> Note that since the null driver does nothing on writes, it trivially
> >> supports the BDRV_REQ_FUA flag (all writes have already landed to
> >> the same bit-bucket without needing an extra flush call).  Furthermore,
> >> bdrv_refresh_limits() defaults the block size to 512 for any driver
> >> that does not support coroutines; while this is still correct for the
> >> other aio-based drivers, the null driver does just as well with
> >> byte-based requests, and being explicit means we can avoid cycles
> >> wasted on read-modify-write.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> >> +static void null_refresh_limits(BlockDriverState *bs, Error **errp)
> >> +{
> >> +    bs->bl.request_alignment =3D 1;
> >> +}
> >=20
> > I would rather modify bdrv_refresh_limits() so that it defaults to 1 for
> > drivers supporting either .bdrv_co_preadv or .bdrv_aio_preadv.
>=20
> Sure, I can do that (although then I may have to provide a
> refresh_limits callback for each of the other drivers that I
> specifically left at 512 alignment).

Do we know that the other drivers need 512, or do we expect than they
can handle byte granularity, but we try to err on the safe side?

If it's the latter (which would be my expectation), then it's probably
better to set request_alignment =3D 512 with a comment in those drivers
and hope that someone will lift the restriction in the future.

Kevin

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa32cYAAoJEH8JsnLIjy/WP2kP/jXTuDAiv5e4jzKNyEWhVWkv
P/tSDzXyLnJQ0w8GvgqW18jlJOU5IDDvy2L7bF3HgoJ05GgiaVAMhGncA5KNI9hD
Zg5NwrXNRyz6UADbXbwbcbw9CsB2MRWQlP/R1K0oBPpBgPS2sTQ3RszqizRQjpTx
yF9esZdaPiWESZFmmxXJEC/j29B48fq9rTF1ZOwB4XtEQwJH+IOZPA164RdmhZJ2
067Zasq9zFFeKwZSiGX2KLT9xdllXjPejG9WKomxnUvoA1HjI7dCleLYhKpjSkuC
Rw1MndLUMr0G4CvodoNZ5x119+mDxsENGFu/JZ/fFscZaksSJ2FIa0NcwbJ7p3r/
2L3CdaHgn/xrpzgHkQ0j96oFlNVSmfb4MFGBMUpZkcCnEz0Fvk/losof0uRCvuAE
fjbAMur1yB4WfvB4TS71xrNXZgUYPbVmLFeZMh7yGMbkiaQuT+TeRRtz5yLr6f2q
agTRFPQZ6yDvMxd4/9Ywb7aZ+uwHdxfTmtt57Hf43YU7WtfAFkrfl+2KUAQ9T6cg
e/H18isO5ePwc4HF+pdZ6jKBKLvkJuTH2haJqtFATed1rNfoFkT0VhstC/mvx8Fx
byKpyagaoWJsyk7WJhFZegfkDdgPSYXlllXUpqMxIy9PzQFheE7P4cFTG3XxZiQr
WG+Rhauv0m7ve1X8PCkM
=Swv8
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
