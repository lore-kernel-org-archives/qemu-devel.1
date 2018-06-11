Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnY-0001kh-0M
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnV-00082G-NU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:51:54 +0200
Message-Id: <20180611205203.2624-2-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/10] qapi: Add default-variant for flat
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This patch allows specifying a discriminator that is an optional member
of the base struct.  In such a case, a default value must be provided
that is used when no value is given.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/introspect.json           |  8 +++++
 scripts/qapi/common.py         | 57 ++++++++++++++++++++++++++++------
 scripts/qapi/doc.py            |  8 +++--
 scripts/qapi/introspect.py     | 10 ++++--
 scripts/qapi/visit.py          | 13 ++++++++
 tests/qapi-schema/test-qapi.py |  2 ++
 6 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 80a0a3e656..b43c87fe8d 100644
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
+#                   (Since: 3.0)
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
 
 ##
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index e82990f0f2..d15f56b260 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -721,6 +721,7 @@ def check_union(expr, info):
     name = expr['union']
     base = expr.get('base')
     discriminator = expr.get('discriminator')
+    default_variant = expr.get('default-variant')
     members = expr['data']
 
     # Two types of unions, determined by discriminator.
@@ -745,16 +746,37 @@ def check_union(expr, info):
         base_members = find_base_members(base)
         assert base_members is not None
 
-        # The value of member 'discriminator' must name a non-optional
-        # member of the base struct.
+        # The value of member 'discriminator' must name a member of
+        # the base struct.
         check_name(info, "Discriminator of flat union '%s'" % name,
                    discriminator)
-        discriminator_type = base_members.get(discriminator)
-        if not discriminator_type:
-            raise QAPISemError(info,
-                               "Discriminator '%s' is not a member of base "
-                               "struct '%s'"
-                               % (discriminator, base))
+        if default_variant is None:
+            discriminator_type = base_members.get(discriminator)
+            if not discriminator_type:
+                if base_members.get('*' + discriminator) is None:
+                    raise QAPISemError(info,
+                                       "Discriminator '%s' is not a member of "
+                                       "base struct '%s'"
+                                       % (discriminator, base))
+                else:
+                    raise QAPISemError(info,
+                                       "Default variant must be specified for "
+                                       "optional discriminator '%s'"
+                                       % discriminator)
+        else:
+            discriminator_type = base_members.get('*' + discriminator)
+            if not discriminator_type:
+                if base_members.get(discriminator) is None:
+                    raise QAPISemError(info,
+                                       "Discriminator '%s' is not a member of "
+                                       "base struct '%s'"
+                                       % (discriminator, base))
+                else:
+                    raise QAPISemError(info,
+                                       "Must not specify a default variant for "
+                                       "non-optional discriminator '%s'"
+                                       % discriminator)
+
         enum_define = enum_types.get(discriminator_type)
         allow_metas = ['struct']
         # Do not allow string discriminator
@@ -763,6 +785,15 @@ def check_union(expr, info):
                                "Discriminator '%s' must be of enumeration "
                                "type" % discriminator)
 
+        if default_variant is not None:
+            # Must be a value of the enumeration
+            if default_variant not in enum_define['data']:
+                raise QAPISemError(info,
+                                   "Default variant '%s' of flat union '%s' is "
+                                   "not part of '%s'"
+                                   % (default_variant, name,
+                                      discriminator_type))
+
     # Check every branch; don't allow an empty union
     if len(members) == 0:
         raise QAPISemError(info, "Union '%s' cannot have empty 'data'" % name)
@@ -910,7 +941,7 @@ def check_exprs(exprs):
         elif 'union' in expr:
             meta = 'union'
             check_keys(expr_elem, 'union', ['data'],
-                       ['base', 'discriminator'])
+                       ['base', 'discriminator', 'default-variant'])
             union_types[expr[meta]] = expr
         elif 'alternate' in expr:
             meta = 'alternate'
@@ -1336,12 +1367,14 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
 
 
 class QAPISchemaObjectTypeVariants(object):
