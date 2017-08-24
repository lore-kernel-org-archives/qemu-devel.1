Received: from eggs.gnu.org ([2001:4830:134:3::10]:58898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpT7-0007F2-NM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpT2-000480-RA
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkpT2-00047n-IB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 899FB8765E
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:34:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Aug 2017 12:33:46 +0200
Message-Id: <20170824103350.16400-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170824103350.16400-1-marcandre.lureau@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/14] tests: add qlit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qlit.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/Makefile.include |  5 +++-
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tests/check-qlit.c

diff --git a/tests/check-qlit.c b/tests/check-qlit.c
new file mode 100644
index 0000000000..47fde92a46
--- /dev/null
+++ b/tests/check-qlit.c
@@ -0,0 +1,64 @@
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
+
+    g_assert(qlit_equal_qobject(&qlit, qobj));
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
