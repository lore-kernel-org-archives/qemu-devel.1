Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinOw-00013l-MN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinOv-0005Gk-PA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:25:34 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93694acf-d6ed-b74d-1641-85b9a1589bd6@redhat.com>
Date: Tue, 28 Feb 2017 13:25:24 -0600
MIME-Version: 1.0
In-Reply-To: <1488194450-28056-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AfVKNOBV9uES50ti67WXpeIcefRJcA1Id"
Subject: Re: [Qemu-devel] [PATCH 14/24] check-qjson: Test errors from
 qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AfVKNOBV9uES50ti67WXpeIcefRJcA1Id
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com
Message-ID: <93694acf-d6ed-b74d-1641-85b9a1589bd6@redhat.com>
Subject: Re: [PATCH 14/24] check-qjson: Test errors from qobject_from_json()
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:20 AM, Markus Armbruster wrote:
> Pass &error_abort with known-good input.  Else pass &err and check
> what comes back.  This demonstrates that the parser fails silently for
> many errors.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c | 88 ++++++++++++++++++++++++++++++++++-----------=
--------
>  1 file changed, 56 insertions(+), 32 deletions(-)
>=20

> @@ -809,7 +811,7 @@ static void utf8_string(void)
>          utf8_in =3D test_cases[i].utf8_in ?: test_cases[i].utf8_out;
>          json_out =3D test_cases[i].json_out ?: test_cases[i].json_in;
> =20
> -        obj =3D qobject_from_json(json_in, NULL);
> +        obj =3D qobject_from_json(json_in, utf8_out ? &error_abort : N=
ULL);

This one ignores errors if utf8_out is not specified; intentional?
Especially when compared to...


>  static void unterminated_string(void)
>  {
> -    QObject *obj =3D qobject_from_json("\"abc", NULL);
> +    Error *err =3D NULL;
> +    QObject *obj =3D qobject_from_json("\"abc", &err);
> +    g_assert(!err);             /* BUG */
>      g_assert(obj =3D=3D NULL);

change like these.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AfVKNOBV9uES50ti67WXpeIcefRJcA1Id
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtc6kAAoJEKeha0olJ0NqoYQH/j8ZtDb1ytDNypaGgKxp65uk
6koBeg0hHFsg9POYDRXsJ0nIOs04ahGebUK6jcBx/rJU/WMChLAhJQJTHUw7q71U
TlrLvvK/J0ROaXzZbUZ/6+534qzt/3L/1GD/vwfvqlQpWZKvFBnm78g5/ej3rA5q
De9siaCCsWllQKfIrdzayjkyCr81/iL/S9kEidGWffLOmSUsdhMCvx9vnuTpim3Z
KHpFLxFo6MKZ35174clgtuHzoxP9yYzu0fO3ai7+Jt6ccHb1ABLNIkQ2keQIclxY
WvWftIwpefejbr/QwKEoyllWra0UnBxs8l+iHoFBTGbxV08Q8aFih4vI6SjuXWE=
=uzx+
-----END PGP SIGNATURE-----

--AfVKNOBV9uES50ti67WXpeIcefRJcA1Id--
