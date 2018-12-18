Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0003bp-4R
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK0x-0002OR-3T
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK0v-0002Db-82
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30039637E5
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:22 +0100
Message-Id: <20181218182234.28876-4-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 03/15] qapi: Generate QAPIEvent stuff
 into separate files WIP
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

Having to include qapi-events.h just for QAPIEvent is suboptimal, but
quite tolerable.  It'll become problematic when we have events
conditional on the target, because then qapi-events.h won't be usable
from target-independent code anymore.  Avoid that by generating it
into separate files.

This is work-in-progress because I conjure up a module to generate
separate files.  Not nice, since that module's name can clash with a
user module's name.  Pick module name 'FIXME' to make abundantly clear
this is a bad idea.

TODO Update docs/devel/qapi-code-gen.txt.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile               |  1 +
 Makefile.objs          |  1 +
 monitor.c              |  2 +-
 scripts/qapi/events.py | 33 ++++++++++++++++++++++-----------
 stubs/monitor.c        |  2 +-
 tests/test-qmp-event.c |  1 +
 ui/vnc.c               |  3 ++-
 7 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index c8b9efdad4..1ab285c928 100644
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,7 @@ GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-events-FIXME.h qapi/qapi-events-FIXME.c
 GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
diff --git a/Makefile.objs b/Makefile.objs
index 56af0347d3..126d0cd9b2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -11,6 +11,7 @@ util-obj-y += $(QAPI_MODULES:%=qapi/qapi-types-%.o)
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
 util-obj-y += $(QAPI_MODULES:%=qapi/qapi-visit-%.o)
+util-obj-y += qapi/qapi-events-FIXME.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
 util-obj-y += qapi/qapi-introspect.o
diff --git a/monitor.c b/monitor.c
index d7ca587bb0..41540655b7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -75,7 +75,7 @@
 #include "qemu/thread.h"
 #include "block/qapi.h"
 #include "qapi/qapi-commands.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-events-FIXME.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d86a2d2b3e..e988e43941 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -143,12 +143,14 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
         self._event_emit_name = c_name(prefix + 'qapi_event_emit')
 
     def _begin_module(self, name):
+        events = self._module_basename('qapi-events', name)
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "%(prefix)sqapi-events.h"
+#include "%(prefix)sqapi-events-FIXME.h"
+#include "%(events)s.h"
 #include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -156,7 +158,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
 #include "qapi/qmp-event.h"
 
 ''',
-                             visit=visit, prefix=self._prefix))
+                             events=events, visit=visit,
+                             prefix=self._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(types)s.h"
@@ -165,17 +168,25 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
                              types=types))
 
     def visit_end(self):
-        (genc, genh) = self._module[self._main_module]
-        genh.add(gen_enum(self._event_enum_name,
-                          self._event_enum_members))
-        genc.add(gen_enum_lookup(self._event_enum_name,
-                                 self._event_enum_members))
-        genh.add(mcgen('''
+        self._add_module('FIXME', ' * QAPI Events FIXME')
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(prefix)sqapi-events-FIXME.h"
+''',
+                                      prefix=self._prefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/util.h"
+'''))
+        self._genh.add(gen_enum(self._event_enum_name,
+                                self._event_enum_members))
+        self._genc.add(gen_enum_lookup(self._event_enum_name,
+                                       self._event_enum_members))
+        self._genh.add(mcgen('''
 
 void %(event_emit)s(%(event_enum)s event, QDict *qdict);
 ''',
-                       event_emit=self._event_emit_name,
-                       event_enum=self._event_enum_name))
+                             event_emit=self._event_emit_name,
+                             event_enum=self._event_enum_name))
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
@@ -189,4 +200,4 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict);
 def gen_events(schema, output_dir, prefix):
     vis = QAPISchemaGenEventVisitor(prefix)
     schema.visit(vis)
-    vis.write(output_dir)
+    vis.write(output_dir, True)
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 32bd7012c3..713c8be042 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-events-FIXME.h"
 #include "qemu-common.h"
 #include "monitor/monitor.h"
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index bf900f14f4..85942419d6 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
 #include "test-qapi-events.h"
+#include "test-qapi-events-FIXME.h"
 
 typedef struct TestEventData {
     QDict *expect;
diff --git a/ui/vnc.c b/ui/vnc.c
index 0c1b477425..8a9000cf09 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,7 +35,8 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-events-FIXME.h"
+#include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "ui/input.h"
-- 
2.17.2
