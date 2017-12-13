Received: from eggs.gnu.org ([2001:4830:134:3::10]:60824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP6G9-0000Ln-Ft
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP6G4-0002JV-Rs
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eP6G4-0002J1-J1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-33-marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2017 13:35:24 +0100
In-Reply-To: <20170911110623.24981-33-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:05 +0200")
Message-ID: <87fu8eerg3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 32/50] qapi2texi: add 'If:' section to
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

Cc: Eric for an additional pair of eyeballs.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The documentation is generated only once, and doesn't know C
> pre-conditions. Add 'If:' sections for top-level entities.

Is this what we want?

QMP also exists only once.  Should the generated qemu-qmp-ref.* document
that instance of QMP, or should it document all potential instances of
QMP?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi2texi.py | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index e72e7cfe0b..150e7045d2 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -132,7 +132,6 @@ def texi_enum_value(value):
>      """Format a table of members item for an enumeration value"""
>      return '@item @code{%s}\n' % value.name
>=20=20
> -
>  def texi_member(member, suffix=3D''):
>      """Format a table of members item for an object type member"""
>      typ =3D member.type.doc_type()

Spurious whitespace change.  PEP8 wants the original spacing here.

> @@ -175,7 +174,7 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
>      return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
>=20=20
>=20=20
> -def texi_sections(doc):
> +def texi_sections(doc, ifcond):
>      """Format additional sections following arguments"""
>      body =3D ''
>      for section in doc.sections:
> @@ -189,14 +188,16 @@ def texi_sections(doc):
>              body +=3D '\n\n@b{%s:}\n' % name
>=20=20
>          body +=3D func(doc)
> +    if ifcond:
> +        body +=3D '\n\n@b{If:} @code{%s}' % ifcond
>      return body
>=20=20
>=20=20
> -def texi_entity(doc, what, base=3DNone, variants=3DNone,
> +def texi_entity(doc, what, ifcond, base=3DNone, variants=3DNone,
>                  member_func=3Dtexi_member):
>      return (texi_body(doc)
>              + texi_members(doc, what, base, variants, member_func)
> -            + texi_sections(doc))
> +            + texi_sections(doc, ifcond))
>=20=20
>=20=20
>  class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
> @@ -213,7 +214,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>              self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Enum',
>                               name=3Ddoc.symbol,
> -                             body=3Dtexi_entity(doc, 'Values',
> +                             body=3Dtexi_entity(doc, 'Values', ifcond,
>                                                member_func=3Dtexi_enum_va=
lue))
>=20=20
>      def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
> @@ -224,7 +225,8 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>              self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Object',
>                               name=3Ddoc.symbol,
> -                             body=3Dtexi_entity(doc, 'Members', base, va=
riants))
> +                             body=3Dtexi_entity(doc, 'Members', ifcond,
> +                                              base, variants))
>=20=20
>      def visit_alternate_type(self, name, info, ifcond, variants):
>          doc =3D self.cur_doc
> @@ -232,7 +234,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>              self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Alternate',
>                               name=3Ddoc.symbol,
> -                             body=3Dtexi_entity(doc, 'Members'))
> +                             body=3Dtexi_entity(doc, 'Members', ifcond))
>=20=20
>      def visit_command(self, name, info, ifcond, arg_type, ret_type,
>                        gen, success_response, boxed):
> @@ -242,9 +244,9 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>          if boxed:
>              body =3D texi_body(doc)
>              body +=3D '\n@b{Arguments:} the members of @code{%s}' % arg_=
type.name
> -            body +=3D texi_sections(doc)
> +            body +=3D texi_sections(doc, ifcond)
>          else:
> -            body =3D texi_entity(doc, 'Arguments')
> +            body =3D texi_entity(doc, 'Arguments', ifcond)
>          self.out +=3D MSG_FMT(type=3D'Command',
>                              name=3Ddoc.symbol,
>                              body=3Dbody)
> @@ -255,7 +257,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>              self.out +=3D '\n'
>          self.out +=3D MSG_FMT(type=3D'Event',
>                              name=3Ddoc.symbol,
> -                            body=3Dtexi_entity(doc, 'Arguments'))
> +                            body=3Dtexi_entity(doc, 'Arguments', ifcond))
>=20=20
>      def symbol(self, doc, entity):
>          self.cur_doc =3D doc
> @@ -266,7 +268,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>          assert not doc.args
>          if self.out:
>              self.out +=3D '\n'
> -        self.out +=3D texi_body(doc) + texi_sections(doc)
> +        self.out +=3D texi_body(doc) + texi_sections(doc, None)
>=20=20
>=20=20
>  def texi_schema(schema):

Missing: coverage in tests/qapi-schema/doc-good.json.
