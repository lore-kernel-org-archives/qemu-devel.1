Received: from eggs.gnu.org ([2001:4830:134:3::10]:59412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zJ-0003uZ-EW
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zI-0004n8-K5
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:57 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  5 Jan 2017 16:29:45 +0100
Message-Id: <1483630188-32021-3-git-send-email-lvivier@redhat.com>
In-Reply-To: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
References: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] qtest: add display-vga-test to ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Only enable for ppc64 in the Makefile, but added
code in the file to check cirrus card only on architectures
supporting it (alpha, mips, i386, x86_64).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
---
 tests/Makefile.include   | 1 +
 tests/display-vga-test.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8d6ac7a..05cf535 100644
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
2.7.4
