Received: from eggs.gnu.org ([2001:4830:134:3::10]:47616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZd-0004cc-5E
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZc-0006xK-1r
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBZb-0006ww-OE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:09 +0400
Message-Id: <20181204142023.15982-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 05/19] qdev: move
 qdev_prop_register_global_list() to tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The function is only used by a test, move it there.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/hw/qdev-properties.h   |  1 -
 hw/core/qdev-properties.c      |  9 ---------
 tests/test-qdev-global-props.c | 18 ++++++++++++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index a95f4a73eb..3ab9cd2eb6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -249,7 +249,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char =
*name, int value);
 void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
=20
 void qdev_prop_register_global(GlobalProperty *prop);
-void qdev_prop_register_global_list(GlobalProperty *props);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *=
dev,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ab61d502fd..bd84c4ea4c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1180,15 +1180,6 @@ void qdev_prop_register_global(GlobalProperty *pro=
p)
     global_props =3D g_list_append(global_props, prop);
 }
=20
-void qdev_prop_register_global_list(GlobalProperty *props)
-{
-    int i;
-
-    for (i =3D 0; props[i].driver !=3D NULL; i++) {
-        qdev_prop_register_global(props+i);
-    }
-}
-
 int qdev_prop_check_globals(void)
 {
     GList *l;
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index ccdf6c57c1..b1eb505442 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -89,6 +89,16 @@ static void test_static_prop(void)
     g_test_trap_assert_stdout("");
 }
=20
+static void register_global_properties(GlobalProperty *props)
+{
+    int i;
+
+    for (i =3D 0; props[i].driver !=3D NULL; i++) {
+        qdev_prop_register_global(props + i);
+    }
+}
+
+
 /* Test setting of static property using global properties */
 static void test_static_globalprop_subprocess(void)
 {
@@ -98,7 +108,7 @@ static void test_static_globalprop_subprocess(void)
         {}
     };
=20
-    qdev_prop_register_global_list(props);
+    register_global_properties(props);
=20
     mt =3D STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
     qdev_init_nofail(DEVICE(mt));
@@ -216,7 +226,7 @@ static void test_dynamic_globalprop_subprocess(void)
     };
     int global_error;
=20
-    qdev_prop_register_global_list(props);
+    register_global_properties(props);
=20
     mt =3D DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
     qdev_init_nofail(DEVICE(mt));
@@ -261,7 +271,7 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
     };
     int global_error;
=20
-    qdev_prop_register_global_list(props);
+    register_global_properties(props);
=20
     mt =3D DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
     qdev_init_nofail(DEVICE(mt));
@@ -299,7 +309,7 @@ static void test_subclass_global_props(void)
         {}
     };
=20
-    qdev_prop_register_global_list(props);
+    register_global_properties(props);
=20
     mt =3D STATIC_TYPE(object_new(TYPE_SUBCLASS));
     qdev_init_nofail(DEVICE(mt));
--=20
2.20.0.rc1
