Received: from eggs.gnu.org ([2001:4830:134:3::10]:57426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZXI-0007y3-NP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZXF-0003BF-SO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:31:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erZXF-0003AR-Ka
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:30:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 406FA84222
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 01:30:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 19:30:00 -0600
Message-Id: <20180302013007.11827-24-eblake@redhat.com>
In-Reply-To: <20180302013007.11827-1-eblake@redhat.com>
References: <20180302013007.11827-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/30] qapi: Generate separate .h,
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
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Our qapi-schema.json is composed of modules connected by include
directives, but the generated code is monolithic all the same: one
qapi-types.h with all the types, one qapi-visit.h with all the
visitors, and so forth.  These monolithic headers get included all
over the place.  In my "build everything" tree, adding a QAPI type
recompiles about 4800 out of 5100 objects.

We wouldn't write such monolithic headers by hand.  It stands to
reason that we shouldn't generate them, either.

Split up generated qapi-types.h to mirror the schema's modular
structure: one header per module.  Name the main module's header
qapi-types.h, and sub-module D/B.json's header D/qapi-types-B.h.

Mirror the schema's includes in the headers, so that qapi-types.h gets
you everything exactly as before.  If you need less, you can include
one or more of the sub-module headers.  To be exploited shortly.

Split up qapi-types.c, qapi-visit.h, qapi-visit.c, qmp-commands.h,
qmp-commands.c, qapi-event.h, qapi-event.c the same way.
qmp-introspect.h, qmp-introspect.c and qapi.texi remain monolithic.

The split of qmp-commands.c duplicates static helper function
qmp_marshal_output_str() in qapi-commands-char.c and
qapi-commands-misc.c.  This happens when commands returning the same
type occur in multiple modules.  Not worth avoiding.

Since I'm going to rename qapi-event.[ch] to qapi-events.[ch], and
qmp-commands.[ch] to qapi-commands.[ch], name the shards that way
already, to reduce churn.  This requires temporary hacks in
commands.py and events.py.  They'll go away with the rename.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-23-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Makefile                 | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 Makefile.objs            |  65 ++++++++++++++++++++++++-
 scripts/qapi/commands.py |  35 +++++++++-----
 scripts/qapi/common.py   |  21 +++++++--
 scripts/qapi/events.py   |  19 ++++++--
 .gitignore               |  60 ++++++++++++++++++++++++
 6 files changed, 300 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index 494ae382794..b12fcd5d8ff 100644
--- a/Makefile
+++ b/Makefile
@@ -92,10 +92,70 @@ include $(SRC_PATH)/rules.mak
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
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
+GENERATED_FILES += qapi/qapi-visit-block-core.h qapi/qapi-visit-block-core.c
+GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
+GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
+GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
+GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
+GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
+GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
+GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
+GENERATED_FILES += qapi/qapi-visit-rocker.h qapi/qapi-visit-rocker.c
+GENERATED_FILES += qapi/qapi-visit-run-state.h qapi/qapi-visit-run-state.c
+GENERATED_FILES += qapi/qapi-visit-sockets.h qapi/qapi-visit-sockets.c
+GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
+GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
+GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
+GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
 GENERATED_FILES += qmp-commands.h qmp-commands.c
+GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
+GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
+GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
+GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
+GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
+GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
+GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
+GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
+GENERATED_FILES += qapi/qapi-commands-rocker.h qapi/qapi-commands-rocker.c
+GENERATED_FILES += qapi/qapi-commands-run-state.h qapi/qapi-commands-run-state.c
+GENERATED_FILES += qapi/qapi-commands-sockets.h qapi/qapi-commands-sockets.c
+GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
+GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
+GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
+GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
 GENERATED_FILES += qapi-event.h qapi-event.c
+GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
+GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
+GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
+GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
+GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
+GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
+GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
+GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
+GENERATED_FILES += qapi/qapi-events-rocker.h qapi/qapi-events-rocker.c
+GENERATED_FILES += qapi/qapi-events-run-state.h qapi/qapi-events-run-state.c
+GENERATED_FILES += qapi/qapi-events-sockets.h qapi/qapi-events-sockets.c
+GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
+GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
+GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
+GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
 GENERATED_FILES += qmp-introspect.c qmp-introspect.h
 GENERATED_FILES += qapi-doc.texi

