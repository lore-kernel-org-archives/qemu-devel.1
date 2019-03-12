Received: from eggs.gnu.org ([209.51.188.92]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vse-0008P6-Aj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vlr-0007T2-HV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3Vln-0007PM-N7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:27 -0300
Message-Id: <20190312005930.9043-5-ehabkost@redhat.com>
In-Reply-To: <20190312005930.9043-1-ehabkost@redhat.com>
References: <20190312005930.9043-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] hostmem-memfd: disable for systems without
 sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Ilya Maximets <i.maximets@samsung.com>

From: Ilya Maximets <i.maximets@samsung.com>

If seals are not supported, memfd_create() will fail.
Furthermore, there is no way to disable it in this case because
'.seal' property is not registered.

This issue leads to vhost-user-test failures on RHEL 7.2:

  qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
                      failed to create memfd: Invalid argument

and actually breaks the feature on such systems.

Let's restrict memfd backend to systems with sealing support.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Message-Id: <20190311135850.6537-2-i.maximets@samsung.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-memfd.c | 18 ++++++++----------
 tests/vhost-user-test.c  |  5 +++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 98c9bf3240..46b15b916a 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -154,15 +154,13 @@ memfd_backend_class_init(ObjectClass *oc, void *data)
                                               "Huge pages size (ex: 2M, 1G)",
                                               &error_abort);
     }
-    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
-        object_class_property_add_bool(oc, "seal",
-                                       memfd_backend_get_seal,
-                                       memfd_backend_set_seal,
-                                       &error_abort);
-        object_class_property_set_description(oc, "seal",
-                                              "Seal growing & shrinking",
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
 
 static const TypeInfo memfd_backend_info = {
@@ -175,7 +173,7 @@ static const TypeInfo memfd_backend_info = {
 
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
@@ -178,7 +178,8 @@ static void append_mem_opts(TestServer *server, GString *cmd_line,
                             int size, enum test_memfd memfd)
 {
     if (memfd == TEST_MEMFD_AUTO) {
-        memfd = qemu_memfd_check(0) ? TEST_MEMFD_YES : TEST_MEMFD_NO;
+        memfd = qemu_memfd_check(MFD_ALLOW_SEALING) ? TEST_MEMFD_YES
+                                                    : TEST_MEMFD_NO;
     }
 
     if (memfd == TEST_MEMFD_YES) {
@@ -930,7 +931,7 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_read_guest_mem, &opts);
 
-    if (qemu_memfd_check(0)) {
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         opts.before = vhost_user_test_setup_memfd;
         qos_add_test("vhost-user/read-guest-mem/memfd",
                      "virtio-net",
-- 
2.18.0.rc1.1.g3f1ff2140
