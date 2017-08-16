Received: from eggs.gnu.org ([2001:4830:134:3::10]:55781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di0UC-0002TK-5y
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di0U8-0002A4-Rn
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1di0U8-00025m-EF
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:43:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-8-marcandre.lureau@redhat.com>
Date: Wed, 16 Aug 2017 17:43:50 +0200
In-Reply-To: <20170727154126.11339-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:07 +0200")
Message-ID: <87mv6z4ix5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/26] qapi: add 'if' condition on
 top-level schema elements
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

> Add 'if' c-preprocessor condition on top-level schema elements:
> struct, enum, union, alternate, command, event.

An example would be useful here.  Your cover letter has nice ones, would
be a shame not to preserve them for posterity in the commit log.

> Variants objects types are created outside of #if blocks, since they

What are "variants objects types"?

> may be shared by various types. Even if unused, this shouldn't be an
> issue, since those are internal types.
>
> Note that there is no checks in qapi scripts to verify that elements

there are

> have compatible conditions (ex: if-struct used by a if-foo
> command). This may thus fail at C build time if they don't share the
> same subset of conditions.

Fair enough.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                         | 153 +++++++++++++++++++++++++-=
------
>  scripts/qapi-commands.py                |   4 +-
>  scripts/qapi-event.py                   |   4 +-
>  scripts/qapi-introspect.py              |  46 ++++++----
>  scripts/qapi-types.py                   |  51 +++++++----
>  scripts/qapi-visit.py                   |  13 ++-
>  scripts/qapi2texi.py                    |  10 +--
>  tests/Makefile.include                  |   1 +
>  tests/qapi-schema/bad-if.err            |   1 +
>  tests/qapi-schema/bad-if.exit           |   1 +
>  tests/qapi-schema/bad-if.json           |   3 +
>  tests/qapi-schema/bad-if.out            |   0
>  tests/qapi-schema/qapi-schema-test.json |  20 +++++
>  tests/qapi-schema/qapi-schema-test.out  |  31 +++++++
>  tests/qapi-schema/test-qapi.py          |  21 +++--
>  15 files changed, 272 insertions(+), 87 deletions(-)
>  create mode 100644 tests/qapi-schema/bad-if.err
>  create mode 100644 tests/qapi-schema/bad-if.exit
>  create mode 100644 tests/qapi-schema/bad-if.json
>  create mode 100644 tests/qapi-schema/bad-if.out
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 4ecc19e944..79ba1e93da 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -639,6 +639,16 @@ def add_name(name, info, meta, implicit=3DFalse):
>      all_names[name] =3D meta
>=20=20
>=20=20
> +def check_if(expr, info):
> +    ifcond =3D expr.get('if')
> +    if not ifcond or isinstance(ifcond, str):
> +        return
> +    if (not isinstance(ifcond, list) or
> +        any([not isinstance(elt, str) for elt in ifcond])):
> +        raise QAPISemError(info, "'if' condition requires a string or "
> +                           "a list of string")

Wait a second!  What's this list business?  The commit message doesn't
say.

Also, pep8 gripes:

    scripts/qapi.py:647:9: E129 visually indented line with same indent as =
next logical line

> +
> +
>  def check_type(info, source, value, allow_array=3DFalse,
>                 allow_dict=3DFalse, allow_optional=3DFalse,
>                 allow_metas=3D[]):
> @@ -865,6 +875,7 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
>      expr =3D expr_elem['expr']
>      info =3D expr_elem['info']
>      name =3D expr[meta]
> +    optional.append('if')

Caution!

    $ python
    Python 2.7.13 (default, May 10 2017, 20:04:36)=20
    >>> def surprise(arg=3D[]):
    ...     arg.append('if')
    ...     return arg
    ...=20
    >>> surprise()
    ['if']
    >>> surprise()
    ['if', 'if']
    >>> surprise()
    ['if', 'if', 'if']

