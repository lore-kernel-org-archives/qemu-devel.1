Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVunt-0007ey-JP
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVunq-0001P7-7A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:18:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVunq-0001La-1v
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BCA1401CE8B
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:18:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-7-marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 10:18:46 +0200
In-Reply-To: <20180321115211.17937-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:28 +0100")
Message-ID: <87wouso8m1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/49] qapi: add 'ifcond' to visitor
 methods
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

> Modify the test visitor to check correct passing of values.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 10e68b01d9..6d25a37dda 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -23,12 +23,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>      def visit_include(self, name, info):
>          print('include %s' % name)
>=20=20
> -    def visit_enum_type(self, name, info, values, prefix):
> +    def visit_enum_type(self, name, info, ifcond, values, prefix):
>          print('enum %s %s' % (name, values))
>          if prefix:
>              print('    prefix %s' % prefix)
> +        self._print_if(ifcond)
>=20=20
> -    def visit_object_type(self, name, info, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
>          print('object %s' % name)
>          if base:
>              print('    base %s' % base.name)
> @@ -36,21 +37,25 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              print('    member %s: %s optional=3D%s' % \
>                    (m.name, m.type.name, m.optional))
>          self._print_variants(variants)
> +        self._print_if(ifcond)
>=20=20
> -    def visit_alternate_type(self, name, info, variants):
> +    def visit_alternate_type(self, name, info, ifcond, variants):
>          print('alternate %s' % name)
>          self._print_variants(variants)
> +        self._print_if(ifcond)
>=20=20
> -    def visit_command(self, name, info, arg_type, ret_type,
> +    def visit_command(self, name, info, ifcond, arg_type, ret_type,
>                        gen, success_response, boxed, allow_oob):
>          print('command %s %s -> %s' % \
>                (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
>          print('   gen=3D%s success_response=3D%s boxed=3D%s' % \
>                (gen, success_response, boxed))
> +        self._print_if(ifcond)
>=20=20
> -    def visit_event(self, name, info, arg_type, boxed):
> +    def visit_event(self, name, info, ifcond, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))
>          print('   boxed=3D%s' % boxed)
> +        self._print_if(ifcond)
>=20=20
>      @staticmethod
>      def _print_variants(variants):
> @@ -59,6 +64,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              for v in variants.variants:
>                  print('    case %s: %s' % (v.name, v.type.name))
>=20=20
> +    @staticmethod
> +    def _print_if(ifcond, indent=3D4):
> +        if ifcond:
> +            print('%sif %s' % (' ' * indent, ifcond))
>=20=20

pycodestyle points out:

    tests/qapi-schema/test-qapi.py:72:1: E305 expected 2 blank lines after =
class or function definition, found 1

Can touch up when I apply.

>  try:
>      schema =3D QAPISchema(sys.argv[1])
