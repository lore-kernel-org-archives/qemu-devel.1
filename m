Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSKzq-0006VG-Qe
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSKqO-0001oD-QJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:50:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSKqO-0001np-IY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D400930A3AC1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:50:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 29 Nov 2018 12:50:48 +0100
Message-Id: <1543492248-28356-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0] tests/display-vga: Enable virtio-vga
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, kraxel@redhat.com, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

There are some "#ifdef CONFIG_VIRTIO_VGA" in the code here which
do not work as expected: CONFIG_VIRTIO_VGA is a Makefile switch,
but not a CPP macro, so the "guarded" code currently simply never
gets enabled.

So enable this code now unconditionally, with some runtime switches
for the architectures that have the VIRTIO_VGA device enabled by
default. Looking at the other if-statement in the main function here,
it also seems like this test was originally supposed to be running
on "mips" and "alpha", too, so enable it now for these architectures
in the Makefile, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Yes, I know, this will likely also be done in a better way once
 "qgraph" gets merged ... but for the time being, it's a simple
 fix to get some more test coverage...

 tests/Makefile.include   |  5 +++++
 tests/display-vga-test.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9b26116..9336029 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -222,18 +222,23 @@ check-qtest-x86_64-y += $(check-qtest-i386-y)
 check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 
 check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
+check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
 check-qtest-hppa-y += tests/boot-serial-test$(EXESUF)
+check-qtest-hppa-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
 check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblaze-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+check-qtest-mips-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
 check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+check-qtest-mips64-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
 check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+check-qtest-mips64el-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
 check-qtest-moxie-y += tests/boot-serial-test$(EXESUF)
 
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 2d7d24e..bd176dc 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -40,13 +40,11 @@ static void pci_virtio_gpu(void)
     qtest_end();
 }
 
-#ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
 {
     qtest_start("-vga none -device virtio-vga");
     qtest_end();
 }
-#endif
 
 int main(int argc, char **argv)
 {
@@ -62,8 +60,10 @@ int main(int argc, char **argv)
     qtest_add_func("/display/pci/secondary", pci_secondary);
     qtest_add_func("/display/pci/multihead", pci_multihead);
     qtest_add_func("/display/pci/virtio-gpu", pci_virtio_gpu);
-#ifdef CONFIG_VIRTIO_VGA
-    qtest_add_func("/display/pci/virtio-vga", pci_virtio_vga);
-#endif
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
+        g_str_equal(arch, "hppa") || g_str_equal(arch, "ppc64")) {
+        qtest_add_func("/display/pci/virtio-vga", pci_virtio_vga);
+    }
+
     return g_test_run();
 }
-- 
1.8.3.1
