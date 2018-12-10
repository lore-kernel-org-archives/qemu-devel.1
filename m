Received: from eggs.gnu.org ([2001:4830:134:3::10]:45990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWPP8-00067s-Up
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWPP7-0003XB-V4
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWPP7-0003Wr-Mz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:31:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-16-marcandre.lureau@redhat.com>
Date: Mon, 10 Dec 2018 18:31:35 +0100
In-Reply-To: <20181208111606.8505-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:54 +0400")
Message-ID: <87zhtdcmq0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 15/27] qapi: add an error in
 case a discriminator is conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Making a discriminator conditional doesn't make much sense.

Good point (so easy to overlook!), but why first add the 'if' feature
broken that way in PATCH 13, then fix it up in PATCH 15?

>                                                             Instead,
> the union could be made conditional.

What do you mean by that?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py                          |  8 ++++++++
>  tests/Makefile.include                          |  1 +
>  .../flat-union-invalid-if-discriminator.err     |  1 +
>  .../flat-union-invalid-if-discriminator.exit    |  1 +
>  .../flat-union-invalid-if-discriminator.json    | 17 +++++++++++++++++
>  .../flat-union-invalid-if-discriminator.out     |  0
>  6 files changed, 28 insertions(+)
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index aec51acb07..f79b3fad54 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -578,6 +578,7 @@ def find_alternate_member_qtype(qapi_type):
>  # Return the discriminator enum define if discriminator is specified as =
an
>  # enum type, otherwise return None.
>  def discriminator_find_enum_define(expr):
> +    name =3D expr['union']
>      base =3D expr.get('base')
>      discriminator =3D expr.get('discriminator')
>=20=20
> @@ -594,6 +595,7 @@ def discriminator_find_enum_define(expr):
>=20=20
>      if isinstance(discriminator_value, dict):
>          discriminator_value =3D discriminator_value['type']
> +
>      return enum_types.get(discriminator_value)
>=20=20
>=20=20

These two hunks are leftovers, please drop.

> @@ -800,7 +802,12 @@ def check_union(expr, info):
>                                 "struct '%s'"
>                                 % (discriminator, base))
>          if isinstance(discriminator_value, dict):
> +            if discriminator_value.get('if'):
> +                raise QAPISemError(info, 'The discriminator %s.%s for un=
ion %s '
> +                                   'must not be conditional' %
> +                                   (base, discriminator, name))
>              discriminator_value =3D discriminator_value['type']
> +
>          enum_define =3D enum_types.get(discriminator_value)
>          allow_metas =3D ['struct']
>          # Do not allow string discriminator
> @@ -1023,6 +1030,7 @@ def check_exprs(exprs):
>=20=20
>          if 'include' in expr:
>              continue
> +        info =3D expr_elem['info']
>          if 'union' in expr and not discriminator_find_enum_define(expr):
>              name =3D '%sKind' % expr['union']
>          elif 'alternate' in expr:
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ea5d1e8787..3f5a1d0c30 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -409,6 +409,7 @@ qapi-schema +=3D flat-union-inline-invalid-dict.json
>  qapi-schema +=3D flat-union-int-branch.json
>  qapi-schema +=3D flat-union-invalid-branch-key.json
>  qapi-schema +=3D flat-union-invalid-discriminator.json
> +qapi-schema +=3D flat-union-invalid-if-discriminator.json
>  qapi-schema +=3D flat-union-no-base.json
>  qapi-schema +=3D flat-union-optional-discriminator.json
>  qapi-schema +=3D flat-union-string-discriminator.json
> diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
> new file mode 100644
> index 0000000000..0c94c9860d
> --- /dev/null
> +++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/flat-union-invalid-if-discriminator.json:13: The discr=
iminator TestBase.enum1 for union TestUnion must not be conditional
> diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.exit b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.json b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.json
> new file mode 100644
> index 0000000000..618ec36396
> --- /dev/null
> +++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.json
> @@ -0,0 +1,17 @@
> +{ 'enum': 'TestEnum',
> +  'data': [ 'value1', 'value2' ] }
> +
> +{ 'struct': 'TestBase',
> +  'data': { 'enum1': { 'type': 'TestEnum', 'if': 'FOO' } } }
> +
> +{ 'struct': 'TestTypeA',
> +  'data': { 'string': 'str' } }
> +
> +{ 'struct': 'TestTypeB',
> +  'data': { 'integer': 'int' } }
> +
> +{ 'union': 'TestUnion',
> +  'base': 'TestBase',
> +  'discriminator': 'enum1',
> +  'data': { 'value1': 'TestTypeA',
> +            'value2': 'TestTypeB' } }
> diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.out b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.out
> new file mode 100644
> index 0000000000..e69de29bb2

Patch looks good otherwise.
