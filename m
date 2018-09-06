Received: from eggs.gnu.org ([2001:4830:134:3::10]:43686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxwvW-0005ER-Ea
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxwvQ-0000QJ-A8
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:14:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxwvO-0000Ke-A0
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A558402332F
	for <qemu-devel@nongnu.org>; Thu,  6 Sep 2018 16:14:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 20:14:15 +0400
Message-Id: <20180906161415.8543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hostmem-memfd: add checks before adding
 hostmem-memfd & properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Run some memfd-related checks before registering hostmem-memfd &
various properties. This will help libvirt to figure out what the host
is supposed to be capable of.

qemu_memfd_check() is changed to a less optimized version, since it is
used with various flags, it no longer caches the result.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h     | 18 +++++++++++++++++-
 backends/hostmem-memfd.c | 32 +++++++++++++++++++-------------
 tests/vhost-user-test.c  |  6 +++---
 util/memfd.c             | 35 ++++++-----------------------------
 4 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 49e79634da..d551c28b68 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,12 +16,28 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
=20
+#ifndef MFD_CLOEXEC
+#define MFD_CLOEXEC 0x0001U
+#endif
+
+#ifndef MFD_ALLOW_SEALING
+#define MFD_ALLOW_SEALING 0x0002U
+#endif
+
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
+
+#ifndef MFD_HUGE_SHIFT
+#define MFD_HUGE_SHIFT 26
+#endif
+
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **=
errp);
 bool qemu_memfd_alloc_check(void);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
-bool qemu_memfd_check(void);
+bool qemu_memfd_check(unsigned int flags);
=20
 #endif /* QEMU_MEMFD_H */
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 7184918112..ccf70a0694 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -138,18 +138,22 @@ memfd_backend_class_init(ObjectClass *oc, void *dat=
a)
=20
     bc->alloc =3D memfd_backend_memory_alloc;
=20
-    object_class_property_add_bool(oc, "hugetlb",
-                                   memfd_backend_get_hugetlb,
-                                   memfd_backend_set_hugetlb,
-                                   &error_abort);
-    object_class_property_add(oc, "hugetlbsize", "int",
-                              memfd_backend_get_hugetlbsize,
-                              memfd_backend_set_hugetlbsize,
-                              NULL, NULL, &error_abort);
-    object_class_property_add_bool(oc, "seal",
-                                   memfd_backend_get_seal,
-                                   memfd_backend_set_seal,
-                                   &error_abort);
+    if (qemu_memfd_check(MFD_HUGETLB)) {
+        object_class_property_add_bool(oc, "hugetlb",
+                                       memfd_backend_get_hugetlb,
+                                       memfd_backend_set_hugetlb,
+                                       &error_abort);
+        object_class_property_add(oc, "hugetlbsize", "int",
+                                  memfd_backend_get_hugetlbsize,
+                                  memfd_backend_set_hugetlbsize,
+                                  NULL, NULL, &error_abort);
+    }
+    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
+        object_class_property_add_bool(oc, "seal",
+                                       memfd_backend_get_seal,
+                                       memfd_backend_set_seal,
+                                       &error_abort);
+    }
 }
=20
 static const TypeInfo memfd_backend_info =3D {
@@ -162,7 +166,9 @@ static const TypeInfo memfd_backend_info =3D {
=20
 static void register_types(void)
 {
-    type_register_static(&memfd_backend_info);
+    if (qemu_memfd_check(0)) {
+        type_register_static(&memfd_backend_info);
+    }
 }
=20
 type_init(register_types);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 716aff7153..45d58d8ea2 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -169,7 +169,7 @@ static char *get_qemu_cmd(TestServer *s,
                           int mem, enum test_memfd memfd, const char *me=
m_path,
                           const char *chr_opts, const char *extra)
 {
-    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check()) {
+    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
         memfd =3D TEST_MEMFD_YES;
     }
=20
@@ -903,7 +903,7 @@ static void test_multiqueue(void)
     s->queues =3D 2;
     test_server_listen(s);
=20
-    if (qemu_memfd_check()) {
+    if (qemu_memfd_check(0)) {
         cmd =3D g_strdup_printf(
             QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
             "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
@@ -963,7 +963,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread =3D g_thread_new(NULL, thread_function, loop);
=20
-    if (qemu_memfd_check()) {
+    if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
                             test_read_guest_mem);
diff --git a/util/memfd.c b/util/memfd.c
index d248a53c3c..c4bd076182 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -45,22 +45,6 @@ static int memfd_create(const char *name, unsigned int=
 flags)
 }
 #endif
=20
-#ifndef MFD_CLOEXEC
-#define MFD_CLOEXEC 0x0001U
-#endif
-
-#ifndef MFD_ALLOW_SEALING
-#define MFD_ALLOW_SEALING 0x0002U
-#endif
-
-#ifndef MFD_HUGETLB
-#define MFD_HUGETLB 0x0004U
-#endif
-
-#ifndef MFD_HUGE_SHIFT
-#define MFD_HUGE_SHIFT 26
-#endif
-
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **=
errp)
 {
@@ -200,23 +184,16 @@ bool qemu_memfd_alloc_check(void)
  *
  * Check if host supports memfd.
  */
-bool qemu_memfd_check(void)
+bool qemu_memfd_check(unsigned int flags)
 {
 #ifdef CONFIG_LINUX
-    static int memfd_check =3D MEMFD_TODO;
+    int mfd =3D memfd_create("test", flags);
=20
-    if (memfd_check =3D=3D MEMFD_TODO) {
-        int mfd =3D memfd_create("test", 0);
-        if (mfd >=3D 0) {
-            memfd_check =3D MEMFD_OK;
-            close(mfd);
-        } else {
-            memfd_check =3D MEMFD_KO;
-        }
+    if (mfd >=3D 0) {
+        close(mfd);
+        return true;
     }
+#endif
=20
-    return memfd_check =3D=3D MEMFD_OK;
-#else
     return false;
-#endif
 }
--=20
2.19.0.rc1
