Received: from eggs.gnu.org ([2001:4830:134:3::10]:37890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7D-00088m-6Z
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN74-0007Nz-2y
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:19 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:49 +0400
Message-Id: <20181107123652.23417-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 11/14] qom: teach interfaces to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index b1a7f70550..980eeb8283 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -290,7 +290,6 @@ static void type_initialize(TypeImpl *ti)
         assert(ti->instance_size =3D=3D 0);
         assert(ti->abstract);
         assert(!ti->instance_init);
-        assert(!ti->instance_post_init);
         assert(!ti->instance_finalize);
         assert(!ti->num_interfaces);
     }
@@ -363,6 +362,13 @@ static void object_init_with_type(Object *obj, TypeI=
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
2.19.1.708.g4ede3d42df
