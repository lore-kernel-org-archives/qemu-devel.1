Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlL-0002NS-BT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlH-0008Dl-E7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRdlH-0008Ct-7q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127135046euoutp02369699b56fbc094c7eff6b16905697f2~q-2hwdcu_2240422404euoutp02P
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:50:46 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 16:50:27 +0300
Message-Id: <20181127135030.1671-2-i.maximets@samsung.com>
In-Reply-To: <20181127135030.1671-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

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
 tests/vhost-user-test.c  |  6 +++---
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index b6836b28e5..a3455da9c9 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -156,15 +156,13 @@ memfd_backend_class_init(ObjectClass *oc, void *dat=
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
@@ -177,7 +175,7 @@ static const TypeInfo memfd_backend_info =3D {
=20
 static void register_types(void)
 {
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         type_register_static(&memfd_backend_info);
     }
 }
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 45d58d8ea2..e3e9a33580 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -169,7 +169,7 @@ static char *get_qemu_cmd(TestServer *s,
                           int mem, enum test_memfd memfd, const char *me=
m_path,
                           const char *chr_opts, const char *extra)
 {
-    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
+    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(MFD_ALLOW_SEALI=
NG)) {
         memfd =3D TEST_MEMFD_YES;
     }
=20
@@ -903,7 +903,7 @@ static void test_multiqueue(void)
     s->queues =3D 2;
     test_server_listen(s);
=20
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         cmd =3D g_strdup_printf(
             QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
             "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
@@ -963,7 +963,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread =3D g_thread_new(NULL, thread_function, loop);
=20
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
                             test_read_guest_mem);
--=20
2.17.1
