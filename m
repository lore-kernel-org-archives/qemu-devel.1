Received: from eggs.gnu.org ([2001:4830:134:3::10]:34815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPzc-0005HU-Jy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPzZ-0000so-Hy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:59:36 -0500
References: <1484160658-15419-1-git-send-email-joserz@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6122a696-b85c-4fc8-b0be-a3b80fbb761f@redhat.com>
Date: Wed, 11 Jan 2017 14:59:29 -0600
MIME-Version: 1.0
In-Reply-To: <1484160658-15419-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8GeIfBBip9hdFl9aWGF2tVfS4MsOuV0hI"
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix a warning in bcdcfz code and
 improve BCD_DIG_BYTE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, 655708@bugs.launchpad.net, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8GeIfBBip9hdFl9aWGF2tVfS4MsOuV0hI
From: Eric Blake <eblake@redhat.com>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au,
 nikunj@linux.vnet.ibm.com, 655708@bugs.launchpad.net, thuth@redhat.com
Message-ID: <6122a696-b85c-4fc8-b0be-a3b80fbb761f@redhat.com>
Subject: Re: [PATCH] ppc: Fix a warning in bcdcfz code and improve
 BCD_DIG_BYTE macro
References: <1484160658-15419-1-git-send-email-joserz@linux.vnet.ibm.com>
In-Reply-To: <1484160658-15419-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 12:50 PM, Jose Ricardo Ziviani wrote:
> This commit fixes a warning in the code "(i * 2) ? .. : ..", which
> should be better as "(i) ? .. : ..", and improves the BCD_DIG_BYTE

Could remove the () around i here.

> macro by placing parentheses around its argument to avoid possible
> expansion issues like: BCD_DIG_BYTE(i + j).
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  target/ppc/int_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 24e5964..d889084 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2583,9 +2583,9 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, ppc_avr_t *c)
>  #define NATIONAL_NEG    0x2D
> =20
>  #if defined(HOST_WORDS_BIGENDIAN)
> -#define BCD_DIG_BYTE(n) (15 - (n/2))
> +#define BCD_DIG_BYTE(n) (15 - ((n) / 2))
>  #else
> -#define BCD_DIG_BYTE(n) (n/2)
> +#define BCD_DIG_BYTE(n) ((n) / 2)
>  #endif
> =20
>  static int bcd_get_sgn(ppc_avr_t *bcd)
> @@ -2908,7 +2908,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b=
, uint32_t ps)
>      }
> =20
>      for (i =3D 0; i < 16; i++) {
> -        zone_digit =3D (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zon=
e_lead;
> +        zone_digit =3D (i) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_le=
ad;

Extra (); I'd go with zone_digit =3D i ? ...

With that tweak,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8GeIfBBip9hdFl9aWGF2tVfS4MsOuV0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdpyxAAoJEKeha0olJ0NqiVYIAJr8s43R/rMNNc2RAp5Ig3Xc
6rIcOGqAzpCarkegGNncz05u29rvFf4rhmuRJHU8L6XvVb7XoqR6WShR4d9VcgJW
g+G+5QZ3zNBWg1FF215aUdeU8JSwJvUh804CP+PqKwU3dza0NSIF0q5NrJPESjB/
w5Ld/eMKWowaAWMuGAIv216bxM5v2iLEko84VM8pp6a2s8GktMWpfwr+5fxUdJ04
uahCmz/PB4ZLGhrKA025LWLTwJxPJHihp7PrbDk+A82KAQLD4+N3KgY7ib1X3x0t
YuEklZN6ZiHkOL891XR6xHq4WGpagZNQMmcmTOb+3npmYQaqqL08t80Gari8Rrc=
=aTSO
-----END PGP SIGNATURE-----

--8GeIfBBip9hdFl9aWGF2tVfS4MsOuV0hI--
