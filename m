Received: from eggs.gnu.org ([209.51.188.92]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBIzC-0002yN-CS
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBIzB-0006t1-9r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hBIzA-0006rj-S2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:57:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B3B33078AA7
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 12:57:51 +0000 (UTC)
References: <20190402073018.17747-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ccd76d0f-19f4-9a66-8f64-4f9498d95ea1@redhat.com>
Date: Tue, 2 Apr 2019 07:57:47 -0500
MIME-Version: 1.0
In-Reply-To: <20190402073018.17747-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cv98q7f0IXp1Za8GHtRokmvhgyyHgtTQV"
Subject: Re: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cv98q7f0IXp1Za8GHtRokmvhgyyHgtTQV
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ccd76d0f-19f4-9a66-8f64-4f9498d95ea1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
References: <20190402073018.17747-1-kraxel@redhat.com>
In-Reply-To: <20190402073018.17747-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/2/19 2:30 AM, Gerd Hoffmann wrote:
> On some systems wchar_t is "long int", on others just "int".

And elsewhere, it's 'short'.

> So go cast to "long int" and adjust the printf format accordingly.
>=20
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/curses.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index cc6d6da68463..fb63945188b2 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>      swch =3D sizeof(wch);
> =20
>      if (iconv(conv, &pwch, &swch, &pch, &sch) =3D=3D (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-=
2: %s\n",
> -                        wch, strerror(errno));
> +        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS=
-2: %s\n",
> +                (unsigned long)wch, strerror(errno));

Sadly, I think you are right that a cast is necessary; there is no
reserved printf character for printing wchar_t as an integer, and the
width of wchar_t is unspecified (on 32-bit systems where it is 'long
int', it does not promote to 'int').

You could have also stuck with %02x and (int)wch, for less typing, but
it's not worth the respin.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cv98q7f0IXp1Za8GHtRokmvhgyyHgtTQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyjXEsACgkQp6FrSiUn
Q2pqrgf+LgtgkCDXYtVaZjs6WUhR8Kg4z3WzkMtt1HD2r9ON0AAT8cLcueJT8IrP
aId8JBoPf2zFQ6zzWjg26+gjcjtrn0J/S5kPe9Ryk5BDnVbfbOXeR9TFHqdKbdMh
jtCtUg3g81eOZ815Wbx+uzf14oGen9gK23sME7yqomcAG8R1Dq+ldTHG1+nanE3d
sqpXeyL+Y8V7ddQ9TsNEeReI/MiH2E6QLf8QjlGFHEvjWkYEKMTX3Y+JWdF+2pUi
z/mwrdBqSpQACbtwHSoY3s1dZMR++vQ8Y7AFyx29Tym2SBwemFyQLqwvkYxQJ9pd
UOY9z/yEah9KXTO/sUlg9ZNCH9EhrA==
=j4Aq
-----END PGP SIGNATURE-----

--cv98q7f0IXp1Za8GHtRokmvhgyyHgtTQV--