Never modify an argument that has list or dictionary default value.  To
avoid the temptation, never use such defaul values.

>      if not isinstance(name, str):
>          raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
>      required =3D required + [meta]
> @@ -880,6 +891,8 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
>              raise QAPISemError(info,
>                                 "'%s' of %s '%s' should only use true val=
ue"
>                                 % (key, meta, name))
> +        if key =3D=3D 'if':
> +            check_if(expr, info)
>      for key in required:
>          if key not in expr:
>              raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
> @@ -989,6 +1002,10 @@ class QAPISchemaEntity(object):
>          # such place).
>          self.info =3D info
>          self.doc =3D doc
> +        self.ifcond =3D None
> +
> +    def set_ifcond(self, ifcond):
> +        self.ifcond =3D ifcond

@ifcond is an awkward name, but I don't have better ideas.

>=20=20
>      def c_name(self):
>          return c_name(self.name)
> @@ -1017,26 +1034,26 @@ class QAPISchemaVisitor(object):
>      def visit_builtin_type(self, name, info, json_type):
>          pass
>=20=20
> -    def visit_enum_type(self, name, info, values, prefix):
> +    def visit_enum_type(self, name, info, values, prefix, ifcond):
>          pass
>=20=20
> -    def visit_array_type(self, name, info, element_type):
> +    def visit_array_type(self, name, info, element_type, ifcond):
>          pass
>=20=20
> -    def visit_object_type(self, name, info, base, members, variants):
> +    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
>          pass
>=20=20
> -    def visit_object_type_flat(self, name, info, members, variants):
> +    def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
>          pass
>=20=20
> -    def visit_alternate_type(self, name, info, variants):
> +    def visit_alternate_type(self, name, info, variants, ifcond):
>          pass
>=20=20
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, ifcond):
>          pass
>=20=20
> -    def visit_event(self, name, info, arg_type, boxed):
> +    def visit_event(self, name, info, arg_type, boxed, ifcond):
>          pass
>=20=20
>=20=20
> @@ -1136,7 +1153,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>=20=20
>      def visit(self, visitor):
>          visitor.visit_enum_type(self.name, self.info,
> -                                self.member_names(), self.prefix)
> +                                self.member_names(), self.prefix, self.i=
fcond)
>=20=20
>=20=20
>  class QAPISchemaArrayType(QAPISchemaType):
> @@ -1149,6 +1166,7 @@ class QAPISchemaArrayType(QAPISchemaType):
>      def check(self, schema):
>          self.element_type =3D schema.lookup_type(self._element_type_name)
>          assert self.element_type
> +        self.ifcond =3D self.element_type.ifcond
>=20=20
>      def is_implicit(self):
>          return True
> @@ -1166,7 +1184,8 @@ class QAPISchemaArrayType(QAPISchemaType):
>          return 'array of ' + elt_doc_type
>=20=20
>      def visit(self, visitor):
> -        visitor.visit_array_type(self.name, self.info, self.element_type)
> +        visitor.visit_array_type(self.name, self.info, self.element_type,
> +                                 self.ifcond)
>=20=20
>=20=20
>  class QAPISchemaObjectType(QAPISchemaType):
> @@ -1247,9 +1266,10 @@ class QAPISchemaObjectType(QAPISchemaType):
>=20=20
>      def visit(self, visitor):
>          visitor.visit_object_type(self.name, self.info,
> -                                  self.base, self.local_members, self.va=
riants)
> +                                  self.base, self.local_members, self.va=
riants,
> +                                  self.ifcond)
>          visitor.visit_object_type_flat(self.name, self.info,
> -                                       self.members, self.variants)
> +                                       self.members, self.variants, self=
.ifcond)

You break the line before self.ifcond almost everywhere, and when you
don't, the line gets long.  This one goes over the limit:

    scripts/qapi.py:1285:80: E501 line too long (80 > 79 characters)

Suggest to break it before self.ifcond everywhere.

