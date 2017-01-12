Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk8-00037C-0I
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-0006fW-Jc
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:58 +1100
Message-Id: <20170112020327.24882-39-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 38/67] qtest: add display-vga-test to ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Only enable for ppc64 in the Makefile, but added
code in the file to check cirrus card only on architectures
supporting it (alpha, mips, i386, x86_64).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/Makefile.include   | 1 +
 tests/display-vga-test.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 08ddf59..6ed78b8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -287,6 +287,7 @@ check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
+check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 9146021..2d7d24e 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -50,9 +50,14 @@ static void pci_virtio_vga(void)
 
 int main(int argc, char **argv)
 {
+    const char *arch = qtest_get_arch();
+
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/display/pci/cirrus", pci_cirrus);
+    if (strcmp(arch, "alpha") == 0 || strcmp(arch, "i386") == 0 ||
+        strcmp(arch, "mips") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("/display/pci/cirrus", pci_cirrus);
+    }
     qtest_add_func("/display/pci/stdvga", pci_stdvga);
     qtest_add_func("/display/pci/secondary", pci_secondary);
     qtest_add_func("/display/pci/multihead", pci_multihead);
-- 
2.9.3
