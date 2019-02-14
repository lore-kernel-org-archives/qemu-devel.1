Received: from eggs.gnu.org ([209.51.188.92]:56512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMS-0003OD-Kp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMM-0003Kb-D8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDML-0002h4-Sv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62E942D7EC
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:40 +0100
Message-Id: <20190214093053.1400-6-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/18] qapi: Generate QAPIEvent stuff into
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Having to include qapi-events.h just for QAPIEvent is suboptimal, but
quite tolerable now.  It'll become problematic when we have events
conditional on the target, because then qapi-events.h won't be usable
from target-independent code anymore.  Avoid that by generating it
into separate files.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
index 321095bf1a..b66b772551 100644
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
index 3658310b95..53d161b65f 100644
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,7 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qap=
i-visit-%.c)
 GENERATED_QAPI_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.h)
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.c)
+GENERATED_QAPI_FILES +=3D qapi/qapi-emit-events.h qapi/qapi-emit-events.=
c
 GENERATED_QAPI_FILES +=3D qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.h)
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.c)
diff --git a/Makefile.objs b/Makefile.objs
index b7aae33367..ec11a0f55b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -12,6 +12,7 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.o)
 util-obj-y +=3D qapi/qapi-builtin-visit.o
 util-obj-y +=3D qapi/qapi-visit.o
 util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
+util-obj-y +=3D qapi/qapi-emit-events.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
 util-obj-y +=3D qapi/qapi-introspect.o
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c9ba8ddb2e..b517b0cfbf 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1381,11 +1381,15 @@ qapi_event_send_EVENT().
=20
 The following files are created:
=20
-$(prefix)qapi-events.h - Function prototypes for each event type, plus a=
n
-                        enumeration of all event names
+$(prefix)qapi-events.h - Function prototypes for each event type
=20
 $(prefix)qapi-events.c - Implementation of functions to send an event
=20
+$(prefix)qapi-emit-events.h - Enumeration of all event names, and
+                              common event code declarations
+
+$(prefix)qapi-emit-events.c - Common event code definitions
+
 Example:
=20
     $ cat qapi-generated/example-qapi-events.h
@@ -1397,9 +1401,32 @@ Example:
     #include "qapi/util.h"
     #include "example-qapi-types.h"
=20
-
     void qapi_event_send_my_event(void);
=20
+    #endif /* EXAMPLE_QAPI_EVENTS_H */
+    $ cat qapi-generated/example-qapi-events.c
+[Uninteresting stuff omitted...]
+
+    void qapi_event_send_my_event(void)
+    {
+        QDict *qmp;
+
+        qmp =3D qmp_event_build_dict("MY_EVENT");
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
=20
     void example_qapi_event_emit(example_QAPIEvent event, QDict *qdict);
=20
-    #endif /* EXAMPLE_QAPI_EVENTS_H */
-    $ cat qapi-generated/example-qapi-events.c
+    #endif /* EXAMPLE_QAPI_EMIT_EVENTS_H */
+    $ cat qapi-generated/example-qapi-emit-events.c
 [Uninteresting stuff omitted...]
=20
-    void qapi_event_send_my_event(void)
-    {
-        QDict *qmp;
-
-        qmp =3D qmp_event_build_dict("MY_EVENT");
-
-        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
-
-        qobject_unref(qmp);
-    }
-
     const QEnumLookup example_QAPIEvent_lookup =3D {
         .array =3D (const char *const[]) {
             [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
diff --git a/monitor.c b/monitor.c
index e5de5765b8..8e02a001a3 100644
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
@@ -143,12 +143,14 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
         self._event_emit_name =3D c_name(prefix + 'qapi_event_emit')
=20
     def _begin_user_module(self, name):
+        events =3D self._module_basename('qapi-events', name)
         types =3D self._module_basename('qapi-types', name)
         visit =3D self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "%(prefix)sqapi-events.h"
+#include "%(prefix)sqapi-emit-events.h"
+#include "%(events)s.h"
 #include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -156,26 +158,34 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
 #include "qapi/qmp-event.h"
=20
 ''',
-                             visit=3Dvisit, prefix=3Dself._prefix))
+                             events=3Devents, visit=3Dvisit,
+                             prefix=3Dself._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(types)s.h"
-
 ''',
                              types=3Dtypes))
=20
     def visit_end(self):
-        (genc, genh) =3D self._module[self._main_module]
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
+                                      prefix=3Dself._prefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/util.h"
+'''))
+        self._genh.add(gen_enum(self._event_enum_name,
+                                self._event_enum_members))
+        self._genc.add(gen_enum_lookup(self._event_enum_name,
+                                       self._event_enum_members))
+        self._genh.add(mcgen('''
=20
 void %(event_emit)s(%(event_enum)s event, QDict *qdict);
 ''',
-                       event_emit=3Dself._event_emit_name,
-                       event_enum=3Dself._event_enum_name))
+                             event_emit=3Dself._event_emit_name,
+                             event_enum=3Dself._event_enum_name))
=20
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
=20
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index bf900f14f4..eee7e08ab6 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
 #include "test-qapi-events.h"
+#include "test-qapi-emit-events.h"
=20
 typedef struct TestEventData {
     QDict *expect;
diff --git a/ui/vnc.c b/ui/vnc.c
index 0fef646fc4..7e0710ed8f 100644
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
--=20
2.17.2
