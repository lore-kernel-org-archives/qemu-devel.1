Received: from eggs.gnu.org ([209.51.188.92]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlb-0004hI-Vj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRla-0001xU-2J
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlX-0001qr-S7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 099747AEA2
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:13 +0100
Message-Id: <20190206181725.14337-6-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/17] qapi: Generate QAPIEvent stuff into
 separate files
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
quite tolerable now.  It'll become problematic when we have events
conditional on the target, because then qapi-events.h won't be usable
from target-independent code anymore.  Avoid that by generating it
into separate files.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore                   |  1 +
 Makefile                     |  1 +
 Makefile.objs                |  1 +
 docs/devel/qapi-code-gen.txt | 48 ++++++++++++++++++++++++------------
 monitor.c                    |  2 +-
 scripts/qapi/events.py       | 32 +++++++++++++++---------
 stubs/monitor.c              |  2 +-
 tests/test-qmp-event.c       |  1 +
 ui/vnc.c                     |  3 ++-
 9 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0430257313..6d66daf713 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 /qapi/qapi-builtin-visit.[ch]
 /qapi/qapi-commands-*.[ch]
 /qapi/qapi-commands.[ch]
+/qapi/qapi-emit-events.[ch]
 /qapi/qapi-events-*.[ch]
 /qapi/qapi-events.[ch]
 /qapi/qapi-introspect.[ch]
diff --git a/Makefile b/Makefile
index 1278a3eb52..cd13e26c88 100644
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,7 @@ GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
+GENERATED_QAPI_FILES += qapi/qapi-emit-events.h qapi/qapi-emit-events.c
 GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08a..c463899df3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -12,6 +12,7 @@ util-obj-y += $(QAPI_MODULES:%=qapi/qapi-types-%.o)
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
 util-obj-y += $(QAPI_MODULES:%=qapi/qapi-visit-%.o)
+util-obj-y += qapi/qapi-emit-events.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += $(QAPI_MODULES:%=qapi/qapi-events-%.o)
 util-obj-y += qapi/qapi-introspect.o
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c9ba8ddb2e..b517b0cfbf 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1381,11 +1381,15 @@ qapi_event_send_EVENT().
 
 The following files are created:
 
-$(prefix)qapi-events.h - Function prototypes for each event type, plus an
-                        enumeration of all event names
+$(prefix)qapi-events.h - Function prototypes for each event type
 
 $(prefix)qapi-events.c - Implementation of functions to send an event
 
+$(prefix)qapi-emit-events.h - Enumeration of all event names, and
+                              common event code declarations
+
+$(prefix)qapi-emit-events.c - Common event code definitions
+
 Example:
 
     $ cat qapi-generated/example-qapi-events.h
@@ -1397,9 +1401,32 @@ Example:
     #include "qapi/util.h"
     #include "example-qapi-types.h"
 
-
     void qapi_event_send_my_event(void);
 
+    #endif /* EXAMPLE_QAPI_EVENTS_H */
+    $ cat qapi-generated/example-qapi-events.c
+[Uninteresting stuff omitted...]
+
+    void qapi_event_send_my_event(void)
+    {
+        QDict *qmp;
+
+        qmp = qmp_event_build_dict("MY_EVENT");
+
+        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
+
+        qobject_unref(qmp);
+    }
+
+[Uninteresting stuff omitted...]
+    $ cat qapi-generated/example-qapi-emit-events.h
+[Uninteresting stuff omitted...]
+
+    #ifndef EXAMPLE_QAPI_EMIT_EVENTS_H
+    #define EXAMPLE_QAPI_EMIT_EVENTS_H
+
+    #include "qapi/util.h"
+
     typedef enum example_QAPIEvent {
         EXAMPLE_QAPI_EVENT_MY_EVENT,
         EXAMPLE_QAPI_EVENT__MAX,
@@ -1412,21 +1439,10 @@ Example:
 
     void example_qapi_event_emit(example_QAPIEvent event, QDict *qdict);
 
-    #endif /* EXAMPLE_QAPI_EVENTS_H */
-    $ cat qapi-generated/example-qapi-events.c
+    #endif /* EXAMPLE_QAPI_EMIT_EVENTS_H */
+    $ cat qapi-generated/example-qapi-emit-events.c
 [Uninteresting stuff omitted...]
 
-    void qapi_event_send_my_event(void)
-    {
-        QDict *qmp;
-
-        qmp = qmp_event_build_dict("MY_EVENT");
-
-        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
-
-        qobject_unref(qmp);
-    }
-
     const QEnumLookup example_QAPIEvent_lookup = {
         .array = (const char *const[]) {
             [EXAMPLE_QAPI_EVENT_MY_EVENT] = "MY_EVENT",
diff --git a/monitor.c b/monitor.c
index c09fa63940..20d8e2e2aa 100644
--- a/monitor.c
+++ b/monitor.c
@@ -75,7 +75,7 @@
 #include "qemu/thread.h"
 #include "block/qapi.h"
 #include "qapi/qapi-commands.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-emit-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 6f39cf8196..28bbc3745d 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -143,12 +143,14 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
         self._event_emit_name = c_name(prefix + 'qapi_event_emit')
 
     def _begin_user_module(self, name):
+        events = self._module_basename('qapi-events', name)
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "%(prefix)sqapi-events.h"
+#include "%(prefix)sqapi-emit-events.h"
+#include "%(events)s.h"
 #include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -156,26 +158,34 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
 #include "qapi/qmp-event.h"
 
 ''',
-                             visit=visit, prefix=self._prefix))
+                             events=events, visit=visit,
+                             prefix=self._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(types)s.h"
-
 ''',
                              types=types))
 
     def visit_end(self):
-        (genc, genh) = self._module[self._main_module]
-        genh.add(gen_enum(self._event_enum_name,
-                          self._event_enum_members))
-        genc.add(gen_enum_lookup(self._event_enum_name,
-                                 self._event_enum_members))
-        genh.add(mcgen('''
+        self._add_system_module('emit', ' * QAPI Events emission')
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(prefix)sqapi-emit-events.h"
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
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 32bd7012c3..b57fe6c32f 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-emit-events.h"
 #include "qemu-common.h"
 #include "monitor/monitor.h"
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index bf900f14f4..eee7e08ab6 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
 #include "test-qapi-events.h"
+#include "test-qapi-emit-events.h"
 
 typedef struct TestEventData {
     QDict *expect;
diff --git a/ui/vnc.c b/ui/vnc.c
index 6002d09407..284ea824d0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,7 +35,8 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-events.h"
+#include "qapi/qapi-emit-events.h"
+#include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "ui/input.h"
-- 
2.17.2
