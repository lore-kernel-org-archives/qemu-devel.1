Received: from eggs.gnu.org ([2001:4830:134:3::10]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1J-0006b7-Ls
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1I-0001e7-5a
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1H-0001df-Rj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6D5E7EA9F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:16 +0200
Message-Id: <20170901153758.8628-6-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/47] qlit: move qlit from check-qjson to
 qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fix code style issues while at it, to please checkpatch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-3-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h | 49 +++++++++++++++++++++++++
 qobject/Makefile.objs   |  2 +-
 qobject/qlit.c          | 89 +++++++++++++++++++++++++++++++++++++++++++=
++
 tests/check-qjson.c     | 96 +------------------------------------------=
------
 4 files changed, 140 insertions(+), 96 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qobject/qlit.c

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
new file mode 100644
index 0000000000..280db5064a
--- /dev/null
+++ b/include/qapi/qmp/qlit.h
@@ -0,0 +1,49 @@
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
+#ifndef QLIT_H
+#define QLIT_H
+
+#include "qapi-types.h"
+#include "qobject.h"
+
+typedef struct LiteralQDictEntry LiteralQDictEntry;
+typedef struct LiteralQObject LiteralQObject;
+
+struct LiteralQObject {
+    int type;
+    union {
+        int64_t qnum;
+        const char *qstr;
+        LiteralQDictEntry *qdict;
+        LiteralQObject *qlist;
+    } value;
+};
+
+struct LiteralQDictEntry {
+    const char *key;
+    LiteralQObject value;
+};
+
+#define QLIT_QNUM(val) \
+    (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
+#define QLIT_QSTR(val) \
+    (LiteralQObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
+#define QLIT_QDICT(val) \
+    (LiteralQObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
+#define QLIT_QLIST(val) \
+    (LiteralQObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
+
+int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs);
+
+#endif /* QLIT_H */
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
index fc8885c9a4..002d25873a 100644
--- a/qobject/Makefile.objs
+++ b/qobject/Makefile.objs
@@ -1,2 +1,2 @@
-util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o
+util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
 util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pars=
er.o
diff --git a/qobject/qlit.c b/qobject/qlit.c
new file mode 100644
index 0000000000..5917c3584e
--- /dev/null
+++ b/qobject/qlit.c
@@ -0,0 +1,89 @@
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
+    LiteralQObject *objs;
+    int result;
+} QListCompareHelper;
+
+static void compare_helper(QObject *obj, void *opaque)
+{
+    QListCompareHelper *helper =3D opaque;
+
+    if (helper->result =3D=3D 0) {
+        return;
+    }
+
+    if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
+        helper->result =3D 0;
+        return;
+    }
+
+    helper->result =3D
+        compare_litqobj_to_qobj(&helper->objs[helper->index++], obj);
+}
+
+int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs)
+{
+    int64_t val;
+
+    if (!rhs || lhs->type !=3D qobject_type(rhs)) {
+        return 0;
+    }
+
+    switch (lhs->type) {
+    case QTYPE_QNUM:
+        g_assert(qnum_get_try_int(qobject_to_qnum(rhs), &val));
+        return lhs->value.qnum =3D=3D val;
+    case QTYPE_QSTRING:
+        return (strcmp(lhs->value.qstr,
+                       qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
+    case QTYPE_QDICT: {
+        int i;
+
+        for (i =3D 0; lhs->value.qdict[i].key; i++) {
+            QObject *obj =3D qdict_get(qobject_to_qdict(rhs),
+                                     lhs->value.qdict[i].key);
+
+            if (!compare_litqobj_to_qobj(&lhs->value.qdict[i].value, obj=
)) {
+                return 0;
+            }
+        }
+
+        return 1;
+    }
+    case QTYPE_QLIST: {
+        QListCompareHelper helper;
+
+        helper.index =3D 0;
+        helper.objs =3D lhs->value.qlist;
+        helper.result =3D 1;
+
+        qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
+
+        return helper.result;
+    }
+    default:
+        break;
+    }
+
+    return 0;
+}
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index a3a97b0d99..525f79e60b 100644
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
@@ -1059,101 +1060,6 @@ static void keyword_literal(void)
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
--=20
2.13.5
