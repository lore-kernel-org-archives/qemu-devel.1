Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5J-00045Z-1c
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5F-00067x-4r
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:37:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:39 +0400
Message-Id: <20181107123652.23417-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 01/14] tests:
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Instead, it returns 1 if an error was detected, which is the case for:

/qdev/properties/dynamic/global/subprocess:
warning: global dynamic-prop-type-bad.prop3 has invalid class name
warning: global nohotplug-type.prop5=3D105 not used
warning: global nondevice-type.prop6 has invalid class name

Clarify the function return value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.19.1.708.g4ede3d42df
