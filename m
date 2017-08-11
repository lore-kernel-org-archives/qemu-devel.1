Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg2xU-0000JN-VF
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 01:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dg2xT-0003gB-QV
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 01:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dg2xT-0003fp-Hn
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 01:58:07 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Aug 2017 07:57:56 +0200
Message-Id: <1502431076-22849-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1502431076-22849-1-git-send-email-thuth@redhat.com>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.11 2/2] tests/pxe: Check
 virtio-net-ccw on s390x
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
 tests/Makefile.include |  1 +
 tests/boot-sector.c    | 20 ++++++++++++++++++++
 tests/pxe-test.c       |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb4895f..2a238db 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -337,6 +337,7 @@ check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
 
 check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index 8729562..9ee8537 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -67,6 +67,21 @@ static uint8_t x86_boot_sector[512] = {
     [0x1FF] = 0xAA,
 };
 
+/* For s390x, use a mini "kernel" with the appropriate signature */
+static const uint8_t s390x_psw[] = {
+    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
+};
+static const uint8_t s390x_code[] = {
+    0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 */
+    0x00, 0x00, 0x00, 0x00,
+    'S', '3', '9', '0',
+    'E', 'P', 0x00, 0x01,
+    0xa7, 0x38, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lhi r3,0x7c10 */
+    0xa7, 0x48, LOW(SIGNATURE), HIGH(SIGNATURE),           /* lhi r4,0xadde */
+    0x40, 0x40, 0x30, 0x00,                                /* sth r4,0(r3) */
+    0xa7, 0xf4, 0xff, 0xfa                                 /* j 0x10010 */
+};
+
 /* Create boot disk file.  */
 int boot_sector_init(char *fname)
 {
@@ -92,6 +107,11 @@ int boot_sector_init(char *fname)
                                     LOW(SIGNATURE), SIGNATURE_ADDR,
                                     HIGH(SIGNATURE), SIGNATURE_ADDR + 1);
         len = strlen(boot_code);
+    } else if (g_str_equal(arch, "s390x")) {
+        len = 0x10000 + sizeof(s390x_code);
+        boot_code = g_malloc0(len);
+        memcpy(boot_code, s390x_psw, sizeof(s390x_psw));
+        memcpy(&boot_code[0x10000], s390x_code, sizeof(s390x_code));
     } else {
         g_assert_not_reached();
     }
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
