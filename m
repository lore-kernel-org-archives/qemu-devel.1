Received: from eggs.gnu.org ([209.51.188.92]:50913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNE-0004vs-JU
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHP-0005ng-LR
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHP-0005lO-Bh
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:48 +0100
Message-Id: <20190301154051.23317-5-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] qapi: Fix code generation for sub-modules
 in other directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

The #include directives to pull in sub-modules use file names relative
to the main module.  Works only when all modules are in the same
directory, or the main module's output directory is in the compiler's
include path.  Use relative file names instead.

The dummy variable we generate to avoid empty .o files has an invalid
name for sub-modules in other directories.  Fix that.

Both messed up in commit 252dc3105fc "qapi: Generate separate .h, .c
for each module".  Escaped testing because tests/qapi-schema-test.json
doesn't cover sub-modules in other directories, only
tests/qapi-schema/include-relpath.json does, and we generate and
compile C code only for the former, not the latter.  Fold the latter
into the former.  This would have caught the mistakes fixed in this
commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                     | 33 ++++++++++------
 tests/.gitignore                           |  8 ++++
 tests/Makefile.include                     | 44 +++++++++++++++++++---
 tests/qapi-schema/include-relpath-sub.json |  2 -
 tests/qapi-schema/include-relpath.err      |  0
 tests/qapi-schema/include-relpath.exit     |  1 -
 tests/qapi-schema/include-relpath.json     |  1 -
 tests/qapi-schema/include-relpath.out      | 20 ----------
 tests/qapi-schema/include/relpath.json     |  1 -
 tests/qapi-schema/include/sub-module.json  |  5 +++
 tests/qapi-schema/qapi-schema-test.json    |  3 ++
 tests/qapi-schema/qapi-schema-test.out     |  9 +++++
 tests/qapi-schema/sub-sub-module.json      |  6 +++
 13 files changed, 91 insertions(+), 42 deletions(-)
 delete mode 100644 tests/qapi-schema/include-relpath-sub.json
 delete mode 100644 tests/qapi-schema/include-relpath.err
 delete mode 100644 tests/qapi-schema/include-relpath.exit
 delete mode 100644 tests/qapi-schema/include-relpath.json
 delete mode 100644 tests/qapi-schema/include-relpath.out
 delete mode 100644 tests/qapi-schema/include/relpath.json
 create mode 100644 tests/qapi-schema/include/sub-module.json
 create mode 100644 tests/qapi-schema/sub-sub-module.json

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8512cac427..f51948364c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2017,8 +2017,8 @@ def mcgen(code, **kwds):
     return cgen(code, **kwds)
 
 
-def guardname(filename):
-    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()
+def c_fname(filename):
+    return re.sub(r'[^A-Za-z0-9_]', '_', filename)
 
 
 def guardstart(name):
@@ -2027,7 +2027,7 @@ def guardstart(name):
 #define %(name)s
 
 ''',
-                 name=guardname(name))
+                 name=c_fname(name).upper())
 
 
 def guardend(name):
@@ -2035,7 +2035,7 @@ def guardend(name):
 
 #endif /* %(name)s */
 ''',
-                 name=guardname(name))
+                 name=c_fname(name).upper())
 
 
 def gen_if(ifcond):
@@ -2281,9 +2281,9 @@ class QAPIGenC(QAPIGenCCode):
         return mcgen('''
 
 /* Dummy declaration to prevent empty .o file */
-char dummy_%(name)s;
+char qapi_dummy_%(name)s;
 ''',
-                     name=c_name(self.fname))
+                     name=c_fname(self.fname))
 
 
 class QAPIGenH(QAPIGenC):
@@ -2337,21 +2337,29 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
     def _is_builtin_module(name):
         return not name
 
+    def _module_dirname(self, what, name):
+        if self._is_user_module(name):
+            return os.path.dirname(name)
+        return ''
+
     def _module_basename(self, what, name):
         ret = '' if self._is_builtin_module(name) else self._prefix
         if self._is_user_module(name):
-            dirname, basename = os.path.split(name)
+            basename = os.path.basename(name)
             ret += what
             if name != self._main_module:
                 ret += '-' + os.path.splitext(basename)[0]
-            ret = os.path.join(dirname, ret)
         else:
             name = name[2:] if name else 'builtin'
             ret += re.sub(r'-', '-' + name + '-', what)
         return ret
 