>=20=20
>=20=20
>  class QAPISchemaMember(object):
> @@ -1392,7 +1412,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
>          return 'value'
>=20=20
>      def visit(self, visitor):
> -        visitor.visit_alternate_type(self.name, self.info, self.variants)
> +        visitor.visit_alternate_type(self.name, self.info,
> +                                     self.variants, self.ifcond)
>=20=20
>      def is_empty(self):
>          return False
> @@ -1434,7 +1455,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
>      def visit(self, visitor):
>          visitor.visit_command(self.name, self.info,
>                                self.arg_type, self.ret_type,
> -                              self.gen, self.success_response, self.boxe=
d)
> +                              self.gen, self.success_response, self.boxe=
d,
> +                              self.ifcond)
>=20=20
>=20=20
>  class QAPISchemaEvent(QAPISchemaEntity):
> @@ -1462,7 +1484,8 @@ class QAPISchemaEvent(QAPISchemaEntity):
>              raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
>=20=20
>      def visit(self, visitor):
> -        visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed)
> +        visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed,
> +                            self.ifcond)
>=20=20
>=20=20
>  class QAPISchema(object):
> @@ -1481,11 +1504,12 @@ class QAPISchema(object):
>              print >>sys.stderr, err
>              exit(1)
>=20=20
> -    def _def_entity(self, ent):
> +    def _def_entity(self, ent, ifcond=3DNone):
>          # Only the predefined types are allowed to not have info
>          assert ent.info or self._predefining
>          assert ent.name not in self._entity_dict
>          self._entity_dict[ent.name] =3D ent
> +        ent.set_ifcond(ifcond)

.set_ifcond(None) does the right thing.

However:

>=20=20
>      def lookup_entity(self, name, typ=3DNone):
>          ent =3D self._entity_dict.get(name)
> @@ -1534,11 +1558,11 @@ class QAPISchema(object):
>      def _make_enum_members(self, values):
>          return [QAPISchemaMember(v) for v in values]
>=20=20
> -    def _make_implicit_enum_type(self, name, info, values):
> +    def _make_implicit_enum_type(self, name, info, values, ifcond):
>          # See also QAPISchemaObjectTypeMember._pretty_owner()
>          name =3D name + 'Kind'   # Use namespace reserved by add_name()
>          self._def_entity(QAPISchemaEnumType(
> -            name, info, None, self._make_enum_members(values), None))
> +            name, info, None, self._make_enum_members(values), None), if=
cond)
>          return name

Why is ifcond not a constructor argument like name, info, and so forth?
What makes it special?

>=20=20
>      def _make_array_type(self, element_type, info):
> @@ -1547,22 +1571,26 @@ class QAPISchema(object):
>              self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
>          return name
>=20=20
> -    def _make_implicit_object_type(self, name, info, doc, role, members):
> +    def _make_implicit_object_type(self, name, info, doc, role, members,
> +                                   ifcond=3DNone):
>          if not members:
>              return None
>          # See also QAPISchemaObjectTypeMember._pretty_owner()
>          name =3D 'q_obj_%s-%s' % (name, role)
> -        if not self.lookup_entity(name, QAPISchemaObjectType):
> +        if self.lookup_entity(name, QAPISchemaObjectType):
> +            assert ifcond is None
> +        else:
>              self._def_entity(QAPISchemaObjectType(name, info, doc, None,
> -                                                  members, None))
> +                                                  members, None), ifcond)
>          return name

Hmm, this smells like it might be the "variants objects types" mentioned
in the commit message.

Types made with _make_implicit_object_type():

* The wrapper around "simple" union members, by _make_simple_variant()

* A flat union's base type when it's implicit, by _def_union_type()

* A command's argument type when it's implicit, by _def_command()

* An event's argument type when it's implicit, by _def_event()

