Received: from eggs.gnu.org ([208.118.235.92]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdlK-0000Yq-7f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdkM-0004YP-2b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdkL-0004Y8-JA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:59:25 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
Date: Fri, 2 Feb 2018 09:59:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZZt9N8tL16VT1xeuaxqRHcaURHf9K4cGs"
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZZt9N8tL16VT1xeuaxqRHcaURHf9K4cGs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
Subject: Re: [PATCH RFC 03/21] qapi: New classes QAPIGenC, QAPIGenH,
 QAPIGenDoc
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-4-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> These classes encapsulate accumulating and writing output.
>=20
> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
> rather shallow: most of the output accumulation is not converted.
> Left for later.
>=20
> The indentation machinery uses a single global variable indent_level,
> even though we generally interleave creation of a .c and its .h.  It
> should become instance variable of QAPIGenC.  Also left for later.
>=20
> Documentation generation isn't converted, and QAPIGenDoc isn't used.
> This will change shortly.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-commands.py   | 27 ++++++-------
>  scripts/qapi-event.py      | 26 +++++++------
>  scripts/qapi-introspect.py | 22 ++++++-----
>  scripts/qapi-types.py      | 26 +++++++------
>  scripts/qapi-visit.py      | 26 +++++++------
>  scripts/qapi.py            | 96 ++++++++++++++++++++++++++------------=
--------
>  6 files changed, 122 insertions(+), 101 deletions(-)
>=20

A little bit longer due to more structure, but reasonable diffstat in
that it shows the conversion is fairly straightforward and opens the
doors for later patches to use the new structures more effectively.

> =20
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenEventVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenEventVisitor()
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)

I don't know if it is worth a sentence in the commit message that the
visitor variable is renamed from 'gen' to 'vis' for less confusion with
the new class instances 'genc' and 'genh'.

> +++ b/scripts/qapi-types.py
> @@ -180,7 +180,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self.decl =3D ''
>          self.defn =3D ''
>          self._fwdecl =3D ''
> -        self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
> +        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')

Tweaks like this means you were paying attention to still producing
identical generated files; always a good sign.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ZZt9N8tL16VT1xeuaxqRHcaURHf9K4cGs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0itcACgkQp6FrSiUn
Q2p1Ngf/WJNdX27SklIjmzzoiaSX0Z4kY9dME2koABgLBaQumNAwuEhFnQUBZBJU
plg7V4kvS0//h/Sp+MVocUUZbSVr9oEN0jasdQTboSbNBP+7ERCNg2NEQZBx+A5A
Vk3GYYSu5suLEVWvZAvWflVlx93ez1K3d5WxLYIDot4XtElRxX4Oi/Own6lQ3oSj
eDJ+NMpN1wEDAqiXuEOHqbDcEQ9SJk8uugE8yYuQ/UCMxH78kIVzcKU+LeGYE/c1
dEp1PJMp7mHzhX9iaIjkrK3uHOkaupL3JEvBoIWHJBhEZV4M3MmgqQSp5rJHoxIe
uZ6GjWk9iZEJG5G3lXT2y2U1CjZ0dw==
=mxms
-----END PGP SIGNATURE-----

--ZZt9N8tL16VT1xeuaxqRHcaURHf9K4cGs--
