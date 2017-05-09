Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d894z-0006Rt-1r
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d894r-0003nv-6u
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:37:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d894q-0003mO-Lj
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:37:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A673804E2
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:37:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:46 +0300
Message-Id: <20170509173559.31598-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We would like to use a same QObject type to represent numbers, whether
they are int, uint, or floats. getters will allow some compatibility
between the various types if the number fits other representations

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                          |  30 +++----
 scripts/qapi-visit.py                    |   2 +-
 include/qapi/qmp/qdict.h                 |   3 +-
 include/qapi/qmp/qfloat.h                |  29 -------
 include/qapi/qmp/qint.h                  |  28 -------
 include/qapi/qmp/qlist.h                 |   2 +-
 include/qapi/qmp/qnum.h                  |  43 ++++++++++
 include/qapi/qmp/types.h                 |   3 +-
 include/qapi/qobject-input-visitor.h     |   2 +-
 include/qapi/qobject-output-visitor.h    |   8 +-
 block/blkdebug.c                         |   1 -
 block/nbd.c                              |   1 -
 block/nfs.c                              |   1 -
 block/qapi.c                             |  13 ++-
 block/quorum.c                           |   1 -
 block/sheepdog.c                         |   1 -
 block/ssh.c                              |   1 -
 block/vvfat.c                            |   1 -
 blockdev.c                               |   5 +-
 hw/acpi/pcihp.c                          |   1 -
 hw/i386/acpi-build.c                     |  15 ++--
 hw/usb/xen-usb.c                         |   1 -
 monitor.c                                |   2 +-
 qapi/qobject-input-visitor.c             |  36 +++-----
 qapi/qobject-output-visitor.c            |   6 +-
 qga/commands.c                           |   2 +-
 qga/main.c                               |   1 -
 qobject/json-parser.c                    |  18 ++--
 qobject/qdict.c                          |  38 ++++-----
 qobject/qfloat.c                         |  62 --------------
 qobject/qint.c                           |  61 --------------
 qobject/qjson.c                          |  37 +--------
 qobject/qnum.c                           | 138 +++++++++++++++++++++++++=
++++++
 qobject/qobject.c                        |   3 +-
 qom/object.c                             |  21 +++--
 target/i386/cpu.c                        |   6 +-
 tests/check-qdict.c                      |  23 +++---
 tests/check-qfloat.c                     |  53 ------------
 tests/check-qint.c                       |  87 -------------------
 tests/check-qjson.c                      |  84 +++++++++----------
 tests/check-qlist.c                      |  15 ++--
 tests/check-qnum.c                       | 131 +++++++++++++++++++++++++=
++++
 tests/test-keyval.c                      |   1 -
 tests/test-qmp-commands.c                |   6 +-
 tests/test-qmp-event.c                   |   7 +-
 tests/test-qobject-input-visitor.c       |  30 +++----
 tests/test-qobject-output-visitor.c      |  56 ++++++-------
 tests/test-x86-cpuid-compat.c            |  13 ++-
 ui/spice-core.c                          |   1 -
 ui/vnc-enc-tight.c                       |   1 -
 util/qemu-option.c                       |  20 ++---
 MAINTAINERS                              |   3 +-
 qobject/Makefile.objs                    |   2 +-
 scripts/coccinelle/qobject.cocci         |   4 +-
 tests/.gitignore                         |   3 +-
 tests/Makefile.include                   |  13 ++-
 tests/qapi-schema/comments.out           |   2 +-
 tests/qapi-schema/doc-good.out           |   2 +-
 tests/qapi-schema/empty.out              |   2 +-
 tests/qapi-schema/event-case.out         |   2 +-
 tests/qapi-schema/ident-with-escape.out  |   2 +-
 tests/qapi-schema/include-relpath.out    |   2 +-
 tests/qapi-schema/include-repetition.out |   2 +-
 tests/qapi-schema/include-simple.out     |   2 +-
 tests/qapi-schema/indented-expr.out      |   2 +-
 tests/qapi-schema/qapi-schema-test.out   |   2 +-
 66 files changed, 557 insertions(+), 639 deletions(-)
 delete mode 100644 include/qapi/qmp/qfloat.h
 delete mode 100644 include/qapi/qmp/qint.h
 create mode 100644 include/qapi/qmp/qnum.h
 delete mode 100644 qobject/qfloat.c
 delete mode 100644 qobject/qint.c
 create mode 100644 qobject/qnum.c
 delete mode 100644 tests/check-qfloat.c
 delete mode 100644 tests/check-qint.c
 create mode 100644 tests/check-qnum.c

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 6c4d554165..01fd0027a5 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -21,18 +21,18 @@ from ordereddict import OrderedDict
=20
 builtin_types =3D {
     'str':      'QTYPE_QSTRING',
-    'int':      'QTYPE_QINT',
-    'number':   'QTYPE_QFLOAT',
+    'int':      'QTYPE_QNUM',
+    'number':   'QTYPE_QNUM',
     'bool':     'QTYPE_QBOOL',
-    'int8':     'QTYPE_QINT',
-    'int16':    'QTYPE_QINT',
-    'int32':    'QTYPE_QINT',
-    'int64':    'QTYPE_QINT',
-    'uint8':    'QTYPE_QINT',
-    'uint16':   'QTYPE_QINT',
-    'uint32':   'QTYPE_QINT',
-    'uint64':   'QTYPE_QINT',
-    'size':     'QTYPE_QINT',
+    'int8':     'QTYPE_QNUM',
+    'int16':    'QTYPE_QNUM',
+    'int32':    'QTYPE_QNUM',
+    'int64':    'QTYPE_QNUM',
+    'uint8':    'QTYPE_QNUM',
+    'uint16':   'QTYPE_QNUM',
+    'uint32':   'QTYPE_QNUM',
+    'uint64':   'QTYPE_QNUM',
+    'size':     'QTYPE_QNUM',
     'any':      None,           # any QType possible, actually
     'QType':    'QTYPE_QSTRING',
 }
@@ -1044,8 +1044,8 @@ class QAPISchemaType(QAPISchemaEntity):
     def alternate_qtype(self):
         json2qtype =3D {
             'string':  'QTYPE_QSTRING',
-            'number':  'QTYPE_QFLOAT',
-            'int':     'QTYPE_QINT',
+            'number':  'QTYPE_QNUM',
+            'int':     'QTYPE_QNUM',
             'boolean': 'QTYPE_QBOOL',
             'object':  'QTYPE_QDICT'
         }
@@ -1507,9 +1507,9 @@ class QAPISchema(object):
         self.the_empty_object_type =3D QAPISchemaObjectType(
             'q_empty', None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
-        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qint=
',
+        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
                                                 'qstring', 'qdict', 'qli=
st',
-                                                'qfloat', 'qbool'])
+                                                'qbool'])
         self._def_entity(QAPISchemaEnumType('QType', None, None,
                                             qtype_values, 'QTYPE'))
=20
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 5737aefa05..cc447ecacc 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -164,7 +164,7 @@ def gen_visit_alternate(name, variants):
     promote_int =3D 'true'
     ret =3D ''
     for var in variants.variants:
-        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT':
+        if var.type.alternate_qtype() =3D=3D 'QTYPE_QNUM':
             promote_int =3D 'false'
