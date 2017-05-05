Received: from eggs.gnu.org ([2001:4830:134:3::10]:33139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6k6A-0003iy-Gw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6k67-0005ZP-DA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6k67-0005YV-48
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:45:07 -0400
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-3-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f623263-e78c-fbb3-5ac4-5629d68c4bbc@redhat.com>
Date: Fri, 5 May 2017 15:45:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170505201128.12099-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u0iKBwErNuCfM84lQ0JucpM00U4OahXeE"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add enum_table[] parameter to
 start_alternate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u0iKBwErNuCfM84lQ0JucpM00U4OahXeE
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <9f623263-e78c-fbb3-5ac4-5629d68c4bbc@redhat.com>
Subject: Re: [PATCH v2 2/3] qapi: Add enum_table[] parameter to
 start_alternate
References: <20170505201128.12099-1-ehabkost@redhat.com>
 <20170505201128.12099-3-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:11 PM, Eduardo Habkost wrote:
> The new parameter will be used by the string input visitor to detect
> alternate types that can't be parsed unambiguously.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * (new patch added to series)
> ---

> +++ b/include/qapi/visitor.h
> @@ -411,13 +411,21 @@ void visit_end_list(Visitor *v, void **list);
>   * @supported_qtypes is a bit mask indicating which QTypes are support=
ed
>   * by the alternate.
>   *
> + * @enum_table contains the enum value lookup table, in case
> + * strings in the input are going to be parsed as enums. Visitors
> + * aren't required to validate string input according to
> + * enum_table, as visit_type_enum() will be called automatically
> + * if (*obj)->type is QTYPE_QSTRING.

Presumably, enum_table will be NULL if the alternate type does not
include an enum?  [reads ahead] yes. Should be documented.

I'm less convinced we need this patch, if we can instead guarantee at
QAPI-generation time that alternates are not possible if they would
cause an ambiguity.


> +++ b/scripts/qapi-visit.py
> @@ -166,6 +166,12 @@ def gen_visit_alternate(name, variants):
>      supported_qtypes =3D ' | '.join(qtypes)
>      ret =3D ''
> =20
> +    enum_table =3D 'NULL'
> +    for var in variants.variants:
> +        if isinstance(var.type, QAPISchemaEnumType):
> +            enum_table =3D '%s_lookup' % (var.type.c_name())
> +            break
> +
>      ret +=3D mcgen('''
> =20
>  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **=
obj, Error **errp)
> @@ -174,7 +180,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *=
name, %(c_name)s **obj, Error
>      uint32_t supported_qtypes =3D %(supported_qtypes)s;
> =20
>      visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**=
obj),
> -                          supported_qtypes, &err);
> +                          supported_qtypes, %(enum_table)s, &err);

So there's where you populate the enum through.

I'll have to see where 3/3 goes before deciding if this is worth having.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u0iKBwErNuCfM84lQ0JucpM00U4OahXeE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDORNAAoJEKeha0olJ0NqJp8H/iSlcD5N77G6uFk8Q1jZaUCi
GFFGx0K3skFvCfViZJw0TeoYI+l9at+4L5D1Dz9JmUDcMjgyjJd6zBbNh8iURB6V
MO2OgBzWnmZ4zG9+1af+//Y5nVpIOkyOaHCHw1MN2epWitpeP/7GuiCCB5VH8bni
y6/6upDp9EbsTUQzw5JXt39zZF4XC/ai1WAxibLdlY5xwb6rmMt6ZPQqlgi897yt
HBoJCtr2u32GRomEHDCxv1xlUezKiLYlQsSA7suK+PbkP2ZKclo00EYZ/BLfHAYy
kwmU/8qKyT66Y8i/25/JG8PMZiunW/WJihl/6vGDmMzKvHzYuDAwha+Trk/1Uwo=
=zf8j
-----END PGP SIGNATURE-----

--u0iKBwErNuCfM84lQ0JucpM00U4OahXeE--
