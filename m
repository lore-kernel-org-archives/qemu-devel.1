Received: from eggs.gnu.org ([2001:4830:134:3::10]:49563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViF-00050X-HP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001X1-Hp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Uu-36
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 399008D777
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:05:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:47 +0200
Message-Id: <20180504080454.11014-4-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/10] qobject: use a QObjectBase_ struct
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

By moving the base fields to a QObjectBase_, QObject can be a type
which also has a 'base' field. This allows writing a generic QOBJECT()
macro that will work with any QObject type, including QObject
itself. The container_of() macro ensures that the object to cast has a
QObjectBase_ base field, giving some type safety guarantees. QObject
must have no members but QObjectBase_ base, or else QOBJECT() breaks.

QObjectBase_ is not a typedef and uses a trailing underscore to make
it obvious it is not for normal use and to avoid potential abuse.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180419150145.24795-3-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qbool.h   |  2 +-
 include/qapi/qmp/qdict.h   |  2 +-
 include/qapi/qmp/qlist.h   |  2 +-
 include/qapi/qmp/qnull.h   |  2 +-
 include/qapi/qmp/qnum.h    |  2 +-
 include/qapi/qmp/qobject.h | 31 ++++++++++++++++++++-----------
 include/qapi/qmp/qstring.h |  2 +-
 qobject/qobject.c          | 12 ++++++------
 tests/check-qdict.c        |  6 +++---
 9 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
index b9a44a1bfe..5f61e38e64 100644
--- a/include/qapi/qmp/qbool.h
+++ b/include/qapi/qmp/qbool.h
@@ -17,7 +17,7 @@
 #include "qapi/qmp/qobject.h"
=20
 struct QBool {
-    QObject base;
+    struct QObjectBase_ base;
     bool value;
 };
=20
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 2cc3e906f7..921a28d2d3 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -25,7 +25,7 @@ typedef struct QDictEntry {
 } QDictEntry;
=20
 struct QDict {
-    QObject base;
+    struct QObjectBase_ base;
     size_t size;
     QLIST_HEAD(,QDictEntry) table[QDICT_BUCKET_MAX];
 };
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 5c673acb06..8d2c32ca28 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -22,7 +22,7 @@ typedef struct QListEntry {
 } QListEntry;
=20
 struct QList {
-    QObject base;
+    struct QObjectBase_ base;
     QTAILQ_HEAD(,QListEntry) head;
 };
=20
diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
index c992ee2ae1..e8ea2c315a 100644
--- a/include/qapi/qmp/qnull.h
+++ b/include/qapi/qmp/qnull.h
@@ -16,7 +16,7 @@
 #include "qapi/qmp/qobject.h"
=20
 struct QNull {
-    QObject base;
+    struct QObjectBase_ base;
 };
=20
 extern QNull qnull_;
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 3e47475b2c..45bf02a036 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -45,7 +45,7 @@ typedef enum {
  * convert under the hood.
  */
 struct QNum {
-    QObject base;
+    struct QObjectBase_ base;
     QNumKind kind;
     union {
         int64_t i64;
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 5206ff9ee1..a713c0165b 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -34,13 +34,21 @@
=20
 #include "qapi/qapi-builtin-types.h"
=20
-struct QObject {
+/* Not for use outside include/qapi/qmp/ */
+struct QObjectBase_ {
     QType type;
     size_t refcnt;
 };
=20
-/* Get the 'base' part of an object */
-#define QOBJECT(obj) (&(obj)->base)
+/* this struct must have no other members than base */
+struct QObject {
+    struct QObjectBase_ base;
+};
+
+#define QOBJECT(obj) ({                                         \
+    typeof(obj) _obj =3D (obj);                                   \
+    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
+})
=20
 /* High-level interface for qobject_incref() */
 #define QINCREF(obj)      \
@@ -68,8 +76,8 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
 static inline void qobject_init(QObject *obj, QType type)
 {
     assert(QTYPE_NONE < type && type < QTYPE__MAX);
-    obj->refcnt =3D 1;
-    obj->type =3D type;
+    obj->base.refcnt =3D 1;
+    obj->base.type =3D type;
 }
=20
 /**
@@ -77,8 +85,9 @@ static inline void qobject_init(QObject *obj, QType typ=
e)
  */
 static inline void qobject_incref(QObject *obj)
 {
-    if (obj)
-        obj->refcnt++;
+    if (obj) {
+        obj->base.refcnt++;
+    }
 }
=20
 /**
@@ -101,8 +110,8 @@ void qobject_destroy(QObject *obj);
  */
 static inline void qobject_decref(QObject *obj)
 {
-    assert(!obj || obj->refcnt);
-    if (obj && --obj->refcnt =3D=3D 0) {
+    assert(!obj || obj->base.refcnt);
+    if (obj && --obj->base.refcnt =3D=3D 0) {
         qobject_destroy(obj);
     }
 }
@@ -112,8 +121,8 @@ static inline void qobject_decref(QObject *obj)
  */
 static inline QType qobject_type(const QObject *obj)
 {
-    assert(QTYPE_NONE < obj->type && obj->type < QTYPE__MAX);
-    return obj->type;
+    assert(QTYPE_NONE < obj->base.type && obj->base.type < QTYPE__MAX);
+    return obj->base.type;
 }
=20
 /**
diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 30ae260a7f..b3b3d444d2 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -16,7 +16,7 @@
 #include "qapi/qmp/qobject.h"
=20
 struct QString {
-    QObject base;
+    struct QObjectBase_ base;
     char *string;
     size_t length;
     size_t capacity;
diff --git a/qobject/qobject.c b/qobject/qobject.c
index 87649c5be5..cf4b7e229e 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -37,9 +37,9 @@ static void (*qdestroy[QTYPE__MAX])(QObject *) =3D {
=20
 void qobject_destroy(QObject *obj)
 {
-    assert(!obj->refcnt);
-    assert(QTYPE_QNULL < obj->type && obj->type < QTYPE__MAX);
-    qdestroy[obj->type](obj);
+    assert(!obj->base.refcnt);
+    assert(QTYPE_QNULL < obj->base.type && obj->base.type < QTYPE__MAX);
+    qdestroy[obj->base.type](obj);
 }
=20
=20
@@ -62,11 +62,11 @@ bool qobject_is_equal(const QObject *x, const QObject=
 *y)
         return true;
     }
=20
-    if (!x || !y || x->type !=3D y->type) {
+    if (!x || !y || x->base.type !=3D y->base.type) {
         return false;
     }
=20
-    assert(QTYPE_NONE < x->type && x->type < QTYPE__MAX);
+    assert(QTYPE_NONE < x->base.type && x->base.type < QTYPE__MAX);
=20
-    return qis_equal[x->type](x, y);
+    return qis_equal[x->base.type](x, y);
 }
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 08d4303e6a..07bb8f4564 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -570,11 +570,11 @@ static void qdict_join_test(void)
         }
=20
         /* Check the references */
-        g_assert(qdict_get(dict1, "foo")->refcnt =3D=3D 1);
-        g_assert(qdict_get(dict1, "bar")->refcnt =3D=3D 1);
+        g_assert(qdict_get(dict1, "foo")->base.refcnt =3D=3D 1);
+        g_assert(qdict_get(dict1, "bar")->base.refcnt =3D=3D 1);
=20
         if (!overwrite) {
-            g_assert(qdict_get(dict2, "foo")->refcnt =3D=3D 1);
+            g_assert(qdict_get(dict2, "foo")->base.refcnt =3D=3D 1);
         }
=20
         /* Clean up */
--=20
2.13.6