Only the first one can be used more than once, namely when a type occurs
in more than one simple union.  The "correct" ifcond is the disjunction
of all its user's ifconds.  You make it use the *first* ifcond instead.
Wrong: breaks when one of the other simple unions has a condition that
is true when the first one's is false.

Your commit message suggests you intended to make it unconditional
instead.  That would work: the worst that can happen is compiling a few
q_obj_FOO_wrapper typedefs and visit_type_q_FOO_wrapper() functions that
aren't actually used.  Tolerable, in particular since I hope to get rid
of "simple" unions some day.

Sadly, it would prevent us from making the visit functions for implicit
types static, because unused static functions trigger warnings.  Let's
not worry about that now.

Generating the disjunction of all conditions wouldn't be terribly hard.
I'm not asking for it, though.

You assert that implicit types are unconditional from the second use on.
I guess you mean to assert the ones used more than once are
unconditional:

           typ =3D self.lookup_entity(name, QAPISchemaObjectType)
           if typ:
               assert ifcond is None and typ.ifcond is None

But what you *should* assert is that the conditions are the same:

           typ =3D self.lookup_entity(name, QAPISchemaObjectType)
           if typ:
               assert ifcond =3D=3D typ.ifcond

>=20=20
>      def _def_enum_type(self, expr, info, doc):
>          name =3D expr['enum']
>          data =3D expr['data']
>          prefix =3D expr.get('prefix')
> -        self._def_entity(QAPISchemaEnumType(
> -            name, info, doc, self._make_enum_members(data), prefix))
> +        return self._def_entity(QAPISchemaEnumType(
> +            name, info, doc, self._make_enum_members(data), prefix),
> +                                expr.get('if'))

Covers enumeration types.

Why return?  The (only) caller throws the value away...

>=20=20
>      def _make_member(self, name, typ, info):
>          optional =3D False
> @@ -1584,7 +1612,8 @@ class QAPISchema(object):
>          data =3D expr['data']
>          self._def_entity(QAPISchemaObjectType(name, info, doc, base,
>                                                self._make_members(data, i=
nfo),
> -                                              None))
> +                                              None),
> +                         expr.get('if'))

Covers struct types.

>=20=20
>      def _make_variant(self, case, typ):
>          return QAPISchemaObjectTypeVariant(case, typ)
> @@ -1593,8 +1622,10 @@ class QAPISchema(object):
>          if isinstance(typ, list):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
> +        type_entity =3D self.lookup_type(typ)
>          typ =3D self._make_implicit_object_type(
> -            typ, info, None, 'wrapper', [self._make_member('data', typ, =
info)])
> +            typ, info, None, 'wrapper',
> +            [self._make_member('data', typ, info)], type_entity.ifcond)
>          return QAPISchemaObjectTypeVariant(case, typ)

A simple union member's wrapper type inherits its condition from the
member type.

I think you need to pass None instead of type_entity.ifcond here.

>=20=20
>      def _def_union_type(self, expr, info, doc):
> @@ -1604,8 +1635,9 @@ class QAPISchema(object):
>          tag_name =3D expr.get('discriminator')
>          tag_member =3D None
>          if isinstance(base, dict):
> -            base =3D (self._make_implicit_object_type(
> -                name, info, doc, 'base', self._make_members(base, info)))
> +            base =3D self._make_implicit_object_type(
> +                name, info, doc, 'base', self._make_members(base, info),
> +                expr.get('if'))

A flat union's implicit base type inherits its condition from the flat
union.  Good.

>          if tag_name:
>              variants =3D [self._make_variant(key, value)
>                          for (key, value) in data.iteritems()]
> @@ -1614,14 +1646,16 @@ class QAPISchema(object):
>              variants =3D [self._make_simple_variant(key, value, info)
>                          for (key, value) in data.iteritems()]
>              typ =3D self._make_implicit_enum_type(name, info,
> -                                                [v.name for v in variant=
s])
> +                                                [v.name for v in variant=
s],
> +                                                expr.get('if'))

A flat union's implicit enumeration type inherits its condition from the
flat union.  Good.

