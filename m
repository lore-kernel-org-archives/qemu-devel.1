Received: from eggs.gnu.org ([2001:4830:134:3::10]:40416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwT7-0000re-Ua
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUwT4-00022l-Gz
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:25:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUwT4-000220-6u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:25:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E0A637E66
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:25:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-19-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 17:25:31 +0100
In-Reply-To: <20180706105753.26700-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:44 +0200")
Message-ID: <871s6ubp1g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 18/27] qapi: add an error in case a
 discriminator is conditionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Making a discriminator conditonal doesn't make much sense.

Good point (so easy to overlook!), but why first add the 'if' feature
broken that way in PATCH 16, then fix it up in PATCH 18?

>                                                            Instead,
> the union could be made conditional.

What do you mean by that?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py                          | 11 +++++++++--
>  tests/Makefile.include                          |  1 +
>  .../flat-union-invalid-if-discriminator.err     |  1 +
>  .../flat-union-invalid-if-discriminator.exit    |  1 +
>  .../flat-union-invalid-if-discriminator.json    | 17 +++++++++++++++++
>  .../flat-union-invalid-if-discriminator.out     |  0
>  6 files changed, 29 insertions(+), 2 deletions(-)
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
> index 9b95f8cfe9..13fbb28493 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -577,7 +577,8 @@ def find_alternate_member_qtype(qapi_type):
>=20=20
>  # Return the discriminator enum define if discriminator is specified as =
an
>  # enum type, otherwise return None.
> -def discriminator_find_enum_define(expr):
> +def discriminator_find_enum_define(expr, info):
> +    name =3D expr['union']
>      base =3D expr.get('base')
>      discriminator =3D expr.get('discriminator')
>=20=20
> @@ -592,6 +593,11 @@ def discriminator_find_enum_define(expr):
>      if not discriminator_member:
>          return None
>=20=20
> +    if discriminator_member.get('if'):
> +        raise QAPISemError(info, 'The discriminator %s.%s for union %s '
> +                           'must not be conditional' %
> +                           (base, discriminator, name))
> +
>      return enum_types.get(discriminator_member['type'])
>=20=20
>=20=20

I'm afraid this isn't the proper place to check.  It's an accessor
function for @struct_types and @enum_types.  The check should go into
check_union(), like this:

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 0cf39df404..c1bc9e9c29 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -799,6 +794,11 @@ def check_union(expr, info):
                                "Discriminator '%s' is not a member of base=
 "
                                "struct '%s'"
                                % (discriminator, base))
+        if discriminator_member.get('if'):
+            raise QAPISemError(info, 'The discriminator %s.%s for union %s=
 '
+                               'must not be conditional' %
+                               (base, discriminator, name))
+
         enum_define =3D enum_types.get(discriminator_member['type'])
         allow_metas =3D ['struct']
         # Do not allow string discriminator

> @@ -1020,7 +1026,8 @@ def check_exprs(exprs):
>=20=20
>          if 'include' in expr:
>              continue
> -        if 'union' in expr and not discriminator_find_enum_define(expr):
> +        info =3D expr_elem['info']
> +        if 'union' in expr and not discriminator_find_enum_define(expr, =
info):
>              name =3D '%sKind' % expr['union']
>          elif 'alternate' in expr:
>              name =3D '%sKind' % expr['alternate']
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 43e100a6cd..abc3fdf764 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -510,6 +510,7 @@ qapi-schema +=3D flat-union-inline.json
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
