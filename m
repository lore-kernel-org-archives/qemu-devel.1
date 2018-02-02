Received: from eggs.gnu.org ([208.118.235.92]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMe-0002kG-Go
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLV-0004dv-ML
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdLV-0004cC-02
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:34 +0100
Message-Id: <20180202130336.24719-20-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 19/21] qapi/types: Generate separate .h,
 .c for each module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Our qapi-schema.json is composed of modules connected by include
directives, but the generated code is monolithic all the same: one
qapi-types.h with all the types, one qapi-visit.h with all the
visitors, and so forth.  These monolithic headers get included all
over the place.  In my "build everything" tree, adding a QAPI type
recompiles about 4500 out of 4800 objects.

Nobody would write such monolithic headers by hand.  It stands to
reason that one shouldn't generate them, either.

Split up generated qapi-types.h to mirror the schema's modular
structure: one header per module.  Name the main module's header
qapi-types.h, and sub-module D/B.json's header D/qapi-types-B.h.

Mirror the schema's includes in the headers, so that qapi-types.h gets
you everything exactly as before.  If you need less, you can include
one or more of the sub-module headers.  To be exploited shortly.

Split up qapi-types.c similarly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile              | 30 ++++++++++++++++++++++++++++++
 Makefile.objs         | 18 +++++++++++++++++-
 scripts/qapi/types.py | 18 ++++++++++++++++--
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f9b7900330..f1b68dca9b 100644
--- a/Makefile
+++ b/Makefile
@@ -91,6 +91,21 @@ GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
 GENERATED_FILES += qmp-commands.h qmp-marshal.c
 GENERATED_FILES += qapi-builtin-types.h qapi-builtin-types.c
 GENERATED_FILES += qapi-types.h qapi-types.c
+GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
+GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
+GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
+GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
+GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
+GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
+GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
+GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
+GENERATED_FILES += qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
+GENERATED_FILES += qapi/qapi-types-run-state.h qapi/qapi-types-run-state.c
+GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
+GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
+GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
+GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
+GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
 GENERATED_FILES += qapi-builtin-visit.h qapi-builtin-visit.c
 GENERATED_FILES += qapi-visit.h qapi-visit.c
 GENERATED_FILES += qapi-event.h qapi-event.c
@@ -519,6 +534,21 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
 
 qapi-builtin-types.c qapi-builtin-types.h \
 qapi-types.c qapi-types.h \
+qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
+qapi/qapi-types-block.c qapi/qapi-types-block.h \
+qapi/qapi-types-char.c qapi/qapi-types-char.h \
+qapi/qapi-types-common.c qapi/qapi-types-common.h \
+qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
+qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
+qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
+qapi/qapi-types-net.c qapi/qapi-types-net.h \
+qapi/qapi-types-rocker.c qapi/qapi-types-rocker.h \
+qapi/qapi-types-run-state.c qapi/qapi-types-run-state.h \
+qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
+qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
+qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
+qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
+qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
 qapi-builtin-visit.c qapi-builtin-visit.h \
 qapi-visit.c qapi-visit.h \
 qmp-commands.h qmp-marshal.c \
diff --git a/Makefile.objs b/Makefile.objs
index f16cca06e7..e7411a2658 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,7 +3,23 @@
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
 util-obj-y += qapi-builtin-types.o qapi-builtin-visit.o
-util-obj-y += qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y += qapi-types.o
+util-obj-y += qapi/qapi-types-block-core.o
+util-obj-y += qapi/qapi-types-block.o
+util-obj-y += qapi/qapi-types-char.o
+util-obj-y += qapi/qapi-types-common.o
+util-obj-y += qapi/qapi-types-crypto.o
+util-obj-y += qapi/qapi-types-introspect.o
+util-obj-y += qapi/qapi-types-migration.o
+util-obj-y += qapi/qapi-types-net.o
+util-obj-y += qapi/qapi-types-rocker.o
+util-obj-y += qapi/qapi-types-run-state.o
+util-obj-y += qapi/qapi-types-sockets.o
+util-obj-y += qapi/qapi-types-tpm.o
+util-obj-y += qapi/qapi-types-trace.o
+util-obj-y += qapi/qapi-types-transaction.o
+util-obj-y += qapi/qapi-types-ui.o
+util-obj-y += qmp-introspect.o qapi-visit.o qapi-event.o
 
 chardev-obj-y = chardev/
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index f84ed17960..7bd8e1a978 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -172,6 +172,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self._opt_builtins = opt_builtins
         self._prefix = prefix
         self._module = {}
+        self._main_module = None
         self._add_module(None, ' * Built-in QAPI types')
         self._genc.preamble(mcgen('''
 #include "qemu/osdep.h"
@@ -186,7 +187,11 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
     def _module_basename(self, name):
         if name is None:
             return 'qapi-builtin-types'
-        return self._prefix + 'qapi-types'
+        basename = os.path.join(os.path.dirname(name),
+                                self._prefix + 'qapi-types')
+        if name == self._main_module:
+            return basename
+        return basename + '-' + os.path.splitext(os.path.basename(name))[0]
 
     def _add_module(self, name, blurb):
         genc = QAPIGenC(blurb, __doc__)
@@ -211,7 +216,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         objects_seen.add(schema.the_empty_object_type.name)
 
     def visit_module(self, name):
-        if len(self._module) != 1:
+        if self._main_module is None:
+            self._main_module = name
+        if name in self._module:
+            self._set_module(name)
             return
         self._add_module(name, ' * Schema-defined QAPI types')
         self._genc.preamble(mcgen('''
@@ -225,6 +233,12 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 #include "qapi-builtin-types.h"
 '''))
 
+    def visit_include(self, name, info):
+        self._genh.preamble(mcgen('''
+#include "%(basename)s.h"
+''',
+                                  basename=self._module_basename(name)))
+
     def _gen_type_cleanup(self, name):
         self._genh.body(gen_type_cleanup_decl(name))
         self._genc.body(gen_type_cleanup(name))
-- 
2.13.6
