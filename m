Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddGCs-0000SY-8p
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddGCo-0003ad-BL
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:30:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ddGCo-0003ZT-2R
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:30:26 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  3 Aug 2017 15:30:19 +0200
Message-Id: <1501767019-4989-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/pxe: Check virtio-net-ccw on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

Now that we've got a firmware that can do TFTP booting on s390x (i.e.
the pc-bios/s390-netboot.img), we can enable the PXE tester for this
architecture, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Since this only adds a test, I guess this could still be included
 for 2.10 ... otherwise, I think it's also OK to simply postpone this
 to 2.11 instead
 
 tests/Makefile.include |  1 +
 tests/boot-sector.c    | 25 ++++++++++++++++++++++---
 tests/pxe-test.c       |  7 +++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59e536b..f9af5e3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -337,6 +337,7 @@ check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
 
 check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
+check-qtest-s390x-y += tests/pxe-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index e3880f4..87a8fb5 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -21,6 +21,7 @@
 #define SIGNATURE 0xdead
 #define SIGNATURE_OFFSET 0x10
 #define BOOT_SECTOR_ADDRESS 0x7c00
+#define SIGNATURE_ADDR (BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET)
 
 /* Boot sector code: write SIGNATURE into memory,
  * then halt.
@@ -73,6 +74,7 @@ int boot_sector_init(char *fname)
 {
     int fd, ret;
     size_t len = sizeof boot_sector;
+    const char *arch = qtest_get_arch();
 
     fd = mkstemp(fname);
     if (fd < 0) {
@@ -81,10 +83,27 @@ int boot_sector_init(char *fname)
     }
 
     /* For Open Firmware based system, we can use a Forth script instead */
-    if (strcmp(qtest_get_arch(), "ppc64") == 0) {
+    if (g_str_equal(arch, "ppc64")) {
         len = sprintf((char *)boot_sector, "\\ Bootscript\n%x %x c! %x %x c!\n",
-                LOW(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET,
-                HIGH(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET + 1);
+                LOW(SIGNATURE), SIGNATURE_ADDR,
+                HIGH(SIGNATURE), SIGNATURE_ADDR + 1);
+    } else if (g_str_equal(arch, "s390x")) {
+        /* For s390x, fake a kernel signature */
+        const uint8_t psw[] = {
+            0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
+        };
+        const uint8_t code[] = {
+            0xa7, 0xf4, 0x00, 0x0a,     /* j 0x10010 */
+            0x00, 0x00, 0x00, 0x00,
+            'S', '3', '9', '0',
+            'E', 'P', 0x00, 0x01,
+            0xa7, 0x38, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lhi r3 */
+            0xa7, 0x48, LOW(SIGNATURE), HIGH(SIGNATURE),    /* lhi r4,0xadde */
+            0x40, 0x40, 0x30, 0x00,     /* sth r4,0(r3) */
+            0xa7, 0xf4, 0xff, 0xfa      /* j 0x10010 */
+        };
+        memcpy(boot_sector, psw, 8);
+        memcpy(&boot_sector[0x10000], code, sizeof(code));
     }
 
     ret = write(fd, boot_sector, len);
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index cf6e225..0d70afc 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -51,6 +51,11 @@ static void test_pxe_spapr_vlan(void)
     test_pxe_one("-device spapr-vlan,netdev=" NETNAME, true);
 }
 
+static void test_pxe_virtio_ccw(void)
+{
+    test_pxe_one("-device virtio-net-ccw,bootindex=1,netdev=" NETNAME, false);
+}
+
 int main(int argc, char *argv[])
 {
     int ret;
@@ -68,6 +73,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "ppc64") == 0) {
         qtest_add_func("pxe/virtio", test_pxe_virtio_pci);
         qtest_add_func("pxe/spapr-vlan", test_pxe_spapr_vlan);
+    } else if (g_str_equal(arch, "s390x")) {
+        qtest_add_func("pxe/virtio-ccw", test_pxe_virtio_ccw);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
1.8.3.1
