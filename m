Received: from eggs.gnu.org ([2001:4830:134:3::10]:37134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJGQD-0001Xl-Ec
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJGQ8-0003ry-KP
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:41:37 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dJGQ8-0003rS-Dz
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:41:32 -0400
Received: by mail-wm0-x244.google.com with SMTP id 70so10889255wme.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 02:41:29 -0700 (PDT)
Date: Fri, 9 Jun 2017 10:41:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170609094113.GD26144@stefanha-x1.localdomain>
References: <20170608232255.1621-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <20170608232255.1621-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 02:22:55AM +0300, Manos Pitsidianakis wrote:
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64..1a74339 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -416,16 +416,16 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>                  /* 6-byte LBA + 2-byte range per entry */
>                  uint64_t entry =3D le64_to_cpu(buffer[i]);
>                  uint64_t sector =3D entry & 0x0000ffffffffffffULL;
> -                uint16_t count =3D entry >> 48;
> +                uint16_t bytes =3D entry >> 48;
> =20
> -                if (count =3D=3D 0) {
> +                if (bytes =3D=3D 0) {
>                      continue;
>                  }
> =20
>                  /* Got an entry! Submit and exit.  */
>                  iocb->aiocb =3D blk_aio_pdiscard(iocb->blk,
>                                                 sector << BDRV_SECTOR_BIT=
S,
> -                                               count << BDRV_SECTOR_BITS,
> +                                               bytes << BDRV_SECTOR_BITS,
>                                                 ide_issue_trim_cb, opaque=
);
>                  return;
>              }

This change looks suspicious:

  bytes << BDRV_SECTOR_BITS

Therefore 'bytes' is actually in units of sectors!

Please drop this hunk.

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOm05AAoJEJykq7OBq3PIyXoH/RGgCKIc8aUofNEU42I4Yb+7
h1s0gJDXBjW3SqJKcbS+jDIIr49KuFWBLjMuuYQjl6ApXNBV/No2abA0Oj2LFkr0
cZIDPsLK+8RBiFFdWf6vPs6X7a4IrxjYe7gTJdDPzCiXLC9m86NwMgxcrVPuRYGb
FnfC/saSM1AltFYvQbzkGJ70mnUavQyWRpkmlM3TRWQ52iMftvsUOYqmoLUhe+/o
GdbJXcHbNkvDoCtUXQR9zcilpLHeXYgKBv+5iOlBJxA63ocmcfr7LhhAizG6TOTv
WKxf1JV7OiwrS1sYoodm9LNXNpqsDOmgylcZI8zMuR+Qos/+L0l4ivMrUijbE8g=
=HvzG
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
