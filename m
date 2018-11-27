Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZiQ-0004tt-6W
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZiP-0006Rv-Cy
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZiP-0006Qg-5M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:55 +0400
Message-Id: <20181127092801.21777-23-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 22/28] qom: teach interfaces to
 implement post-init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

The following patches are going to implement post_init callbacks for
settings properties. The interface post_init are called before the
instance post_init, so the default interface behaviour can be
overriden if necessary.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c                |  8 +++++++-
 tests/check-qom-interface.c | 23 +++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index aa6f3a2a71..8fa59026c5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -288,7 +288,6 @@ static void type_initialize(TypeImpl *ti)
         assert(ti->instance_size =3D=3D 0);
         assert(ti->abstract);
         assert(!ti->instance_init);
-        assert(!ti->instance_post_init);
         assert(!ti->instance_finalize);
         assert(!ti->num_interfaces);
     }
@@ -361,6 +360,13 @@ static void object_init_with_type(Object *obj, TypeI=
mpl *ti)
=20
 static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 {
+    GSList *e;
+
+    for (e =3D ti->class->interfaces; e; e =3D e->next) {
+        TypeImpl *itype =3D OBJECT_CLASS(e->data)->type;
+        object_post_init_with_type(obj, itype);
+    }
+
     if (ti->instance_post_init) {
         ti->instance_post_init(obj);
     }
diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
index 2177f0dce5..cd2dd6dcee 100644
--- a/tests/check-qom-interface.c
+++ b/tests/check-qom-interface.c
@@ -31,9 +31,27 @@ typedef struct TestIfClass {
     uint32_t test;
 } TestIfClass;
=20
+typedef struct DirectImpl {
+    Object parent_obj;
+
+    bool if_post_init;
+} DirectImpl;
+
+#define TYPE_DIRECT_IMPL "direct-impl"
+#define DIRECT_IMPL(obj) \
+    OBJECT_CHECK(DirectImpl, (obj), TYPE_DIRECT_IMPL)
+
+static void test_if_post_init(Object *obj)
+{
+    DirectImpl *d =3D DIRECT_IMPL(obj);
+
+    d->if_post_init =3D true;
+}
+
 static const TypeInfo test_if_info =3D {
     .name          =3D TYPE_TEST_IF,
     .parent        =3D TYPE_INTERFACE,
+    .instance_post_init =3D test_if_post_init,
     .class_size =3D sizeof(TestIfClass),
 };
=20
@@ -47,11 +65,10 @@ static void test_class_init(ObjectClass *oc, void *da=
ta)
     tc->test =3D PATTERN;
 }
=20
-#define TYPE_DIRECT_IMPL "direct-impl"
-
 static const TypeInfo direct_impl_info =3D {
     .name =3D TYPE_DIRECT_IMPL,
     .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(DirectImpl),
     .class_init =3D test_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_TEST_IF },
@@ -70,10 +87,12 @@ static void test_interface_impl(const char *type)
 {
     Object *obj =3D object_new(type);
     TestIf *iobj =3D TEST_IF(obj);
+    DirectImpl *d =3D DIRECT_IMPL(obj);
     TestIfClass *ioc =3D TEST_IF_GET_CLASS(iobj);
=20
     g_assert(iobj);
     g_assert(ioc->test =3D=3D PATTERN);
+    g_assert(d->if_post_init =3D=3D true);
     object_unref(obj);
 }
=20
--=20
2.20.0.rc1