>              tag_member =3D QAPISchemaObjectTypeMember('type', typ, False)
>              members =3D [tag_member]
>          self._def_entity(
>              QAPISchemaObjectType(name, info, doc, base, members,
>                                   QAPISchemaObjectTypeVariants(tag_name,
>                                                                tag_member,
> -                                                              variants)))
> +                                                              variants)),
> +            expr.get('if'))

Covers union types.

Third use of expr.get('if') in this function.  Please put it in a
variable.

Actually, do that for *all* uses of expr[X] and expr.get(X) in class
QAPISchema, because that's how the existing code works.

>=20=20
>      def _def_alternate_type(self, expr, info, doc):
>          name =3D expr['alternate']
> @@ -1633,7 +1667,8 @@ class QAPISchema(object):
>              QAPISchemaAlternateType(name, info, doc,
>                                      QAPISchemaObjectTypeVariants(None,
>                                                                   tag_mem=
ber,
> -                                                                 variant=
s)))
> +                                                                 variant=
s)),
> +            expr.get('if'))

Covers alternate types.

>=20=20
>      def _def_command(self, expr, info, doc):
>          name =3D expr['command']
> @@ -1644,12 +1679,14 @@ class QAPISchema(object):
>          boxed =3D expr.get('boxed', False)
>          if isinstance(data, OrderedDict):
>              data =3D self._make_implicit_object_type(
> -                name, info, doc, 'arg', self._make_members(data, info))
> +                name, info, doc, 'arg', self._make_members(data, info),
> +                expr.get('if'))

A command's implicit argument type inherits its condition from the
command.  Good.

>          if isinstance(rets, list):
>              assert len(rets) =3D=3D 1
>              rets =3D self._make_array_type(rets[0], info)
>          self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
> -                                           gen, success_response, boxed))
> +                                           gen, success_response, boxed),
> +                         expr.get('if'))

Covers commands.

>=20=20
>      def _def_event(self, expr, info, doc):
>          name =3D expr['event']
> @@ -1657,8 +1694,10 @@ class QAPISchema(object):
>          boxed =3D expr.get('boxed', False)
>          if isinstance(data, OrderedDict):
>              data =3D self._make_implicit_object_type(
> -                name, info, doc, 'arg', self._make_members(data, info))
> -        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
> +                name, info, doc, 'arg', self._make_members(data, info),
> +                expr.get('if'))

An event's implicit argument type inherits its condition from the
command.  Good.

> +        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed),
> +                         expr.get('if'))

Covers events.  You got them all.  Good.

>=20=20
>      def _def_exprs(self):
>          for expr_elem in self.exprs:
> @@ -1848,6 +1887,54 @@ def guardend(name):
>                   name=3Dguardname(name))
>=20=20
>=20=20
> +def gen_if(ifcond, func=3D''):
> +    if not ifcond:
> +        return ''
> +    if isinstance(ifcond, str):
> +        ifcond =3D [ifcond]
> +    ret =3D '\n'
> +    for ifc in ifcond:
> +        ret +=3D mcgen('#if %(ifcond)s /* %(func)s */\n', ifcond=3Difc, =
func=3Dfunc)
> +    ret +=3D '\n'
> +    return ret

Please use mcgen() like the existing code:

           ret +=3D mcgen('''
   #if %(ifcond)s /* %(func)s */
   ''', ifcond=3Difc, func=3Dfunc)

With the default value of @func, we get a useless, ugly comment /* */.
If this can happen, please suppress the comment.  Else, drop @func's
default value.

Lists appear to be conjunctions.  What for?

> +
> +
> +def gen_endif(ifcond, func=3D''):
> +    if not ifcond:
> +        return ''
> +    if isinstance(ifcond, str):
> +        ifcond =3D [ifcond]
> +    ret =3D '\n'
> +    for ifc in reversed(ifcond):
> +        ret +=3D mcgen('#endif /* %(ifcond)s %(func)s */\n',
> +                     ifcond=3Difc, func=3Dfunc)
> +    ret +=3D '\n'
> +    return ret

