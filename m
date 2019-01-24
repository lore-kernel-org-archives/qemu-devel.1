Received: from eggs.gnu.org ([209.51.188.92]:48065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9a-0004KT-W7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9V-0004pO-IZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg9U-0004UO-W3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 604199D435
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-138.ams2.redhat.com
	[10.36.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04E311048117
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:38:23 +0100
Message-Id: <20190124143825.25921-3-armbru@redhat.com>
In-Reply-To: <20190124143825.25921-1-armbru@redhat.com>
References: <20190124143825.25921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] qapi: Eliminate indirection through
 qmp_event_get_func_emit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qapi_event_send_FOO() functions emit events like this:

    QMPEventFuncEmit emit;

    emit =3D qmp_event_get_func_emit();
    if (!emit) {
        return;
    }

    qmp =3D qmp_event_build_dict("FOO");
    [put event arguments into @qmp...]

    emit(QAPI_EVENT_FOO, qmp);

The value of qmp_event_get_func_emit() depends only on the program:

* In qemu-system-FOO, it's always monitor_qapi_event_queue.

* In tests/test-qmp-event, it's always event_test_emit.

* In all other programs, it's always null.

This is exactly the kind of dependence the linker is supposed to
resolve; we don't actually need an indirection.

Note that things would fall apart if we linked more than one QAPI
schema into a single program: each set of qapi_event_send_FOO() uses
its own event enumeration, yet they share a single emit function.
Which takes the event enumeration as an argument.  Which one if
there's more than one?

More seriously: how does this work even now?  qemu-system-FOO wants
QAPIEvent, and passes a function taking that to
qmp_event_set_func_emit().  test-qmp-event wants test_QAPIEvent, and
passes a function taking that to qmp_event_set_func_emit().

It works by type trickery, of course:

    typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);

    void qmp_event_set_func_emit(QMPEventFuncEmit emit);

    QMPEventFuncEmit qmp_event_get_func_emit(void);

We use unsigned instead of the enumeration type.  Relies on both
enumerations boiling down to unsigned, which happens to be true for
the compilers we use.

Clean this up as follows:

* Generate qapi_event_send_FOO() that call PREFIX_qapi_event_emit()
  instead of the value of qmp_event_set_func_emit().

* Generate a prototype for PREFIX_qapi_event_emit() into
  qapi-events.h.

* PREFIX_ is empty for qapi/qapi-schema.json, and test_ for
  tests/qapi-schema/qapi-schema-test.json.  It's qga_ for
  qga/qapi-schema.json, and doc-good- for
  tests/qapi-schema/doc-good.json, but those don't define any events.

* Rename monitor_qapi_event_queue() to qapi_event_emit() instead of
  passing it to qmp_event_set_func_emit().  This takes care of
  qemu-system-FOO.

* Rename event_test_emit() to test_qapi_event_emit() instead of
  passing it to qmp_event_set_func_emit().  This takes care of
  tests/test-qmp-event.

* Add a qapi_event_emit() that does nothing to stubs/monitor.c.  This
  takes care of all other programs that link code emitting QMP events.

* Drop qmp_event_set_func_emit(), qmp_event_get_func_emit().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181218182234.28876-3-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[Commit message typos fixed]
---
 docs/devel/qapi-code-gen.txt |  8 +-------
 include/qapi/qmp-event.h     |  6 ------
 monitor.c                    |  4 +---
 qapi/qmp-event.c             | 12 ------------
 scripts/qapi/events.py       | 24 ++++++++++++++----------
 stubs/monitor.c              |  5 +++++
 tests/Makefile.include       |  4 ++--
 tests/test-qmp-event.c       |  6 +-----
 8 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 418a607842..87183d3a09 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1385,16 +1385,10 @@ Example:
     void qapi_event_send_my_event(void)
     {
         QDict *qmp;
-        QMPEventFuncEmit emit;
-
-        emit =3D qmp_event_get_func_emit();
-        if (!emit) {
-            return;
-        }
=20
         qmp =3D qmp_event_build_dict("MY_EVENT");
=20
-        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
+        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
=20
         qobject_unref(qmp);
     }
diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
index 23e588ccf8..b60f1d3a89 100644
--- a/include/qapi/qmp-event.h
+++ b/include/qapi/qmp-event.h
@@ -14,11 +14,5 @@
 #ifndef QMP_EVENT_H
 #define QMP_EVENT_H
=20
-typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
-
-void qmp_event_set_func_emit(QMPEventFuncEmit emit);
-
-QMPEventFuncEmit qmp_event_get_func_emit(void);
-
 QDict *qmp_event_build_dict(const char *event_name);
 #endif
diff --git a/monitor.c b/monitor.c
index eb39fb015b..c09fa63940 100644
--- a/monitor.c
+++ b/monitor.c
@@ -590,8 +590,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, =
QDict *qdict)
     qemu_mutex_unlock(&monitor_lock);
 }
