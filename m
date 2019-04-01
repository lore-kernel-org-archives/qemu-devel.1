Received: from eggs.gnu.org ([209.51.188.92]:45623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAxcQ-0001dK-5K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hAxcO-0004Ze-Ly
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:08:58 -0400
Date: Mon, 1 Apr 2019 16:08:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190401140842.GD4935@localhost.localdomain>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<20190401115410.GB4935@localhost.localdomain>
	<87k1gdyinr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1gdyinr.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org

Am 01.04.2019 um 15:11 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Option 4:
> >
> > Add a dummy option to BlockdevOptionsFile:
> >
> >     '*x-auto-read-only-is-dynamic': { 'type': 'null',
> >                                       'if': 'defined(CONFIG_POSIX)' }
> >
> > Specifying it has no effect, so the ridiculous complexity of three bools
> > to select from three options is avoided. Its presence in the schema
> > indicates that file-posix implements dynamic auto-read-only.
> >
> > Basically this is features flags in the schema without having proper
> > feature flags yet.
> >
> > Once we add real annotations (hopefully 4.1), this dummy field can be
> > removed again.
> 
> Exact same patch as for option 3, with the parameter renamed and the
> sanity check for non-sensical use dropped.  *Shrug*
> 
> Puts more pressure on me to deliver QAPI feature flags sooner rather
> than later.  My QAPI pressure control valve has been shedding pressure
> for a while, so "bring it on".  I'd advise against holding your breath,
> though.

Okay, let's stop beating around the bush.

Nobody has told me so explicitly during this discussion, but implicitly
I understand that everyone seems to think doing annotations in the
schema is what we really want to have.

Instead of continuing to argue which option to get around it is the
least ugly one - how bad is the following attempt at just implementing
what we really want?

Only for structs for now, but that's all we need at the moment. Should
be easy to extend during the 4.1 cycle (or whenever we need something
else).

Note that even if there are bugs in it, they are not user-visible and
can just be fixed in 4.1. Currently, a diff between old and new
query-qmp-schema output looks sane - just the added 'features' list
where we want it.

Kevin



diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..d74bf4a88a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2852,7 +2852,8 @@
             '*aio': 'BlockdevAioOptions',
 	    '*drop-cache': {'type': 'bool',
 	                    'if': 'defined(CONFIG_LINUX)'},
-            '*x-check-cache-dropped': 'bool' } }
+            '*x-check-cache-dropped': 'bool' },
+  'features': [ 'dynamic-auto-read-only' ] }
 
 ##
 # @BlockdevOptionsNull:
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f07869ec73..668ebb654a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -886,12 +886,22 @@ def check_enum(expr, info):
 def check_struct(expr, info):
     name = expr['struct']
     members = expr['data']
+    features = expr.get('features')
 
     check_type(info, "'data' for struct '%s'" % name, members,
                allow_dict=True, allow_optional=True)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=['struct'])
 
+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info,
+                               "Struct '%s' requires an array for 'features'" %
+                               name)
+        for s in features:
+            if not isinstance(s, str):
+                raise QAPISemError(info, "'features' for struct '%s' must "
+                                         "contain strings" % name)
 
 def check_known_keys(info, source, keys, required, optional):
 
@@ -986,7 +996,7 @@ def check_exprs(exprs):
             normalize_members(expr['data'])
         elif 'struct' in expr:
             meta = 'struct'
-            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
+            check_keys(expr_elem, 'struct', ['data'], ['base', 'if', 'features'])
             normalize_members(expr['data'])
             struct_types[expr[meta]] = expr
         elif 'command' in expr:
@@ -1129,7 +1139,8 @@ class QAPISchemaVisitor(object):
     def visit_object_type(self, name, info, ifcond, base, members, variants):
         pass
 
-    def visit_object_type_flat(self, name, info, ifcond, members, variants):
+    def visit_object_type_flat(self, name, info, ifcond, members, variants,
+                               features):
         pass
 
     def visit_alternate_type(self, name, info, ifcond, variants):
@@ -1290,7 +1301,7 @@ class QAPISchemaArrayType(QAPISchemaType):
 
 class QAPISchemaObjectType(QAPISchemaType):
     def __init__(self, name, info, doc, ifcond,
-                 base, local_members, variants):
+                 base, local_members, variants, features):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -1307,6 +1318,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.local_members = local_members
         self.variants = variants
         self.members = None
+        self.features = features
 
     def check(self, schema):
         QAPISchemaType.check(self, schema)
@@ -1370,7 +1382,8 @@ class QAPISchemaObjectType(QAPISchemaType):
         visitor.visit_object_type(self.name, self.info, self.ifcond,
                                   self.base, self.local_members, self.variants)
         visitor.visit_object_type_flat(self.name, self.info, self.ifcond,
-                                       self.members, self.variants)
+                                       self.members, self.variants,
+                                       self.features)
 
 
 class QAPISchemaMember(object):
@@ -1675,7 +1688,7 @@ class QAPISchema(object):
                   ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
-            'q_empty', None, None, None, None, [], None)
+            'q_empty', None, None, None, None, [], None, [])
         self._def_entity(self.the_empty_object_type)
 
         qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
@@ -1721,7 +1734,7 @@ class QAPISchema(object):
             assert ifcond == typ._ifcond # pylint: disable=protected-access
         else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond,
-                                                  None, members, None))
+                                                  None, members, None, []))
         return name
 
     def _def_enum_type(self, expr, info, doc):
@@ -1752,9 +1765,10 @@ class QAPISchema(object):
         base = expr.get('base')
         data = expr['data']
         ifcond = expr.get('if')
+        features = expr.get('features')
         self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, base,
                                               self._make_members(data, info),
-                                              None))
+                                              None, features))
 
     def _make_variant(self, case, typ, ifcond):
         return QAPISchemaObjectTypeVariant(case, typ, ifcond)
@@ -1795,7 +1809,7 @@ class QAPISchema(object):
             QAPISchemaObjectType(name, info, doc, ifcond, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member,
-                                                              variants)))
+                                                              variants), []))
 
     def _def_alternate_type(self, expr, info, doc):
         name = expr['alternate']
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f7f2ca07e4..f93a31aaa8 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -188,11 +188,15 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_qlit('[' + element + ']', 'array', {'element-type': element},
                        ifcond)
 
-    def visit_object_type_flat(self, name, info, ifcond, members, variants):
+    def visit_object_type_flat(self, name, info, ifcond, members, variants,
+                               features):
         obj = {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
+        if features:
+            obj['features'] = features
+
         self._gen_qlit(name, 'object', obj, ifcond)
 
     def visit_alternate_type(self, name, info, ifcond, variants):
