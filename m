Received: from eggs.gnu.org ([2001:4830:134:3::10]:41926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dajUW-0003qA-Cp
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dajUM-0007ff-Vz
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dajUM-0007df-N2
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:10:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2C3C64DB9
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:10:05 +0000 (UTC)
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
	<1501148776-16890-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7f16ea7-3d0d-b4a4-6eb1-79a029f60da7@redhat.com>
Date: Thu, 27 Jul 2017 09:10:04 -0500
MIME-Version: 1.0
In-Reply-To: <1501148776-16890-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7kHw5oJGtiXp2PpDtIjlATHc9ndA5EaQl"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] host-utils: Simplify pow2ceil()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7kHw5oJGtiXp2PpDtIjlATHc9ndA5EaQl
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <e7f16ea7-3d0d-b4a4-6eb1-79a029f60da7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] host-utils: Simplify pow2ceil()
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
 <1501148776-16890-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1501148776-16890-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 04:46 AM, Markus Armbruster wrote:
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/host-utils.h | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20

> =20
> -/* round up to the nearest power of 2 (0 if overflow) */
> +/*
> + * Return @value rounded up to the nearest power of two modulo 2^64.
> + * This is *zero* for @value > 2^63, so be careful.
> + */
>  static inline uint64_t pow2ceil(uint64_t value)
>  {
> -    uint8_t nlz =3D clz64(value);
> +    int n =3D clz64(value - 1);
> =20
> -    if (is_power_of_2(value)) {
> -        return value;
> +    if (!n) {
> +        /*
> +         * @value - 1 has no leading zeroes, thus @value - 1 >=3D 2^63=

> +         * Therefore, either @value =3D=3D 0 or @value > 2^63.
> +         * If it's 0, return 1, else return 0.
> +         */
> +        return !value;

Tricky, but the comment is worth its weight in gold.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7kHw5oJGtiXp2PpDtIjlATHc9ndA5EaQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll59DwACgkQp6FrSiUn
Q2oOLQgAj5UqNPIamxgJC/lUly92efdCwhYyfJ5wVvjEAotBC9BQkf7vQ8AYrvPw
VwT705CAc1x1BgrpmshypqU3DVGdCLXKJOYIKDfoB8giqzZj1IQzTU+/DrGTEm7k
o06GOhCKIlu6yIB7F0hhaPZbT/pvDu0TC98PityUUdgTPl3MTiwlC/6p1XgmrVC5
Y5Uup2WewSRQfPbStmizveQFtl/IyJLDPukW5F3gE21KPuHS/jqX4ICiuj9eqm85
Ffj7xBuVClyg/emDfBuso9X2SNYG1liVwgXrLJCjRr/rnnvo1dlceMOWfDWHCVpT
cAyXkvDAw7WYxGeZ38uhbJfYF8Uf8w==
=ZWUJ
-----END PGP SIGNATURE-----

--7kHw5oJGtiXp2PpDtIjlATHc9ndA5EaQl--
