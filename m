Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHBzl-00034Y-Rh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHBzk-0003Xu-Fr
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:38:17 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-2-mreitz@redhat.com>
	<6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a72e32d9-deb4-765b-5a65-b0b800896961@redhat.com>
Date: Fri, 11 May 2018 19:38:08 +0200
MIME-Version: 1.0
In-Reply-To: <6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uU1Dct7njHsTgOpGPXP5ojI8bY00Nz3j4"
Subject: Re: [Qemu-devel] [PATCH 01/13] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uU1Dct7njHsTgOpGPXP5ojI8bY00Nz3j4
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <a72e32d9-deb4-765b-5a65-b0b800896961@redhat.com>
Subject: Re: [PATCH 01/13] qapi: Add default-variant for flat unions
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-2-mreitz@redhat.com>
 <6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
In-Reply-To: <6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 15:12, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> This patch allows specifying a discriminator that is an optional membe=
r
>> of the base struct.=C2=A0 In such a case, a default value must be prov=
ided
>> that is used when no value is given.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/introspect.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++
>> =C2=A0 scripts/qapi/common.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 57
>> ++++++++++++++++++++++++++++++++++--------
>> =C2=A0 scripts/qapi/doc.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++--
>> =C2=A0 scripts/qapi/introspect.py=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++--=
-
>> =C2=A0 scripts/qapi/visit.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 33 ++++++++++++++++++++++--
>> =C2=A0 tests/qapi-schema/test-qapi.py |=C2=A0 2 ++
>> =C2=A0 6 files changed, 101 insertions(+), 17 deletions(-)
>=20
> I've been threatening that we might need this for some time, so I'm gla=
d
> to see it being implemented.=C2=A0 We'll see if the tests in 2 and 3 co=
ver
> the code added here.
>=20
>>
>> diff --git a/qapi/introspect.json b/qapi/introspect.json
>> index c7f67b7d78..2d7b1e3745 100644
>> --- a/qapi/introspect.json
>> +++ b/qapi/introspect.json
>> @@ -168,6 +168,13 @@
>> =C2=A0 # @tag: the name of the member serving as type tag.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An element of @members wi=
th this name must exist.
>> =C2=A0 #
>> +# @default-variant: if the @tag element of @members is optional, this=

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is the default value for choosing=
 a variant.=C2=A0 Its
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value must be a valid value for @=
tag.
>=20
> Perhaps s/must/will/ as this struct is used for output (and therefore w=
e
> always meet the condition, rather than the user having to do something
> correctly).

I mostly copied from the other descriptions which seemed to prefer
"must", but I'm happy with either.

> Nice that you remembered introspection.

I didn't, because I had no idea how introspection works exactly before
this series.  But one of the tests broke, thus telling me I might have
forgotten something. :-)

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Present exactly when @tag is pres=
ent and the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 associated element of @members is=
 optional.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Since: 2.13)
>> +#
>> =C2=A0 # @variants: variant members, i.e. additional members that
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 depend on the type tag's value.=C2=A0 Present exactly when
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 @tag is present.=C2=A0 The variants are in no particular order,

[...]

>> =C2=A0 diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 5d72d8936c..ecffc46bd3 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -40,10 +40,20 @@ def gen_visit_object_members(name, base, members,
>> variants):
>> =C2=A0 void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj,=

>> Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> -
>> =C2=A0 ''',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c_name=3Dc_name(name))
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if variants:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D mcgen('''
>> +=C2=A0=C2=A0=C2=A0 %(c_type)s %(c_name)s;
>> +''',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c_type=3Dvariants.tag=
_member.type.c_name(),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c_name=3Dc_name(varia=
nts.tag_member.name))
>> +
>> +=C2=A0=C2=A0=C2=A0 ret +=3D mcgen('''
>> +
>> +''')
>> +
>=20
> Creating a temp variable makes it easier to handle the default...
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if base:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D mcgen(=
'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 visit_type_%(c_type)s_members(v, (%(c_t=
ype)s *)obj, &err);
>> @@ -75,8 +85,27 @@ void visit_type_%(c_name)s_members(Visitor *v,
>> %(c_name)s *obj, Error **errp)
>> =C2=A0 ''')
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants.default_tag_va=
lue is None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t +=3D mcgen('''
>> +=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_name)s;
>> +''',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 c_name=3Dc_name(variants.tag_member.name))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t +=3D mcgen('''
>> +=C2=A0=C2=A0=C2=A0 if (obj->has_%(c_name)s) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_na=
me)s;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D %(enum_cons=
t)s;
>> +=C2=A0=C2=A0=C2=A0 }
>> +''',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 c_name=3Dc_name(variants.tag_member.name),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 enum_const=3Dc_enum_const(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 variants.tag_member.type.name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 variants.default_tag_value,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 variants.tag_member.type.prefix))
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D mcgen(=
'''
>> -=C2=A0=C2=A0=C2=A0 switch (obj->%(c_name)s) {
>> +=C2=A0=C2=A0=C2=A0 switch (%(c_name)s) {
>=20
> ...compared to the old code that just inlined the one thing that used t=
o
> be assigned to what is now the temporary variable.
>=20
> It might be possible to inline things so that the generated code reads
> either:
>=20
> switch (obj->discriminator) {
> switch (!obj->has_discriminator ? DEFAULT : obj->discriminator) {
>=20
> but I don't think it's worth the effort; and the temporary variable is
> fine even though it makes the generated file bigger.

I don't really mind either way, but depending on the default value and
the discriminator name, using ?: may lead to a rather long line.

>> =C2=A0 ''',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c_name=3Dc_n=
ame(variants.tag_member.name))
>> =C2=A0 diff --git a/tests/qapi-schema/test-qapi.py
>> b/tests/qapi-schema/test-qapi.py
>> index c1a144ba29..f2a072b92e 100644
>> --- a/tests/qapi-schema/test-qapi.py
>> +++ b/tests/qapi-schema/test-qapi.py
>> @@ -56,6 +56,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _print_variants(variants):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 print('=C2=A0=C2=A0=C2=A0 tag %s' % variants.tag_member.name)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 variants.default_tag_value:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0 default variant: %s' %
>> variants.default_tag_value)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for v in variants.variants:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0 case %s: %s' % (=
v.name, v.type.name))
>> =C2=A0
>=20
> Looks good!
> Reviewed-by: Eric Blake <eblake@redhat.com>

Phew. :-)

Thanks!

Max


--uU1Dct7njHsTgOpGPXP5ojI8bY00Nz3j4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr11QAACgkQ9AfbAGHV
z0CWzAf8CXtht3rrWfPNOsren2YisVQEYq9UAt0Oyexa5rplNas3aAtIq+ijHjNA
p5qlloLDc6IWi0bsbrRRzsqCLp8dd/MpaTCv7aLn/aIzwMGOsAc13UTzFyHWB6Ja
3tngDnRXrhpXn2nSMWx0gXPaortK5Z/nrtHptk2VWjK3pFIoCKWNyzuIcyHH8vff
bSjS5g/PJEAQppM+APM4UFUw8vLQ/fr56CPZl8BAnWYP5scyBhZ1jclx++Oz58MN
W3rJbAe7x0DuD+yMlsV0F3Ja5sierF0aeeANudbUm/g3yJymlkLzPyJB1ynH/c68
ZqOfkNUG6VhH26YYaXtci04vJFBppg==
=AYXj
-----END PGP SIGNATURE-----

--uU1Dct7njHsTgOpGPXP5ojI8bY00Nz3j4--
