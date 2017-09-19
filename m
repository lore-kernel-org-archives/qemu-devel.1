Received: from eggs.gnu.org ([2001:4830:134:3::10]:44290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxI-00024a-3h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxG-0007ON-Qs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJxG-0007Nn-IA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:00 +0200
Message-Id: <20170919145636.9389-3-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/38] tests: Enable the drive_del test also on
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We can use the drive_del test on s390x, too, to check that adding and
deleting also works fine with the virtio-ccw bus. But we have to make
sure that we use the devices with the "-ccw" suffix instead of the
"-pci" suffix for the virtio-ccw transport on s390x. Introduce a helper
function called qvirtio_get_dev_type() that returns the correct string
for the current architecture.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1504190408-11143-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/Makefile.include |  3 ++-
 tests/drive_del-test.c | 25 ++++++++++++++++---------
 tests/libqos/virtio.c  | 17 +++++++++++++++++
 tests/libqos/virtio.h  |  3 +++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..24b2225d26 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -366,6 +366,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
+check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
@@ -767,7 +768,7 @@ tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
-tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-pc-obj-y)
+tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2175139abb..c9ac997555 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/virtio.h"
 
 static void drive_add(void)
 {
@@ -65,14 +66,14 @@ static void test_after_failed_device_add(void)
 
     qtest_start("-drive if=none,id=drive0");
 
-    /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
+    /* Make device_add fail. If this leaks the virtio-blk device then a
      * reference to drive0 will also be held (via qdev properties).
      */
     response = qmp("{'execute': 'device_add',"
                    " 'arguments': {"
-                   "   'driver': 'virtio-blk-pci',"
+                   "   'driver': 'virtio-blk-%s',"
                    "   'drive': 'drive0'"
-                   "}}");
+                   "}}", qvirtio_get_dev_type());
     g_assert(response);
     error = qdict_get_qdict(response, "error");
     g_assert_cmpstr(qdict_get_try_str(error, "class"), ==, "GenericError");
@@ -82,7 +83,7 @@ static void test_after_failed_device_add(void)
     drive_del();
 
     /* Try to re-add the drive.  This fails with duplicate IDs if a leaked
-     * virtio-blk-pci exists that holds a reference to the old drive0.
+     * virtio-blk device exists that holds a reference to the old drive0.
      */
     drive_add();
 
@@ -91,10 +92,14 @@ static void test_after_failed_device_add(void)
 
 static void test_drive_del_device_del(void)
 {
+    char *args;
+
     /* Start with a drive used by a device that unplugs instantaneously */
-    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
-                " -device virtio-scsi-pci"
-                " -device scsi-hd,drive=drive0,id=dev0");
+    args = g_strdup_printf("-drive if=none,id=drive0,file=null-co://,format=raw"
+                           " -device virtio-scsi-%s"
+                           " -device scsi-hd,drive=drive0,id=dev0",
+                           qvirtio_get_dev_type());
+    qtest_start(args);
 
     /*
      * Delete the drive, and then the device
@@ -104,6 +109,7 @@ static void test_drive_del_device_del(void)
     device_del();
 
     qtest_end();
+    g_free(args);
 }
 
 int main(int argc, char **argv)
@@ -114,9 +120,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/drive_del/without-dev", test_drive_without_dev);
 
-    /* TODO I guess any arch with PCI would do */
+    /* TODO I guess any arch with a hot-pluggable virtio bus would do */
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64") ||
-        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64")) {
+        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
+        !strcmp(arch, "s390x")) {
         qtest_add_func("/drive_del/after_failed_device_add",
                        test_after_failed_device_add);
         qtest_add_func("/blockdev/drive_del_device_del",
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 9880a6964e..0879a621c8 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -339,3 +339,20 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     /* vq->avail->used_event */
     writew(vq->avail + 4 + (2 * vq->size), idx);
 }
+
+/*
+ * qvirtio_get_dev_type:
+ * Returns: the preferred virtio bus/device type for the current architecture.
+ */
+const char *qvirtio_get_dev_type(void)
+{
+    const char *arch = qtest_get_arch();
+
+    if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
+        return "device";  /* for virtio-mmio */
+    } else if (g_str_equal(arch, "s390x")) {
+        return "ccw";
+    } else {
+        return "pci";
+    }
+}
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 8fbcd1869c..0a04740adf 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -143,4 +143,7 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
 bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx);
 
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
+
+const char *qvirtio_get_dev_type(void);
+
 #endif
-- 
2.13.5
