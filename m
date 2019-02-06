Received: from eggs.gnu.org ([209.51.188.92]:38208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIg-0008SR-Cj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIe-0007tj-Pd
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:02 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:44 +0100
Message-Id: <20190206195551.28893-2-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This patch allows specifying a discriminator that is an optional member
of the base struct.  In such a case, a default value must be provided
that is used when no value is given.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/introspect.json           |  8 +++++
 scripts/qapi/common.py         | 58 ++++++++++++++++++++++++++++------
 scripts/qapi/doc.py            | 10 ++++--
 scripts/qapi/introspect.py     | 10 ++++--
 scripts/qapi/visit.py          | 13 ++++++++
 tests/qapi-schema/test-qapi.py |  2 ++
 6 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 3d22166b2b..e4740aa7a0 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -168,6 +168,13 @@
 # @tag: the name of the member serving as type tag.
 #       An element of @members with this name must exist.
 #
+# @default-variant: if the @tag element of @members is optional, this
+#                   is the default value for choosing a variant.  Its
+#                   value will be a valid value for @tag.
+#                   Present exactly when @tag is present and the
+#                   associated element of @members is optional.
+#                   (Since: 4.0)
+#
 # @variants: variant members, i.e. additional members that
 #            depend on the type tag's value.  Present exactly when
 #            @tag is present.  The variants are in no particular order,
@@ -181,6 +188,7 @@
 { 'struct': 'SchemaInfoObject',
   'data': { 'members': [ 'SchemaInfoObjectMember' ],
             '*tag': 'str',
+            '*default-variant': 'str',
             '*variants': [ 'SchemaInfoObjectVariant' ] } }
=20
 ##
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c89edc0cb0..13fd55d9c9 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -750,6 +750,7 @@ def check_union(expr, info):
     name =3D expr['union']
     base =3D expr.get('base')
     discriminator =3D expr.get('discriminator')
+    default_variant =3D expr.get('default-variant')
     members =3D expr['data']
=20
     # Two types of unions, determined by discriminator.
@@ -774,16 +775,37 @@ def check_union(expr, info):
         base_members =3D find_base_members(base)
         assert base_members is not None
=20
-        # The value of member 'discriminator' must name a non-optional
-        # member of the base struct.
+        # The value of member 'discriminator' must name a member of
+        # the base struct.
         check_name(info, "Discriminator of flat union '%s'" % name,
                    discriminator)
-        discriminator_value =3D base_members.get(discriminator)
-        if not discriminator_value:
-            raise QAPISemError(info,
-                               "Discriminator '%s' is not a member of ba=
se "
-                               "struct '%s'"
-                               % (discriminator, base))
+        if default_variant is None:
+            discriminator_value =3D base_members.get(discriminator)
+            if not discriminator_value:
+                if base_members.get('*' + discriminator) is None:
+                    raise QAPISemError(info,
+                                       "Discriminator '%s' is not a memb=
er of "
+                                       "base struct '%s'"
+                                       % (discriminator, base))
+                else:
+                    raise QAPISemError(info,
+                                       "Default variant must be specifie=
d for "
+                                       "optional discriminator '%s'"
+                                       % discriminator)
+        else:
+            discriminator_value =3D base_members.get('*' + discriminator=
)
+            if not discriminator_value:
+                if base_members.get(discriminator) is None:
+                    raise QAPISemError(info,
+                                       "Discriminator '%s' is not a memb=
er of "
+                                       "base struct '%s'"
+                                       % (discriminator, base))
+                else:
+                    raise QAPISemError(info,
+                                       "Must not specify a default varia=
nt for "
+                                       "non-optional discriminator '%s'"
+                                       % discriminator)
+
         if discriminator_value.get('if'):
             raise QAPISemError(info, 'The discriminator %s.%s for union =
%s '
                                'must not be conditional' %
@@ -796,6 +818,16 @@ def check_union(expr, info):
                                "Discriminator '%s' must be of enumeratio=
n "
                                "type" % discriminator)
=20
+        if default_variant is not None:
+            # Must be a value of the enumeration
+            if not any(value for value in enum_define['data']
+                       if value['name'] =3D=3D default_variant):
+                raise QAPISemError(info,
+                                   "Default variant '%s' of flat union '=
%s' is "
+                                   "not part of '%s'"
+                                   % (default_variant, name,
+                                      discriminator_value['type']))
+
     # Check every branch; don't allow an empty union
     if len(members) =3D=3D 0:
         raise QAPISemError(info, "Union '%s' cannot have empty 'data'" %=
 name)
@@ -976,7 +1008,7 @@ def check_exprs(exprs):
         elif 'union' in expr:
             meta =3D 'union'
             check_keys(expr_elem, 'union', ['data'],
-                       ['base', 'discriminator', 'if'])
+                       ['base', 'discriminator', 'if', 'default-variant'=
])
             normalize_members(expr.get('base'))
             normalize_members(expr['data'])
             union_types[expr[meta]] =3D expr
