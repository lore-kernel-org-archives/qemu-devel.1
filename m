Received: from eggs.gnu.org ([2001:4830:134:3::10]:41925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmNG-0006GY-My
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmND-0005xd-82
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmNC-0005vp-Sx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:03:11 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:28 -0200
Message-Id: <20181211180129.7661-24-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/24] qdev: move
 qdev_prop_register_global_list() to tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The function is only used by a test, move it there.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181204142023.15982-6-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
