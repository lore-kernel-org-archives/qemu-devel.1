Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXSCC-0003ib-CS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXSC9-0005LF-5F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXSC8-0005L0-V1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:10:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DEB2F68B2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 14:10:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-20-marcandre.lureau@redhat.com>
Date: Mon, 25 Jun 2018 16:10:13 +0200
In-Reply-To: <20180321115211.17937-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:41 +0100")
Message-ID: <87sh5bq7ne.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/49] qapi: factor out
 check_known_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The following patches are going to need similar checks from various
> code path. This refactoring will report all conflicting keys (instead
> of the first one encountered).
>
> Modify unknown-expr-key to check plural form.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py                  | 27 ++++++++++++++++++-------
>  tests/qapi-schema/alternate-base.err    |  2 +-
>  tests/qapi-schema/double-type.err       |  2 +-
>  tests/qapi-schema/enum-missing-data.err |  2 +-
>  tests/qapi-schema/unknown-expr-key.err  |  2 +-
>  tests/qapi-schema/unknown-expr-key.json |  2 +-
>  6 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 4d19146064..fdbb5f1823 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -879,6 +879,24 @@ def check_struct(expr, info):
>                 allow_metas=3D['struct'])
>=20=20
>=20=20
> +def check_known_keys(info, source, keys, required, optional):
> +
> +    def pprint(elems):
> +        return ', '.join("'" + e + "'" for e in sorted(elems))
> +
> +    missing =3D set(required) - set(keys)
> +    if missing:
> +        raise QAPISemError(info, "%s must have %s key%s"
> +                           % (source, pprint(missing),
> +                              's' if len(missing) > 1 else ''))
> +    allowed =3D set(required + optional)
> +    unknown =3D set(keys) - allowed
> +    if unknown:
> +        raise QAPISemError(info, "%s has unknown key%s %s (allowed: %s)"
> +                           % (source, 's' if len(unknown) > 1 else '',
> +                              pprint(unknown), pprint(allowed)))
> +
> +
>  def check_keys(expr_elem, meta, required, optional=3D[]):
>      expr =3D expr_elem['expr']
>      info =3D expr_elem['info']
> @@ -886,10 +904,9 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
>      if not isinstance(name, str):
>          raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
>      required =3D required + [meta]
> +    source =3D "%s '%s'" % (meta, name)
> +    check_known_keys(info, source, expr, required, optional)
>      for (key, value) in expr.items():
> -        if key not in required and key not in optional:
> -            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
> -                               % (key, meta, name))
>          if (key =3D=3D 'gen' or key =3D=3D 'success-response') and value=
 is not False:
>              raise QAPISemError(info,
>                                 "'%s' of %s '%s' should only use false va=
lue"
> @@ -900,10 +917,6 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
>                                 % (key, meta, name))
>          if key =3D=3D 'if':
>              check_if(expr, info)
> -    for key in required:
> -        if key not in expr:
> -            raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
> -                               % (key, meta, name))
>=20=20
>=20=20
>  def check_exprs(exprs):
> diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
> index 30d8a34373..2b09c4c7a3 100644
> --- a/tests/qapi-schema/alternate-base.err
> +++ b/tests/qapi-schema/alternate-base.err
> @@ -1 +1 @@
> -tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
> +tests/qapi-schema/alternate-base.json:4: alternate 'Alt' has unknown key=
 'base' (allowed: 'alternate', 'data', 'if')

The change in the error message proper, i.e. up to the parenthesis,
doesn't feel like an improvment to me.  The old message starts with
what's wrong.  The new one starts with where's something wrong.

I'd do the parenthesis with error_append_hint(), and say something like
"Valid keys are ...".  See below for a more complete example.

> diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
> index f9613c6d6b..a8c5637659 100644
> --- a/tests/qapi-schema/double-type.err
> +++ b/tests/qapi-schema/double-type.err
> @@ -1 +1 @@
> -tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
> +tests/qapi-schema/double-type.json:2: struct 'bar' has unknown key 'comm=
and' (allowed: 'base', 'data', 'if', 'struct')
> diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
> index ba4873ae69..68e286badc 100644
> --- a/tests/qapi-schema/enum-missing-data.err
> +++ b/tests/qapi-schema/enum-missing-data.err
> @@ -1 +1 @@
> -tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
> +tests/qapi-schema/enum-missing-data.json:2: enum 'MyEnum' must have 'dat=
a' key

Again, the error message change doesn't feel like an improvement to me.

> diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
> index 12f5ed5b43..d9f4e41cac 100644
> --- a/tests/qapi-schema/unknown-expr-key.err
> +++ b/tests/qapi-schema/unknown-expr-key.err
> @@ -1 +1 @@
> -tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
> +tests/qapi-schema/unknown-expr-key.json:2: struct 'bar' has unknown keys=
 'bogus', 'foo' (allowed: 'base', 'data', 'if', 'struct')
> diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.json

Suggest something like

    tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'foo' =
in struct 'bar'
    Valid keys are 'base', 'data', 'if', 'struct'.

> index 3b2be00cc4..5bcb8efd1d 100644
> --- a/tests/qapi-schema/unknown-expr-key.json
> +++ b/tests/qapi-schema/unknown-expr-key.json
> @@ -1,2 +1,2 @@
>  # we reject an expression with unknown top-level keys
> -{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
> +{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { }, 'foo': { } }

The patch does two things: 1. factor out a helper for later use in other
places, 2. report all offending keys instead of just the first one.
Split it up, please.
