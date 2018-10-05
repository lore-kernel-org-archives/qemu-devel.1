Received: from eggs.gnu.org ([2001:4830:134:3::10]:59057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFe-0001Bm-UX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFe-0006bk-34
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PFd-0006at-Rj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:06 +0400
Message-Id: <20181005122910.11745-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/12] tests/qom-proplist: check properties
 are not listed multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

And factor out a common function used by the follow class properties
iterator test.

Fix uninitialized "seentype" variable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/check-qom-proplist.c | 44 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 0f6d9c1ce3..2c07719607 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -520,32 +520,19 @@ static void test_dummy_getenum(void)
 }
=20
=20
-static void test_dummy_iterator(void)
+static void test_dummy_prop_iterator(ObjectPropertyIterator *iter)
 {
-    Object *parent =3D object_get_objects_root();
-    DummyObject *dobj =3D DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
-                              parent,
-                              "dummy0",
-                              &error_abort,
-                              "bv", "yes",
-                              "sv", "Hiss hiss hiss",
-                              "av", "platypus",
-                              NULL));
-
+    bool seenbv =3D false, seensv =3D false, seenav =3D false, seentype =
=3D false;
     ObjectProperty *prop;
-    ObjectPropertyIterator iter;
-    bool seenbv =3D false, seensv =3D false, seenav =3D false, seentype;
=20
-    object_property_iter_init(&iter, OBJECT(dobj));
-    while ((prop =3D object_property_iter_next(&iter))) {
-        if (g_str_equal(prop->name, "bv")) {
+    while ((prop =3D object_property_iter_next(iter))) {
+        if (!seenbv && g_str_equal(prop->name, "bv")) {
             seenbv =3D true;
-        } else if (g_str_equal(prop->name, "sv")) {
+        } else if (!seensv && g_str_equal(prop->name, "sv")) {
             seensv =3D true;
-        } else if (g_str_equal(prop->name, "av")) {
+        } else if (!seenav && g_str_equal(prop->name, "av")) {
             seenav =3D true;
-        } else if (g_str_equal(prop->name, "type")) {
+        } else if (!seentype && g_str_equal(prop->name, "type")) {
             /* This prop comes from the base Object class */
             seentype =3D true;
         } else {
@@ -557,7 +544,24 @@ static void test_dummy_iterator(void)
     g_assert(seenav);
     g_assert(seensv);
     g_assert(seentype);
+}
=20
+static void test_dummy_iterator(void)
+{
+    Object *parent =3D object_get_objects_root();
+    DummyObject *dobj =3D DUMMY_OBJECT(
+        object_new_with_props(TYPE_DUMMY,
+                              parent,
+                              "dummy0",
+                              &error_abort,
+                              "bv", "yes",
+                              "sv", "Hiss hiss hiss",
+                              "av", "platypus",
+                              NULL));
+    ObjectPropertyIterator iter;
+
+    object_property_iter_init(&iter, OBJECT(dobj));
+    test_dummy_prop_iterator(&iter);
     object_unparent(OBJECT(dobj));
 }
=20
--=20
2.19.0.271.gfe8321ec05
