Received: from eggs.gnu.org ([2001:4830:134:3::10]:58530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzO-0001sG-PX
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzN-0002PW-2f
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzM-0002PH-PO
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:39 +0400
Message-Id: <20170311132256.22951-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The type is not used at all yet. Add some tests to exercice it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/introspect.json                     |  2 +-
 scripts/qapi.py                          | 28 ++++++++-------
 include/qapi/qmp/quint.h                 | 25 ++++++++++++++
 include/qapi/qmp/types.h                 |  1 +
 block/qapi.c                             |  5 +++
 qobject/qobject.c                        |  1 +
 qobject/quint.c                          | 58 ++++++++++++++++++++++++++=
+++++
 tests/check-qint.c                       | 59 ++++++++++++++++++++++++++=
++++++
 qobject/Makefile.objs                    |  2 +-
 tests/qapi-schema/comments.out           |  2 +-
 tests/qapi-schema/empty.out              |  2 +-
 tests/qapi-schema/event-case.out         |  2 +-
 tests/qapi-schema/ident-with-escape.out  |  2 +-
 tests/qapi-schema/include-relpath.out    |  2 +-
 tests/qapi-schema/include-repetition.out |  2 +-
 tests/qapi-schema/include-simple.out     |  2 +-
 tests/qapi-schema/indented-expr.out      |  2 +-
 tests/qapi-schema/qapi-schema-test.out   |  2 +-
 18 files changed, 175 insertions(+), 24 deletions(-)
 create mode 100644 include/qapi/qmp/quint.h
 create mode 100644 qobject/quint.c

diff --git a/qapi/introspect.json b/qapi/introspect.json
index f6adc439bb..512a961ab3 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -125,7 +125,7 @@
 # Since: 2.5
 ##
 { 'enum': 'JSONType',
-  'data': [ 'string', 'number', 'int', 'boolean', 'null',
+  'data': [ 'string', 'number', 'int', 'uint', 'boolean', 'null',
             'object', 'array', 'value' ] }
=20
 ##
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 9504ebd8c7..80ecc821cb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -28,11 +28,11 @@ builtin_types =3D {
     'int16':    'QTYPE_QINT',
     'int32':    'QTYPE_QINT',
     'int64':    'QTYPE_QINT',
-    'uint8':    'QTYPE_QINT',
-    'uint16':   'QTYPE_QINT',
-    'uint32':   'QTYPE_QINT',
-    'uint64':   'QTYPE_QINT',
-    'size':     'QTYPE_QINT',
+    'uint8':    'QTYPE_QUINT',
+    'uint16':   'QTYPE_QUINT',
+    'uint32':   'QTYPE_QUINT',
+    'uint64':   'QTYPE_QUINT',
+    'size':     'QTYPE_QUINT',
     'any':      None,           # any QType possible, actually
     'QType':    'QTYPE_QSTRING',
 }
@@ -1093,6 +1093,7 @@ class QAPISchemaType(QAPISchemaEntity):
             'string':  'QTYPE_QSTRING',
             'number':  'QTYPE_QFLOAT',
             'int':     'QTYPE_QINT',
+            'uint':    'QTYPE_QUINT',
             'boolean': 'QTYPE_QBOOL',
             'object':  'QTYPE_QDICT'
         }
@@ -1103,8 +1104,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
     def __init__(self, name, json_type, c_type):
         QAPISchemaType.__init__(self, name, None)
         assert not c_type or isinstance(c_type, str)
-        assert json_type in ('string', 'number', 'int', 'boolean', 'null=
',
-                             'value')
+        assert json_type in ('string', 'number', 'int', 'uint',
+                             'boolean', 'null', 'value')
         self._json_type_name =3D json_type
         self._c_type_name =3D c_type
=20
@@ -1519,18 +1520,19 @@ class QAPISchema(object):
                   ('int16',  'int',     'int16_t'),
                   ('int32',  'int',     'int32_t'),
                   ('int64',  'int',     'int64_t'),
-                  ('uint8',  'int',     'uint8_t'),
-                  ('uint16', 'int',     'uint16_t'),
-                  ('uint32', 'int',     'uint32_t'),
-                  ('uint64', 'int',     'uint64_t'),
-                  ('size',   'int',     'uint64_t'),
+                  ('uint8',  'uint',    'uint8_t'),
+                  ('uint16', 'uint',    'uint16_t'),
+                  ('uint32', 'uint',    'uint32_t'),
+                  ('uint64', 'uint',    'uint64_t'),
+                  ('size',   'uint',    'uint64_t'),
                   ('bool',   'boolean', 'bool'),
                   ('any',    'value',   'QObject' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type =3D QAPISchemaObjectType('q_empty', N=
one,
                                                           None, [], None=
)
         self._def_entity(self.the_empty_object_type)
-        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qint=
',
+        qtype_values =3D self._make_enum_members(['none', 'qnull',
+                                                'qint', 'quint',
                                                 'qstring', 'qdict', 'qli=
st',
                                                 'qfloat', 'qbool'])
         self._def_entity(QAPISchemaEnumType('QType', None, qtype_values,
diff --git a/include/qapi/qmp/quint.h b/include/qapi/qmp/quint.h
new file mode 100644
index 0000000000..5b920ece5d
--- /dev/null
+++ b/include/qapi/qmp/quint.h
@@ -0,0 +1,25 @@
+/*
+ * QUInt Module
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QUINT_H
+#define QUINT_H
+
+#include "qapi/qmp/qobject.h"
+
+typedef struct QUInt {
+    QObject base;
+    uint64_t value;
+} QUInt;
+
+QUInt *quint_from_uint(uint64_t value);
+uint64_t quint_get_uint(const QUInt *qi);
+QUInt *qobject_to_quint(const QObject *obj);
+void quint_destroy_obj(QObject *obj);
+
+#endif /* QUINT_H */
diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
index 27cfbd84e5..99a60f75d0 100644
--- a/include/qapi/qmp/types.h
+++ b/include/qapi/qmp/types.h
@@ -15,6 +15,7 @@
=20
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qapi/qmp/qfloat.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..6261a49b4d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -600,6 +600,11 @@ static void dump_qobject(fprintf_function func_fprin=
tf, void *f,
             func_fprintf(f, "%" PRId64, qint_get_int(value));
             break;
         }
+        case QTYPE_QUINT: {
+            QUInt *value =3D qobject_to_quint(obj);
+            func_fprintf(f, "%" PRIu64, quint_get_uint(value));
+            break;
+        }
         case QTYPE_QSTRING: {
             QString *value =3D qobject_to_qstring(obj);
             func_fprintf(f, "%s", qstring_get_str(value));
diff --git a/qobject/qobject.c b/qobject/qobject.c
index fe4fa10989..9bdb5e5947 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -15,6 +15,7 @@ static void (*qdestroy[QTYPE__MAX])(QObject *) =3D {
     [QTYPE_NONE] =3D NULL,               /* No such object exists */
     [QTYPE_QNULL] =3D NULL,              /* qnull_ is indestructible */
     [QTYPE_QINT] =3D qint_destroy_obj,
+    [QTYPE_QUINT] =3D quint_destroy_obj,
     [QTYPE_QSTRING] =3D qstring_destroy_obj,
     [QTYPE_QDICT] =3D qdict_destroy_obj,
     [QTYPE_QLIST] =3D qlist_destroy_obj,
diff --git a/qobject/quint.c b/qobject/quint.c
new file mode 100644
index 0000000000..e3a7ac37c4
--- /dev/null
+++ b/qobject/quint.c
@@ -0,0 +1,58 @@
+/*
+ * QUInt Module
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/quint.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu-common.h"
+
+/**
+ * quint_from_uint(): Create a new QUInt from an uint64_t
+ *
+ * Return strong reference.
+ */
+QUInt *quint_from_uint(uint64_t value)
+{
+    QUInt *qi;
+
+    qi =3D g_malloc(sizeof(*qi));
+    qobject_init(QOBJECT(qi), QTYPE_QUINT);
+    qi->value =3D value;
+
+    return qi;
+}
+
+/**
+ * quint_get_int(): Get the stored integer
+ */
+uint64_t quint_get_uint(const QUInt *qi)
+{
+    return qi->value;
+}
+
+/**
+ * qobject_to_quint(): Convert a QObject into a QUInt
+ */
+QUInt *qobject_to_quint(const QObject *obj)
+{
+    if (!obj || qobject_type(obj) !=3D QTYPE_QUINT) {
+        return NULL;
+    }
+    return container_of(obj, QUInt, base);
+}
+
+/**
+ * quint_destroy_obj(): Free all memory allocated by a
+ * QUInt object
+ */
+void quint_destroy_obj(QObject *obj)
+{
+    assert(obj !=3D NULL);
+    g_free(qobject_to_quint(obj));
+}
diff --git a/tests/check-qint.c b/tests/check-qint.c
index b6e4555115..603aa1aa92 100644
--- a/tests/check-qint.c
+++ b/tests/check-qint.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qemu-common.h"
=20
 /*
@@ -73,6 +74,58 @@ static void qobject_to_qint_test(void)
     QDECREF(qi);
 }
=20
+static void quint_from_uint_test(void)
+{
+    QUInt *qu;
+    const unsigned value =3D -42;
+
+    qu =3D quint_from_uint(value);
+    g_assert(qu !=3D NULL);
+    g_assert(qu->value =3D=3D value);
+    g_assert(qu->base.refcnt =3D=3D 1);
+    g_assert(qobject_type(QOBJECT(qu)) =3D=3D QTYPE_QUINT);
+
+    g_free(qu);
+}
+
+static void quint_destroy_test(void)
+{
+    QUInt *qu =3D quint_from_uint(0);
+    QDECREF(qu);
+}
+
+static void quint_from_uint64_test(void)
+{
+    QUInt *qu;
+    const uint64_t value =3D 0x1234567890abcdefLL;
+
+    qu =3D quint_from_uint(value);
+    g_assert((uint64_t) qu->value =3D=3D value);
+
+    QDECREF(qu);
+}
+
+static void quint_get_uint_test(void)
+{
+    QUInt *qu;
+    const unsigned value =3D 123456;
+
+    qu =3D quint_from_uint(value);
+    g_assert(quint_get_uint(qu) =3D=3D value);
+
+    QDECREF(qu);
+}
+
+static void qobject_to_quint_test(void)
+{
+    QUInt *qu;
+
+    qu =3D quint_from_uint(0);
+    g_assert(qobject_to_quint(QOBJECT(qu)) =3D=3D qu);
+
+    QDECREF(qu);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -83,5 +136,11 @@ int main(int argc, char **argv)
     g_test_add_func("/public/get_int", qint_get_int_test);
     g_test_add_func("/public/to_qint", qobject_to_qint_test);
=20
+    g_test_add_func("/public/from_uint", quint_from_uint_test);
+    g_test_add_func("/public/uint_destroy", quint_destroy_test);
+    g_test_add_func("/public/from_uint64", quint_from_uint64_test);
+    g_test_add_func("/public/get_uint", quint_get_uint_test);
+    g_test_add_func("/public/to_quint", qobject_to_quint_test);
+
     return g_test_run();
 }
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
index bed55084bb..1f7b95552f 100644
--- a/qobject/Makefile.objs
+++ b/qobject/Makefile.objs
@@ -1,2 +1,2 @@
-util-obj-y =3D qnull.o qint.o qstring.o qdict.o qlist.o qfloat.o qbool.o
+util-obj-y =3D qnull.o qint.o quint.o qstring.o qdict.o qlist.o qfloat.o=
 qbool.o
 util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pars=
er.o
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index a962fb2d2e..42ea87a1a1 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 8a5b034424..5dcccb1d55 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,3 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 object q_empty
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 2865714ad5..3464bd30f6 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 event oops None
    boxed=3DFalse
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 69fc908e68..a81ef8cd34 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 command fooA q_obj_fooA-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index a962fb2d2e..42ea87a1a1 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index a962fb2d2e..42ea87a1a1 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index a962fb2d2e..42ea87a1a1 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 285d052257..b158bcd6eb 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index bc8d496ff4..690460658c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -54,7 +54,7 @@ object NestedEnumsOne
     member enum4: EnumOne optional=3DTrue
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qint', 'quint', 'qstring', 'qdict', 'qlist=
', 'qfloat', 'qbool']
     prefix QTYPE
 object TestStruct
     member integer: int optional=3DFalse
--=20
2.12.0.191.gc5d8de91d
