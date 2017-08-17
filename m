Received: from eggs.gnu.org ([2001:4830:134:3::10]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFb-0001t0-5V
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFY-00070b-0x
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFX-0006yF-O6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:10 +0200
Message-Id: <1502951113-4246-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] tests: Enable the drive_del test also on
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

By using the "virtio-xxx" device name aliases instead of the
"virtio-xxx-pci" names, we can use this test on s390x, too,
to check that adding and deleting also works fine with the
virtio-ccw bus.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |  1 +
 tests/drive_del-test.c | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0bb18b3..ff2a551 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -363,6 +363,7 @@ check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
 check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
+check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2175139..efceb31 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -65,12 +65,12 @@ static void test_after_failed_device_add(void)
 
     qtest_start("-drive if=none,id=drive0");
 
-    /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
+    /* Make device_add fail.  If this leaks the virtio-blk device then a
      * reference to drive0 will also be held (via qdev properties).
      */
     response = qmp("{'execute': 'device_add',"
                    " 'arguments': {"
-                   "   'driver': 'virtio-blk-pci',"
+                   "   'driver': 'virtio-blk',"
                    "   'drive': 'drive0'"
                    "}}");
     g_assert(response);
@@ -82,7 +82,7 @@ static void test_after_failed_device_add(void)
     drive_del();
 
     /* Try to re-add the drive.  This fails with duplicate IDs if a leaked
-     * virtio-blk-pci exists that holds a reference to the old drive0.
+     * virtio-blk exists that holds a reference to the old drive0.
      */
     drive_add();
 
@@ -93,7 +93,7 @@ static void test_drive_del_device_del(void)
 {
     /* Start with a drive used by a device that unplugs instantaneously */
     qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
-                " -device virtio-scsi-pci"
+                " -device virtio-scsi"
                 " -device scsi-hd,drive=drive0,id=dev0");
 
     /*
@@ -114,9 +114,10 @@ int main(int argc, char **argv)
 
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
-- 
1.8.3.1