-    def __init__(self, tag_name, tag_member, variants):
+    def __init__(self, tag_name, tag_member, default_tag_value, variants):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set, and tag_name remains
         # a reliable witness of being used by a flat union.
         assert bool(tag_member) != bool(tag_name)
+        # default_tag_value is only passed for flat unions.
+        assert bool(tag_name) or not bool(default_tag_value)
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
         assert len(variants) > 0
@@ -1349,6 +1382,7 @@ class QAPISchemaObjectTypeVariants(object):
             assert isinstance(v, QAPISchemaObjectTypeVariant)
         self._tag_name = tag_name
         self.tag_member = tag_member
+        self.default_tag_value = default_tag_value
         self.variants = variants
 
     def set_owner(self, name):
@@ -1640,6 +1674,7 @@ class QAPISchema(object):
         data = expr['data']
         base = expr.get('base')
         tag_name = expr.get('discriminator')
+        default_tag_value = expr.get('default-variant')
         tag_member = None
         if isinstance(base, dict):
             base = (self._make_implicit_object_type(
@@ -1659,6 +1694,7 @@ class QAPISchema(object):
             QAPISchemaObjectType(name, info, doc, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member,
+                                                              default_tag_value,
                                                               variants)))
 
     def _def_alternate_type(self, expr, info, doc):
@@ -1671,6 +1707,7 @@ class QAPISchema(object):
             QAPISchemaAlternateType(name, info, doc,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_member,
+                                                                 None,
                                                                  variants)))
 
     def _def_command(self, expr, info, doc):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index b5630844f9..7dd14173e5 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -160,8 +160,12 @@ def texi_members(doc, what, base, variants, member_func):
         items += '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
         for v in variants.variants:
-            when = ' when @code{%s} is @t{"%s"}' % (
-                variants.tag_member.name, v.name)
+            if v.name == variants.default_tag_value:
+                when = ' when @code{%s} is @t{"%s"} or not given' % (
+                    variants.tag_member.name, v.name)
+            else:
+                when = ' when @code{%s} is @t{"%s"}' % (
+                    variants.tag_member.name, v.name)
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 5b6c72c7b2..0133f91792 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -142,9 +142,12 @@ const QLitObject %(c_name)s = %(c_string)s;
             ret['default'] = None
         return ret
 
-    def _gen_variants(self, tag_name, variants):
-        return {'tag': tag_name,
-                'variants': [self._gen_variant(v) for v in variants]}
+    def _gen_variants(self, tag_name, default_variant, variants):
+        ret = {'tag': tag_name,
+               'variants': [self._gen_variant(v) for v in variants]}
+        if default_variant:
+            ret['default-variant'] = default_variant
+        return ret
 
     def _gen_variant(self, variant):
         return {'case': variant.name, 'type': self._use_type(variant.type)}
@@ -163,6 +166,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         obj = {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
+                                          variants.default_tag_value,
                                           variants.variants))
         self._gen_qlit(name, 'object', obj)
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d8936c..4c432f3ead 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -75,6 +75,19 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 ''')
 
     if variants:
+        if variants.default_tag_value is not None:
+            ret += mcgen('''
+    if (!obj->has_%(c_name)s) {
+        obj->has_%(c_name)s = true;
+        obj->%(c_name)s = %(enum_const)s;
+    }
+''',
+                         c_name=c_name(variants.tag_member.name),
+                         enum_const=c_enum_const(
+                             variants.tag_member.type.name,
+                             variants.default_tag_value,
+                             variants.tag_member.type.prefix))
+
         ret += mcgen('''
     switch (obj->%(c_name)s) {
 ''',
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 4512a41504..3609e98348 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -56,6 +56,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def _print_variants(variants):
         if variants:
             print('    tag %s' % variants.tag_member.name)
+            if variants.default_tag_value:
+                print('    default variant: %s' % variants.default_tag_value)
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
 
-- 
2.17.1
