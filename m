Received: from eggs.gnu.org ([2001:4830:134:3::10]:52230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpFvY-0001Q8-Pa
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpFvN-0000W6-So
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dpFvN-0000Vb-JH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:38:01 -0400
Date: Tue, 5 Sep 2017 11:38:00 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <80558265.8663807.1504625880216.JavaMail.zimbra@redhat.com>
In-Reply-To: <87h8wicuhc.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-18-marcandre.lureau@redhat.com>
	<87h8wicuhc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 17/54] qapi: add 'if' condition on
 entity objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Take 'if' from expression, and use it to construct entity objects.
> > Shared implicit objects must share the same 'if' condition.
>=20
> Shared by what?

Shared by various make_implicit_object_type() users.

>=20
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi.py | 81
> >  +++++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 53 insertions(+), 28 deletions(-)
> >
> > diff --git a/scripts/qapi.py b/scripts/qapi.py
> > index a94d93ada4..dc40d74abb 100644
> > --- a/scripts/qapi.py
> > +++ b/scripts/qapi.py
> > @@ -992,7 +992,7 @@ def check_exprs(exprs):
> >  #
> > =20
> >  class QAPISchemaEntity(object):
> > -    def __init__(self, name, info, doc):
> > +    def __init__(self, name, info, doc, ifcond=3DNone):
> >          assert isinstance(name, str)
> >          self.name =3D name
> >          # For explicitly defined entities, info points to the (explici=
t)
>=20
> Not visible here: QAPISchemaType inherits this.
>=20
> > @@ -1002,6 +1002,7 @@ class QAPISchemaEntity(object):
> >          # such place).
> >          self.info =3D info
> >          self.doc =3D doc
> > +        self.ifcond =3D ifcond
> > =20
> >      def c_name(self):
> >          return c_name(self.name)
> > @@ -1118,8 +1119,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
> > =20
> > =20
> >  class QAPISchemaEnumType(QAPISchemaType):
> > -    def __init__(self, name, info, doc, values, prefix):
> > -        QAPISchemaType.__init__(self, name, info, doc)
> > +    def __init__(self, name, info, doc, values, prefix, ifcond=3DNone)=
:
> > +        QAPISchemaType.__init__(self, name, info, doc, ifcond)
> >          for v in values:
> >              assert isinstance(v, QAPISchemaMember)
> >              v.set_owner(name)
> > @@ -1162,6 +1163,7 @@ class QAPISchemaArrayType(QAPISchemaType):
> >      def check(self, schema):
> >          self.element_type =3D schema.lookup_type(self._element_type_na=
me)
> >          assert self.element_type
> > +        self.ifcond =3D self.element_type.ifcond
>=20
> This is subtler than it looks on first glance.
>=20
> All the other entities set self.ifcond in their constructor to the true
> value passed in as argument.
>=20
> QAPISchemaArrayType doesn't take such an argument.  Instead, it inherits
> its .ifcond from its .element_type.  However, .element_type isn't known
> at construction time if it's a forward reference.  We therefore delay
> setting it until .check() time.  You do the same for .ifcond (no
> choice).
>=20
> Before .check(), .ifcond is None, because the constructor sets it that
> way: it calls QAPISchemaType.__init__() without passing a ifcond
> argument, which then sets self.ifcond to its default argument None.
>=20
> Pitfall: accessing ent.ifcond before ent.check() works *except* when ent
> is an array type.  Hmm.
>=20
> > =20
> >      def is_implicit(self):
> >          return True
> > @@ -1183,11 +1185,12 @@ class QAPISchemaArrayType(QAPISchemaType):
> > =20
> > =20
> >  class QAPISchemaObjectType(QAPISchemaType):
> > -    def __init__(self, name, info, doc, base, local_members, variants)=
:
> > +    def __init__(self, name, info, doc, base, local_members, variants,
> > +                 ifcond=3DNone):
> >          # struct has local_members, optional base, and no variants
> >          # flat union has base, variants, and no local_members
> >          # simple union has local_members, variants, and no base
> > -        QAPISchemaType.__init__(self, name, info, doc)
> > +        QAPISchemaType.__init__(self, name, info, doc, ifcond)
> >          assert base is None or isinstance(base, str)
> >          for m in local_members:
> >              assert isinstance(m, QAPISchemaObjectTypeMember)
> > @@ -1375,8 +1378,8 @@ class
> > QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
> > =20
> > =20
> >  class QAPISchemaAlternateType(QAPISchemaType):
> > -    def __init__(self, name, info, doc, variants):
> > -        QAPISchemaType.__init__(self, name, info, doc)
> > +    def __init__(self, name, info, doc, variants, ifcond):
> > +        QAPISchemaType.__init__(self, name, info, doc, ifcond)
> >          assert isinstance(variants, QAPISchemaObjectTypeVariants)
> >          assert variants.tag_member
> >          variants.set_owner(name)
> > @@ -1413,8 +1416,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
> > =20
> >  class QAPISchemaCommand(QAPISchemaEntity):
> >      def __init__(self, name, info, doc, arg_type, ret_type,
> > -                 gen, success_response, boxed):
> > -        QAPISchemaEntity.__init__(self, name, info, doc)
> > +                 gen, success_response, boxed, ifcond):
> > +        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
> >          assert not arg_type or isinstance(arg_type, str)
> >          assert not ret_type or isinstance(ret_type, str)
> >          self._arg_type_name =3D arg_type
> > @@ -1451,8 +1454,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
> > =20
> > =20
> >  class QAPISchemaEvent(QAPISchemaEntity):
> > -    def __init__(self, name, info, doc, arg_type, boxed):
> > -        QAPISchemaEntity.__init__(self, name, info, doc)
> > +    def __init__(self, name, info, doc, arg_type, boxed, ifcond):
> > +        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
> >          assert not arg_type or isinstance(arg_type, str)
> >          self._arg_type_name =3D arg_type
> >          self.arg_type =3D None
>=20
> Hmm.  You're adding parameter ifcond to all entity constructors.  The
> entity constructors' signatures all look like this:
>=20
>     def __init__(<common parameters>, <specific parameters>)
>=20
> where <common parameters> is self, name, info, doc.
>=20
> Since ifcond is common, let's add it to <common parameters>.  Pick a
> position you like.
>=20