@@ -524,10 +584,70 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \

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
+qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
+qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
+qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
+qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
+qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
+qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
+qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
+qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
+qapi/qapi-visit-rocker.c qapi/qapi-visit-rocker.h \
+qapi/qapi-visit-run-state.c qapi/qapi-visit-run-state.h \
+qapi/qapi-visit-sockets.c qapi/qapi-visit-sockets.h \
+qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
+qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
+qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
+qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
 qmp-commands.h qmp-commands.c \
+qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
+qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
+qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
+qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
+qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
+qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
+qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
+qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
+qapi/qapi-commands-rocker.c qapi/qapi-commands-rocker.h \
+qapi/qapi-commands-run-state.c qapi/qapi-commands-run-state.h \
+qapi/qapi-commands-sockets.c qapi/qapi-commands-sockets.h \
+qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
+qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
+qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
+qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
 qapi-event.c qapi-event.h \
+qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
+qapi/qapi-events-block.c qapi/qapi-events-block.h \
+qapi/qapi-events-char.c qapi/qapi-events-char.h \
+qapi/qapi-events-common.c qapi/qapi-events-common.h \
+qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
+qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
+qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
+qapi/qapi-events-net.c qapi/qapi-events-net.h \
+qapi/qapi-events-rocker.c qapi/qapi-events-rocker.h \
+qapi/qapi-events-run-state.c qapi/qapi-events-run-state.h \
+qapi/qapi-events-sockets.c qapi/qapi-events-sockets.h \
+qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
+qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
+qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
+qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
 qmp-introspect.h qmp-introspect.c \
 qapi-doc.texi: \
 qapi-gen-timestamp ;
diff --git a/Makefile.objs b/Makefile.objs
index 2ace9c13b9d..5dc7a13c726 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,8 +3,56 @@
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
 util-obj-y += qapi-builtin-types.o
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
 util-obj-y += qapi-builtin-visit.o
-util-obj-y += qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y += qapi-visit.o
+util-obj-y += qapi/qapi-visit-block-core.o
+util-obj-y += qapi/qapi-visit-block.o
+util-obj-y += qapi/qapi-visit-char.o
+util-obj-y += qapi/qapi-visit-common.o
+util-obj-y += qapi/qapi-visit-crypto.o
+util-obj-y += qapi/qapi-visit-introspect.o
+util-obj-y += qapi/qapi-visit-migration.o
+util-obj-y += qapi/qapi-visit-net.o
+util-obj-y += qapi/qapi-visit-rocker.o
+util-obj-y += qapi/qapi-visit-run-state.o
+util-obj-y += qapi/qapi-visit-sockets.o
+util-obj-y += qapi/qapi-visit-tpm.o
+util-obj-y += qapi/qapi-visit-trace.o
+util-obj-y += qapi/qapi-visit-transaction.o
+util-obj-y += qapi/qapi-visit-ui.o
+util-obj-y += qapi-event.o
+util-obj-y += qapi/qapi-events-block-core.o
+util-obj-y += qapi/qapi-events-block.o
+util-obj-y += qapi/qapi-events-char.o
+util-obj-y += qapi/qapi-events-common.o
+util-obj-y += qapi/qapi-events-crypto.o
+util-obj-y += qapi/qapi-events-introspect.o
+util-obj-y += qapi/qapi-events-migration.o
+util-obj-y += qapi/qapi-events-net.o
+util-obj-y += qapi/qapi-events-rocker.o
+util-obj-y += qapi/qapi-events-run-state.o
+util-obj-y += qapi/qapi-events-sockets.o
+util-obj-y += qapi/qapi-events-tpm.o
+util-obj-y += qapi/qapi-events-trace.o
+util-obj-y += qapi/qapi-events-transaction.o
+util-obj-y += qapi/qapi-events-ui.o
+util-obj-y += qmp-introspect.o

 chardev-obj-y = chardev/

@@ -81,6 +129,21 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 # qapi

 common-obj-y += qmp-commands.o
+common-obj-y += qapi/qapi-commands-block-core.o
+common-obj-y += qapi/qapi-commands-block.o
+common-obj-y += qapi/qapi-commands-char.o
+common-obj-y += qapi/qapi-commands-common.o
+common-obj-y += qapi/qapi-commands-crypto.o
+common-obj-y += qapi/qapi-commands-introspect.o
+common-obj-y += qapi/qapi-commands-migration.o
+common-obj-y += qapi/qapi-commands-net.o
+common-obj-y += qapi/qapi-commands-rocker.o
+common-obj-y += qapi/qapi-commands-run-state.o
+common-obj-y += qapi/qapi-commands-sockets.o
+common-obj-y += qapi/qapi-commands-tpm.o
+common-obj-y += qapi/qapi-commands-trace.o
+common-obj-y += qapi/qapi-commands-transaction.o
+common-obj-y += qapi/qapi-commands-ui.o
 common-obj-y += qmp-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 46757db771d..a43bccb1902 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -223,14 +223,24 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
     return ret


