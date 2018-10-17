Received: from eggs.gnu.org ([2001:4830:134:3::10]:45345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiEx-000709-NZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiEs-0007tz-OK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:35:43 -0400
Date: Wed, 17 Oct 2018 10:35:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017093535.GH22755@stefanha-x1.localdomain>
References: <20181016172503.27814-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline
In-Reply-To: <20181016172503.27814-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/vdi: Don't take address
 of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 06:25:03PM +0100, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
>=20
> There are a few places where the in-place swap function is
> used on something other than a packed struct field; we convert
> those anyway, for consistency.
>=20
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
>=20
> There are other places where we take the address of a packed member
> in this file for other purposes than passing it to a byteswap
> function (all the calls to qemu_uuid_*()); we leave those for now.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Another "tested with make check" auto-conversion patch. In this
> case, as noted above, it doesn't fix all the warnings for the file,
> but we might as well put the easy part of the fix in. I'm not sure
> what to do with the qemu_uuid_*() calls. Something like
>      QemuUUID uuid_link =3D header->uuid_link;
> and then using "qemu_uuid_is_null(uuid_link)" rather than

I would take this route.  (I think you mean qemu_uuid_is_null(&uuid_link).)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwJnAAoJEJykq7OBq3PI6HgH/07F/7vbf7pdUoGfS1dLLeeV
DrDIWqCMMj1q6YpDKx7de07aOh9pT8xJRxmS5/DHkM3afb9/OZ1zXzLX5OeJG76C
tGB6J1lByOz6dxzBLdwXbQ8xUU8lzD7oRLaXZ5Ooy/d7yKKuvYobnSucHeA+X9Te
vsyh7sx8a5dShQAIX8SVKBSB8wIQlRqSjSNBH/TEzCzIVG5oXjOPirJVZv1FQXwy
MGBXhQUAyKu/AZcip60Vdcbsqpt+Fs8R4/I06a0x5HX/rr1eoaqROOr3jE4+UJvQ
nxLu6LOSVDi2+4pqctLeXVbnUrppGpu0rGJEVlzdyLtAAMsN9Ugcek78G+P3DsE=
=DJlF
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--
