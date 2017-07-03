Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dRzgh-0002XK-Nr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dRzgg-0003Mt-MD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:38:43 -0400
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f246d4de-997b-2523-b2d1-ba89d950b072@redhat.com>
Date: Mon, 3 Jul 2017 06:38:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170622124204.19407-11-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LCQwRBd1wEs3puLAFBauJIxg36LrM2MbQ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/31] vvfat: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LCQwRBd1wEs3puLAFBauJIxg36LrM2MbQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f246d4de-997b-2523-b2d1-ba89d950b072@redhat.com>
Subject: Re: [Qemu-block] [PATCH 10/31] vvfat: use DIV_ROUND_UP
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
 <20170622124204.19407-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/vvfat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 426ca70e35..877f71dcdc 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -433,7 +433,7 @@ static inline direntry_t* create_long_filename(BDRV=
VVFATState* s,const char* fil
>  {
>      char buffer[258];
>      int length=3Dshort2long_name(buffer,filename),
> -        number_of_entries=3D(length+25)/26,i;
> +        number_of_entries=3DDIV_ROUND_UP(length, 26),i;

This formatting made me do a double take (at first, I thought it was a
comma expression, before realizing it was a declaration).  While you are
touching it, can you please rewrite it into something more legible, such =
as:

int length =3D short2long_name(buffer, filename);
int number_of_entries =3D DIV_ROUND_UP(length, 26);
int i;

I don't mind declaring multiple variables in one declaration - provided
that we aren't also initializing them.  But mixing in the un-initialized
declaration of 'i' with other initialized variables is just awkward.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LCQwRBd1wEs3puLAFBauJIxg36LrM2MbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWiy3AAoJEKeha0olJ0NqJNwH/0H6GwdKD5EBbfhUtLMytVaJ
jNaJJWAKWZds5/2IUBmEpXpHZUofoEciMC0gnzcUKP5r6iSmh8v4bRyKnJtD/JKF
X6tDVF8TFesSm9nFq+Fu74rmmMwEX9cmfNyI0i4vZcC98ZNKGlfKUpcXGslbdaRT
wmXSh9cpxGrp+53RbcU1/ylwlP6Lus23flBZVQlHLmlDqAMmQaA5sEJEyPwn/x9P
4ARJ/dNGZEFfe+NnkwMhPPuYkZqfa9LvtTkuwlb771xSFfG0iKDxLQEt3Tv7NqaQ
XIM53vkA+Rp0fdZmQ139AMxTlbniqrpQ0k9mfWKzdT9N42jSnMCZZwmFLICuTPc=
=0Wgd
-----END PGP SIGNATURE-----

--LCQwRBd1wEs3puLAFBauJIxg36LrM2MbQ--
