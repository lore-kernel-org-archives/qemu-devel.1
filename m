Received: from eggs.gnu.org ([2001:4830:134:3::10]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLF-0007aM-Va
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLF-0004yK-0K
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dlCLE-0004y3-NU
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FD077DD05
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 10:59:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 12:59:05 +0200
Message-Id: <20170825105913.4060-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/14] qlit: make qlit_equal_qobject return
 a bool
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

Make it more obvious about the expected return values.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h |  2 +-
 qobject/qlit.c          | 18 +++++++++---------
 tests/check-qjson.c     | 14 +++++++-------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 5a180477c8..35aabbdc9f 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -44,6 +44,6 @@ struct QLitDictEntry {
 #define QLIT_QLIST(val) \
     { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
=20
-int qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
+bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
=20
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 0c4101898d..a2975bef3f 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -21,19 +21,19 @@
 typedef struct QListCompareHelper {
     int index;
     QLitObject *objs;
-    int result;
+    bool result;
 } QListCompareHelper;
=20
 static void compare_helper(QObject *obj, void *opaque)
 {
     QListCompareHelper *helper =3D opaque;
=20
-    if (helper->result =3D=3D 0) {
+    if (!helper->result) {
         return;
     }
=20
     if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
-        helper->result =3D 0;
+        helper->result =3D false;
         return;
     }
=20
@@ -41,12 +41,12 @@ static void compare_helper(QObject *obj, void *opaque=
)
         qlit_equal_qobject(&helper->objs[helper->index++], obj);
 }
=20
-int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
+bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
 {
     int64_t val;
=20
     if (!rhs || lhs->type !=3D qobject_type(rhs)) {
-        return 0;
+        return false;
     }
=20
     switch (lhs->type) {
@@ -64,18 +64,18 @@ int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
                                      lhs->value.qdict[i].key);
=20
             if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
-                return 0;
+                return false;
             }
         }
=20
-        return 1;
+        return true;
     }
     case QTYPE_QLIST: {
         QListCompareHelper helper;
=20
         helper.index =3D 0;
         helper.objs =3D lhs->value.qlist;
-        helper.result =3D 1;
+        helper.result =3D true;
=20
         qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
=20
@@ -85,5 +85,5 @@ int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
         break;
     }
=20
-    return 0;
+    return false;
 }
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e5ca273cbc..59227934ce 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1094,13 +1094,13 @@ static void simple_dict(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1203,13 +1203,13 @@ static void simple_list(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1265,13 +1265,13 @@ static void simple_whitespace(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
=20
         qobject_decref(obj);
         QDECREF(str);
@@ -1295,7 +1295,7 @@ static void simple_varargs(void)
     g_assert(embedded_obj !=3D NULL);
=20
     obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
-    g_assert(qlit_equal_qobject(&decoded, obj) =3D=3D 1);
+    g_assert(qlit_equal_qobject(&decoded, obj));
=20
     qobject_decref(obj);
 }
--=20
2.14.1.146.gd35faa819