Likewise.

> +
> +
> +# wrap a method to add #if / #endif to generated code
> +# self must have 'if_members' listing the attributes to wrap
> +# the last argument of the wrapped function must be the 'ifcond'

Start your sentences with a capital letter, and end them with a period,
please.

> +def if_wrap(func):

Blank line, please.

> +    def func_wrapper(self, *args, **kwargs):
> +        funcname =3D self.__class__.__name__ + '.' + func.__name__
> +        ifcond =3D args[-1]
> +        save =3D {}
> +        for mem in self.if_members:
> +            save[mem] =3D getattr(self, mem)
> +        func(self, *args, **kwargs)
> +        for mem, val in save.items():
> +            newval =3D getattr(self, mem)
> +            if newval !=3D val:
> +                assert newval.startswith(val)
> +                newval =3D newval[len(val):]
> +                val +=3D gen_if(ifcond, funcname)

Emitting comments pointing to the QAPI schema into the generated code is
often helpful.  But this one points to QAPI generator code.  Why is that
useful?

> +                val +=3D newval
> +                val +=3D gen_endif(ifcond, funcname)
> +            setattr(self, mem, val)
> +
> +    return func_wrapper
> +

pep8 again:

    scripts/qapi.py:1955:1: E302 expected 2 blank lines, found 1

Peeking ahead: this function is used as a decorator.  Let's help the
reader and mention that in the function comment, or by naming the
function suitably.  ifcond_decorator?

Messing with the wrapped method's class's attributes is naughty.  Worse,
it's hard to understand.  What alternatives have you considered?

