Received: from eggs.gnu.org ([2001:4830:134:3::10]:38281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fMZ-0004CM-Ii
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fMW-0001NF-9Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5fMV-0001N7-WB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:29:36 -0400
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-2-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0cc1a96d-c828-d055-7024-3d3296e82be1@redhat.com>
Date: Tue, 2 May 2017 16:29:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170502203115.22233-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5RiX7bXFbPnkfTAQJ4MC4aJNM2RhhDSWs"
Subject: Re: [Qemu-devel] [PATCH 1/4] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5RiX7bXFbPnkfTAQJ4MC4aJNM2RhhDSWs
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <0cc1a96d-c828-d055-7024-3d3296e82be1@redhat.com>
Subject: Re: [PATCH 1/4] visitor: Add 'supported_qtypes' parameter to
 visit_start_alternate()
References: <20170502203115.22233-1-ehabkost@redhat.com>
 <20170502203115.22233-2-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 03:31 PM, Eduardo Habkost wrote:
> This will allow visitors to make decisions based on the supported qtype=
s
> of a given alternate type. The new parameter can replace the old
> 'promote_int' argument, as qobject-input-visitor can simply check if
> QTYPE_QINT is set in supported_qtypes.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

> @@ -416,7 +417,7 @@ void visit_end_list(Visitor *v, void **list);
>   */
>  void visit_start_alternate(Visitor *v, const char *name,
>                             GenericAlternate **obj, size_t size,
> -                           bool promote_int, Error **errp);
> +                           unsigned long supported_qtypes, Error **err=
p);

Why unsigned long (which is platform-dependent in size)? At the moment,
even unsigned char happens to be long enough, although I probably would
have used uint32_t.

Oh, I see, it's because you use the BIT() macros from bitops.h, which
are hardcoded to unsigned long.

> +++ b/scripts/qapi-visit.py
> @@ -161,20 +161,21 @@ void visit_type_%(c_name)s(Visitor *v, const char=
 *name, %(c_name)s *obj, Error
> =20
> =20
>  def gen_visit_alternate(name, variants):
> -    promote_int =3D 'true'
> +    qtypes =3D ['BIT(%s)' % (var.type.alternate_qtype())
> +              for var in variants.variants]
> +    supported_qtypes =3D '|'.join(qtypes)

Do you want ' | '.join(qtypes), so that at least the generated code
still follows recommended operator spacing? (The line is long no matter
what, though, and that's not worth worrying about.)

>      ret =3D ''
> -    for var in variants.variants:
> -        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT':
> -            promote_int =3D 'false'
> =20
>      ret +=3D mcgen('''
> =20
>  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **=
obj, Error **errp)
>  {
>      Error *err =3D NULL;
> +    unsigned long supported_qtypes =3D %(supported_qtypes)s;
> =20
> +    assert(QTYPE__MAX < BITS_PER_LONG);

Do we really have to generate a separate copy of this assert in every
generated function?  Especially when we know it is true by construction,
that seems like a lot.  Having the assertion once in a .c file rather
than generated in multiple functions might be acceptable, though.

> +++ b/qapi/qobject-input-visitor.c

> @@ -349,7 +351,7 @@ static void qobject_input_start_alternate(Visitor *=
v, const char *name,
>      }
>      *obj =3D g_malloc0(size);
>      (*obj)->type =3D qobject_type(qobj);
> -    if (promote_int && (*obj)->type =3D=3D QTYPE_QINT) {
> +    if (!(supported_qtypes & BIT(QTYPE_QINT)) && (*obj)->type =3D=3D Q=
TYPE_QINT) {

Experimenting, does this read any better:

if (!extract32(supported_qtypes, QTYPE_QINT, 1) && ...

which would be another argument for uint32_t instead of unsigned long in
the signature.

The idea makes sense, but I'm still not necessarily sold on using a long.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5RiX7bXFbPnkfTAQJ4MC4aJNM2RhhDSWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCPo8AAoJEKeha0olJ0NqvNwH/0mQPV5ctaa2MFVsg2GpbKFZ
b8S4D4KM2dNpcVl+npWQU5aQCdkVcKMVuwGyWJyWucs1Fccmh1NOTSKU71LTW8Sw
szMl4RRjEEfI5HJjTrT3gEoxT1o1z2y3spXmPAX2Fhi1+T7s3RmeUZV64vF5yms9
xyaCuZ6c4QgFZw66jMr4iLnLY4cfnEVXTXGlASUWy20/HuV41TGT5zoE2aKdifXi
xkAcjWOqof2Fkfvq5Nw0ADgAuGD00+m7uUE/OeuBfpE7uFbH6eH58GVU/KPLY4sK
nf9hq2eVxl5HwqlAJkYVzPg/FMsdpwbFDzndIQyl9lnKY/ycmO7oy+VDM+OO45A=
=o/58
-----END PGP SIGNATURE-----

--5RiX7bXFbPnkfTAQJ4MC4aJNM2RhhDSWs--