ok

> > @@ -1547,11 +1550,11 @@ class QAPISchema(object):
> >      def _make_enum_members(self, values):
> >          return [QAPISchemaMember(v) for v in values]
> > =20
> > -    def _make_implicit_enum_type(self, name, info, values):
> > +    def _make_implicit_enum_type(self, name, info, values, ifcond):
> >          # See also QAPISchemaObjectTypeMember._pretty_owner()
> >          name =3D name + 'Kind'   # Use namespace reserved by add_name(=
)
> >          self._def_entity(QAPISchemaEnumType(
> > -            name, info, None, self._make_enum_members(values), None))
> > +            name, info, None, self._make_enum_members(values), None,
> > ifcond))
> >          return name
>=20
> Called by _def_union_type() to create the implicit tag enum, with the
> same ifcond it passes to QAPISchemaObjectType().  Thus, the implicit
> type's ifcond matches the ifcond of its only user.  Good.
>=20
> > =20
> >      def _make_array_type(self, element_type, info):
> > @@ -1560,22 +1563,29 @@ class QAPISchema(object):
> >              self._def_entity(QAPISchemaArrayType(name, info,
> >              element_type))
> >          return name
> > =20
> > -    def _make_implicit_object_type(self, name, info, doc, role, member=
s):
> > +    def _make_implicit_object_type(self, name, info, doc, role, member=
s,
> > +                                   ifcond=3DNone):
> >          if not members:
> >              return None
> >          # See also QAPISchemaObjectTypeMember._pretty_owner()
> >          name =3D 'q_obj_%s-%s' % (name, role)
> > -        if not self.lookup_entity(name, QAPISchemaObjectType):
> > +        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
> > +        if typ:
> > +            # FIXME: generating the disjunction of all conditions
>=20
> What are "all conditions"?  I hope I can shed some light on that below.
>=20
> > +            assert ifcond =3D=3D typ.ifcond
> > +        else:
> >              self._def_entity(QAPISchemaObjectType(name, info, doc, Non=
e,
> > -                                                  members, None))
> > +                                                  members, None, ifcon=
d))
> >          return name
>=20
> Several callers:
>=20
> * _make_simple_variant() to create a wrapper type, with the wrapped
>   type's ifcond.  The wrapped type's ifcond is necessary for the wrapper
>   type to compile.  It's not sufficient for it to be needed.  The
>   "needed" condition is the disjunction of all users' ifcond.
>=20
>   In other words, your code generates condition that is correct, but not
>   tight.  Your FIXME is about tightening it.  I'd make it a TODO,
>   because nothing is actually broken now.
>=20
>   Need a comment explaining this.  Perhaps:
>=20
>         if typ:
>             # The implicit object type has multiple users.  This can
>             # happen only for simple unions' implicit wrapper types.
>             # Its ifcond should be the disjunction of its user's
>             # ifconds.  Not implemented.  Instead, we always pass the
>             # wrapped type's ifcond, which is trivially the same for all
>             # users.  It's also necessary for the wrapper to compile.
>             # But it's not tight: the disjunction need not imply it.  We
>             # may end up compiling useless wrapper types.
>             # TODO kill simple unions or implement the disjunction
>=20
>   I hate simple unions.

