Received: from eggs.gnu.org ([2001:4830:134:3::10]:39436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Wkn-0007jP-Vp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Wkn-0000fi-03
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:17:25 -0400
Date: Tue, 18 Apr 2017 18:17:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418171712.GO21261@stefanha-x1.localdomain>
References: <20170413154334.23708-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/UvyDgxjlFfP/4zZ"
Content-Disposition: inline
In-Reply-To: <20170413154334.23708-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10?] block: Do not unref
 bs->file on error in BD's open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--/UvyDgxjlFfP/4zZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 05:43:34PM +0200, Max Reitz wrote:
> The block layer takes care of removing the bs->file child if the block
> driver's bdrv_open()/bdrv_file_open() implementation fails. The block
> driver therefore does not need to do so, and indeed should not unless it
> sets bs->file to NULL afterwards -- because if this is not done, the
> bdrv_unref_child() in bdrv_open_inherit() will dereference the freed
> memory block at bs->file afterwards, which is not good.
>=20
> We can now decide whether to add a "bs->file =3D NULL;" after each of the
> offending bdrv_unref_child() invocations, or just drop them altogether.
> The latter is simpler, so let's do that.
>=20
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> It's an issue only in blkdebug, blkreplace and blkverify, and only when
> an error occurs in their open functions; therefore I think this is fine
> to delay until 2.10.
>=20
> However, it *is* a use-after-free newly introduced in 2.9, so that's
> where the question mark comes from...
> ---
>  block/blkdebug.c  | 4 +---
>  block/blkreplay.c | 3 ---
>  block/blkverify.c | 3 ---
>  3 files changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/UvyDgxjlFfP/4zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9koYAAoJEJykq7OBq3PIsvYH/iXXXVqKWZDBjEW8HeQe1giW
WZOCiZ4PX6I3pHrOEeSq91PlOza4KEUymGw5wL7Tomwd7y/0VViPhbeKgb1+zrPb
UKxrUgfpfqI+Rr8h/+2ghOZXMxoLdEu7CjcxyByZ17zLEY7+TaTvH+qEhf5sHyhb
yCFlEyFv2shFluE/tkgtqhDY32CHANk6w4k05UDqevIfoMTszsgg/9Ay264Eme6K
30J6Z+Oa9mpeNYnWigHMrwXIEHDN5ti+pJDkSNyfgzFQ43aKeBpftKPZ2IzDhcIq
A8/lZKxjBc2Zm1f6n02+1NA5x7OA9Nt68hlvg12IXIvC7Jsgm/ty2Hr/hVUsfJw=
=zqrv
-----END PGP SIGNATURE-----

--/UvyDgxjlFfP/4zZ--
