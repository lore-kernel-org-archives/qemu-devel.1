Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUygp-0003JQ-Ce
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUygl-0002zj-Fo
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUygd-0002VT-Tr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:47:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3D9C4CEB3
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:47:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-25-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 19:47:35 +0100
In-Reply-To: <20180706105753.26700-25-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:50 +0200")
Message-ID: <871s6u7arc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 24/27] qapi: add 'If:' condition to
 struct members documentation
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/doc.py             | 4 +++-
>  tests/qapi-schema/doc-good.json | 3 ++-
>  tests/qapi-schema/doc-good.out  | 1 +
>  tests/qapi-schema/doc-good.texi | 2 ++
>  4 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 196deea11d..56dc98c068 100755
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -138,9 +138,11 @@ def texi_member(member, suffix=3D''):
>      """Format a table of members item for an object type member"""
>      typ =3D member.type.doc_type()
>      membertype =3D ': ' + typ if typ else ''
> -    return '@item @code{%s%s}%s%s\n' % (
> +    return '@item @code{%s%s}%s%s%s\n' % (
>          member.name, membertype,
>          ' (optional)' if member.optional else '',
> +        '\n@b{If:} @code{%s}\n' %
> +        ', '.join(member.ifcond) if member.ifcond else '',
>          suffix)
>=20=20
>=20=20
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index c7fe08c530..158443b1a3 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -72,7 +72,8 @@
>  #
>  # Another paragraph (but no @var: line)
>  ##
> -{ 'struct': 'Variant1', 'data': { 'var1': 'str' } }
> +{ 'struct': 'Variant1',
> +  'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
>=20=20
>  ##
>  # @Variant2:
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index a05535b69b..c310b47be2 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -18,6 +18,7 @@ object Base
>      member base1: Enum optional=3DFalse
>  object Variant1
>      member var1: str optional=3DFalse
> +        if ['defined(IFSTR)']
>  object Variant2
>  object Object
>      base Base
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index 2446a1c702..255eed9a30 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -120,6 +120,8 @@ Another paragraph (but no @code{var}: line)
>  @b{Members:}
>  @table @asis
>  @item @code{var1: string}
> +@b{If:} @code{defined(IFSTR)}
> +
>  Not documented
>  @end table

Comments on the previous patch apply.
