Received: from eggs.gnu.org ([209.51.188.92]:44477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKa-0007Aa-Hs
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKY-0000Jd-4j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghxKX-0000Hx-RY
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71AAC9B32A
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:58:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 14:58:34 +0100
Message-Id: <20190111135835.3453-2-kraxel@redhat.com>
In-Reply-To: <20190111135835.3453-1-kraxel@redhat.com>
References: <20190111135835.3453-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] tests/display-vga: Enable virtio-vga test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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
Message-id: 1543492248-28356-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/display-vga-test.c | 10 +++++-----
 tests/Makefile.include   |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 2d7d24eee0..bd176dcf3a 100644
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9c84bbd829..a4e59eeb37 100644
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
 
-- 
2.9.3