@@ -1431,12 +1463,14 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember=
):
=20
=20
 class QAPISchemaObjectTypeVariants(object):
-    def __init__(self, tag_name, tag_member, variants):
+    def __init__(self, tag_name, tag_member, default_tag_value, variants=
):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set, and tag_name remains
         # a reliable witness of being used by a flat union.
         assert bool(tag_member) !=3D bool(tag_name)
+        # default_tag_value is only passed for flat unions.
+        assert bool(tag_name) or not bool(default_tag_value)
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
         assert len(variants) > 0
@@ -1444,6 +1478,7 @@ class QAPISchemaObjectTypeVariants(object):
             assert isinstance(v, QAPISchemaObjectTypeVariant)
         self._tag_name =3D tag_name
         self.tag_member =3D tag_member
+        self.default_tag_value =3D default_tag_value
         self.variants =3D variants
=20
     def set_owner(self, name):
@@ -1773,6 +1808,7 @@ class QAPISchema(object):
         base =3D expr.get('base')
         ifcond =3D expr.get('if')
         tag_name =3D expr.get('discriminator')
+        default_tag_value =3D expr.get('default-variant')
         tag_member =3D None
         if isinstance(base, dict):
             base =3D self._make_implicit_object_type(
@@ -1794,6 +1830,7 @@ class QAPISchema(object):
             QAPISchemaObjectType(name, info, doc, ifcond, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member=
,
+                                                              default_ta=
g_value,
                                                               variants))=
)
=20
     def _def_alternate_type(self, expr, info, doc):
@@ -1807,6 +1844,7 @@ class QAPISchema(object):
             QAPISchemaAlternateType(name, info, doc, ifcond,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_mem=
ber,
+                                                                 None,
                                                                  variant=
s)))
=20
     def _def_command(self, expr, info, doc):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index c03b690161..c7ad23985b 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -168,8 +168,14 @@ def texi_members(doc, what, base, variants, member_f=
unc):
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
         for v in variants.variants:
-            when =3D ' when @code{%s} is @t{"%s"}%s' % (
-                variants.tag_member.name, v.name, texi_if(v.ifcond, " ("=
, ")"))
+            if v.name =3D=3D variants.default_tag_value:
+                when =3D ' when @code{%s} is @t{"%s"} or not given%s' % =
(
+                    variants.tag_member.name, v.name,
+                    texi_if(v.ifcond, " (", ")"))
+            else:
+                when =3D ' when @code{%s} is @t{"%s"}%s' % (
+                    variants.tag_member.name, v.name,
+                    texi_if(v.ifcond, " (", ")"))
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f7f2ca07e4..db8af348d2 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -166,9 +166,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             ret =3D (ret, {'if': member.ifcond})
         return ret
=20
-    def _gen_variants(self, tag_name, variants):
-        return {'tag': tag_name,
-                'variants': [self._gen_variant(v) for v in variants]}
+    def _gen_variants(self, tag_name, default_variant, variants):
+        ret =3D {'tag': tag_name,
+               'variants': [self._gen_variant(v) for v in variants]}
+        if default_variant:
+            ret['default-variant'] =3D default_variant
+        return ret
=20
     def _gen_variant(self, variant):
         return ({'case': variant.name, 'type': self._use_type(variant.ty=
pe)},
@@ -192,6 +195,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
+                                          variants.default_tag_value,
                                           variants.variants))
         self._gen_qlit(name, 'object', obj, ifcond)
=20
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 82eab72b21..57eccdfdc2 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -77,6 +77,19 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_nam=
e)s *obj, Error **errp)
         ret +=3D gen_endif(memb.ifcond)
=20
     if variants:
+        if variants.default_tag_value is not None:
+            ret +=3D mcgen('''
+    if (!obj->has_%(c_name)s) {
+        obj->has_%(c_name)s =3D true;
+        obj->%(c_name)s =3D %(enum_const)s;
+    }
+''',
+                         c_name=3Dc_name(variants.tag_member.name),
+                         enum_const=3Dc_enum_const(
+                             variants.tag_member.type.name,
+                             variants.default_tag_value,
+                             variants.tag_member.type.prefix))
+
         ret +=3D mcgen('''
     switch (obj->%(c_name)s) {
 ''',
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index d592854601..be223e2cc4 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -66,6 +66,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def _print_variants(variants):
         if variants:
             print('    tag %s' % variants.tag_member.name)
+            if variants.default_tag_value:
+                print('    default variant: %s' % variants.default_tag_v=
alue)
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
                 QAPISchemaTestVisitor._print_if(v.ifcond, indent=3D8)
--=20
2.20.1
