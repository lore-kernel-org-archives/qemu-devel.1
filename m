Received: from eggs.gnu.org ([209.51.188.92]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlr-0004wz-9B
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRln-00028Z-FO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRll-0001oY-DP
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF7FCC062C6A
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:11 +0100
Message-Id: <20190206181725.14337-4-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/17] qapi: Clean up modular built-in code
 generation a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

We neglect to call .visit_module() for the special module we use for
built-ins.  Harmless, but clean it up anyway.  The
tests/qapi-schema/*.out now show the built-in module as 'module None'.

Subclasses of QAPISchemaModularCVisitor need to ._add_module() this
special module to enable code generation for built-ins.  When this
hasn't been done, QAPISchemaModularCVisitor.visit_module() does
nothing for the special module.  That looks like built-ins could
accidentally be generated into the wrong module when a subclass
neglects to call ._add_module().  Can't happen, because built-ins are
all visited before any other module.  But that's non-obvious.  Switch
off code generation explicitly.

Split QAPISchemaModularCVisitor._add_module() into ._add_user_module()
and ._add_system_module(), for clarity.

Rename QAPISchemaModularCVisitor._begin_module() to
._begin_user_module().

New QAPISchemaModularCVisitor._is_builtin_module(), for clarity.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py                 |  2 +-
 scripts/qapi/common.py                   | 24 ++++++++++++++++++------
 scripts/qapi/events.py                   |  2 +-
 scripts/qapi/types.py                    |  2 +-
 scripts/qapi/visit.py                    |  2 +-
 tests/qapi-schema/comments.out           |  1 +
 tests/qapi-schema/doc-bad-section.out    |  1 +
 tests/qapi-schema/doc-good.out           |  1 +
 tests/qapi-schema/empty.out              |  1 +
 tests/qapi-schema/event-case.out         |  1 +
 tests/qapi-schema/ident-with-escape.out  |  1 +
 tests/qapi-schema/include-relpath.out    |  1 +
 tests/qapi-schema/include-repetition.out |  1 +
 tests/qapi-schema/include-simple.out     |  1 +
 tests/qapi-schema/indented-expr.out      |  1 +
 tests/qapi-schema/qapi-schema-test.out   |  1 +
 16 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 0f3c991918..ebf488953d 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -242,7 +242,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
         self._regy = QAPIGenCCode()
         self._visited_ret_types = {}
 
-    def _begin_module(self, name):
+    def _begin_user_module(self, name):
         self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
         types = self._module_basename('qapi-types', name)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c89edc0cb0..0e3ec598a4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1868,6 +1868,7 @@ class QAPISchema(object):
     def visit(self, visitor):
         visitor.visit_begin(self)
         module = None
+        visitor.visit_module(module)
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
                 if entity.module != module:
@@ -2321,9 +2322,15 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         self._what = what
         self._blurb = blurb
         self._pydoc = pydoc
+        self._genc = None
+        self._genh = None
         self._module = {}
         self._main_module = None
 
+    @staticmethod
+    def _is_builtin_module(name):
+        return not name
+
     def _module_basename(self, what, name):
         if name is None:
             return re.sub(r'-', '-builtin-', what)
@@ -2334,7 +2341,7 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         return basename + '-' + os.path.splitext(os.path.basename(name))[0]
 
     def _add_module(self, name, blurb):
-        if self._main_module is None and name is not None:
+        if self._main_module is None and not self._is_builtin_module(name):
             self._main_module = name
         genc = QAPIGenC(blurb, self._pydoc)
         genh = QAPIGenH(blurb, self._pydoc)
@@ -2346,22 +2353,27 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
 
     def write(self, output_dir, opt_builtins=False):
         for name in self._module:
-            if name is None and not opt_builtins:
+            if self._is_builtin_module(name) and not opt_builtins:
                 continue
             basename = self._module_basename(self._what, name)
             (genc, genh) = self._module[name]
             genc.write(output_dir, basename + '.c')
             genh.write(output_dir, basename + '.h')
 
-    def _begin_module(self, name):
+    def _begin_user_module(self, name):
         pass
 
     def visit_module(self, name):
         if name in self._module:
             self._set_module(name)
-            return
-        self._add_module(name, self._blurb)
-        self._begin_module(name)
+        elif self._is_builtin_module(name):
+            # The built-in module has not been created.  No code may
+            # be generated.
+            self._genc = None
+            self._genh = None
+        else:
+            self._add_module(name, self._blurb)
+            self._begin_user_module(name)
 
     def visit_include(self, name, info):
         basename = self._module_basename(self._what, name)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d86a2d2b3e..6f39cf8196 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -142,7 +142,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
         self._event_enum_members = []
         self._event_emit_name = c_name(prefix + 'qapi_event_emit')
 
-    def _begin_module(self, name):
+    def _begin_user_module(self, name):
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 62d4cf9f95..9fa510f7df 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -194,7 +194,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
 #include "qapi/util.h"
 '''))
 
-    def _begin_module(self, name):
+    def _begin_user_module(self, name):
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 82eab72b21..ca86009398 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -298,7 +298,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 ''',
                                       prefix=prefix))
 
-    def _begin_module(self, name):
+    def _begin_user_module(self, name):
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.out
index d1abc4b5a1..273f0f54e1 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
index db8014eed0..367e2a1c3e 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 21bf345ff0..d3bca343eb 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 5483cb7bc6..5b53d00702 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-case.out
index f69d4ffe4e..ec8a1406e4 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index 7f891f7e90..39754eba8c 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/include-relpath.out
index 783ccfc855..cf8636b78f 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema/include-repetition.out
index d45977ee56..5423983239 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/include-simple.out
index 1afe20802a..061f81e509 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index c0cf3243f3..bffdf6756d 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 9464101d26..d8aec17115 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,3 +1,4 @@
+module None
 object q_empty
 enum QType
     prefix QTYPE
-- 
2.17.2