=20
-static void
-monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     /*
      * monitor_qapi_event_queue_no_reenter() is not reentrant: it
@@ -704,7 +703,6 @@ static void monitor_qapi_event_init(void)
 {
     monitor_qapi_event_state =3D g_hash_table_new(qapi_event_throttle_ha=
sh,
                                                 qapi_event_throttle_equa=
l);
-    qmp_event_set_func_emit(monitor_qapi_event_queue);
 }
=20
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 5b8854043e..81ddd5331f 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -19,18 +19,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
=20
-static QMPEventFuncEmit qmp_emit;
-
-void qmp_event_set_func_emit(QMPEventFuncEmit emit)
-{
-    qmp_emit =3D emit;
-}
-
-QMPEventFuncEmit qmp_event_get_func_emit(void)
-{
-    return qmp_emit;
-}
-
 static void timestamp_put(QDict *qdict)
 {
     int err;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 37ee5de682..d86a2d2b3e 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -58,7 +58,7 @@ def gen_param_var(typ):
     return ret
=20
=20
-def gen_event_send(name, arg_type, boxed, event_enum_name):
+def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
     # FIXME: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
@@ -70,7 +70,6 @@ def gen_event_send(name, arg_type, boxed, event_enum_na=
me):
 %(proto)s
 {
     QDict *qmp;
-    QMPEventFuncEmit emit;
 ''',
                 proto=3Dbuild_event_send_proto(name, arg_type, boxed))
=20
@@ -86,11 +85,6 @@ def gen_event_send(name, arg_type, boxed, event_enum_n=
ame):
=20
     ret +=3D mcgen('''
=20
-    emit =3D qmp_event_get_func_emit();
-    if (!emit) {
-        return;
-    }
-
     qmp =3D qmp_event_build_dict("%(name)s");
=20
 ''',
@@ -121,9 +115,10 @@ def gen_event_send(name, arg_type, boxed, event_enum=
_name):
 ''')
=20
     ret +=3D mcgen('''
-    emit(%(c_enum)s, qmp);
+    %(event_emit)s(%(c_enum)s, qmp);
=20
 ''',
+                 event_emit=3Devent_emit,
                  c_enum=3Dc_enum_const(event_enum_name, name))
=20
     if arg_type and not arg_type.is_empty():
@@ -145,6 +140,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
             ' * Schema-defined QAPI/QMP events', __doc__)
         self._event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3D=
False)
         self._event_enum_members =3D []
+        self._event_emit_name =3D c_name(prefix + 'qapi_event_emit')
=20
     def _begin_module(self, name):
         types =3D self._module_basename('qapi-types', name)
@@ -170,15 +166,23 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
=20
     def visit_end(self):
         (genc, genh) =3D self._module[self._main_module]
-        genh.add(gen_enum(self._event_enum_name, self._event_enum_member=
s))
+        genh.add(gen_enum(self._event_enum_name,
+                          self._event_enum_members))
         genc.add(gen_enum_lookup(self._event_enum_name,
                                  self._event_enum_members))
+        genh.add(mcgen('''
+
+void %(event_emit)s(%(event_enum)s event, QDict *qdict);
+''',
+                       event_emit=3Dself._event_emit_name,
+                       event_enum=3Dself._event_enum_name))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
-                                          self._event_enum_name))
+                                          self._event_enum_name,
+                                          self._event_emit_name))
         self._event_enum_members.append(QAPISchemaMember(name, ifcond))
=20
=20
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 3890771bb5..32bd7012c3 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events.h"
 #include "qemu-common.h"
 #include "monitor/monitor.h"
=20
@@ -14,3 +15,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Erro=
r **errp)
 void monitor_init(Chardev *chr, int flags)
 {
 }
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4eea38ae99..3453579af3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -528,7 +528,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
 test-util-obj-y =3D libqemuutil.a
 test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
-	tests/test-qapi-events.o tests/test-qapi-introspect.o \
+	tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
 benchmark-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
@@ -620,7 +620,7 @@ tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tes=
ts/qapi-schema/doc-good.jso
=20
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visito=
r.o $(test-qapi-obj-y)
-tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
+tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)=
 tests/test-qapi-events.o
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-vi=
sitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qap=
i-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visi=
tor.o $(test-qapi-obj-y)
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 9cddd72adb..bf900f14f4 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -93,9 +93,7 @@ static bool qdict_cmp_simple(QDict *a, QDict *b)
     return d.result;
 }
=20
-/* This function is hooked as final emit function, which can verify the
-   correctness. */
-static void event_test_emit(test_QAPIEvent event, QDict *d)
+void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 {
     QDict *t;
     int64_t s, ms;
@@ -241,8 +239,6 @@ static void test_event_d(TestEventData *data,
=20
 int main(int argc, char **argv)
 {
-    qmp_event_set_func_emit(event_test_emit);
-
     g_test_init(&argc, &argv, NULL);
=20
     event_test_add("/event/event_a", test_event_a);
--=20
2.17.2
