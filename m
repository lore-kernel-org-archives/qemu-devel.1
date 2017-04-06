Received: from eggs.gnu.org ([2001:4830:134:3::10]:36823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw979-0004KB-4g
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw975-00085C-VB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cw975-000854-P6
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:14:19 -0400
Date: Thu, 6 Apr 2017 16:14:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170406151415.GE31259@stefanha-x1.localdomain>
References: <1491405126-30591-1-git-send-email-den@openvz.org>
	<1491405126-30591-2-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <1491405126-30591-2-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] parallels: create
 parallels_inactivate() callback of block driver state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 06:12:05PM +0300, Denis V. Lunev wrote:
> We should avoid to image file at migration end when BDRV_O_INACTIVE

s/avoid to image/avoid writing to the image/ ?

> is set on the block driver state. All modifications should be done
> in advance, i.e. in bdrv_inactivate.
>=20
> The patch also adds final bdrv_flush() to be sure that changes have
> reached disk finally before other side will access the image.

If migration fails/cancels on the source after .bdrv_inactivate() we
need to return to the "activated" state.  .bdrv_invalidate_cache() will
be called so I think it needs to be implemented by parallels to set
s->header->inuse again if BDRV_O_RDWR.

=2Ebdrv_invalidate_cache() is also called on the destination at live
migration handover.  That's okay - it makes sense for the destination to
set the inuse field on success.

> -static void parallels_close(BlockDriverState *bs)
> +static int parallels_inactivate(BlockDriverState *bs)
>  {
> +    int err;
>      BDRVParallelsState *s =3D bs->opaque;
> =20
> -    if (bs->open_flags & BDRV_O_RDWR) {
> -        s->header->inuse =3D 0;
> -        parallels_update_header(bs);
> +    if (!(bs->open_flags & BDRV_O_RDWR)) {
> +        return 0;
> +    }
> +
> +    s->header->inuse =3D 0;
> +    err =3D parallels_update_header(bs);
> +    if (err < 0) {

Should we set s->header->inuse again in all error paths in case
something calls parallels_hupdate_header() again later?

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5ltHAAoJEJykq7OBq3PIqGAH/1Sj7gEtPlQOsSZPyucmuTVX
70BkHIPiV0ZQ4kRHj9P+znRAZXz4GgwqfUhOLHzUA3PjawyuamjkLmJqgmSQugWn
XsHmU4VsmWw9lMaYjzSYCvmOZ5YYJuac4qot7QGemwLr7KCbQKVU0eeO2aUNFjxd
Cy5G4PPT+3YlxIWZyXerV64fAjX/v85zkJ43VUeEaG+Bt+kR3uH421h5geKjkxcN
aYJoBkyuDJvhP8Ob2ZNm0qPVUXeN4PCL95bmFBNjGTcwC6RKWdMfm8pNZ9cVvB6P
UVmG8rGCG/qnTk7LGrA2s0s6cb0P1DQ+lRZ2qWehVyPN7vU4NwyqFDfx8vnOjHI=
=SKt+
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
