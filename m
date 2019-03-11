Received: from eggs.gnu.org ([209.51.188.92]:51261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSb-0008Ss-E1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSa-0000Sy-Er
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3LSa-0000S9-7H
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311135918euoutp0279aea9f58c738e61e4ddd1abdcdb121c~K7DqsJuR22095420954euoutp02R
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:59:18 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 11 Mar 2019 16:58:47 +0300
Message-Id: <20190311135850.6537-2-i.maximets@samsung.com>
In-Reply-To: <20190311135850.6537-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20190311135850.6537-1-i.maximets@samsung.com>
	<CGME20190311135916eucas1p27b50ca29c84af5f7529d56fd43a2964d@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

If seals are not supported, memfd_create() will fail.
Furthermore, there is no way to disable it in this case because
'.seal' property is not registered.

This issue leads to vhost-user-test failures on RHEL 7.2:

  qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,: \
                      failed to create memfd: Invalid argument

and actually breaks the feature on such systems.

Let's restrict memfd backend to systems with sealing support.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---
 backends/hostmem-memfd.c | 18 ++++++++----------
 tests/vhost-user-test.c  |  5 +++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 98c9bf3240..46b15b916a 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -154,15 +154,13 @@ memfd_backend_class_init(ObjectClass *oc, void *dat=
a)
                                               "Huge pages size (ex: 2M, =
1G)",
                                               &error_abort);
     }
-    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
-        object_class_property_add_bool(oc, "seal",
-                                       memfd_backend_get_seal,
-                                       memfd_backend_set_seal,
-                                       &error_abort);
-        object_class_property_set_description(oc, "seal",
-                                              "Seal growing & shrinking"=
,
-                                              &error_abort);
-    }
+    object_class_property_add_bool(oc, "seal",
+                                   memfd_backend_get_seal,
+                                   memfd_backend_set_seal,
+                                   &error_abort);
+    object_class_property_set_description(oc, "seal",
+                                          "Seal growing & shrinking",
+                                          &error_abort);
 }
=20
 static const TypeInfo memfd_backend_info =3D {
@@ -175,7 +173,7 @@ static const TypeInfo memfd_backend_info =3D {
=20
 static void register_types(void)
 {
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         type_register_static(&memfd_backend_info);
     }
 }
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 0c965b3b1e..3817966010 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -178,7 +178,8 @@ static void append_mem_opts(TestServer *server, GStri=
ng *cmd_line,
                             int size, enum test_memfd memfd)
 {
     if (memfd =3D=3D TEST_MEMFD_AUTO) {
-        memfd =3D qemu_memfd_check(0) ? TEST_MEMFD_YES : TEST_MEMFD_NO;
+        memfd =3D qemu_memfd_check(MFD_ALLOW_SEALING) ? TEST_MEMFD_YES
+                                                    : TEST_MEMFD_NO;
     }
=20
     if (memfd =3D=3D TEST_MEMFD_YES) {
@@ -930,7 +931,7 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_read_guest_mem, &opts);
=20
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         opts.before =3D vhost_user_test_setup_memfd;
         qos_add_test("vhost-user/read-guest-mem/memfd",
                      "virtio-net",
--=20
2.17.1
