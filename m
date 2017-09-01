Received: from eggs.gnu.org ([2001:4830:134:3::10]:54092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUr-0000Pu-3H
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUk-0007Ng-3y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007Lm-HW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BAFC61486
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:32 +0200
Message-Id: <20170901125611.29295-9-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/47] qlit: rename compare_litqobj_to_qobj() to
 qlit_equal_qobject()
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

compare_litqobj_to_qobj() lacks a qlit_ prefix.  Moreover, "compare"
suggests -1, 0, +1 for less than, equal and greater than.  The
function actually returns non-zero for equal, zero for unequal.
Rename to qlit_equal_qobject().

Its return type will be cleaned up in the next patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-6-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h |  2 +-
 qobject/qlit.c          |  6 +++---
 tests/check-qjson.c     | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index f1d6eed317..5a180477c8 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -44,6 +44,6 @@ struct QLitDictEntry {
 #define QLIT_QLIST(val) \
     { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
=20
-int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
+int qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
=20
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 262d64988d..0c4101898d 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -38,10 +38,10 @@ static void compare_helper(QObject *obj, void *opaque=
)
     }
=20
     helper->result =3D
-        compare_litqobj_to_qobj(&helper->objs[helper->index++], obj);
+        qlit_equal_qobject(&helper->objs[helper->index++], obj);
 }
=20
-int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs)
+int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
 {
     int64_t val;
=20
@@ -63,7 +63,7 @@ int compare_litqobj_to_qobj(QLitObject *lhs, QObject *r=
hs)
             QObject *obj =3D qdict_get(qobject_to_qdict(rhs),
                                      lhs->value.qdict[i].key);
=20
-            if (!compare_litqobj_to_qobj(&lhs->value.qdict[i].value, obj=
)) {
+            if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
                 return 0;
             }
         }
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 82b3681327..e5ca273cbc 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1094,13 +1094,13 @@ static void simple_dict(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1203,13 +1203,13 @@ static void simple_list(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
         qobject_decref(obj);
         QDECREF(str);
     }
@@ -1265,13 +1265,13 @@ static void simple_whitespace(void)
         QString *str;
=20
         obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
=20
         str =3D qobject_to_json(obj);
         qobject_decref(obj);
=20
         obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
-        g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) =3D=
=3D 1);
+        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
=20
         qobject_decref(obj);
         QDECREF(str);
@@ -1295,7 +1295,7 @@ static void simple_varargs(void)
     g_assert(embedded_obj !=3D NULL);
=20
     obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
-    g_assert(compare_litqobj_to_qobj(&decoded, obj) =3D=3D 1);
+    g_assert(qlit_equal_qobject(&decoded, obj) =3D=3D 1);
=20
     qobject_decref(obj);
 }
--=20
2.13.5
