Received: from eggs.gnu.org ([2001:4830:134:3::10]:52534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5i-00013B-BE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5e-0003c2-64
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:50 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih5d-0003bg-WD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:46 -0500
Received: by mail-qt0-f175.google.com with SMTP id a27so39621809qtd.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-16-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-16-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:44 +0100
Message-ID: <CAMxuvazUOtB4t0EHYsVDNAPLCeomTQOvOD4hmaYgX_ccBK0e7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 15/21] qapi: Record 'include'
 directives in intermediate representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> The include directive permits modular QAPI schemata, but the generated
> code is monolithic all the same.  To permit generating modular code,
> the front end needs to pass more information on inclusions to the back
> ends.  The commit before last added the necessary information to the
> parse tree.  This commit adds it to the intermediate representation
> and its QAPISchemaVisitor.  A later commit will use this to to
> generate modular code.
>
> New entity QAPISchemaInclude represents inclusions.  Call new visitor
> method visit_include() for it, so visitors can see the sub-modules a
> module includes.
>
> New QAPISchemaEntity attribute @module names the entity's source file.
> Call new visitor method visit_module() when it changes during a visit,
> so visitors can keep track of the module being visited.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py                   | 44 ++++++++++++++++++++++++++=
++----
>  tests/qapi-schema/comments.out           |  1 +
>  tests/qapi-schema/doc-bad-section.out    |  1 +
>  tests/qapi-schema/doc-good.out           |  1 +
>  tests/qapi-schema/event-case.out         |  1 +
>  tests/qapi-schema/ident-with-escape.out  |  1 +
>  tests/qapi-schema/include-relpath.out    |  5 ++++
>  tests/qapi-schema/include-repetition.out | 10 ++++++++
>  tests/qapi-schema/include-simple.out     |  3 +++
>  tests/qapi-schema/indented-expr.out      |  1 +
>  tests/qapi-schema/qapi-schema-test.out   |  1 +
>  tests/qapi-schema/test-qapi.py           |  7 +++++
>  12 files changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 3b97bf8702..f4e9ebbb53 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -981,8 +981,9 @@ def check_exprs(exprs):
>
>  class QAPISchemaEntity(object):
>      def __init__(self, name, info, doc):
> -        assert isinstance(name, str)
> +        assert name is None or isinstance(name, str)
>          self.name =3D name
> +        self.module =3D None
>          # For explicitly defined entities, info points to the (explicit)
>          # definition.  For builtins (and their arrays), info is None.
>          # For implicitly defined entities, info points to a place that
> @@ -1011,10 +1012,16 @@ class QAPISchemaVisitor(object):
>      def visit_end(self):
>          pass
>
> +    def visit_module(self, fname):
> +        pass
> +
>      def visit_needed(self, entity):
>          # Default to visiting everything
>          return True
>
> +    def visit_include(self, fname, info):
> +        pass
> +
>      def visit_builtin_type(self, name, info, json_type):
>          pass
>
> @@ -1041,6 +1048,16 @@ class QAPISchemaVisitor(object):
>          pass
>
>
> +class QAPISchemaInclude(QAPISchemaEntity):
> +
> +    def __init__(self, fname, info):
> +        QAPISchemaEntity.__init__(self, None, info, None)
> +        self.fname =3D fname
> +
> +    def visit(self, visitor):
> +        visitor.visit_include(self.fname, self.info)
> +
> +
>  class QAPISchemaType(QAPISchemaEntity):
>      # Return the C type for common use.
>      # For the types we commonly box, this is a pointer type.
> @@ -1468,6 +1485,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>
>  class QAPISchema(object):
>      def __init__(self, fname):
> +        self._fname =3D fname
>          parser =3D QAPISchemaParser(open(fname, 'r'))
>          exprs =3D check_exprs(parser.exprs)
>          self.docs =3D parser.docs
> @@ -1475,16 +1493,19 @@ class QAPISchema(object):
>          self._entity_dict =3D {}
>          self._predefining =3D True
>          self._def_predefineds()
> -        self._predefining =3D False
>          self._def_exprs(exprs)
>          self.check()
>
>      def _def_entity(self, ent):
>          # Only the predefined types are allowed to not have info
>          assert ent.info or self._predefining
> -        assert ent.name not in self._entity_dict
> +        assert ent.name is None or ent.name not in self._entity_dict
>          self._entity_list.append(ent)
> -        self._entity_dict[ent.name] =3D ent
> +        if ent.name is not None:
> +            self._entity_dict[ent.name] =3D ent
> +        if ent.info:
> +            ent.module =3D os.path.relpath(ent.info['file'],
> +                                         os.path.dirname(self._fname))
>
>      def lookup_entity(self, name, typ=3DNone):
>          ent =3D self._entity_dict.get(name)
> @@ -1495,6 +1516,15 @@ class QAPISchema(object):
>      def lookup_type(self, name):
>          return self.lookup_entity(name, QAPISchemaType)
>
> +    def _def_include(self, expr, info, doc):
> +        include =3D expr['include']
> +        assert doc is None
> +        main_info =3D info
> +        while main_info['parent']:
> +            main_info =3D main_info['parent']
> +        fname =3D os.path.relpath(include, os.path.dirname(main_info['fi=
le']))
> +        self._def_entity(QAPISchemaInclude(fname, info))
> +
>      def _def_builtin_type(self, name, json_type, c_type):
>          self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
>          # TODO As long as we have QAPI_TYPES_BUILTIN to share multiple
> @@ -1677,7 +1707,7 @@ class QAPISchema(object):
>              elif 'event' in expr:
>                  self._def_event(expr, info, doc)
>              elif 'include' in expr:
> -                pass
> +                self._def_include(expr, info, doc)
>              else:
>                  assert False
>
> @@ -1687,8 +1717,12 @@ class QAPISchema(object):
>
>      def visit(self, visitor):
>          visitor.visit_begin(self)
> +        module =3D None
>          for entity in self._entity_list:
>              if visitor.visit_needed(entity):
> +                if entity.module !=3D module:
> +                    module =3D entity.module
> +                    visitor.visit_module(module)
>                  entity.visit(visitor)
>          visitor.visit_end()
>
> diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
> index 0261ddf202..8d2f1ce8a2 100644
> --- a/tests/qapi-schema/comments.out
> +++ b/tests/qapi-schema/comments.out
> @@ -1,4 +1,5 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module comments.json
>  enum Status ['good', 'bad', 'ugly']
> diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
> index 23bf8c71ab..cd28721568 100644
> --- a/tests/qapi-schema/doc-bad-section.out
> +++ b/tests/qapi-schema/doc-bad-section.out
> @@ -1,6 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module doc-bad-section.json
>  enum Enum ['one', 'two']
>  doc symbol=3DEnum
>      body=3D
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index 0c07301f07..430b5a87db 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -1,6 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module doc-good.json
>  enum Enum ['one', 'two']
>  object Base
>      member base1: Enum optional=3DFalse
> diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
> index 110571b793..88c0964917 100644
> --- a/tests/qapi-schema/event-case.out
> +++ b/tests/qapi-schema/event-case.out
> @@ -1,5 +1,6 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module event-case.json
>  event oops None
>     boxed=3DFalse
> diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
> index 8336aa7629..ee3b34e623 100644
> --- a/tests/qapi-schema/ident-with-escape.out
> +++ b/tests/qapi-schema/ident-with-escape.out
> @@ -1,6 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module ident-with-escape.json
>  object q_obj_fooA-arg
>      member bar1: str optional=3DFalse
>  command fooA q_obj_fooA-arg -> None
> diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
> index 0261ddf202..ebbabd7a18 100644
> --- a/tests/qapi-schema/include-relpath.out
> +++ b/tests/qapi-schema/include-relpath.out
> @@ -1,4 +1,9 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module include-relpath.json
> +include include/relpath.json
> +module include/relpath.json
> +include include-relpath-sub.json
> +module include-relpath-sub.json
>  enum Status ['good', 'bad', 'ugly']
> diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
> index 0261ddf202..7235e055bc 100644
> --- a/tests/qapi-schema/include-repetition.out
> +++ b/tests/qapi-schema/include-repetition.out
> @@ -1,4 +1,14 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module include-repetition.json
> +include comments.json
> +module comments.json
>  enum Status ['good', 'bad', 'ugly']
> +module include-repetition.json
> +include include-repetition-sub.json
> +module include-repetition-sub.json
> +include comments.json
> +include comments.json
> +module include-repetition.json
> +include comments.json
> diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
> index 0261ddf202..006f723eeb 100644
> --- a/tests/qapi-schema/include-simple.out
> +++ b/tests/qapi-schema/include-simple.out
> @@ -1,4 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module include-simple.json
> +include include-simple-sub.json
> +module include-simple-sub.json
>  enum Status ['good', 'bad', 'ugly']
> diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
> index 34de8be426..a79935e8c3 100644
> --- a/tests/qapi-schema/indented-expr.out
> +++ b/tests/qapi-schema/indented-expr.out
> @@ -1,6 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module indented-expr.json
>  command eins None -> None
>     gen=3DTrue success_response=3DTrue boxed=3DFalse
>  command zwei None -> None
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 50706b0136..012e7fc06a 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -1,6 +1,7 @@
>  object q_empty
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
> +module qapi-schema-test.json
>  object TestStruct
>      member integer: int optional=3DFalse
>      member boolean: bool optional=3DFalse
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index d6bb8ec6a4..2027eef3e5 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -17,6 +17,13 @@ import sys
>
>
>  class QAPISchemaTestVisitor(QAPISchemaVisitor):
> +
> +    def visit_module(self, name):
> +        print 'module %s' % name
> +
> +    def visit_include(self, name, info):
> +        print 'include %s' % name
> +
>      def visit_enum_type(self, name, info, values, prefix):
>          print 'enum %s %s' % (name, values)
>          if prefix:
> --
> 2.13.6
>