=20
     ret +=3D mcgen('''
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 188440a6a8..363e431106 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -15,6 +15,7 @@
=20
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnum.h"
 #include "qemu/queue.h"
=20
 #define QDICT_BUCKET_MAX 512
@@ -54,7 +55,7 @@ void qdict_destroy_obj(QObject *obj);
=20
 /* Helpers for int, bool, and string */
 #define qdict_put_int(qdict, key, value) \
-        qdict_put(qdict, key, qint_from_int(value))
+        qdict_put(qdict, key, qnum_from_int(value))
 #define qdict_put_bool(qdict, key, value) \
         qdict_put(qdict, key, qbool_from_bool(value))
 #define qdict_put_str(qdict, key, value) \
diff --git a/include/qapi/qmp/qfloat.h b/include/qapi/qmp/qfloat.h
deleted file mode 100644
index b5d15836b5..0000000000
--- a/include/qapi/qmp/qfloat.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * QFloat Module
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-
-#ifndef QFLOAT_H
-#define QFLOAT_H
-
-#include "qapi/qmp/qobject.h"
-
-typedef struct QFloat {
-    QObject base;
-    double value;
-} QFloat;
-
-QFloat *qfloat_from_double(double value);
-double qfloat_get_double(const QFloat *qi);
-QFloat *qobject_to_qfloat(const QObject *obj);
-void qfloat_destroy_obj(QObject *obj);
-
-#endif /* QFLOAT_H */
diff --git a/include/qapi/qmp/qint.h b/include/qapi/qmp/qint.h
deleted file mode 100644
index 3aaff768dd..0000000000
--- a/include/qapi/qmp/qint.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * QInt Module
- *
- * Copyright (C) 2009 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- */
-
-#ifndef QINT_H
-#define QINT_H
-
-#include "qapi/qmp/qobject.h"
-
-typedef struct QInt {
-    QObject base;
-    int64_t value;
-} QInt;
-
-QInt *qint_from_int(int64_t value);
-int64_t qint_get_int(const QInt *qi);
-QInt *qobject_to_qint(const QObject *obj);
-void qint_destroy_obj(QObject *obj);
-
-#endif /* QINT_H */
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 5dc4ed9616..2f2c199632 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -31,7 +31,7 @@ typedef struct QList {
=20
 /* Helpers for int, bool, and string */
 #define qlist_append_int(qlist, value) \
-        qlist_append(qlist, qint_from_int(value))
+        qlist_append(qlist, qnum_from_int(value))
 #define qlist_append_bool(qlist, value) \
         qlist_append(qlist, qbool_from_bool(value))
 #define qlist_append_str(qlist, value) \
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
new file mode 100644
index 0000000000..0e51427821
--- /dev/null
+++ b/include/qapi/qmp/qnum.h
@@ -0,0 +1,43 @@
+/*
+ * QNum Module
+ *
+ * Copyright (C) 2009 Red Hat Inc.
+ *
+ * Authors:
+ *  Luiz Capitulino <lcapitulino@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QNUM_H
+#define QNUM_H
+
+#include "qapi/qmp/qobject.h"
+
+typedef enum {
+    QNUM_I64,
+    QNUM_DOUBLE
+} QNumType;
+
+typedef struct QNum {
+    QObject base;
+    QNumType type;
+    union {
+        int64_t i64;
+        double dbl;
+    } u;
+} QNum;
+
+QNum *qnum_from_int(int64_t value);
+QNum *qnum_from_double(double value);
+
+int64_t qnum_get_int(const QNum *qi, Error **errp);
+double qnum_get_double(QNum *qn);
+
+char *qnum_to_string(QNum *qn);
+
+QNum *qobject_to_qnum(const QObject *obj);
+void qnum_destroy_obj(QObject *obj);
+
+#endif /* QNUM_H */
diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
index 27cfbd84e5..a4bc662bfb 100644
--- a/include/qapi/qmp/types.h
+++ b/include/qapi/qmp/types.h
@@ -14,8 +14,7 @@
 #define QAPI_QMP_TYPES_H
=20
 #include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qfloat.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-=
input-visitor.h
index b399285c43..5a6fe83f8f 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -30,7 +30,7 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
  * visit_type_FOO() creates an instance of QAPI type FOO.  The visited
  * QObject must match FOO.  QDict matches struct/union types, QList
  * matches list types, QString matches type 'str' and enumeration
- * types, QInt matches integer types, QFloat matches type 'number',
+ * types, QNum matches integer and float types,
  * QBool matches type 'bool'.  Type 'any' is matched by QObject.  A
  * QAPI alternate type is matched when one of its member types is.
  *
diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject=
-output-visitor.h
index 9b990c318e..e5a3490812 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -28,10 +28,10 @@ typedef struct QObjectOutputVisitor QObjectOutputVisi=
tor;
  *
  * visit_type_FOO() creates a QObject for QAPI type FOO.  It creates a
  * QDict for struct/union types, a QList for list types, QString for
- * type 'str' and enumeration types, QInt for integer types, QFloat
- * for type 'number', QBool for type 'bool'.  For type 'any', it
- * increments the QObject's reference count.  For QAPI alternate
- * types, it creates the QObject for the member that is in use.
+ * type 'str' and enumeration types, QNum for integer and float
+ * types, QBool for type 'bool'.  For type 'any', it increments the
+ * QObject's reference count.  For QAPI alternate types, it creates
+ * the QObject for the member that is in use.
  *
  * visit_start_struct() ... visit_end_struct() visits a QAPI
  * struct/union and creates a QDict.  Visits in between visit the
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 3c088934db..b3032c3ad7 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -30,7 +30,6 @@
 #include "qemu/module.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/qtest.h"
=20
diff --git a/block/nbd.c b/block/nbd.c
index 975faab2c5..e946ea944d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -37,7 +37,6 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
=20
diff --git a/block/nfs.c b/block/nfs.c
index 848b2c0bb0..decefd15f1 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -36,7 +36,6 @@
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..2050df29e4 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -595,9 +595,11 @@ static void dump_qobject(fprintf_function func_fprin=
tf, void *f,
                          int comp_indent, QObject *obj)
 {
     switch (qobject_type(obj)) {
-        case QTYPE_QINT: {
-            QInt *value =3D qobject_to_qint(obj);
-            func_fprintf(f, "%" PRId64, qint_get_int(value));
+        case QTYPE_QNUM: {
+            QNum *value =3D qobject_to_qnum(obj);
+            char *tmp =3D qnum_to_string(value);
+            func_fprintf(f, "%s", tmp);
+            g_free(tmp);
             break;
         }
         case QTYPE_QSTRING: {
@@ -615,11 +617,6 @@ static void dump_qobject(fprintf_function func_fprin=
tf, void *f,
             dump_qlist(func_fprintf, f, comp_indent, value);
             break;
         }
-        case QTYPE_QFLOAT: {
-            QFloat *value =3D qobject_to_qfloat(obj);
-            func_fprintf(f, "%g", qfloat_get_double(value));
-            break;
-        }
         case QTYPE_QBOOL: {
             QBool *value =3D qobject_to_qbool(obj);
             func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "fals=
e");
diff --git a/block/quorum.c b/block/quorum.c
index 1b2a8c3937..55ba916655 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -19,7 +19,6 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a1ca..dea9000bdd 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -16,7 +16,6 @@
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
diff --git a/block/ssh.c b/block/ssh.c
index 11203fc5a2..bac3453c3e 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,7 +34,6 @@
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
 #include "qapi-visit.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index 9c82371360..6089bba774 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -29,7 +29,6 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "migration/migration.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
diff --git a/blockdev.c b/blockdev.c
index 0b38c3df71..ed9b839dd2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -334,8 +334,9 @@ static bool parse_stats_intervals(BlockAcctStats *sta=
ts, QList *intervals,
             break;
         }
=20
-        case QTYPE_QINT: {
-            int64_t length =3D qint_get_int(qobject_to_qint(entry->value=
));
+        case QTYPE_QNUM: {
+            int64_t length =3D qnum_get_int(qobject_to_qnum(entry->value=
),
+                                          &error_abort);
             if (length > 0 && length <=3D UINT_MAX) {
                 block_acct_add_interval(stats, (unsigned) length);
             } else {
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2b0f3e1bfb..3a531a4416 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -37,7 +37,6 @@
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qint.h"
=20
 //#define DEBUG
=20
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108577..ec3ae7fa85 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -57,7 +57,6 @@
=20
 #include "hw/acpi/aml-build.h"
=20
-#include "qapi/qmp/qint.h"
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
@@ -150,21 +149,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
     if (o) {
-        pm->s3_disabled =3D qint_get_int(qobject_to_qint(o));
+        pm->s3_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
     } else {
         pm->s3_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
     if (o) {
-        pm->s4_disabled =3D qint_get_int(qobject_to_qint(o));
+        pm->s4_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
     } else {
         pm->s4_disabled =3D false;
     }
     qobject_decref(o);
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
     if (o) {
-        pm->s4_val =3D qint_get_int(qobject_to_qint(o));
+        pm->s4_val =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
     } else {
         pm->s4_val =3D false;
     }
@@ -500,7 +499,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
     if (bsel) {
-        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
+        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
=20
         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
         notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);
@@ -610,7 +609,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
=20
     /* If bus supports hotplug select it and notify about local events *=
/
     if (bsel) {
-        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
+        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
         aml_append(method,
             aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)
@@ -2586,12 +2585,12 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     if (!o) {
         return false;
     }
-    mcfg->mcfg_base =3D qint_get_int(qobject_to_qint(o));
+    mcfg->mcfg_base =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
     qobject_decref(o);
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
     assert(o);
-    mcfg->mcfg_size =3D qint_get_int(qobject_to_qint(o));
+    mcfg->mcfg_size =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
     qobject_decref(o);
     return true;
 }
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index fe62183fe3..584a6f2442 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,7 +30,6 @@
 #include "hw/xen/xen_backend.h"
 #include "monitor/qdev.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
=20
 #include "hw/xen/io/ring.h"
diff --git a/monitor.c b/monitor.c
index 078cba5c86..7a640f0f65 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2972,7 +2972,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     monitor_printf(mon, "Unknown unit suffix\n");
                     goto fail;
                 }
-                qdict_put(qdict, key, qfloat_from_double(val));
+                qdict_put(qdict, key, qnum_from_double(val));
             }
             break;
         case 'b':
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index d0f0002317..78425a4369 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -377,9 +377,6 @@ static void qobject_input_start_alternate(Visitor *v,=
 const char *name,
     }
     *obj =3D g_malloc0(size);
     (*obj)->type =3D qobject_type(qobj);
-    if (promote_int && (*obj)->type =3D=3D QTYPE_QINT) {
-        (*obj)->type =3D QTYPE_QFLOAT;
-    }
 }
=20
 static void qobject_input_type_int64(Visitor *v, const char *name, int64=
_t *obj,
@@ -387,19 +384,19 @@ static void qobject_input_type_int64(Visitor *v, co=
nst char *name, int64_t *obj,
 {
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
-    QInt *qint;
+    QNum *qnum;
=20
     if (!qobj) {
         return;
     }
-    qint =3D qobject_to_qint(qobj);
-    if (!qint) {
+    qnum =3D qobject_to_qnum(qobj);
+    if (!qnum) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "integer");
         return;
     }
=20
-    *obj =3D qint_get_int(qint);
+    *obj =3D qnum_get_int(qnum, errp);
 }
=20
=20
@@ -423,22 +420,22 @@ static void qobject_input_type_int64_keyval(Visitor=
 *v, const char *name,
 static void qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
-    /* FIXME: qobject_to_qint mishandles values over INT64_MAX */
+    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
-    QInt *qint;
+    QNum *qnum;
=20
     if (!qobj) {
         return;
     }
-    qint =3D qobject_to_qint(qobj);
-    if (!qint) {
+    qnum =3D qobject_to_qnum(qobj);
+    if (!qnum) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "integer");
         return;
     }
=20
-    *obj =3D qint_get_int(qint);
+    *obj =3D qnum_get_int(qnum, errp);
 }
=20
 static void qobject_input_type_uint64_keyval(Visitor *v, const char *nam=
e,
@@ -533,21 +530,14 @@ static void qobject_input_type_number(Visitor *v, c=
onst char *name, double *obj,
 {
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
-    QInt *qint;
-    QFloat *qfloat;
+    QNum *qnum;
=20
     if (!qobj) {
         return;
     }
-    qint =3D qobject_to_qint(qobj);
-    if (qint) {
-        *obj =3D qint_get_int(qobject_to_qint(qobj));
-        return;
-    }
-
-    qfloat =3D qobject_to_qfloat(qobj);
-    if (qfloat) {
-        *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
+    qnum =3D qobject_to_qnum(qobj);
+    if (qnum) {
+        *obj =3D qnum_get_double(qnum);
         return;
     }
=20
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 871127079d..2ca5093b22 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -144,7 +144,7 @@ static void qobject_output_type_int64(Visitor *v, con=
st char *name,
                                       int64_t *obj, Error **errp)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_output_add(qov, name, qint_from_int(*obj));
+    qobject_output_add(qov, name, qnum_from_int(*obj));
 }
=20
 static void qobject_output_type_uint64(Visitor *v, const char *name,
@@ -152,7 +152,7 @@ static void qobject_output_type_uint64(Visitor *v, co=
nst char *name,
 {
     /* FIXME values larger than INT64_MAX become negative */
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_output_add(qov, name, qint_from_int(*obj));
+    qobject_output_add(qov, name, qnum_from_int(*obj));
 }
=20
 static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
@@ -177,7 +177,7 @@ static void qobject_output_type_number(Visitor *v, co=
nst char *name,
                                        double *obj, Error **errp)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_output_add(qov, name, qfloat_from_double(*obj));
+    qobject_output_add(qov, name, qnum_from_double(*obj));
 }
=20
 static void qobject_output_type_any(Visitor *v, const char *name,
diff --git a/qga/commands.c b/qga/commands.c
index 3333ed50b2..ff89e805cf 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -485,7 +485,7 @@ int ga_parse_whence(GuestFileWhence *whence, Error **=
errp)
 {
     /* Exploit the fact that we picked values to match QGA_SEEK_*. */
     if (whence->type =3D=3D QTYPE_QSTRING) {
-        whence->type =3D QTYPE_QINT;
+        whence->type =3D QTYPE_QNUM;
         whence->u.value =3D whence->u.name;
     }
     switch (whence->u.value) {
diff --git a/qga/main.c b/qga/main.c
index cc58d2b53d..405c1290f8 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -19,7 +19,6 @@
 #endif
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qjson.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index c18e48ab94..f431854ba1 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -466,16 +466,16 @@ static QObject *parse_escape(JSONParserContext *ctx=
t, va_list *ap)
     } else if (!strcmp(token->str, "%i")) {
         return QOBJECT(qbool_from_bool(va_arg(*ap, int)));
     } else if (!strcmp(token->str, "%d")) {
-        return QOBJECT(qint_from_int(va_arg(*ap, int)));
+        return QOBJECT(qnum_from_int(va_arg(*ap, int)));
     } else if (!strcmp(token->str, "%ld")) {
-        return QOBJECT(qint_from_int(va_arg(*ap, long)));
+        return QOBJECT(qnum_from_int(va_arg(*ap, long)));
     } else if (!strcmp(token->str, "%lld") ||
                !strcmp(token->str, "%I64d")) {
-        return QOBJECT(qint_from_int(va_arg(*ap, long long)));
+        return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
     } else if (!strcmp(token->str, "%s")) {
         return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
     } else if (!strcmp(token->str, "%f")) {
-        return QOBJECT(qfloat_from_double(va_arg(*ap, double)));
+        return QOBJECT(qnum_from_double(va_arg(*ap, double)));
     }
     return NULL;
 }
@@ -494,12 +494,12 @@ static QObject *parse_literal(JSONParserContext *ct=
xt)
         /* A possibility exists that this is a whole-valued float where =
the
          * fractional part was left out due to being 0 (.0). It's not a =
big
          * deal to treat these as ints in the parser, so long as users o=
f the
-         * resulting QObject know to expect a QInt in place of a QFloat =
in
+         * resulting QObject know to expect a QNum in place of a QNum in
          * cases like these.
          *
          * However, in some cases these values will overflow/underflow a
-         * QInt/int64 container, thus we should assume these are to be h=
andled
-         * as QFloats/doubles rather than silently changing their values=
.
+         * QNum/int64 container, thus we should assume these are to be h=
andled
+         * as QNums/doubles rather than silently changing their values.
          *
          * strtoll() indicates these instances by setting errno to ERANG=
E
          */
@@ -508,7 +508,7 @@ static QObject *parse_literal(JSONParserContext *ctxt=
)
         errno =3D 0; /* strtoll doesn't set errno on success */
         value =3D strtoll(token->str, NULL, 10);
         if (errno !=3D ERANGE) {
-            return QOBJECT(qint_from_int(value));
+            return QOBJECT(qnum_from_int(value));
         }
         /* fall through to JSON_FLOAT */
     }
@@ -516,7 +516,7 @@ static QObject *parse_literal(JSONParserContext *ctxt=
)
         /* FIXME dependent on locale; a pervasive issue in QEMU */
         /* FIXME our lexer matches RFC 7159 in forbidding Inf or NaN,
          * but those might be useful extensions beyond JSON */
-        return QOBJECT(qfloat_from_double(strtod(token->str, NULL)));
+        return QOBJECT(qnum_from_double(strtod(token->str, NULL)));
     default:
         abort();
     }
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 88e2ecd658..ad5bab9572 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -11,8 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qfloat.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
@@ -180,37 +179,26 @@ size_t qdict_size(const QDict *qdict)
 /**
  * qdict_get_double(): Get an number mapped by 'key'
  *
- * This function assumes that 'key' exists and it stores a
- * QFloat or QInt object.
+ * This function assumes that 'key' exists and it stores a QNum.
  *
  * Return number mapped by 'key'.
  */
 double qdict_get_double(const QDict *qdict, const char *key)
 {
-    QObject *obj =3D qdict_get(qdict, key);
-
-    assert(obj);
-    switch (qobject_type(obj)) {
-    case QTYPE_QFLOAT:
-        return qfloat_get_double(qobject_to_qfloat(obj));
-    case QTYPE_QINT:
-        return qint_get_int(qobject_to_qint(obj));
-    default:
-        abort();
-    }
+    return qnum_get_double(qobject_to_qnum(qdict_get(qdict, key)));
 }
=20
 /**
  * qdict_get_int(): Get an integer mapped by 'key'
  *
  * This function assumes that 'key' exists and it stores a
- * QInt object.
+ * QNum representable as int.
  *
  * Return integer mapped by 'key'.
  */
 int64_t qdict_get_int(const QDict *qdict, const char *key)
 {
-    return qint_get_int(qobject_to_qint(qdict_get(qdict, key)));
+    return qnum_get_int(qobject_to_qnum(qdict_get(qdict, key)), &error_a=
bort);
 }
=20
 /**
@@ -260,15 +248,25 @@ const char *qdict_get_str(const QDict *qdict, const=
 char *key)
  * qdict_get_try_int(): Try to get integer mapped by 'key'
  *
  * Return integer mapped by 'key', if it is not present in
- * the dictionary or if the stored object is not of QInt type
+ * the dictionary or if the stored object is not of QNum type
  * 'def_value' will be returned.
  */
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value)
 {
-    QInt *qint =3D qobject_to_qint(qdict_get(qdict, key));
+    Error *err =3D NULL;
+    QNum *qnum =3D qobject_to_qnum(qdict_get(qdict, key));
+    int64_t val =3D def_value;
+
+    if (qnum) {
+        val =3D qnum_get_int(qnum, &err);
+    }
+    if (err) {
+        error_free(err);
+        val =3D def_value;
+    }
=20
-    return qint ? qint_get_int(qint) : def_value;
+    return val;
 }
=20
 /**
diff --git a/qobject/qfloat.c b/qobject/qfloat.c
deleted file mode 100644
index d5da847701..0000000000
--- a/qobject/qfloat.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * QFloat Module
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "qapi/qmp/qfloat.h"
-#include "qapi/qmp/qobject.h"
-#include "qemu-common.h"
-
-/**
- * qfloat_from_int(): Create a new QFloat from a float
- *
- * Return strong reference.
- */
-QFloat *qfloat_from_double(double value)
-{
-    QFloat *qf;
-
-    qf =3D g_malloc(sizeof(*qf));
-    qobject_init(QOBJECT(qf), QTYPE_QFLOAT);
-    qf->value =3D value;
-
-    return qf;
-}
-
-/**
- * qfloat_get_double(): Get the stored float
- */
-double qfloat_get_double(const QFloat *qf)
-{
-    return qf->value;
-}
-
-/**
- * qobject_to_qfloat(): Convert a QObject into a QFloat
- */
-QFloat *qobject_to_qfloat(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) !=3D QTYPE_QFLOAT) {
-        return NULL;
-    }
-    return container_of(obj, QFloat, base);
-}
-
-/**
- * qfloat_destroy_obj(): Free all memory allocated by a
- * QFloat object
- */
-void qfloat_destroy_obj(QObject *obj)
-{
-    assert(obj !=3D NULL);
-    g_free(qobject_to_qfloat(obj));
-}
diff --git a/qobject/qint.c b/qobject/qint.c
deleted file mode 100644
index d7d1b3021f..0000000000
--- a/qobject/qint.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * QInt Module
- *
- * Copyright (C) 2009 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qobject.h"
-#include "qemu-common.h"
-
-/**
- * qint_from_int(): Create a new QInt from an int64_t
- *
- * Return strong reference.
- */
-QInt *qint_from_int(int64_t value)
-{
-    QInt *qi;
-
-    qi =3D g_malloc(sizeof(*qi));
-    qobject_init(QOBJECT(qi), QTYPE_QINT);
-    qi->value =3D value;
-
-    return qi;
-}
-
-/**
- * qint_get_int(): Get the stored integer
- */
-int64_t qint_get_int(const QInt *qi)
-{
-    return qi->value;
-}
-
-/**
- * qobject_to_qint(): Convert a QObject into a QInt
- */
-QInt *qobject_to_qint(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) !=3D QTYPE_QINT) {
-        return NULL;
-    }
-    return container_of(obj, QInt, base);
-}
-
-/**
- * qint_destroy_obj(): Free all memory allocated by a
- * QInt object
- */
-void qint_destroy_obj(QObject *obj)
-{
-    assert(obj !=3D NULL);
-    g_free(qobject_to_qint(obj));
-}
diff --git a/qobject/qjson.c b/qobject/qjson.c
index b2f3bfec53..2e0930884e 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -132,12 +132,11 @@ static void to_json(const QObject *obj, QString *st=
r, int pretty, int indent)
     case QTYPE_QNULL:
         qstring_append(str, "null");
         break;
-    case QTYPE_QINT: {
-        QInt *val =3D qobject_to_qint(obj);
-        char buffer[1024];
-
-        snprintf(buffer, sizeof(buffer), "%" PRId64, qint_get_int(val));
+    case QTYPE_QNUM: {
+        QNum *val =3D qobject_to_qnum(obj);
+        char *buffer =3D qnum_to_string(val);
         qstring_append(str, buffer);
+        g_free(buffer);
         break;
     }
     case QTYPE_QSTRING: {
@@ -234,34 +233,6 @@ static void to_json(const QObject *obj, QString *str=
, int pretty, int indent)
         qstring_append(str, "]");
         break;
     }
-    case QTYPE_QFLOAT: {
-        QFloat *val =3D qobject_to_qfloat(obj);
-        char buffer[1024];
-        int len;
-
-        /* FIXME: snprintf() is locale dependent; but JSON requires
-         * numbers to be formatted as if in the C locale. Dependence
-         * on C locale is a pervasive issue in QEMU. */
-        /* FIXME: This risks printing Inf or NaN, which are not valid
-         * JSON values. */
-        /* FIXME: the default precision of 6 for %f often causes
-         * rounding errors; we should be using DBL_DECIMAL_DIG (17),
-         * and only rounding to a shorter number if the result would
-         * still produce the same floating point value.  */
-        len =3D snprintf(buffer, sizeof(buffer), "%f", qfloat_get_double=
(val));
-        while (len > 0 && buffer[len - 1] =3D=3D '0') {
-            len--;
-        }
-
-        if (len && buffer[len - 1] =3D=3D '.') {
-            buffer[len - 1] =3D 0;
-        } else {
-            buffer[len] =3D 0;
-        }
-
-        qstring_append(str, buffer);
-        break;
-    }
     case QTYPE_QBOOL: {
         QBool *val =3D qobject_to_qbool(obj);
=20
diff --git a/qobject/qnum.c b/qobject/qnum.c
new file mode 100644
index 0000000000..8e9dd38350
--- /dev/null
+++ b/qobject/qnum.c
@@ -0,0 +1,138 @@
+/*
+ * QNum Module
+ *
+ * Copyright (C) 2009 Red Hat Inc.
+ *
+ * Authors:
+ *  Luiz Capitulino <lcapitulino@redhat.com>
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu-common.h"
+
+/**
+ * qnum_from_int(): Create a new QNum from an int64_t
+ *
+ * Return strong reference.
+ */
+QNum *qnum_from_int(int64_t value)
+{
+    QNum *qn =3D g_new(QNum, 1);
+
+    qobject_init(QOBJECT(qn), QTYPE_QNUM);
+    qn->type =3D QNUM_I64;
+    qn->u.i64 =3D value;
+
+    return qn;
+}
+
+/**
+ * qnum_from_double(): Create a new QNum from a double
+ *
+ * Return strong reference.
+ */
+QNum *qnum_from_double(double value)
+{
+    QNum *qn =3D g_new(QNum, 1);
+
+    qobject_init(QOBJECT(qn), QTYPE_QNUM);
+    qn->type =3D QNUM_DOUBLE;
+    qn->u.dbl =3D value;
+
+    return qn;
+}
+
+/**
+ * qnum_get_int(): Get an integer representation of the number
+ */
+int64_t qnum_get_int(const QNum *qn, Error **errp)
+{
+    switch (qn->type) {
+    case QNUM_I64:
+        return qn->u.i64;
+    case QNUM_DOUBLE:
+        error_setg(errp, "The number is a float");
+        return 0;
+    }
+
+    g_assert_not_reached();
+}
+
+/**
+ * qnum_get_double(): Get a float representation of the number
+ */
+double qnum_get_double(QNum *qn)
+{
+    switch (qn->type) {
+    case QNUM_I64:
+        return qn->u.i64;
+    case QNUM_DOUBLE:
+        return qn->u.dbl;
+    }
+
+    g_assert_not_reached();
+}
+
+char *qnum_to_string(QNum *qn)
+{
+    char *buffer;
+    int len;
+
+    switch (qn->type) {
+    case QNUM_I64:
+        return g_strdup_printf("%" PRId64, qn->u.i64);
+    case QNUM_DOUBLE:
+        /* FIXME: snprintf() is locale dependent; but JSON requires
+         * numbers to be formatted as if in the C locale. Dependence
+         * on C locale is a pervasive issue in QEMU. */
+        /* FIXME: This risks printing Inf or NaN, which are not valid
+         * JSON values. */
+        /* FIXME: the default precision of 6 for %f often causes
+         * rounding errors; we should be using DBL_DECIMAL_DIG (17),
+         * and only rounding to a shorter number if the result would
+         * still produce the same floating point value.  */
+        buffer =3D g_strdup_printf("%f" , qn->u.dbl);
+        len =3D strlen(buffer);
+        while (len > 0 && buffer[len - 1] =3D=3D '0') {
+            len--;
+        }
+
+        if (len && buffer[len - 1] =3D=3D '.') {
+            buffer[len - 1] =3D 0;
+        } else {
+            buffer[len] =3D 0;
+        }
+
+        return buffer;
+    }
+
+    g_assert_not_reached();
+}
+
+/**
+ * qobject_to_qnum(): Convert a QObject into a QNum
+ */
+QNum *qobject_to_qnum(const QObject *obj)
+{
+    if (!obj || qobject_type(obj) !=3D QTYPE_QNUM) {
+        return NULL;
+    }
+    return container_of(obj, QNum, base);
+}
+
+/**
+ * qnum_destroy_obj(): Free all memory allocated by a
+ * QNum object
+ */
+void qnum_destroy_obj(QObject *obj)
+{
+    assert(obj !=3D NULL);
+    g_free(qobject_to_qnum(obj));
+}
diff --git a/qobject/qobject.c b/qobject/qobject.c
index fe4fa10989..b0cafb66f1 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -14,11 +14,10 @@
 static void (*qdestroy[QTYPE__MAX])(QObject *) =3D {
     [QTYPE_NONE] =3D NULL,               /* No such object exists */
     [QTYPE_QNULL] =3D NULL,              /* qnull_ is indestructible */
-    [QTYPE_QINT] =3D qint_destroy_obj,
+    [QTYPE_QNUM] =3D qnum_destroy_obj,
     [QTYPE_QSTRING] =3D qstring_destroy_obj,
     [QTYPE_QDICT] =3D qdict_destroy_obj,
     [QTYPE_QLIST] =3D qlist_destroy_obj,
-    [QTYPE_QFLOAT] =3D qfloat_destroy_obj,
     [QTYPE_QBOOL] =3D qbool_destroy_obj,
 };
=20
diff --git a/qom/object.c b/qom/object.c
index c7b8079df6..c1644dbcb7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -27,7 +27,6 @@
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
=20
 #define MAX_INTERFACES 32
@@ -1190,28 +1189,32 @@ bool object_property_get_bool(Object *obj, const =
char *name,
 void object_property_set_int(Object *obj, int64_t value,
                              const char *name, Error **errp)
 {
-    QInt *qint =3D qint_from_int(value);
-    object_property_set_qobject(obj, QOBJECT(qint), name, errp);
+    QNum *qnum =3D qnum_from_int(value);
+    object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
=20
-    QDECREF(qint);
+    QDECREF(qnum);
 }
=20
 int64_t object_property_get_int(Object *obj, const char *name,
                                 Error **errp)
 {
     QObject *ret =3D object_property_get_qobject(obj, name, errp);
-    QInt *qint;
+    Error *err =3D NULL;
+    QNum *qnum;
     int64_t retval;
=20
     if (!ret) {
         return -1;
     }
-    qint =3D qobject_to_qint(ret);
-    if (!qint) {
+    qnum =3D qobject_to_qnum(ret);
+    if (qnum) {
+        retval =3D qnum_get_int(qnum, &err);
+    }
+
+    if (!qnum || err) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "int");
+        error_free(err);
         retval =3D -1;
-    } else {
-        retval =3D qint_get_int(qint);
     }
=20
     qobject_decref(ret);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985f11..1e8a5b55c0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -29,11 +29,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qfloat.h"
+#include "qapi/qmp/types.h"
=20
 #include "qapi-types.h"
 #include "qapi-visit.h"
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index be8d81f07b..bcd06a7d6b 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -11,7 +11,6 @@
  */
 #include "qemu/osdep.h"
=20
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
@@ -39,7 +38,7 @@ static void qdict_new_test(void)
=20
 static void qdict_put_obj_test(void)
 {
-    QInt *qi;
+    QNum *qi;
     QDict *qdict;
     QDictEntry *ent;
     const int num =3D 42;
@@ -51,8 +50,8 @@ static void qdict_put_obj_test(void)
=20
     g_assert(qdict_size(qdict) =3D=3D 1);
     ent =3D QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
-    qi =3D qobject_to_qint(ent->value);
-    g_assert(qint_get_int(qi) =3D=3D num);
+    qi =3D qobject_to_qnum(ent->value);
+    g_assert(qnum_get_int(qi, &error_abort) =3D=3D num);
=20
     // destroy doesn't exit yet
     QDECREF(qi);
@@ -74,7 +73,7 @@ static void qdict_destroy_simple_test(void)
=20
 static void qdict_get_test(void)
 {
-    QInt *qi;
+    QNum *qi;
     QObject *obj;
     const int value =3D -42;
     const char *key =3D "test";
@@ -85,8 +84,8 @@ static void qdict_get_test(void)
     obj =3D qdict_get(tests_dict, key);
     g_assert(obj !=3D NULL);
=20
-    qi =3D qobject_to_qint(obj);
-    g_assert(qint_get_int(qi) =3D=3D value);
+    qi =3D qobject_to_qnum(obj);
+    g_assert(qnum_get_int(qi, &error_abort) =3D=3D value);
=20
     QDECREF(tests_dict);
 }
@@ -329,7 +328,7 @@ static void qdict_array_split_test(void)
 {
     QDict *test_dict =3D qdict_new();
     QDict *dict1, *dict2;
-    QInt *int1;
+    QNum *int1;
     QList *test_list;
=20
     /*
@@ -380,7 +379,7 @@ static void qdict_array_split_test(void)
=20
     dict1 =3D qobject_to_qdict(qlist_pop(test_list));
     dict2 =3D qobject_to_qdict(qlist_pop(test_list));
-    int1 =3D qobject_to_qint(qlist_pop(test_list));
+    int1 =3D qobject_to_qnum(qlist_pop(test_list));
=20
     g_assert(dict1);
     g_assert(dict2);
@@ -402,7 +401,7 @@ static void qdict_array_split_test(void)
=20
     QDECREF(dict2);
=20
-    g_assert(qint_get_int(int1) =3D=3D 66);
+    g_assert(qnum_get_int(int1, &error_abort) =3D=3D 66);
=20
     QDECREF(int1);
=20
@@ -447,14 +446,14 @@ static void qdict_array_split_test(void)
=20
     qdict_array_split(test_dict, &test_list);
=20
-    int1 =3D qobject_to_qint(qlist_pop(test_list));
+    int1 =3D qobject_to_qnum(qlist_pop(test_list));
=20
     g_assert(int1);
     g_assert(qlist_empty(test_list));
=20
     QDECREF(test_list);
=20
-    g_assert(qint_get_int(int1) =3D=3D 42);
+    g_assert(qnum_get_int(int1, &error_abort) =3D=3D 42);
=20
     QDECREF(int1);
=20
diff --git a/tests/check-qfloat.c b/tests/check-qfloat.c
deleted file mode 100644
index 1da2cdae08..0000000000
--- a/tests/check-qfloat.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * QFloat unit-tests.
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-
-#include "qapi/qmp/qfloat.h"
-#include "qemu-common.h"
-
-/*
- * Public Interface test-cases
- *
- * (with some violations to access 'private' data)
- */
-
-static void qfloat_from_double_test(void)
-{
-    QFloat *qf;
-    const double value =3D -42.23423;
-
-    qf =3D qfloat_from_double(value);
-    g_assert(qf !=3D NULL);
-    g_assert(qf->value =3D=3D value);
-    g_assert(qf->base.refcnt =3D=3D 1);
-    g_assert(qobject_type(QOBJECT(qf)) =3D=3D QTYPE_QFLOAT);
-
-    // destroy doesn't exit yet
-    g_free(qf);
-}
-
-static void qfloat_destroy_test(void)
-{
-    QFloat *qf =3D qfloat_from_double(0.0);
-    QDECREF(qf);
-}
-
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-
-    g_test_add_func("/public/from_double", qfloat_from_double_test);
-    g_test_add_func("/public/destroy", qfloat_destroy_test);
-
-    return g_test_run();
-}
diff --git a/tests/check-qint.c b/tests/check-qint.c
deleted file mode 100644
index b6e4555115..0000000000
--- a/tests/check-qint.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * QInt unit-tests.
- *
- * Copyright (C) 2009 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- */
-#include "qemu/osdep.h"
-
-#include "qapi/qmp/qint.h"
-#include "qemu-common.h"
-
-/*
- * Public Interface test-cases
- *
- * (with some violations to access 'private' data)
- */
-
-static void qint_from_int_test(void)
-{
-    QInt *qi;
-    const int value =3D -42;
-
-    qi =3D qint_from_int(value);
-    g_assert(qi !=3D NULL);
-    g_assert(qi->value =3D=3D value);
-    g_assert(qi->base.refcnt =3D=3D 1);
-    g_assert(qobject_type(QOBJECT(qi)) =3D=3D QTYPE_QINT);
-
-    // destroy doesn't exit yet
-    g_free(qi);
-}
-
-static void qint_destroy_test(void)
-{
-    QInt *qi =3D qint_from_int(0);
-    QDECREF(qi);
-}
-
-static void qint_from_int64_test(void)
-{
-    QInt *qi;
-    const int64_t value =3D 0x1234567890abcdefLL;
-
-    qi =3D qint_from_int(value);
-    g_assert((int64_t) qi->value =3D=3D value);
-
-    QDECREF(qi);
-}
-
-static void qint_get_int_test(void)
-{
-    QInt *qi;
-    const int value =3D 123456;
-
-    qi =3D qint_from_int(value);
-    g_assert(qint_get_int(qi) =3D=3D value);
-
-    QDECREF(qi);
-}
-
-static void qobject_to_qint_test(void)
-{
-    QInt *qi;
-
-    qi =3D qint_from_int(0);
-    g_assert(qobject_to_qint(QOBJECT(qi)) =3D=3D qi);
-
-    QDECREF(qi);
-}
-
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-
-    g_test_add_func("/public/from_int", qint_from_int_test);
-    g_test_add_func("/public/destroy", qint_destroy_test);
-    g_test_add_func("/public/from_int64", qint_from_int64_test);
-    g_test_add_func("/public/get_int", qint_get_int_test);
-    g_test_add_func("/public/to_qint", qobject_to_qint_test);
-
-    return g_test_run();
-}
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 963dd46f07..c432aebf13 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -886,21 +886,21 @@ static void simple_number(void)
     };
=20
     for (i =3D 0; test_cases[i].encoded; i++) {
-        QInt *qint;
+        QNum *qnum;
=20
-        qint =3D qobject_to_qint(qobject_from_json(test_cases[i].encoded=
,
+        qnum =3D qobject_to_qnum(qobject_from_json(test_cases[i].encoded=
,
                                                  &error_abort));
-        g_assert(qint);
-        g_assert(qint_get_int(qint) =3D=3D test_cases[i].decoded);
+        g_assert(qnum);
+        g_assert(qnum_get_int(qnum, &error_abort) =3D=3D test_cases[i].d=
ecoded);
         if (test_cases[i].skip =3D=3D 0) {
             QString *str;
=20
-            str =3D qobject_to_json(QOBJECT(qint));
+            str =3D qobject_to_json(QOBJECT(qnum));
             g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded)=
 =3D=3D 0);
             QDECREF(str);
         }
=20
-        QDECREF(qint);
+        QDECREF(qnum);
     }
 }
=20
@@ -921,12 +921,12 @@ static void float_number(void)
=20
     for (i =3D 0; test_cases[i].encoded; i++) {
         QObject *obj;
-        QFloat *qfloat;
+        QNum *qnum;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        qfloat =3D qobject_to_qfloat(obj);
-        g_assert(qfloat);
-        g_assert(qfloat_get_double(qfloat) =3D=3D test_cases[i].decoded)=
;
+        qnum =3D qobject_to_qnum(obj);
+        g_assert(qnum);
+        g_assert(qnum_get_double(qnum) =3D=3D test_cases[i].decoded);
=20
         if (test_cases[i].skip =3D=3D 0) {
             QString *str;
@@ -936,29 +936,28 @@ static void float_number(void)
             QDECREF(str);
         }
=20
-        QDECREF(qfloat);
+        QDECREF(qnum);
     }
 }
=20
 static void vararg_number(void)
 {
-    QInt *qint;
-    QFloat *qfloat;
+    QNum *qnum;
     int value =3D 0x2342;
     long long value_ll =3D 0x2342342343LL;
     double valuef =3D 2.323423423;
=20
-    qint =3D qobject_to_qint(qobject_from_jsonf("%d", value));
-    g_assert(qint_get_int(qint) =3D=3D value);
-    QDECREF(qint);
+    qnum =3D qobject_to_qnum(qobject_from_jsonf("%d", value));
+    g_assert(qnum_get_int(qnum, &error_abort) =3D=3D value);
+    QDECREF(qnum);
=20
-    qint =3D qobject_to_qint(qobject_from_jsonf("%lld", value_ll));
-    g_assert(qint_get_int(qint) =3D=3D value_ll);
-    QDECREF(qint);
+    qnum =3D qobject_to_qnum(qobject_from_jsonf("%lld", value_ll));
+    g_assert(qnum_get_int(qnum, &error_abort) =3D=3D value_ll);
+    QDECREF(qnum);
=20
-    qfloat =3D qobject_to_qfloat(qobject_from_jsonf("%f", valuef));
-    g_assert(qfloat_get_double(qfloat) =3D=3D valuef);
-    QDECREF(qfloat);
+    qnum =3D qobject_to_qnum(qobject_from_jsonf("%f", valuef));
+    g_assert(qnum_get_double(qnum) =3D=3D valuef);
+    QDECREF(qnum);
 }
=20
 static void keyword_literal(void)
@@ -1019,7 +1018,7 @@ struct LiteralQObject
 {
     int type;
     union {
-        int64_t qint;
+        int64_t qnum;
         const char *qstr;
         LiteralQDictEntry *qdict;
         LiteralQObject *qlist;
@@ -1032,7 +1031,7 @@ struct LiteralQDictEntry
     LiteralQObject value;
 };
=20
-#define QLIT_QINT(val) (LiteralQObject){.type =3D QTYPE_QINT, .value.qin=
t =3D (val)}
+#define QLIT_QNUM(val) (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnu=
m =3D (val)}
 #define QLIT_QSTR(val) (LiteralQObject){.type =3D QTYPE_QSTRING, .value.=
qstr =3D (val)}
 #define QLIT_QDICT(val) (LiteralQObject){.type =3D QTYPE_QDICT, .value.q=
dict =3D (val)}
 #define QLIT_QLIST(val) (LiteralQObject){.type =3D QTYPE_QLIST, .value.q=
list =3D (val)}
@@ -1069,8 +1068,9 @@ static int compare_litqobj_to_qobj(LiteralQObject *=
lhs, QObject *rhs)
     }
=20
     switch (lhs->type) {
-    case QTYPE_QINT:
-        return lhs->value.qint =3D=3D qint_get_int(qobject_to_qint(rhs))=
;
+    case QTYPE_QNUM:
+        return lhs->value.qnum =3D=3D qnum_get_int(qobject_to_qnum(rhs),
+                                               &error_abort);
     case QTYPE_QSTRING:
         return (strcmp(lhs->value.qstr, qstring_get_str(qobject_to_qstri=
ng(rhs))) =3D=3D 0);
     case QTYPE_QDICT: {
@@ -1114,7 +1114,7 @@ static void simple_dict(void)
         {
             .encoded =3D "{\"foo\": 42, \"bar\": \"hello world\"}",
             .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
-                        { "foo", QLIT_QINT(42) },
+                        { "foo", QLIT_QNUM(42) },
                         { "bar", QLIT_QSTR("hello world") },
                         { }
                     })),
@@ -1126,7 +1126,7 @@ static void simple_dict(void)
         }, {
             .encoded =3D "{\"foo\": 43}",
             .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
-                        { "foo", QLIT_QINT(43) },
+                        { "foo", QLIT_QNUM(43) },
                         { }
                     })),
         },
@@ -1212,15 +1212,15 @@ static void simple_list(void)
         {
             .encoded =3D "[43,42]",
             .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(43),
-                        QLIT_QINT(42),
+                        QLIT_QNUM(43),
+                        QLIT_QNUM(42),
                         { }
                     })),
         },
         {
             .encoded =3D "[43]",
             .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(43),
+                        QLIT_QNUM(43),
                         { }
                     })),
         },
@@ -1269,35 +1269,35 @@ static void simple_whitespace(void)
         {
             .encoded =3D " [ 43 , 42 ]",
             .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(43),
-                        QLIT_QINT(42),
+                        QLIT_QNUM(43),
+                        QLIT_QNUM(42),
                         { }
                     })),
         },
         {
             .encoded =3D " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
             .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(43),
+                        QLIT_QNUM(43),
                         QLIT_QDICT(((LiteralQDictEntry[]){
                                     { "h", QLIT_QSTR("b") },
                                     { }})),
                         QLIT_QLIST(((LiteralQObject[]){
                                     { }})),
-                        QLIT_QINT(42),
+                        QLIT_QNUM(42),
                         { }
                     })),
         },
         {
             .encoded =3D " [ 43 , { 'h' : 'b' , 'a' : 32 }, [ ], 42 ]",
             .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(43),
+                        QLIT_QNUM(43),
                         QLIT_QDICT(((LiteralQDictEntry[]){
                                     { "h", QLIT_QSTR("b") },
-                                    { "a", QLIT_QINT(32) },
+                                    { "a", QLIT_QNUM(32) },
                                     { }})),
                         QLIT_QLIST(((LiteralQObject[]){
                                     { }})),
-                        QLIT_QINT(42),
+                        QLIT_QNUM(42),
                         { }
                     })),
         },
@@ -1327,11 +1327,11 @@ static void simple_varargs(void)
     QObject *embedded_obj;
     QObject *obj;
     LiteralQObject decoded =3D QLIT_QLIST(((LiteralQObject[]){
-            QLIT_QINT(1),
-            QLIT_QINT(2),
+            QLIT_QNUM(1),
+            QLIT_QNUM(2),
             QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QINT(32),
-                        QLIT_QINT(42),
+                        QLIT_QNUM(32),
+                        QLIT_QNUM(42),
                         {}})),
             {}}));
=20
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index 4983867c27..a2d1701003 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -11,8 +11,8 @@
  */
 #include "qemu/osdep.h"
=20
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qlist.h"
+#include "qapi/error.h"
+#include "qapi/qmp/types.h"
=20
 /*
  * Public Interface test-cases
@@ -35,11 +35,11 @@ static void qlist_new_test(void)
=20
 static void qlist_append_test(void)
 {
-    QInt *qi;
+    QNum *qi;
     QList *qlist;
     QListEntry *entry;
=20
-    qi =3D qint_from_int(42);
+    qi =3D qnum_from_int(42);
=20
     qlist =3D qlist_new();
     qlist_append(qlist, qi);
@@ -84,13 +84,14 @@ static const int iter_max =3D 42;
=20
 static void iter_func(QObject *obj, void *opaque)
 {
-    QInt *qi;
+    QNum *qi;
=20
     g_assert(opaque =3D=3D NULL);
=20
-    qi =3D qobject_to_qint(obj);
+    qi =3D qobject_to_qnum(obj);
     g_assert(qi !=3D NULL);
-    g_assert((qint_get_int(qi) >=3D 0) && (qint_get_int(qi) <=3D iter_ma=
x));
+    g_assert((qnum_get_int(qi, &error_abort) >=3D 0) &&
+             (qnum_get_int(qi, &error_abort) <=3D iter_max));
=20
     iter_called++;
 }
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
new file mode 100644
index 0000000000..d08d35e85a
--- /dev/null
+++ b/tests/check-qnum.c
@@ -0,0 +1,131 @@
+/*
+ * QNum unit-tests.
+ *
+ * Copyright (C) 2009 Red Hat Inc.
+ *
+ * Authors:
+ *  Luiz Capitulino <lcapitulino@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/qmp/qnum.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+
+/*
+ * Public Interface test-cases
+ *
+ * (with some violations to access 'private' data)
+ */
+
+static void qnum_from_int_test(void)
+{
+    QNum *qi;
+    const int value =3D -42;
+
+    qi =3D qnum_from_int(value);
+    g_assert(qi !=3D NULL);
+    g_assert_cmpint(qi->u.i64, =3D=3D, value);
+    g_assert_cmpint(qi->base.refcnt, =3D=3D, 1);
+    g_assert_cmpint(qobject_type(QOBJECT(qi)), =3D=3D, QTYPE_QNUM);
+
+    // destroy doesn't exit yet
+    g_free(qi);
+}
+
+static void qnum_from_double_test(void)
+{
+    QNum *qf;
+    const double value =3D -42.23423;
+
+    qf =3D qnum_from_double(value);
+    g_assert(qf !=3D NULL);
+    g_assert_cmpfloat(qf->u.dbl, =3D=3D, value);
+    g_assert_cmpint(qf->base.refcnt, =3D=3D, 1);
+    g_assert_cmpint(qobject_type(QOBJECT(qf)), =3D=3D, QTYPE_QNUM);
+
+    // destroy doesn't exit yet
+    g_free(qf);
+}
+
+static void qnum_from_int64_test(void)
+{
+    QNum *qi;
+    const int64_t value =3D 0x1234567890abcdefLL;
+
+    qi =3D qnum_from_int(value);
+    g_assert_cmpint((int64_t) qi->u.i64, =3D=3D, value);
+
+    QDECREF(qi);
+}
+
+static void qnum_get_int_test(void)
+{
+    QNum *qi;
+    const int value =3D 123456;
+
+    qi =3D qnum_from_int(value);
+    g_assert_cmpint(qnum_get_int(qi, &error_abort), =3D=3D, value);
+
+    QDECREF(qi);
+}
+
+static void qobject_to_qnum_test(void)
+{
+    QNum *qn;
+
+    qn =3D qnum_from_int(0);
+    g_assert(qobject_to_qnum(QOBJECT(qn)) =3D=3D qn);
+    QDECREF(qn);
+
+    qn =3D qnum_from_double(0);
+    g_assert(qobject_to_qnum(QOBJECT(qn)) =3D=3D qn);
+    QDECREF(qn);
+}
+
+static void qnum_to_string_test(void)
+{
+    QNum *qn;
+    char *tmp;
+
+    qn =3D qnum_from_int(123456);
+    tmp =3D qnum_to_string(qn);
+    g_assert_cmpstr(tmp, =3D=3D, "123456");
+    g_free(tmp);
+    QDECREF(qn);
+
+    qn =3D qnum_from_double(0.42);
+    tmp =3D qnum_to_string(qn);
+    g_assert_cmpstr(tmp, =3D=3D, "0.42");
+    g_free(tmp);
+    QDECREF(qn);
+}
+
+static void qnum_destroy_test(void)
+{
+    QNum *qn;
+
+    qn =3D qnum_from_int(0);
+    QDECREF(qn);
+
+    qn =3D qnum_from_double(0.42);
+    QDECREF(qn);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/qnum/from_int", qnum_from_int_test);
+    g_test_add_func("/qnum/from_double", qnum_from_double_test);
+    g_test_add_func("/qnum/destroy", qnum_destroy_test);
+    g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
+    g_test_add_func("/qnum/get_int", qnum_get_int_test);
+    g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
+    g_test_add_func("/qnum/to_string", qnum_to_string_test);
+
+    return g_test_run();
+}
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index df0ff831b5..bec574257e 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -611,7 +611,6 @@ static void test_keyval_visit_optional(void)
=20
 static void test_keyval_visit_alternate(void)
 {
-    Error *err =3D NULL;
     Visitor *v;
     QDict *qdict;
     AltNumStr *ans;
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index acdded4d67..96a52dbca8 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -162,7 +162,7 @@ static void test_dispatch_cmd_io(void)
     QDict *ud1b =3D qdict_new();
     QDict *ret, *ret_dict, *ret_dict_dict, *ret_dict_dict_userdef;
     QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
-    QInt *ret3;
+    QNum *ret3;
=20
     qdict_put_int(ud1a, "integer", 42);
     qdict_put_str(ud1a, "string", "hello");
@@ -194,8 +194,8 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args3);
     qdict_put_str(req, "execute", "guest-get-time");
=20
-    ret3 =3D qobject_to_qint(test_qmp_dispatch(req));
-    assert(qint_get_int(ret3) =3D=3D 66);
+    ret3 =3D qobject_to_qnum(test_qmp_dispatch(req));
+    assert(qnum_get_int(ret3, &error_abort) =3D=3D 66);
     QDECREF(ret3);
=20
     QDECREF(req);
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 4c0f09601d..e996bebc6e 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -18,7 +18,6 @@
 #include "test-qapi-visit.h"
 #include "test-qapi-event.h"
 #include "qapi/qmp/types.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp-event.h"
=20
@@ -62,9 +61,9 @@ void qdict_cmp_do_simple(const char *key, QObject *obj1=
, void *opaque)
         d->result =3D (qbool_get_bool(qobject_to_qbool(obj1)) =3D=3D
                      qbool_get_bool(qobject_to_qbool(obj2)));
         return;
-    case QTYPE_QINT:
-        d->result =3D (qint_get_int(qobject_to_qint(obj1)) =3D=3D
-                     qint_get_int(qobject_to_qint(obj2)));
+    case QTYPE_QNUM:
+        d->result =3D (qnum_get_int(qobject_to_qnum(obj1), &error_abort)=
 =3D=3D
+                     qnum_get_int(qobject_to_qnum(obj2), &error_abort));
         return;
     case QTYPE_QSTRING:
         d->result =3D g_strcmp0(qstring_get_str(qobject_to_qstring(obj1)=
),
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index a30e2d5e95..4484980969 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -152,7 +152,7 @@ static void test_visitor_in_int_overflow(TestInputVis=
itorData *data,
     Visitor *v;
=20
     /* this will overflow a Qint/int64, so should be deserialized into
-     * a QFloat/double field instead, leading to an error if we pass it
+     * a QNum/double field instead, leading to an error if we pass it
      * to visit_type_int. confirm this.
      */
     v =3D visitor_input_test_init(data, "%f", DBL_MAX);
@@ -428,7 +428,7 @@ static void test_visitor_in_any(TestInputVisitorData =
*data,
 {
     QObject *res =3D NULL;
     Visitor *v;
-    QInt *qint;
+    QNum *qnum;
     QBool *qbool;
     QString *qstring;
     QDict *qdict;
@@ -436,9 +436,9 @@ static void test_visitor_in_any(TestInputVisitorData =
*data,
=20
     v =3D visitor_input_test_init(data, "-42");
     visit_type_any(v, NULL, &res, &error_abort);
-    qint =3D qobject_to_qint(res);
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
+    qnum =3D qobject_to_qnum(res);
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
     qobject_decref(res);
=20
     v =3D visitor_input_test_init(data, "{ 'integer': -42, 'boolean': tr=
ue, 'string': 'foo' }");
@@ -447,9 +447,9 @@ static void test_visitor_in_any(TestInputVisitorData =
*data,
     g_assert(qdict && qdict_size(qdict) =3D=3D 3);
     qobj =3D qdict_get(qdict, "integer");
     g_assert(qobj);
-    qint =3D qobject_to_qint(qobj);
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
+    qnum =3D qobject_to_qnum(qobj);
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
     qobj =3D qdict_get(qdict, "boolean");
     g_assert(qobj);
     qbool =3D qobject_to_qbool(qobj);
@@ -527,7 +527,7 @@ static void test_visitor_in_alternate(TestInputVisito=
rData *data,
=20
     v =3D visitor_input_test_init(data, "42");
     visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
-    g_assert_cmpint(tmp->type, =3D=3D, QTYPE_QINT);
+    g_assert_cmpint(tmp->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpint(tmp->u.i, =3D=3D, 42);
     qapi_free_UserDefAlternate(tmp);
=20
@@ -555,7 +555,7 @@ static void test_visitor_in_alternate(TestInputVisito=
rData *data,
=20
     v =3D visitor_input_test_init(data, "{ 'alt': 42 }");
     visit_type_WrapAlternate(v, NULL, &wrap, &error_abort);
-    g_assert_cmpint(wrap->alt->type, =3D=3D, QTYPE_QINT);
+    g_assert_cmpint(wrap->alt->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpint(wrap->alt->u.i, =3D=3D, 42);
     qapi_free_WrapAlternate(wrap);
=20
@@ -596,19 +596,19 @@ static void test_visitor_in_alternate_number(TestIn=
putVisitorData *data,
=20
     v =3D visitor_input_test_init(data, "42");
     visit_type_AltStrNum(v, NULL, &asn, &error_abort);
-    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpfloat(asn->u.n, =3D=3D, 42);
     qapi_free_AltStrNum(asn);
=20
     v =3D visitor_input_test_init(data, "42");
     visit_type_AltNumStr(v, NULL, &ans, &error_abort);
-    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpfloat(ans->u.n, =3D=3D, 42);
     qapi_free_AltNumStr(ans);
=20
     v =3D visitor_input_test_init(data, "42");
     visit_type_AltStrInt(v, NULL, &asi, &error_abort);
-    g_assert_cmpint(asi->type, =3D=3D, QTYPE_QINT);
+    g_assert_cmpint(asi->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpint(asi->u.i, =3D=3D, 42);
     qapi_free_AltStrInt(asi);
=20
@@ -621,13 +621,13 @@ static void test_visitor_in_alternate_number(TestIn=
putVisitorData *data,
=20
     v =3D visitor_input_test_init(data, "42.5");
     visit_type_AltStrNum(v, NULL, &asn, &error_abort);
-    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpfloat(asn->u.n, =3D=3D, 42.5);
     qapi_free_AltStrNum(asn);
=20
     v =3D visitor_input_test_init(data, "42.5");
     visit_type_AltNumStr(v, NULL, &ans, &error_abort);
-    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QNUM);
     g_assert_cmpfloat(ans->u.n, =3D=3D, 42.5);
     qapi_free_AltNumStr(ans);
=20
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 94b9518e40..66a682d5a8 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -58,13 +58,13 @@ static void test_visitor_out_int(TestOutputVisitorDat=
a *data,
                                  const void *unused)
 {
     int64_t value =3D -42;
-    QInt *qint;
+    QNum *qnum;
=20
     visit_type_int(data->ov, NULL, &value, &error_abort);
=20
-    qint =3D qobject_to_qint(visitor_get(data));
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, value);
+    qnum =3D qobject_to_qnum(visitor_get(data));
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, value);
 }
=20
 static void test_visitor_out_bool(TestOutputVisitorData *data,
@@ -84,13 +84,13 @@ static void test_visitor_out_number(TestOutputVisitor=
Data *data,
                                     const void *unused)
 {
     double value =3D 3.14;
-    QFloat *qfloat;
+    QNum *qnum;
=20
     visit_type_number(data->ov, NULL, &value, &error_abort);
=20
-    qfloat =3D qobject_to_qfloat(visitor_get(data));
-    g_assert(qfloat);
-    g_assert(qfloat_get_double(qfloat) =3D=3D value);
+    qnum =3D qobject_to_qnum(visitor_get(data));
+    g_assert(qnum);
+    g_assert(qnum_get_double(qnum) =3D=3D value);
 }
=20
 static void test_visitor_out_string(TestOutputVisitorData *data,
@@ -329,16 +329,16 @@ static void test_visitor_out_any(TestOutputVisitorD=
ata *data,
                                  const void *unused)
 {
     QObject *qobj;
-    QInt *qint;
+    QNum *qnum;
     QBool *qbool;
     QString *qstring;
     QDict *qdict;
=20
-    qobj =3D QOBJECT(qint_from_int(-42));
+    qobj =3D QOBJECT(qnum_from_int(-42));
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
-    qint =3D qobject_to_qint(visitor_get(data));
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
+    qnum =3D qobject_to_qnum(visitor_get(data));
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
     qobject_decref(qobj);
=20
     visitor_reset(data);
@@ -351,9 +351,9 @@ static void test_visitor_out_any(TestOutputVisitorDat=
a *data,
     qobject_decref(qobj);
     qdict =3D qobject_to_qdict(visitor_get(data));
     g_assert(qdict);
-    qint =3D qobject_to_qint(qdict_get(qdict, "integer"));
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
+    qnum =3D qobject_to_qnum(qdict_get(qdict, "integer"));
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
     qbool =3D qobject_to_qbool(qdict_get(qdict, "boolean"));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) =3D=3D true);
@@ -388,18 +388,18 @@ static void test_visitor_out_alternate(TestOutputVi=
sitorData *data,
                                        const void *unused)
 {
     UserDefAlternate *tmp;
-    QInt *qint;
+    QNum *qnum;
     QString *qstr;
     QDict *qdict;
=20
     tmp =3D g_new0(UserDefAlternate, 1);
-    tmp->type =3D QTYPE_QINT;
+    tmp->type =3D QTYPE_QNUM;
     tmp->u.i =3D 42;
=20
     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    qint =3D qobject_to_qint(visitor_get(data));
-    g_assert(qint);
-    g_assert_cmpint(qint_get_int(qint), =3D=3D, 42);
+    qnum =3D qobject_to_qnum(visitor_get(data));
+    g_assert(qnum);
+    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, 42);
=20
     qapi_free_UserDefAlternate(tmp);
=20
@@ -603,18 +603,18 @@ static void check_native_list(QObject *qobj,
     case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
-        /* all integer elements in JSON arrays get stored into QInts whe=
n
+        /* all integer elements in JSON arrays get stored into QNums whe=
n
          * we convert to QObjects, so we can check them all in the same
          * fashion, so simply fall through here
          */
     case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
         for (i =3D 0; i < 32; i++) {
             QObject *tmp;
-            QInt *qvalue;
+            QNum *qvalue;
             tmp =3D qlist_peek(qlist);
             g_assert(tmp);
-            qvalue =3D qobject_to_qint(tmp);
-            g_assert_cmpint(qint_get_int(qvalue), =3D=3D, i);
+            qvalue =3D qobject_to_qnum(tmp);
+            g_assert_cmpint(qnum_get_int(qvalue, &error_abort), =3D=3D, =
i);
             qobject_decref(qlist_pop(qlist));
         }
         break;
@@ -645,15 +645,15 @@ static void check_native_list(QObject *qobj,
     case USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER:
         for (i =3D 0; i < 32; i++) {
             QObject *tmp;
-            QFloat *qvalue;
+            QNum *qvalue;
             GString *double_expected =3D g_string_new("");
             GString *double_actual =3D g_string_new("");
=20
             tmp =3D qlist_peek(qlist);
             g_assert(tmp);
-            qvalue =3D qobject_to_qfloat(tmp);
+            qvalue =3D qobject_to_qnum(tmp);
             g_string_printf(double_expected, "%.6f", (double)i / 3);
-            g_string_printf(double_actual, "%.6f", qfloat_get_double(qva=
lue));
+            g_string_printf(double_actual, "%.6f", qnum_get_double(qvalu=
e));
             g_assert_cmpstr(double_actual->str, =3D=3D, double_expected-=
>str);
=20
             qobject_decref(qlist_pop(qlist));
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.=
c
index 79a2e69a28..60d168fda8 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -1,9 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qbool.h"
+#include "qapi/error.h"
+#include "qapi/qmp/types.h"
 #include "libqtest.h"
=20
 static char *get_cpu0_qom_path(void)
@@ -56,12 +54,13 @@ static void test_cpuid_prop(const void *data)
 {
     const CpuidTestArgs *args =3D data;
     char *path;
-    QInt *value;
+    QNum *value;
=20
     qtest_start(args->cmdline);
     path =3D get_cpu0_qom_path();
-    value =3D qobject_to_qint(qom_get(path, args->property));
-    g_assert_cmpint(qint_get_int(value), =3D=3D, args->expected_value);
+    value =3D qobject_to_qnum(qom_get(path, args->property));
+    g_assert_cmpint(qnum_get_int(value, &error_abort), =3D=3D,
+                    args->expected_value);
     qtest_end();
=20
     QDECREF(value);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 804abc5c0f..561d0649cf 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -30,7 +30,6 @@
 #include "qemu-x509.h"
 #include "qemu/sockets.h"
 #include "qmp-commands.h"
-#include "qapi/qmp/qint.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 1e53b1cf84..89ab12c0d8 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -44,7 +44,6 @@
 #endif
=20
 #include "qemu/bswap.h"
-#include "qapi/qmp/qint.h"
 #include "vnc.h"
 #include "vnc-enc-tight.h"
 #include "vnc-palette.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5977bfc3e9..39b1e06225 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -941,9 +941,8 @@ typedef struct OptsFromQDictState {
 static void qemu_opts_from_qdict_1(const char *key, QObject *obj, void *=
opaque)
 {
     OptsFromQDictState *state =3D opaque;
-    char buf[32];
+    char buf[32], *tmp =3D NULL;
     const char *value;
-    int n;
=20
     if (!strcmp(key, "id") || *state->errp) {
         return;
@@ -953,17 +952,9 @@ static void qemu_opts_from_qdict_1(const char *key, =
QObject *obj, void *opaque)
     case QTYPE_QSTRING:
         value =3D qstring_get_str(qobject_to_qstring(obj));
         break;
-    case QTYPE_QINT:
-        n =3D snprintf(buf, sizeof(buf), "%" PRId64,
-                     qint_get_int(qobject_to_qint(obj)));
-        assert(n < sizeof(buf));
-        value =3D buf;
-        break;
-    case QTYPE_QFLOAT:
-        n =3D snprintf(buf, sizeof(buf), "%.17g",
-                     qfloat_get_double(qobject_to_qfloat(obj)));
-        assert(n < sizeof(buf));
-        value =3D buf;
+    case QTYPE_QNUM:
+        tmp =3D qnum_to_string(qobject_to_qnum(obj));
+        value =3D tmp;
         break;
     case QTYPE_QBOOL:
         pstrcpy(buf, sizeof(buf),
@@ -975,12 +966,13 @@ static void qemu_opts_from_qdict_1(const char *key,=
 QObject *obj, void *opaque)
     }
=20
     qemu_opt_set(state->opts, key, value, state->errp);
+    g_free(tmp);
 }
=20
 /*
  * Create QemuOpts from a QDict.
  * Use value of key "id" as ID if it exists and is a QString.
- * Only QStrings, QInts, QFloats and QBools are copied.  Entries with
+ * Only QStrings, QNums and QBools are copied.  Entries with
  * other types are silently ignored.
  */
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
diff --git a/MAINTAINERS b/MAINTAINERS
index 66c9734311..421fb585ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1395,8 +1395,7 @@ F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
 F: scripts/coccinelle/qobject.cocci
 F: tests/check-qdict.c
-F: tests/check-qfloat.c
-F: tests/check-qint.c
+F: tests/check-qnum.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
 F: tests/check-qstring.c
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
index bed55084bb..fc8885c9a4 100644
--- a/qobject/Makefile.objs
+++ b/qobject/Makefile.objs
@@ -1,2 +1,2 @@
-util-obj-y =3D qnull.o qint.o qstring.o qdict.o qlist.o qfloat.o qbool.o
+util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o
 util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pars=
er.o
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobjec=
t.cocci
index 97703a438b..c3253deb1b 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -6,7 +6,7 @@ expression Obj, Key, E;
 - qdict_put_obj(Obj, Key, QOBJECT(E));
 + qdict_put(Obj, Key, E);
 |
-- qdict_put(Obj, Key, qint_from_int(E));
+- qdict_put(Obj, Key, qnum_from_int(E));
 + qdict_put_int(Obj, Key, E);
 |
 - qdict_put(Obj, Key, qbool_from_bool(E));
@@ -24,7 +24,7 @@ expression Obj, E;
 - qlist_append_obj(Obj, QOBJECT(E));
 + qlist_append(Obj, E);
 |
-- qlist_append(Obj, qint_from_int(E));
+- qlist_append(Obj, qnum_from_int(E));
 + qlist_append_int(Obj, E);
 |
 - qlist_append(Obj, qbool_from_bool(E));
diff --git a/tests/.gitignore b/tests/.gitignore
index a966740c2c..847f4f1474 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -1,7 +1,6 @@
 atomic_add-bench
 check-qdict
-check-qfloat
-check-qint
+check-qnum
 check-qjson
 check-qlist
 check-qnull
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 31931c0d77..ac0387d88a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -10,10 +10,8 @@ check-unit-y =3D tests/check-qdict$(EXESUF)
 gcov-files-check-qdict-y =3D qobject/qdict.c
 check-unit-y +=3D tests/test-char$(EXESUF)
 gcov-files-check-qdict-y =3D chardev/char.c
-check-unit-y +=3D tests/check-qfloat$(EXESUF)
-gcov-files-check-qfloat-y =3D qobject/qfloat.c
-check-unit-y +=3D tests/check-qint$(EXESUF)
-gcov-files-check-qint-y =3D qobject/qint.c
+check-unit-y +=3D tests/check-qnum$(EXESUF)
+gcov-files-check-qnum-y =3D qobject/qnum.c
 check-unit-y +=3D tests/check-qstring$(EXESUF)
 gcov-files-check-qstring-y =3D qobject/qstring.c
 check-unit-y +=3D tests/check-qlist$(EXESUF)
@@ -500,8 +498,8 @@ GENERATED_FILES +=3D tests/test-qapi-types.h tests/te=
st-qapi-visit.h \
 	tests/test-qmp-commands.h tests/test-qapi-event.h \
 	tests/test-qmp-introspect.h
=20
-test-obj-y =3D tests/check-qint.o tests/check-qstring.o tests/check-qdic=
t.o \
-	tests/check-qlist.o tests/check-qfloat.o tests/check-qnull.o \
+test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
+	tests/check-qlist.o tests/check-qnull.o \
 	tests/check-qjson.o \
 	tests/test-coroutine.o tests/test-string-output-visitor.o \
 	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
@@ -529,11 +527,10 @@ test-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-ob=
j-y)
 test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
 test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
=20
-tests/check-qint$(EXESUF): tests/check-qint.o $(test-util-obj-y)
+tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
 tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
 tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
 tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
-tests/check-qfloat$(EXESUF): tests/check-qfloat.o $(test-util-obj-y)
 tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
 tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-q=
om-obj-y)
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 5d7c13cad1..17e652535c 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 70c1252408..63ca25a8b9 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -6,7 +6,7 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 object SugaredUnion
     member type: SugaredUnionKind optional=3DFalse
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 8a5b034424..40b886ddae 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,3 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 object q_empty
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 5a0f2bf805..313c0fe7be 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 event oops None
    boxed=3DFalse
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 1d2722c02e..b5637cb2e0 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 command fooA q_obj_fooA-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index 5d7c13cad1..17e652535c 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 5d7c13cad1..17e652535c 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 5d7c13cad1..17e652535c 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index e8171c935f..586795f44d 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,4 +1,4 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 5c6655a5c3..7812a6c69b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -46,7 +46,7 @@ object NestedEnumsOne
     member enum4: EnumOne optional=3DTrue
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
 object TestStruct
     member integer: int optional=3DFalse
--=20
2.13.0.rc1.16.gd80b50c3f