+    def _module_filename(self, what, name):
+        return os.path.join(self._module_dirname(what, name),
+                            self._module_basename(what, name))
+
     def _add_module(self, name, blurb):
-        basename = self._module_basename(self._what, name)
+        basename = self._module_filename(self._what, name)
         genc = QAPIGenC(basename + '.c', blurb, self._pydoc)
         genh = QAPIGenH(basename + '.h', blurb, self._pydoc)
         self._module[name] = (genc, genh)
@@ -2393,8 +2401,9 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
             self._begin_user_module(name)
 
     def visit_include(self, name, info):
-        basename = self._module_basename(self._what, name)
+        relname = os.path.relpath(self._module_filename(self._what, name),
+                                  os.path.dirname(self._genh.fname))
         self._genh.preamble_add(mcgen('''
-#include "%(basename)s.h"
+#include "%(relname)s.h"
 ''',
-                                      basename=basename))
+                                      relname=relname))
diff --git a/tests/.gitignore b/tests/.gitignore
index 72c18aaab0..b7b61ffb38 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -11,9 +11,17 @@ test-*
 !test-*.c
 !docker/test-*
 test-qapi-commands.[ch]
+include/test-qapi-commands-sub-module.[ch]
+test-qapi-commands-sub-sub-module.[ch]
 test-qapi-events.[ch]
+include/test-qapi-events-sub-module.[ch]
+test-qapi-events-sub-sub-module.[ch]
 test-qapi-types.[ch]
+include/test-qapi-types-sub-module.[ch]
+test-qapi-types-sub-sub-module.[ch]
 test-qapi-visit.[ch]
