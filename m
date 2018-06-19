Received: from eggs.gnu.org ([2001:4830:134:3::10]:60966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVCbQ-00010y-LY
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVCbL-0007DA-NQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:07:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVCbJ-0007Cy-Iv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF076814F0A5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:06:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-6-marcandre.lureau@redhat.com>
Date: Tue, 19 Jun 2018 11:06:48 +0200
In-Reply-To: <20180321115211.17937-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:27 +0100")
Message-ID: <87a7rrywk7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/49] qapi: leave the ifcond attribute
 undefined until check()
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

> We commonly initialize attributes to None in .init(), then set their
> real value in .check().  Accessing the attribute before .check()
> yields None.  If we're lucky, the code that accesses the attribute
> prematurely chokes on None.
>
> It won't for .ifcond, because None is a legitimate value.
>
> Leave the ifcond attribute undefined until check().

Drawback: pylint complains.  We'll live.

>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Shouldn't this be squashed into the previous patch?

> ---
>  scripts/qapi/common.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d8ab3d8f7f..eb07d641ab 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1026,13 +1026,19 @@ class QAPISchemaEntity(object):
>          # such place).
>          self.info =3D info
>          self.doc =3D doc
> -        self.ifcond =3D listify_cond(ifcond)
> +        self._ifcond =3D ifcond  # self.ifcond is set only after .check()
>=20=20
>      def c_name(self):
>          return c_name(self.name)
>=20=20
>      def check(self, schema):
> -        pass
> +        if isinstance(self._ifcond, QAPISchemaType):
> +            # inherit the condition from a type
> +            typ =3D self._ifcond
> +            typ.check(schema)
> +            self.ifcond =3D typ.ifcond
> +        else:
> +            self.ifcond =3D listify_cond(self._ifcond)

Whenever we add a .check(), we need to prove QAPISchema.check()'s
recursion still terminates, and terminates the right way.

Argument before this patch: we recurse only into types contained in
types, e.g. an object type's base type, and we detect and report cycles
as "Object %s contains itself", in QAPISchemaObjectType.check().

The .check() added here recurses into a type.  If this creates a cycle,
it'll be caught and reported as "contains itself".  We still need to
show that the error message remains accurate.

We .check() here to inherit .ifcond from a type.  As far as I can tell,
we use this inheritance feature only to inherit an array's condition
from its element type.  That's safe, because an array does contain its
elements.

This is hardly a rigorous proof.  Just enough to make me believe your
code works.

However, I suspect adding the inheritance feature at the entity level
complicates the correctness argument without real need.  Can we restrict
it to array elements?  Have QAPISchemaArrayType.check() resolve
type-valued ._ifcond, and all the others choke on it?

>=20=20
>      def is_implicit(self):
>          return not self.info
> @@ -1169,6 +1175,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>          self.prefix =3D prefix
>=20=20
>      def check(self, schema):
> +        QAPISchemaType.check(self, schema)
>          seen =3D {}
>          for v in self.values:
>              v.check_clash(self.info, seen)
> @@ -1201,8 +1208,10 @@ class QAPISchemaArrayType(QAPISchemaType):
>          self.element_type =3D None
>=20=20
>      def check(self, schema):
> +        QAPISchemaType.check(self, schema)
>          self.element_type =3D schema.lookup_type(self._element_type_name)
>          assert self.element_type
> +        self.element_type.check(schema)
>          self.ifcond =3D self.element_type.ifcond
>=20=20
>      def is_implicit(self):
> @@ -1245,6 +1254,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>          self.members =3D None
>=20=20
>      def check(self, schema):
> +        QAPISchemaType.check(self, schema)
>          if self.members is False:               # check for cycles
>              raise QAPISemError(self.info,
>                                 "Object %s contains itself" % self.name)
> @@ -1427,6 +1437,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>          self.variants =3D variants
>=20=20
>      def check(self, schema):
> +        QAPISchemaType.check(self, schema)
>          self.variants.tag_member.check(schema)
>          # Not calling self.variants.check_clash(), because there's nothi=
ng
>          # to clash with
> @@ -1470,6 +1481,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>          self.allow_oob =3D allow_oob
>=20=20
>      def check(self, schema):
> +        QAPISchemaEntity.check(self, schema)
>          if self._arg_type_name:
>              self.arg_type =3D schema.lookup_type(self._arg_type_name)
>              assert (isinstance(self.arg_type, QAPISchemaObjectType) or
> @@ -1504,6 +1516,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>          self.boxed =3D boxed
>=20=20
>      def check(self, schema):
> +        QAPISchemaEntity.check(self, schema)
>          if self._arg_type_name:
>              self.arg_type =3D schema.lookup_type(self._arg_type_name)
>              assert (isinstance(self.arg_type, QAPISchemaObjectType) or
> @@ -1633,7 +1646,7 @@ class QAPISchema(object):
>              # But it's not tight: the disjunction need not imply it.  We
>              # may end up compiling useless wrapper types.
>              # TODO kill simple unions or implement the disjunction
> -            assert ifcond =3D=3D typ.ifcond
> +            assert ifcond =3D=3D typ._ifcond

pylint complains

    W:1649,29: Access to a protected member _ifcond of a client class (prot=
ected-access)

Layering violation.  Tolerable, I think.

>          else:
>              self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
>                                                    None, members, None))
> @@ -1679,7 +1692,7 @@ class QAPISchema(object):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
>          typ =3D self._make_implicit_object_type(
> -            typ, info, None, self.lookup_type(typ).ifcond,
> +            typ, info, None, self.lookup_type(typ),
>              'wrapper', [self._make_member('data', typ, info)])
>          return QAPISchemaObjectTypeVariant(case, typ)

Perhaps other attributes that become valid only at .check() time should
receive the same treatment.  Not necessarily in this series, not
necessarily by you.  A TODO comment wouldn't hurt, though.