-class QAPISchemaGenCommandVisitor(QAPISchemaMonolithicCVisitor):
+class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):

     def __init__(self, prefix):
-        QAPISchemaMonolithicCVisitor.__init__(
-            self, prefix, 'qmp-commands',
+        QAPISchemaModularCVisitor.__init__(
+            self, prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', __doc__)
         self._regy = ''
-        self._visited_ret_types = set()
+        self._visited_ret_types = {}
+
+    # Temporary HACK:
+    def _module_basename(self, what, name):
+        basename = QAPISchemaModularCVisitor._module_basename(self, what, name)
+        if name == self._main_module:
+            return re.sub(r'qapi-commands', 'qmp-commands', basename)
+        return basename
+
+    def _begin_module(self, name):
+        self._visited_ret_types[self._genc] = set()
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -246,26 +256,29 @@ class QAPISchemaGenCommandVisitor(QAPISchemaMonolithicCVisitor):
 #include "%(prefix)sqmp-commands.h"

 ''',
-                             prefix=prefix))
+                             prefix=self._prefix))
         self._genh.add(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/dispatch.h"

-void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                             prefix=prefix,
-                             c_prefix=c_name(prefix, protect=False)))
+                             prefix=self._prefix))

     def visit_end(self):
-        self._genc.add(gen_registry(self._regy, self._prefix))
+        (genc, genh) = self._module[self._main_module]
+        genh.add(mcgen('''
+void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
+''',
+                       c_prefix=c_name(self._prefix, protect=False)))
+        genc.add(gen_registry(self._regy, self._prefix))

     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
         if not gen:
             return
         self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
-        if ret_type and ret_type not in self._visited_ret_types:
-            self._visited_ret_types.add(ret_type)
+        if ret_type and ret_type not in self._visited_ret_types[self._genc]:
+            self._visited_ret_types[self._genc].add(ret_type)
             self._genc.add(gen_marshal_output(ret_type))
         self._genh.add(gen_marshal_decl(name))
         self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 069ec3715d7..077e0fde4f4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2073,13 +2073,20 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         self._blurb = blurb
         self._pydoc = pydoc
         self._module = {}
+        self._main_module = None

     def _module_basename(self, what, name):
         if name is None:
             return re.sub(r'-', '-builtin-', what)
-        return self._prefix + what
+        basename = os.path.join(os.path.dirname(name),
+                                self._prefix + what)
+        if name == self._main_module:
+            return basename
+        return basename + '-' + os.path.splitext(os.path.basename(name))[0]

     def _add_module(self, name, blurb):
+        if self._main_module is None and name is not None:
+            self._main_module = name
         genc = QAPIGenC(blurb, self._pydoc)
         genh = QAPIGenH(blurb, self._pydoc)
         self._module[name] = (genc, genh)
@@ -2088,7 +2095,7 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
     def _set_module(self, name):
         self._genc, self._genh = self._module[name]

-    def write(self, output_dir, opt_builtins):
+    def write(self, output_dir, opt_builtins=False):
         for name in self._module:
             if name is None and not opt_builtins:
                 continue
@@ -2101,7 +2108,15 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         pass

     def visit_module(self, name):
-        if len(self._module) != 1:
+        if name in self._module:
+            self._set_module(name)
             return
         self._add_module(name, self._blurb)
         self._begin_module(name)
+
+    def visit_include(self, name, info):
+        basename = self._module_basename(self._what, name)
+        self._genh.preamble_add(mcgen('''
+#include "%(basename)s.h"
+''',
+                                      basename=basename))
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 81ab3abb309..1e0b990f356 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -148,14 +148,23 @@ out:
     return ret


-class QAPISchemaGenEventVisitor(QAPISchemaMonolithicCVisitor):
+class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):

     def __init__(self, prefix):
-        QAPISchemaMonolithicCVisitor.__init__(
-            self, prefix, 'qapi-event',
+        QAPISchemaModularCVisitor.__init__(
+            self, prefix, 'qapi-events',
             ' * Schema-defined QAPI/QMP events', __doc__)
         self._enum_name = c_name(prefix + 'QAPIEvent', protect=False)
         self._event_names = []
+
+    # Temporary HACK:
+    def _module_basename(self, what, name):
+        basename = QAPISchemaModularCVisitor._module_basename(self, what, name)
+        if name == self._main_module:
+            return re.sub(r'qapi-events', 'qapi-event', basename)
+        return basename
+
+    def _begin_module(self, name):
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -167,13 +176,13 @@ class QAPISchemaGenEventVisitor(QAPISchemaMonolithicCVisitor):
 #include "qapi/qmp-event.h"

 ''',
-                             prefix=prefix))
+                             prefix=self._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(prefix)sqapi-types.h"

 ''',
-                             prefix=prefix))
+                             prefix=self._prefix))

     def visit_end(self):
         self._genh.add(gen_enum(self._enum_name, self._event_names))
diff --git a/.gitignore b/.gitignore
index 9477a08b6b3..42c57998fd5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,7 +31,67 @@
 /qapi-gen-timestamp
 /qapi-builtin-types.[ch]
 /qapi-builtin-visit.[ch]
+/qapi/qapi-commands-block-core.[ch]
+/qapi/qapi-commands-block.[ch]
+/qapi/qapi-commands-char.[ch]
+/qapi/qapi-commands-common.[ch]
+/qapi/qapi-commands-crypto.[ch]
+/qapi/qapi-commands-introspect.[ch]
+/qapi/qapi-commands-migration.[ch]
+/qapi/qapi-commands-net.[ch]
+/qapi/qapi-commands-rocker.[ch]
+/qapi/qapi-commands-run-state.[ch]
+/qapi/qapi-commands-sockets.[ch]
+/qapi/qapi-commands-tpm.[ch]
+/qapi/qapi-commands-trace.[ch]
+/qapi/qapi-commands-transaction.[ch]
+/qapi/qapi-commands-ui.[ch]
+/qapi/qapi-events-block-core.[ch]
+/qapi/qapi-events-block.[ch]
+/qapi/qapi-events-char.[ch]
+/qapi/qapi-events-common.[ch]
+/qapi/qapi-events-crypto.[ch]
+/qapi/qapi-events-introspect.[ch]
+/qapi/qapi-events-migration.[ch]
+/qapi/qapi-events-net.[ch]
+/qapi/qapi-events-rocker.[ch]
+/qapi/qapi-events-run-state.[ch]
+/qapi/qapi-events-sockets.[ch]
+/qapi/qapi-events-tpm.[ch]
+/qapi/qapi-events-trace.[ch]
+/qapi/qapi-events-transaction.[ch]
+/qapi/qapi-events-ui.[ch]
+/qapi/qapi-types-block-core.[ch]
+/qapi/qapi-types-block.[ch]
+/qapi/qapi-types-char.[ch]
+/qapi/qapi-types-common.[ch]
+/qapi/qapi-types-crypto.[ch]
+/qapi/qapi-types-introspect.[ch]
+/qapi/qapi-types-migration.[ch]
+/qapi/qapi-types-net.[ch]
+/qapi/qapi-types-rocker.[ch]
+/qapi/qapi-types-run-state.[ch]
+/qapi/qapi-types-sockets.[ch]
+/qapi/qapi-types-tpm.[ch]
+/qapi/qapi-types-trace.[ch]
+/qapi/qapi-types-transaction.[ch]
+/qapi/qapi-types-ui.[ch]
 /qapi-types.[ch]
+/qapi/qapi-visit-block-core.[ch]
+/qapi/qapi-visit-block.[ch]
+/qapi/qapi-visit-char.[ch]
+/qapi/qapi-visit-common.[ch]
+/qapi/qapi-visit-crypto.[ch]
+/qapi/qapi-visit-introspect.[ch]
+/qapi/qapi-visit-migration.[ch]
+/qapi/qapi-visit-net.[ch]
+/qapi/qapi-visit-rocker.[ch]
+/qapi/qapi-visit-run-state.[ch]
+/qapi/qapi-visit-sockets.[ch]
+/qapi/qapi-visit-tpm.[ch]
+/qapi/qapi-visit-trace.[ch]
+/qapi/qapi-visit-transaction.[ch]
+/qapi/qapi-visit-ui.[ch]
 /qapi-visit.[ch]
 /qapi-event.[ch]
 /qapi-doc.texi
-- 
2.14.3