+include/test-qapi-visit-sub-module.[ch]
+test-qapi-visit-sub-sub-module.[ch]
 test-qapi-introspect.[ch]
 *-test
 qapi-schema/*.test.*
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e60488da7d..c964ebc51a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -438,7 +438,6 @@ qapi-schema += include-format-err.json
 qapi-schema += include-nested-err.json
 qapi-schema += include-no-file.json
 qapi-schema += include-non-file.json
-qapi-schema += include-relpath.json
 qapi-schema += include-repetition.json
 qapi-schema += include-self-cycle.json
 qapi-schema += include-simple.json
@@ -505,8 +504,18 @@ qapi-schema += unknown-expr-key.json
 
 check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
 
-GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
-	tests/test-qapi-commands.h tests/test-qapi-events.h \
+GENERATED_FILES += tests/test-qapi-types.h \
+	tests/include/test-qapi-types-sub-module.h \
+	tests/test-qapi-types-sub-sub-module.h \
+	tests/test-qapi-visit.h \
+	tests/include/test-qapi-visit-sub-module.h \
+	tests/test-qapi-visit-sub-sub-module.h \
+	tests/test-qapi-commands.h \
+	tests/include/test-qapi-commands-sub-module.h \
+	tests/test-qapi-commands-sub-sub-module.h \
+	tests/test-qapi-events.h \
+	tests/include/test-qapi-events-sub-module.h \
+	tests/test-qapi-events-sub-sub-module.h \
 	tests/test-qapi-introspect.h
 
 test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
@@ -534,7 +543,12 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 # Deps that are common to various different sets of tests below
 test-util-obj-y = libqemuutil.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
-test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
+test-qapi-obj-y = tests/test-qapi-types.o \
+	tests/include/test-qapi-types-sub-module.o \
+	tests/test-qapi-types-sub-sub-module.o \
+	tests/test-qapi-visit.o \
+	tests/include/test-qapi-visit-sub-module.o \
+	tests/test-qapi-visit-sub-sub-module.o \
 	tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
 benchmark-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
@@ -609,12 +623,32 @@ tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
 	$(test-block-obj-y)
 
 tests/test-qapi-types.c tests/test-qapi-types.h \
+tests/include/test-qapi-types-sub-module.c \
+tests/include/test-qapi-types-sub-module.h \
+tests/test-qapi-types-sub-sub-module.c \
+tests/test-qapi-types-sub-sub-module.h \
 tests/test-qapi-visit.c tests/test-qapi-visit.h \
+tests/include/test-qapi-visit-sub-module.c \
+tests/include/test-qapi-visit-sub-module.h \
+tests/test-qapi-visit-sub-sub-module.c \
+tests/test-qapi-visit-sub-sub-module.h \
 tests/test-qapi-commands.h tests/test-qapi-commands.c \
+tests/include/test-qapi-commands-sub-module.h \
+tests/include/test-qapi-commands-sub-module.c \
+tests/test-qapi-commands-sub-sub-module.h \
+tests/test-qapi-commands-sub-sub-module.c \
 tests/test-qapi-events.c tests/test-qapi-events.h \
+tests/include/test-qapi-events-sub-module.c \
+tests/include/test-qapi-events-sub-module.h \
+tests/test-qapi-events-sub-sub-module.c \
+tests/test-qapi-events-sub-sub-module.h \
 tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
-tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(qapi-py)
+tests/test-qapi-gen-timestamp: \
+		$(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json \
+		$(SRC_PATH)/tests/qapi-schema/include/sub-module.json \
+		$(SRC_PATH)/tests/qapi-schema/sub-sub-module.json \
+		$(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=%)")
diff --git a/tests/qapi-schema/include-relpath-sub.json b/tests/qapi-schema/include-relpath-sub.json
deleted file mode 100644
index 4bd4af4162..0000000000
--- a/tests/qapi-schema/include-relpath-sub.json
+++ /dev/null
@@ -1,2 +0,0 @@
-{ 'enum': 'Status',
-  'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/include-relpath.err b/tests/qapi-schema/include-relpath.err
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/include-relpath.exit b/tests/qapi-schema/include-relpath.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/include-relpath.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/include-relpath.json b/tests/qapi-schema/include-relpath.json
deleted file mode 100644
index 05018f3908..0000000000
--- a/tests/qapi-schema/include-relpath.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': 'include/relpath.json' }
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/include-relpath.out
deleted file mode 100644
index cf8636b78f..0000000000
--- a/tests/qapi-schema/include-relpath.out
+++ /dev/null
@@ -1,20 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module include-relpath.json
-include include/relpath.json
-module include/relpath.json
-include include-relpath-sub.json
-module include-relpath-sub.json
-enum Status
-    member good
-    member bad
-    member ugly
diff --git a/tests/qapi-schema/include/relpath.json b/tests/qapi-schema/include/relpath.json
deleted file mode 100644
index 45dee24704..0000000000
--- a/tests/qapi-schema/include/relpath.json
+++ /dev/null
@@ -1 +0,0 @@
-{ 'include': '../include-relpath-sub.json' }
diff --git a/tests/qapi-schema/include/sub-module.json b/tests/qapi-schema/include/sub-module.json
new file mode 100644
index 0000000000..f2bdbd3990
--- /dev/null
+++ b/tests/qapi-schema/include/sub-module.json
@@ -0,0 +1,5 @@
+# *-*- Mode: Python -*-*
+
+# Sub-module of ../qapi-schema-test.json
+
+{ 'include': '../sub-sub-module.json' }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 70612f394e..1f130a0491 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -130,6 +130,9 @@
             'sizes': ['size'],
             'any': ['any'] } }
 
+# for testing sub-modules
+{ 'include': 'include/sub-module.json' }
+
 # testing commands
 { 'command': 'user_def_cmd', 'data': {} }
 { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 97f671ca5f..baba4c8384 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -176,6 +176,15 @@ object UserDefNativeListUnion
     case string: q_obj_strList-wrapper
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
+include include/sub-module.json
+module include/sub-module.json
+include sub-sub-module.json
+module sub-sub-module.json
+enum Status
+    member good
+    member bad
+    member ugly
+module qapi-schema-test.json
 command user_def_cmd None -> None
    gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_user_def_cmd1-arg
diff --git a/tests/qapi-schema/sub-sub-module.json b/tests/qapi-schema/sub-sub-module.json
new file mode 100644
index 0000000000..524ef9b83f
--- /dev/null
+++ b/tests/qapi-schema/sub-sub-module.json
@@ -0,0 +1,6 @@
+# *-*- Mode: Python -*-*
+
+# Sub-module of sub-module include/sub-module.json of qapi-schema-test.json
+
+{ 'enum': 'Status',
+  'data': [ 'good', 'bad', 'ugly' ] }
-- 
2.17.2
