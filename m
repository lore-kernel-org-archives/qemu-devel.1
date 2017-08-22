Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hg-0006XQ-AD
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HZ-0005wY-5P
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9HY-0005w7-So
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C06CB7EA8F
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:23:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:04 +0200
Message-Id: <20170822132255.23945-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/54] qobject: add literal qobject type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Promote LiteralQObject from tests/check-qjson.c to qobject/qlit.c,
allowing to statically declare complex qobjects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h |  54 +++++++++++++++++
 qobject/qlit.c          | 106 ++++++++++++++++++++++++++++++++++
 tests/check-qjson.c     | 150 +++++++++---------------------------------=
------
 tests/check-qlit.c      |  68 ++++++++++++++++++++++
 qobject/Makefile.objs   |   2 +-
 tests/Makefile.include  |   5 +-
 6 files changed, 261 insertions(+), 124 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qobject/qlit.c
 create mode 100644 tests/check-qlit.c

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
new file mode 100644
index 0000000000..2cdceb448d
--- /dev/null
+++ b/include/qapi/qmp/qlit.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright IBM, Corp. 2009
+ * Copyright (c) 2013, 2015, 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Markus Armbruster <armbru@redhat.com>
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+#ifndef QLIT_H_
+#define QLIT_H_
+
+#include "qapi-types.h"
+#include "qobject.h"
+
+typedef struct QLitDictEntry QLitDictEntry;
+typedef struct QLitObject QLitObject;
+
+struct QLitObject {
+    int type;
+    union {
+        bool qbool;
+        int64_t qnum;
+        const char *qstr;
+        QLitDictEntry *qdict;
+        QLitObject *qlist;
+    } value;
+};
+
+struct QLitDictEntry {
+    const char *key;
+    QLitObject value;
+};
+
+#define QLIT_QNULL \
+    { .type =3D QTYPE_QNULL }
+#define QLIT_QBOOL(val) \
+    { .type =3D QTYPE_QBOOL, .value.qbool =3D (val) }
+#define QLIT_QNUM(val) \
+    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
+#define QLIT_QSTR(val) \
+    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
+#define QLIT_QDICT(val) \
+    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
+#define QLIT_QLIST(val) \
+    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
+
+bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
+
+#endif /* QLIT_H_ */
diff --git a/qobject/qlit.c b/qobject/qlit.c
new file mode 100644
index 0000000000..f4ebeb6259
--- /dev/null
+++ b/qobject/qlit.c
@@ -0,0 +1,106 @@
+/*
+ * QLit literal qobject
+ *
+ * Copyright IBM, Corp. 2009
+ * Copyright (c) 2013, 2015, 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Markus Armbruster <armbru@redhat.com>
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/qmp/qlit.h"
+#include "qapi/qmp/types.h"
+
+typedef struct QListCompareHelper {
+    int index;
+    QLitObject *objs;
+    bool result;
+} QListCompareHelper;
+
+static void compare_helper(QObject *obj, void *opaque)
+{
+    QListCompareHelper *helper =3D opaque;
+
+    if (!helper->result) {
+        return;
+    }
+
+    if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
+        helper->result =3D false;
+        return;
+    }
+
+    helper->result =3D
+        qlit_equal_qobject(&helper->objs[helper->index++], obj);
+}
+
+bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
+{
+    int64_t val;
+
+    if (!rhs || lhs->type !=3D qobject_type(rhs)) {
+        return false;
+    }
+
+    switch (lhs->type) {
+    case QTYPE_QBOOL:
+        return lhs->value.qbool =3D=3D qbool_get_bool(qobject_to_qbool(r=
hs));
+    case QTYPE_QNUM:
+        val =3D qnum_get_int(qobject_to_qnum(rhs));
+        return lhs->value.qnum =3D=3D val;
+    case QTYPE_QSTRING:
+        return g_str_equal(lhs->value.qstr,
+                           qstring_get_str(qobject_to_qstring(rhs)));
+    case QTYPE_QDICT: {
+        int i;
+
+        for (i =3D 0; lhs->value.qdict[i].key; i++) {
+            QObject *obj =3D qdict_get(qobject_to_qdict(rhs),
+                                     lhs->value.qdict[i].key);
+
+            if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
+                return false;
+            }
+        }
+
+        if (qdict_size(qobject_to_qdict(rhs)) !=3D i) {
+            return false;
+        }
+
+        return true;
+    }
+    case QTYPE_QLIST: {
+        QListCompareHelper helper;
+        int i;
+
+        for (i =3D 0; lhs->value.qlist[i].type !=3D QTYPE_NONE; i++) {
+            continue;
+        }
+
+        if (qlist_size(qobject_to_qlist(rhs)) !=3D i) {
+            return false;
+        }
+
+        helper.index =3D 0;
+        helper.objs =3D lhs->value.qlist;
+        helper.result =3D true;
+
+        qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
+
+        return helper.result;
+    }
+    case QTYPE_QNULL:
+        return true;
+    default:
+        break;
+    }
+
+    return false;
+}
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index a3a97b0d99..59227934ce 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlit.h"
 #include "qemu-common.h"
=20
 static void escaped_string(void)
@@ -1059,123 +1060,28 @@ static void keyword_literal(void)
     QDECREF(null);
 }
=20
-typedef struct LiteralQDictEntry LiteralQDictEntry;
-typedef struct LiteralQObject LiteralQObject;
-
-struct LiteralQObject
-{
-    int type;
-    union {
-        int64_t qnum;
-        const char *qstr;
-        LiteralQDictEntry *qdict;
-        LiteralQObject *qlist;
-    } value;
-};
-
-struct LiteralQDictEntry
-{
-    const char *key;
-    LiteralQObject value;
-};
-
-#define QLIT_QNUM(val) (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnu=
m =3D (val)}
-#define QLIT_QSTR(val) (LiteralQObject){.type =3D QTYPE_QSTRING, .value.=
qstr =3D (val)}
-#define QLIT_QDICT(val) (LiteralQObject){.type =3D QTYPE_QDICT, .value.q=
dict =3D (val)}
-#define QLIT_QLIST(val) (LiteralQObject){.type =3D QTYPE_QLIST, .value.q=
list =3D (val)}
-
-typedef struct QListCompareHelper
-{
-    int index;
-    LiteralQObject *objs;
-    int result;
-} QListCompareHelper;
-
-static int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs);
-
-static void compare_helper(QObject *obj, void *opaque)
-{
-    QListCompareHelper *helper =3D opaque;
-
-    if (helper->result =3D=3D 0) {
-        return;
-    }
-
-    if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
-        helper->result =3D 0;
-        return;
-    }
-
-    helper->result =3D compare_litqobj_to_qobj(&helper->objs[helper->ind=
ex++], obj);
-}
-
-static int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs)
-{
-    int64_t val;
-
-    if (!rhs || lhs->type !=3D qobject_type(rhs)) {
-        return 0;
-    }
-
-    switch (lhs->type) {
-    case QTYPE_QNUM:
-        g_assert(qnum_get_try_int(qobject_to_qnum(rhs), &val));
-        return lhs->value.qnum =3D=3D val;
-    case QTYPE_QSTRING:
-        return (strcmp(lhs->value.qstr, qstring_get_str(qobject_to_qstri=
ng(rhs))) =3D=3D 0);
-    case QTYPE_QDICT: {
-        int i;
-
-        for (i =3D 0; lhs->value.qdict[i].key; i++) {
-            QObject *obj =3D qdict_get(qobject_to_qdict(rhs), lhs->value=
.qdict[i].key);
-
-            if (!compare_litqobj_to_qobj(&lhs->value.qdict[i].value, obj=
)) {
-                return 0;
-            }
-        }
-
-        return 1;
-    }
-    case QTYPE_QLIST: {
-        QListCompareHelper helper;
-
-        helper.index =3D 0;
-        helper.objs =3D lhs->value.qlist;
-        helper.result =3D 1;
-       =20
-        qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
-
-        return helper.result;
-    }
-    default:
-        break;
-    }
-
-    return 0;
-}
-
 static void simple_dict(void)
 {
     int i;
     struct {
         const char *encoded;
-        LiteralQObject decoded;
+        QLitObject decoded;
     } test_cases[] =3D {
         {
             .encoded =3D "{\"foo\": 42, \"bar\": \"hello world\"}",
-            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
+            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
                         { "foo", QLIT_QNUM(42) },
                         { "bar", QLIT_QSTR("hello world") },
                         { }
                     })),
         }, {
             .encoded =3D "{}",
-            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
+            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
                         { }
                     })),
         }, {
             .encoded =3D "{\"foo\": 43}",
-            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
+            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
                         { "foo", QLIT_QNUM(43) },
                         { }
                     })),
@@ -1188,13 +1094,13 @@ static void simple_dict(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1257,11 +1163,11 @@ static void simple_list(void)
     int i;
     struct {
         const char *encoded;
-        LiteralQObject decoded;
+        QLitObject decoded;
     } test_cases[] =3D {
         {
             .encoded =3D "[43,42]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         QLIT_QNUM(42),
                         { }
@@ -1269,21 +1175,21 @@ static void simple_list(void)
         },
         {
             .encoded =3D "[43]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         { }
                     })),
         },
         {
             .encoded =3D "[]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         { }
                     })),
         },
         {
             .encoded =3D "[{}]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
-                        QLIT_QDICT(((LiteralQDictEntry[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
+                        QLIT_QDICT(((QLitDictEntry[]){
                                     {},
                                         })),
                         {},
@@ -1297,13 +1203,13 @@ static void simple_list(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1314,11 +1220,11 @@ static void simple_whitespace(void)
     int i;
     struct {
         const char *encoded;
-        LiteralQObject decoded;
+        QLitObject decoded;
     } test_cases[] =3D {
         {
             .encoded =3D " [ 43 , 42 ]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         QLIT_QNUM(42),
                         { }
@@ -1326,12 +1232,12 @@ static void simple_whitespace(void)
         },
         {
             .encoded =3D " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
-                        QLIT_QDICT(((LiteralQDictEntry[]){
+                        QLIT_QDICT(((QLitDictEntry[]){
                                     { "h", QLIT_QSTR("b") },
                                     { }})),
-                        QLIT_QLIST(((LiteralQObject[]){
+                        QLIT_QLIST(((QLitObject[]){
                                     { }})),
                         QLIT_QNUM(42),
                         { }
@@ -1339,13 +1245,13 @@ static void simple_whitespace(void)
         },
         {
             .encoded =3D " [ 43 , { 'h' : 'b' , 'a' : 32 }, [ ], 42 ]",
-            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
+            .decoded =3D QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
-                        QLIT_QDICT(((LiteralQDictEntry[]){
+                        QLIT_QDICT(((QLitDictEntry[]){
                                     { "h", QLIT_QSTR("b") },
                                     { "a", QLIT_QNUM(32) },
                                     { }})),
-                        QLIT_QLIST(((LiteralQObject[]){
+                        QLIT_QLIST(((QLitObject[]){
                                     { }})),
                         QLIT_QNUM(42),
                         { }
@@ -1359,13 +1265,13 @@ static void simple_whitespace(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         qobject_decref(obj);
         QDECREF(str);
@@ -1376,10 +1282,10 @@ static void simple_varargs(void)
 {
     QObject *embedded_obj;
     QObject *obj;
-    LiteralQObject decoded =3D QLIT_QLIST(((LiteralQObject[]){
+    QLitObject decoded =3D QLIT_QLIST(((QLitObject[]){
             QLIT_QNUM(1),
             QLIT_QNUM(2),
-            QLIT_QLIST(((LiteralQObject[]){
+            QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(32),
                         QLIT_QNUM(42),
                         {}})),
@@ -1389,7 +1295,7 @@ static void simple_varargs(void)
     g_assert(embedded_obj !=3D NULL);
=20
     obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
-    g_assert(compare_litqobj_to_qobj(&decoded, obj) =3D=3D 1);
+    g_assert(qlit_equal_qobject(&decoded, obj));
=20
     qobject_decref(obj);
 }
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
new file mode 100644
index 0000000000..5736b61ebf
--- /dev/null
+++ b/tests/check-qlit.c
@@ -0,0 +1,68 @@
+/*
+ * QLit unit-tests.
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlit.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
+
+static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntry[]) {
+    { "foo", QLIT_QNUM(42) },
+    { "bar", QLIT_QSTR("hello world") },
+    { "baz", QLIT_QNULL },
+    { "bee", QLIT_QLIST(((QLitObject[]) {
+        QLIT_QNUM(43),
+        QLIT_QNUM(44),
+        QLIT_QBOOL(true),
+        { },
+    }))},
+    { },
+}));
+
+static QObject *make_qobject(void)
+{
+    QDict *qdict =3D qdict_new();
+    QList *list =3D qlist_new();
+
+    qdict_put_int(qdict, "foo", 42);
+    qdict_put_str(qdict, "bar", "hello world");
+    qdict_put_null(qdict, "baz");
+
+    qlist_append_int(list, 43);
+    qlist_append_int(list, 44);
+    qlist_append_bool(list, true);
+    qdict_put(qdict, "bee", list);
+
+    return QOBJECT(qdict);
+}
+
+static void qlit_equal_qobject_test(void)
+{
+    QObject *qobj =3D make_qobject();
+    QList *list =3D qlist_new();
+
+    g_assert(qlit_equal_qobject(&qlit, qobj));
+
+    qdict_put(qobject_to_qdict(qobj), "bee", list);
+    g_assert(!qlit_equal_qobject(&qlit, qobj));
+
+    qobject_decref(qobj);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/qlit/equal_qobject", qlit_equal_qobject_test);
+
+    return g_test_run();
+}
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
index fc8885c9a4..002d25873a 100644
--- a/qobject/Makefile.objs
+++ b/qobject/Makefile.objs
@@ -1,2 +1,2 @@
-util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o
+util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
 util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pars=
er.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 37c1bed683..3653c7b40a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -43,6 +43,8 @@ check-unit-y +=3D tests/check-qnull$(EXESUF)
 gcov-files-check-qnull-y =3D qobject/qnull.c
 check-unit-y +=3D tests/check-qjson$(EXESUF)
 gcov-files-check-qjson-y =3D qobject/qjson.c
+check-unit-y +=3D tests/check-qlit$(EXESUF)
+gcov-files-check-qlit-y =3D qobject/qlit.c
 check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)
 gcov-files-test-qobject-output-visitor-y =3D qapi/qobject-output-visitor=
.c
 check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
@@ -535,7 +537,7 @@ GENERATED_FILES +=3D tests/test-qapi-types.h tests/te=
st-qapi-visit.h \
=20
 test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
 	tests/check-qlist.o tests/check-qnull.o \
-	tests/check-qjson.o \
+	tests/check-qjson.o tests/check-qlit.o \
 	tests/test-coroutine.o tests/test-string-output-visitor.o \
 	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
 	tests/test-clone-visitor.o \
@@ -569,6 +571,7 @@ tests/check-qdict$(EXESUF): tests/check-qdict.o $(tes=
t-util-obj-y)
 tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
 tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
 tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
+tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-q=
om-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom=
-obj-y)
=20
--=20
2.14.1.146.gd35faa819
