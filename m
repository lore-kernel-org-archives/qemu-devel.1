Received: from eggs.gnu.org ([2001:4830:134:3::10]:51603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1P-0006g0-10
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1J-0001gC-Ud
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1J-0001er-KR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2164285B5
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:17 +0200
Message-Id: <20170901153758.8628-7-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 06/47] qlit: use QLit prefix consistently
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

Rename from LiteralQ to QLit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-4-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h | 24 ++++++++++++------------
 qobject/qlit.c          |  4 ++--
 tests/check-qjson.c     | 40 ++++++++++++++++++++--------------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 280db5064a..a4ad91321b 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -17,33 +17,33 @@
 #include "qapi-types.h"
 #include "qobject.h"
=20
-typedef struct LiteralQDictEntry LiteralQDictEntry;
-typedef struct LiteralQObject LiteralQObject;
+typedef struct QLitDictEntry QLitDictEntry;
+typedef struct QLitObject QLitObject;
=20
-struct LiteralQObject {
+struct QLitObject {
     int type;
     union {
         int64_t qnum;
         const char *qstr;
-        LiteralQDictEntry *qdict;
-        LiteralQObject *qlist;
+        QLitDictEntry *qdict;
+        QLitObject *qlist;
     } value;
 };
=20
-struct LiteralQDictEntry {
+struct QLitDictEntry {
     const char *key;
-    LiteralQObject value;
+    QLitObject value;
 };
=20
 #define QLIT_QNUM(val) \
-    (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
+    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
 #define QLIT_QSTR(val) \
-    (LiteralQObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
+    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
 #define QLIT_QDICT(val) \
-    (LiteralQObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
+    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
 #define QLIT_QLIST(val) \
-    (LiteralQObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
+    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
=20
-int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs);
+int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
=20
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 5917c3584e..262d64988d 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -20,7 +20,7 @@
=20
 typedef struct QListCompareHelper {
     int index;
-    LiteralQObject *objs;
+    QLitObject *objs;
     int result;
 } QListCompareHelper;
=20
@@ -41,7 +41,7 @@ static void compare_helper(QObject *obj, void *opaque)
         compare_litqobj_to_qobj(&helper->objs[helper->index++], obj);
 }
=20
-int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs)
+int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs)
 {
     int64_t val;
=20
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 525f79e60b..82b3681327 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1065,23 +1065,23 @@ static void simple_dict(void)
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
@@ -1163,11 +1163,11 @@ static void simple_list(void)
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
@@ -1175,21 +1175,21 @@ static void simple_list(void)
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
@@ -1220,11 +1220,11 @@ static void simple_whitespace(void)
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
@@ -1232,12 +1232,12 @@ static void simple_whitespace(void)
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
@@ -1245,13 +1245,13 @@ static void simple_whitespace(void)
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
@@ -1282,10 +1282,10 @@ static void simple_varargs(void)
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
--=20
2.13.5
