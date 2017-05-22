Received: from eggs.gnu.org ([2001:4830:134:3::10]:45443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrv8-0001By-Tn
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrv4-0003oK-Ms
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCrv4-0003ny-D8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:19:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A5EF804F7
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 18:19:01 +0000 (UTC)
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
	<1495471335-23707-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b996cbf-028a-0f45-e7ba-6b599680fc9a@redhat.com>
Date: Mon, 22 May 2017 13:18:59 -0500
MIME-Version: 1.0
In-Reply-To: <1495471335-23707-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="stsxe9kPv5Jdx0rdpfp0Jjv4r6woFJhV0"
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: Reject alternates that can't
 work with keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stsxe9kPv5Jdx0rdpfp0Jjv4r6woFJhV0
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com
Message-ID: <4b996cbf-028a-0f45-e7ba-6b599680fc9a@redhat.com>
Subject: Re: [PATCH 4/4] qapi: Reject alternates that can't work with
 keyval_parse()
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
 <1495471335-23707-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:42 AM, Markus Armbruster wrote:
> Alternates are sum types like unions, but use the JSON type on the
> wire / QType in QObject instead of an explicit tag.  That's why we
> require alternate members to have distinct QTypes.
>=20
> The recently introduced keyval_parse() (commit d454dbe) can only
> produce string scalars.  The qobject_input_visitor_new_keyval() input
> visitor mostly hides the difference, so code using a QObject input
> visitor doesn't have to care whether its input was parsed from JSON or
> KEY=3DVALUE,...  The difference leaks for alternates, as noted in commi=
t
> 0ee9ae7: an non-string, non-enum scalar alternate value can't

s/an non/a non/

> currently be expressed.
>=20
> In part, this is just our insufficiently sophisticated implementation.
> Consider alternate type 'GuestFileWhence'.  It has an integer member
> and a 'QGASeek' member.  The latter is an enumeration with values
> 'set', 'cur', 'end'.  The meaning of b=3Dset, b=3Dcur, b=3Dend, b=3D0, =
b=3D1 and
> so forth is perfectly obvious.  However, our current implementation
> falls apart at run time for b=3D0, b=3D1, and so forth.  Fixable, but n=
ot
> today; add a test case and a TODO comment.
>=20
> Now consider an alternate type with a string and an integer member.
> What's the meaning of a=3D42?  Is it the string "42" or the integer 42?=

> Whichever meaning you pick makes the other inexpressible.  This isn't
> just an implementation problem, it's fundamental.  Our current
> implementation will pick string.
>=20
> So far, we haven't needed such alternates.  To make sure we stop and
> think before we add one that cannot sanely work with keyval_parse(),
> let's require alternate members to have sufficiently district

s/district/distinct/

> representation in KEY=3DVALUE,... syntax:
>=20
> * A string member clashes with any other scalar member
>=20
> * An enumeration member clashes with bool members when it has value
>   'on' or 'off'.

Does case-(in)sensitivity factor in here? Should it also be a problem
for an enum member with value 'true' or 'false'?

>=20
> * An enumeration member clashes with numeric members when it has a
>   value that starts with '-', '+', '0' or '9'.  This is a rather lazy

s/'0' or '9'/or among '0' to '9'/

>   approximation of the actual number syntax accepted by the visitor.
>=20
>   Note that enumeration values starting with '-' and '+' are rejected
>   elsewhere already, but better safe than sorry.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/scripts/qapi.py
> @@ -812,11 +812,26 @@ def check_alternate(expr, info):
>          if not qtype:
>              raise QAPISemError(info, "Alternate '%s' member '%s' canno=
t use "
>                                 "type '%s'" % (name, key, value))
> -        if qtype in types_seen:
> +        conflicting =3D set([qtype])
> +        if qtype =3D=3D 'QTYPE_QSTRING':
> +            enum_expr =3D enum_types.get(value)
> +            if enum_expr:
> +                for v in enum_expr['data']:
> +                    if v in ['on', 'off']:

what about 'true', 'false'?

Do we care about case insensitive?

> +                        conflicting.add('QTYPE_QBOOL')
> +                    if re.match(r'[-+0-9.]', v): # lazy, could be tigh=
tened
> +                        conflicting.add('QTYPE_QINT')
> +                        conflicting.add('QTYPE_QFLOAT')
> +            else:
> +                conflicting.add('QTYPE_QINT')
> +                conflicting.add('QTYPE_QFLOAT')
> +                conflicting.add('QTYPE_QBOOL')
> +        if conflicting & set(types_seen):
>              raise QAPISemError(info, "Alternate '%s' member '%s' can't=
 "
>                                 "be distinguished from member '%s'"
>                                 % (name, key, types_seen[qtype]))
> -        types_seen[qtype] =3D key
> +        for qt in conflicting:
> +            types_seen[qt] =3D key
> =20

Looks good.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--stsxe9kPv5Jdx0rdpfp0Jjv4r6woFJhV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyuTAAoJEKeha0olJ0NqTxAH/jCbuaeHO5I83M9ppk0+ePn5
sHgjEe98jCiHGnbaAAmSY+KzOzjYG17q6UWRmqeoO4qT9Cck3HitCD6p49AP5D47
c9BeW2DsTqNKIebLKPTej4f86VqmuLirAjEKvNa2gEAei5NA5Q0MsQm1xWaIaAxe
sh8+vZQ4UtI3MBoUlVY+dEcFWVoaY7n8VX52HwhxG2vBU3ajcMZWuOgg9dO1N04q
oHflw5LOwG08Dy7Qge/nioDh6liDSS+QTFYIaGss/vcAwsbx47V2T6xIwWwgFC0y
RwT08SXl2KeuKaxNT544RMlUVCHursH5FmJvhxOMtn2qoT6jjaRSwUOdTiUigkE=
=ipL4
-----END PGP SIGNATURE-----

--stsxe9kPv5Jdx0rdpfp0Jjv4r6woFJhV0--