ok

>=20
> * _def_union_type() to create an implicit base type, with same ifcond it
>   passes to QAPISchemaObjectType().  Thus, the implicit base type's
>   ifcond matches the ifcond of its only user.  Good.
>=20
> * _def_command() to create an implicit argument type, with the same
>   ifcond it passes to QAPISchemaCommand().  Thus, the implicit argument
>   type's ifcond matches the ifcond of its only user.  Good.
>=20
> * _def_event() likewise.
>=20
> I still can't make sense of the commit message's "Shared implicit
> objects must share the same 'if' condition."
>=20
> > =20
> >      def _def_enum_type(self, expr, info, doc):
> >          name =3D expr['enum']
> >          data =3D expr['data']
> >          prefix =3D expr.get('prefix')
> > +        ifcond =3D expr.get('if')
> >          self._def_entity(QAPISchemaEnumType(
> > -            name, info, doc, self._make_enum_members(data), prefix))
> > +            name, info, doc, self._make_enum_members(data), prefix,
> > +            ifcond))
> > =20
> >      def _make_member(self, name, typ, info):
> >          optional =3D False
> > @@ -1595,9 +1605,10 @@ class QAPISchema(object):
> >          name =3D expr['struct']
> >          base =3D expr.get('base')
> >          data =3D expr['data']
> > +        ifcond =3D expr.get('if')
> >          self._def_entity(QAPISchemaObjectType(name, info, doc, base,
> >                                                self._make_members(data,
> >                                                info),
> > -                                              None))
> > +                                              None, ifcond))
> > =20
> >      def _make_variant(self, case, typ):
> >          return QAPISchemaObjectTypeVariant(case, typ)
> > @@ -1606,19 +1617,23 @@ class QAPISchema(object):
> >          if isinstance(typ, list):
> >              assert len(typ) =3D=3D 1
> >              typ =3D self._make_array_type(typ[0], info)
> > +        type_entity =3D self.lookup_type(typ)
> >          typ =3D self._make_implicit_object_type(
> > -            typ, info, None, 'wrapper', [self._make_member('data', typ=
,
> > info)])
> > +            typ, info, None, 'wrapper',
> > +            [self._make_member('data', typ, info)], type_entity.ifcond=
)
> >          return QAPISchemaObjectTypeVariant(case, typ)
>=20
> This is where you create the wrapper type with the wrapped type's
> ifcond.
>=20
> I don't like the name type_entity.  I'd simply eliminate the variable.
>=20

ok

