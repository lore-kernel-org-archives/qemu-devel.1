Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMc-0005l6-OS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMb-0005Oq-TX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMb-0005OF-MR
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:24 -0200
Message-Id: <20181211180129.7661-20-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/24] tests: qdev_prop_check_globals() doesn't
 return "all_used"
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

Instead, it returns 1 if an error was detected, which is the case for:

/qdev/properties/dynamic/global/subprocess:
warning: global dynamic-prop-type-bad.prop3 has invalid class name
warning: global nohotplug-type.prop5=3D105 not used
warning: global nondevice-type.prop6 has invalid class name

Clarify the function return value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181204142023.15982-2-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-qdev-global-props.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index d81b0862d5..ccdf6c57c1 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -214,7 +214,7 @@ static void test_dynamic_globalprop_subprocess(void)
         { TYPE_NONDEVICE, "prop6", "106", true },
         {}
     };
-    int all_used;
+    int global_error;
=20
     qdev_prop_register_global_list(props);
=20
@@ -223,8 +223,8 @@ static void test_dynamic_globalprop_subprocess(void)
=20
     g_assert_cmpuint(mt->prop1, =3D=3D, 101);
     g_assert_cmpuint(mt->prop2, =3D=3D, 102);
-    all_used =3D qdev_prop_check_globals();
-    g_assert_cmpuint(all_used, =3D=3D, 1);
+    global_error =3D qdev_prop_check_globals();
+    g_assert_cmpuint(global_error, =3D=3D, 1);
     g_assert(props[0].used);
     g_assert(props[1].used);
     g_assert(!props[2].used);
@@ -259,7 +259,7 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
         { TYPE_NONDEVICE, "prop6", "106" },
         {}
     };
-    int all_used;
+    int global_error;
=20
     qdev_prop_register_global_list(props);
=20
@@ -268,8 +268,8 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
=20
     g_assert_cmpuint(mt->prop1, =3D=3D, 101);
     g_assert_cmpuint(mt->prop2, =3D=3D, 102);
-    all_used =3D qdev_prop_check_globals();
-    g_assert_cmpuint(all_used, =3D=3D, 0);
+    global_error =3D qdev_prop_check_globals();
+    g_assert_cmpuint(global_error, =3D=3D, 0);
     g_assert(props[0].used);
     g_assert(props[1].used);
     g_assert(!props[2].used);
--=20
2.18.0.rc1.1.g3f1ff2140