>  def gen_enum_lookup(name, values, prefix=3DNone):
>      ret =3D mcgen('''
>=20=20
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 974d0a4a80..19b1bb9b88 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -228,6 +228,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self.defn =3D None
>          self._regy =3D None
>          self._visited_ret_types =3D None
> +        self.if_members =3D ['decl', 'defn', '_regy']
>=20=20
>      def visit_begin(self, schema):
>          self.decl =3D ''
> @@ -240,8 +241,9 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._regy =3D None
>          self._visited_ret_types =3D None
>=20=20
> +    @if_wrap
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, ifcond):
>          if not gen:
>              return
>          self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index bcbef1035f..cad9ece790 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -152,6 +152,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self.decl =3D None
>          self.defn =3D None
>          self._event_names =3D None
> +        self.if_members =3D ['decl', 'defn']
>=20=20
>      def visit_begin(self, schema):
>          self.decl =3D ''
> @@ -163,7 +164,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
>          self._event_names =3D None
>=20=20
> -    def visit_event(self, name, info, arg_type, boxed):
> +    @if_wrap
> +    def visit_event(self, name, info, arg_type, boxed, ifcond):
>          self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
>          self.defn +=3D gen_event_send(name, arg_type, boxed)
>          self._event_names.append(name)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index fc72cdb66d..ecfb0f2752 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -12,7 +12,7 @@
>  from qapi import *
>=20=20
>=20=20
> -def to_qlit(obj, level=3D0, first_indent=3DTrue):
> +def to_qlit(obj, level=3D0, first_indent=3DTrue, suffix=3D''):
>      def indent(level):
>          return level * 4 * ' '
>      ret =3D ''
> @@ -20,14 +20,20 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>          ret +=3D indent(level)
>      if obj is None:
>          ret +=3D 'QLIT_QNULL'
> +    elif isinstance(obj, tuple):
> +        obj, ifcond =3D  obj
> +        ret +=3D gen_if(ifcond)
> +        ret +=3D to_qlit(obj, level, False) + suffix

Keyword argument instead of bare False, please.

> +        ret +=3D gen_endif(ifcond)
> +        suffix =3D ''

New case tuple, for generating conditionals.  Okay.

>      elif isinstance(obj, str):
>          ret +=3D 'QLIT_QSTR(' + '"' + obj.replace('"', r'\"') + '"' + ')'
>      elif isinstance(obj, list):
> -        elts =3D [to_qlit(elt, level + 1)
> +        elts =3D [to_qlit(elt, level + 1, True, ",")

Make that

           elts =3D [to_qlit(elt, level + 1, suffix=3D",")

>                  for elt in obj]
>          elts.append(indent(level + 1) + "{ }")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> -        ret +=3D ',\n'.join(elts) + '\n'
> +        ret +=3D '\n'.join(elts) + '\n'
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, dict):
>          elts =3D [ indent(level + 1) + '{ "%s", %s }' %
> @@ -39,7 +45,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>          ret +=3D indent(level) + '}))'
>      else:
>          assert False                # not implemented
> -    return ret
> +    return ret + suffix

This is getting really hard to review --- my brain is about to overflow
and shut down for the day.  Can you split off some preparatory work?
The introduction of suffix here, perhaps?

>=20=20
>=20=20
>  class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
> @@ -113,12 +119,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>=20=20
> -    def _gen_qlit(self, name, mtype, obj):
> +    def _gen_qlit(self, name, mtype, obj, ifcond):
>          if mtype not in ('command', 'event', 'builtin', 'array'):
>              name =3D self._name(name)
>          obj['name'] =3D name
>          obj['meta-type'] =3D mtype
> -        self._qlits.append(obj)
> +        self._qlits.append((obj, ifcond))
>=20=20
>      def _gen_member(self, member):
>          ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
> @@ -134,38 +140,40 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
>=20=20
>      def visit_builtin_type(self, name, info, json_type):
> -        self._gen_qlit(name, 'builtin', {'json-type': json_type})
> +        self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
>=20=20
> -    def visit_enum_type(self, name, info, values, prefix):
> -        self._gen_qlit(name, 'enum', {'values': values})
> +    def visit_enum_type(self, name, info, values, prefix, ifcond):
> +        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
>=20=20
> -    def visit_array_type(self, name, info, element_type):
> +    def visit_array_type(self, name, info, element_type, ifcond):
>          element =3D self._use_type(element_type)
> -        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
> +        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
> +                       ifcond)
>=20=20
> -    def visit_object_type_flat(self, name, info, members, variants):
> +    def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
>          obj =3D {'members': [self._gen_member(m) for m in members]}
>          if variants:
>              obj.update(self._gen_variants(variants.tag_member.name,
>                                            variants.variants))
> -        self._gen_qlit(name, 'object', obj)
> +        self._gen_qlit(name, 'object', obj, ifcond)
>=20=20
> -    def visit_alternate_type(self, name, info, variants):
> +    def visit_alternate_type(self, name, info, variants, ifcond):
>          self._gen_qlit(name, 'alternate',
>                         {'members': [{'type': self._use_type(m.type)}
> -                                    for m in variants.variants]})
> +                                    for m in variants.variants]}, ifcond)
>=20=20
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, ifcond):
>          arg_type =3D arg_type or self._schema.the_empty_object_type
>          ret_type =3D ret_type or self._schema.the_empty_object_type
>          self._gen_qlit(name, 'command',
>                         {'arg-type': self._use_type(arg_type),
> -                        'ret-type': self._use_type(ret_type)})
> +                        'ret-type': self._use_type(ret_type)}, ifcond)
>=20=20
> -    def visit_event(self, name, info, arg_type, boxed):
> +    def visit_event(self, name, info, arg_type, boxed, ifcond):
>          arg_type =3D arg_type or self._schema.the_empty_object_type
> -        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
> +        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
> +                       ifcond)
>=20=20
>  # Debugging aid: unmask QAPI schema's type names
>  # We normally mask them, because they're not QMP wire ABI

Out of review brainpower for today.  Hope to resume tomorrow.

[...]