> > =20
> >      def _def_union_type(self, expr, info, doc):
> >          name =3D expr['union']
> >          data =3D expr['data']
> >          base =3D expr.get('base')
> > +        ifcond =3D expr.get('if')
> >          tag_name =3D expr.get('discriminator')
> >          tag_member =3D None
> >          if isinstance(base, dict):
> > -            base =3D (self._make_implicit_object_type(
> > -                name, info, doc, 'base', self._make_members(base, info=
)))
> > +            base =3D self._make_implicit_object_type(
> > +                name, info, doc, 'base', self._make_members(base, info=
),
> > +                ifcond)
> >          if tag_name:
> >              variants =3D [self._make_variant(key, value)
> >                          for (key, value) in data.iteritems()]
>=20
> This is where you create a union's implicit base type with the union's
> ifcond.
>=20
> > @@ -1627,18 +1642,21 @@ class QAPISchema(object):
> >              variants =3D [self._make_simple_variant(key, value, info)
> >                          for (key, value) in data.iteritems()]
> >              typ =3D self._make_implicit_enum_type(name, info,
> > -                                                [v.name for v in
> > variants])
> > +                                                [v.name for v in
> > variants],
> > +                                                ifcond)
> >              tag_member =3D QAPISchemaObjectTypeMember('type', typ, Fal=
se)
> >              members =3D [tag_member]
>=20
> This is where you create a union's implicit tag enum with the union's ifc=
ond.
>=20
> >          self._def_entity(
> >              QAPISchemaObjectType(name, info, doc, base, members,
> >                                   QAPISchemaObjectTypeVariants(tag_name=
,
> >                                                                tag_memb=
er,
> > -                                                              variants=
)))
> > +                                                              variants=
),
> > +                                 ifcond))
> > =20
> >      def _def_alternate_type(self, expr, info, doc):
> >          name =3D expr['alternate']
> >          data =3D expr['data']
> > +        ifcond =3D expr.get('if')
> >          variants =3D [self._make_variant(key, value)
> >                      for (key, value) in data.iteritems()]
> >          tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', Fal=
se)
> > @@ -1646,7 +1664,8 @@ class QAPISchema(object):
> >              QAPISchemaAlternateType(name, info, doc,
> >                                      QAPISchemaObjectTypeVariants(None,
> >                                                                   tag_m=
ember,
> > -
> > variants)))
> > +
> > variants),
> > +                                    ifcond))
> > =20
> >      def _def_command(self, expr, info, doc):
> >          name =3D expr['command']
> > @@ -1655,23 +1674,29 @@ class QAPISchema(object):
> >          gen =3D expr.get('gen', True)
> >          success_response =3D expr.get('success-response', True)
> >          boxed =3D expr.get('boxed', False)
> > +        ifcond =3D expr.get('if')
> >          if isinstance(data, OrderedDict):
> >              data =3D self._make_implicit_object_type(
> > -                name, info, doc, 'arg', self._make_members(data, info)=
)
> > +                name, info, doc, 'arg', self._make_members(data, info)=
,
> > +                ifcond)
>=20
> This is where you create a command's implicit argument type with the
> command's ifcond.
>=20
> >          if isinstance(rets, list):
> >              assert len(rets) =3D=3D 1
> >              rets =3D self._make_array_type(rets[0], info)
> >          self._def_entity(QAPISchemaCommand(name, info, doc, data, rets=
,
> > -                                           gen, success_response, boxe=
d))
> > +                                           gen, success_response, boxe=
d,
> > +                                           ifcond))
> > =20
> >      def _def_event(self, expr, info, doc):
> >          name =3D expr['event']
> >          data =3D expr.get('data')
> >          boxed =3D expr.get('boxed', False)
> > +        ifcond =3D expr.get('if')
> >          if isinstance(data, OrderedDict):
> >              data =3D self._make_implicit_object_type(
> > -                name, info, doc, 'arg', self._make_members(data, info)=
)
> > -        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed)=
)
> > +                name, info, doc, 'arg', self._make_members(data, info)=
,
> > +                ifcond)
>=20
> This is where you create an event's implicit argument type with the
> event's ifcond.
>=20
> > +        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed,
> > +                                         ifcond))
> > =20
> >      def _def_exprs(self):
> >          for expr_elem in self.exprs:
>=20
