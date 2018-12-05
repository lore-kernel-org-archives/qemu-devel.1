Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUbVi-0002vL-3r
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUbVd-0001kj-0L
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUbVc-0001k5-LY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB436307D85E
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 18:02:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-13-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 19:02:47 +0100
In-Reply-To: <20180706105753.26700-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:38 +0200")
Message-ID: <87k1knq2bc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 12/27] qapi: add a dictionnary form with
 'name' key for enum members
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

In subject, s/dictionnary/dictionary/

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Desugar the enum NAME form to { 'name': NAME }. This will allow to add
> new enum members, such as 'if' in the following patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py                        | 47 ++++++++++++++++---
>  tests/Makefile.include                        |  3 +-
>  tests/qapi-schema/enum-bad-member.err         |  1 +
>  ...-dict-member.exit =3D> enum-bad-member.exit} |  0
>  tests/qapi-schema/enum-bad-member.json        |  2 +
>  ...um-dict-member.out =3D> enum-bad-member.out} |  0
>  .../qapi-schema/enum-dict-member-unknown.err  |  2 +
>  .../qapi-schema/enum-dict-member-unknown.exit |  1 +
>  .../qapi-schema/enum-dict-member-unknown.json |  2 +
>  .../qapi-schema/enum-dict-member-unknown.out  |  0
>  tests/qapi-schema/enum-dict-member.err        |  1 -
>  tests/qapi-schema/enum-dict-member.json       |  2 -
>  tests/qapi-schema/enum-missing-data.err       |  2 +-
>  13 files changed, 51 insertions(+), 12 deletions(-)
>  create mode 100644 tests/qapi-schema/enum-bad-member.err
>  rename tests/qapi-schema/{enum-dict-member.exit =3D> enum-bad-member.exi=
t} (100%)
>  create mode 100644 tests/qapi-schema/enum-bad-member.json
>  rename tests/qapi-schema/{enum-dict-member.out =3D> enum-bad-member.out}=
 (100%)
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.err
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.json
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.out
>  delete mode 100644 tests/qapi-schema/enum-dict-member.err
>  delete mode 100644 tests/qapi-schema/enum-dict-member.json
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index cf8dab2866..e9fb736d46 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -740,6 +740,10 @@ def check_event(expr, info):
>                 allow_metas=3Dmeta)
>=20=20
>=20=20
> +def enum_get_names(expr):
> +    return [e['name'] for e in expr['data']]
> +
> +
>  def check_union(expr, info):
>      name =3D expr['union']
>      base =3D expr.get('base')
> @@ -799,7 +803,7 @@ def check_union(expr, info):
>          # If the discriminator names an enum type, then all members
>          # of 'data' must also be members of the enum type.
>          if enum_define:
> -            if key not in enum_define['data']:
> +            if key not in enum_get_names(enum_define):
>                  raise QAPISemError(info,
>                                     "Discriminator value '%s' is not foun=
d in "
>                                     "enum '%s'"
> @@ -831,10 +835,10 @@ def check_alternate(expr, info):
>          if qtype =3D=3D 'QTYPE_QSTRING':
>              enum_expr =3D enum_types.get(value)
>              if enum_expr:
> -                for v in enum_expr['data']:
> +                for v in enum_get_names(enum_expr):
>                      if v in ['on', 'off']:
>                          conflicting.add('QTYPE_QBOOL')
> -                    if re.match(r'[-+0-9.]', v): # lazy, could be tighte=
ned
> +                    if re.match(r'[-+0-9.]', v):  # lazy, could be tight=
ened

Unrelated change.

>                          conflicting.add('QTYPE_QNUM')
>              else:
>                  conflicting.add('QTYPE_QNUM')

The helper enum_get_names() is used just twice.

The second instance

                for v in enum_get_names(enum_expr):

could just as well iterate over enum_expr

                for d in enum_expr['data']:
                    v =3D d['name']

The first instance could simply be inlined then.

> @@ -847,19 +851,34 @@ def check_alternate(expr, info):
>              types_seen[qt] =3D key
>=20=20
>=20=20
> -def check_enum(expr, info):
> +def normalize_enum(expr, info):
>      name =3D expr['enum']
>      members =3D expr.get('data')
> -    prefix =3D expr.get('prefix')
>=20=20
>      if not isinstance(members, list):
>          raise QAPISemError(info,
>                             "Enum '%s' requires an array for 'data'" % na=
me)
> +
> +    # translate short member form to dict form
> +    for i, member in enumerate(members):
> +        if not isinstance(member, dict):
> +            member =3D {'name': member}
> +            members[i] =3D member

Simpler:

       members =3D [m if isinstance(m, dict) else {'name': m} for m in memb=
ers]

> +
> +
> +def check_enum(expr, info):
> +    name =3D expr['enum']
> +    members =3D expr.get('data')

Preexisting: this should be expr['data'], because we already checked
required keys.

> +    prefix =3D expr.get('prefix')
> +
>      if prefix is not None and not isinstance(prefix, str):
>          raise QAPISemError(info,
>                             "Enum '%s' requires a string for 'prefix'" % =
name)
> +
>      for member in members:
> -        check_name(info, "Member of enum '%s'" % name, member,
> +        source =3D "dictionary member of enum '%s'" % name
> +        check_known_keys(info, source, member, ['name'], [])
> +        check_name(info, "Member of enum '%s'" % name, member['name'],
>                     enum_member=3DTrue)
>=20=20
>=20=20
> @@ -921,6 +940,13 @@ def check_exprs(exprs):
>      for builtin in builtin_types.keys():
>          all_names[builtin] =3D 'built-in'
>=20=20
> +    # Normalize exprs
> +    for expr_elem in exprs:
> +        expr =3D expr_elem['expr']
> +        info =3D expr_elem['info']
> +        if 'enum' in expr:
> +            normalize_enum(expr, info)
> +

As demonstrated by tests/qapi-schema/enum-missing-data.json below, the
error message for

    {'enum': 'MyEnum'}

changes from

    Key 'data' is missing from enum 'MyEnum'

to

    Enum 'MyEnum' requires an array for 'data'

because you normalize before checking keys.  I don't think that's a good
idea.

>      # Learn the types and check for valid expression keys
>      for expr_elem in exprs:
>          expr =3D expr_elem['expr']
           info =3D expr_elem['info']
           doc =3D expr_elem.get('doc')

           if 'include' in expr:
               continue

           if not doc and doc_required:
               raise QAPISemError(info,
                                  "Expression missing documentation comment=
")

           if 'enum' in expr:
               meta =3D 'enum'
               check_keys(expr_elem, 'enum', ['data'], ['if', 'prefix'])

This seems a better place to call normalize_enum(expr, info).

               enum_types[expr[meta]] =3D expr
           elif 'union' in expr:
> @@ -1640,7 +1666,14 @@ class QAPISchema(object):
>                                              qtype_values, 'QTYPE'))
>=20=20
>      def _make_enum_members(self, values):
> -        return [QAPISchemaMember(v) for v in values]
> +        enum =3D []
> +        for v in values:
> +            if isinstance(v, dict):
> +                name =3D v['name']
> +            else:
> +                name =3D v
> +            enum.append(QAPISchemaMember(name))
> +        return enum

Despite normalization to the long form, we still deal with both the long
and the short form here.  Three callers:

* _def_predefineds(): passes the short form.

* _make_implicit_enum_type(): passes the short form until PATCH 19
  changes it to pass the long form.

* _def_enum_type(): passes the long form.

I believe always passing the long form would be simpler.

>=20=20
>      def _make_implicit_enum_type(self, name, info, ifcond, values):
>          # See also QAPISchemaObjectTypeMember._pretty_owner()
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a49282704e..8e1b122cf2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -482,10 +482,11 @@ qapi-schema +=3D double-data.json
>  qapi-schema +=3D double-type.json
>  qapi-schema +=3D duplicate-key.json
>  qapi-schema +=3D empty.json
> +qapi-schema +=3D enum-bad-member.json
>  qapi-schema +=3D enum-bad-name.json
>  qapi-schema +=3D enum-bad-prefix.json
>  qapi-schema +=3D enum-clash-member.json
> -qapi-schema +=3D enum-dict-member.json
> +qapi-schema +=3D enum-dict-member-unknown.json
>  qapi-schema +=3D enum-int-member.json
>  qapi-schema +=3D enum-member-case.json
>  qapi-schema +=3D enum-missing-data.json
> diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
> new file mode 100644
> index 0000000000..211db9e6fc
> --- /dev/null
> +++ b/tests/qapi-schema/enum-bad-member.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/enum-bad-member.json:2: Member of enum 'MyEnum' requir=
es a string name
> diff --git a/tests/qapi-schema/enum-dict-member.exit b/tests/qapi-schema/=
enum-bad-member.exit
> similarity index 100%
> rename from tests/qapi-schema/enum-dict-member.exit
> rename to tests/qapi-schema/enum-bad-member.exit
> diff --git a/tests/qapi-schema/enum-bad-member.json b/tests/qapi-schema/e=
num-bad-member.json
> new file mode 100644
> index 0000000000..98da6828b4
> --- /dev/null
> +++ b/tests/qapi-schema/enum-bad-member.json
> @@ -0,0 +1,2 @@
> +# we reject any enum member that is not a string
> +{ 'enum': 'MyEnum', 'data': [ [ ] ] }
> diff --git a/tests/qapi-schema/enum-dict-member.out b/tests/qapi-schema/e=
num-bad-member.out
> similarity index 100%
> rename from tests/qapi-schema/enum-dict-member.out
> rename to tests/qapi-schema/enum-bad-member.out

This replaces enum-dict-member.json.  Okay.  Took me a while to see this
%-/

> diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
> new file mode 100644
> index 0000000000..76bd0471db
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-unknown.err
> @@ -0,0 +1,2 @@
> +tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in dictionary member of enum 'MyEnum'
> +Valid keys are 'name'.
> diff --git a/tests/qapi-schema/enum-dict-member-unknown.exit b/tests/qapi=
-schema/enum-dict-member-unknown.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-unknown.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/enum-dict-member-unknown.json b/tests/qapi=
-schema/enum-dict-member-unknown.json
> new file mode 100644
> index 0000000000..6664c59201
> --- /dev/null
> +++ b/tests/qapi-schema/enum-dict-member-unknown.json
> @@ -0,0 +1,2 @@
> +# we reject any enum member that is not a string or a dict with 'name'
> +{ 'enum': 'MyEnum', 'data': [ { 'name': 'foo', 'bad-key': 'str' } ] }
> diff --git a/tests/qapi-schema/enum-dict-member-unknown.out b/tests/qapi-=
schema/enum-dict-member-unknown.out
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
> deleted file mode 100644
> index 8ca146ea59..0000000000
> --- a/tests/qapi-schema/enum-dict-member.err
> +++ /dev/null
> @@ -1 +0,0 @@
> -tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
> diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.json
> deleted file mode 100644
> index 79672e0f09..0000000000
> --- a/tests/qapi-schema/enum-dict-member.json
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# we reject any enum member that is not a string
> -{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
> diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
> index ba4873ae69..b8ccae071b 100644
> --- a/tests/qapi-schema/enum-missing-data.err
> +++ b/tests/qapi-schema/enum-missing-data.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
> +tests/qapi-schema/enum-missing-data.json:2: Enum 'MyEnum' requires an ar=
ray for 'data'
