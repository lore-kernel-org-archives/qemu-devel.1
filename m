Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZgL-00038q-6r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZgF-0004gM-Ey
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZgD-0004eX-IC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6DB42D80D
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 09:29:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:42 +0400
Message-Id: <20181127092801.21777-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 09/28] tests:
 qdev_prop_check_globals() doesn't return "all_used"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Instead, it returns 1 if an error was detected, which is the case for:

/qdev/properties/dynamic/global/subprocess:
warning: global dynamic-prop-type-bad.prop3 has invalid class name
warning: global nohotplug-type.prop5=3D105 not used
warning: global nondevice-type.prop6 has invalid class name

Clarify the function return value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.20.0.rc1
