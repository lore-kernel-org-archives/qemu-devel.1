Received: from eggs.gnu.org ([2001:4830:134:3::10]:55029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOia-0005qF-Nc
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiZ-0007Z0-Nj
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiZ-0007Yh-Iv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31E357D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:12 +0200
Message-Id: <20180717120414.5852-13-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] check: Only test virtio-gpu when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include   | 4 ++--
 tests/display-vga-test.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a9cb5e926b..c4d68061e5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -238,8 +238,8 @@ check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 gcov-files-pci-y += hw/display/vga.c
 gcov-files-pci-y += hw/display/cirrus_vga.c
 gcov-files-pci-y += hw/display/vga-pci.c
-gcov-files-pci-y += hw/display/virtio-gpu.c
-gcov-files-pci-y += hw/display/virtio-gpu-pci.c
+gcov-files-pci-$(CONFIG_VIRTIO_GPU) += hw/display/virtio-gpu.c
+gcov-files-pci-$(CONFIG_VIRTIO_GPU) += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 2d7d24eee0..b716e70a4b 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -34,11 +34,13 @@ static void pci_multihead(void)
     qtest_end();
 }
 
+#ifdef CONFIG_VIRTIO_GPU
 static void pci_virtio_gpu(void)
 {
     qtest_start("-vga none -device virtio-gpu-pci");
     qtest_end();
 }
+#endif
 
 #ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
@@ -61,7 +63,9 @@ int main(int argc, char **argv)
     qtest_add_func("/display/pci/stdvga", pci_stdvga);
     qtest_add_func("/display/pci/secondary", pci_secondary);
     qtest_add_func("/display/pci/multihead", pci_multihead);
+#ifdef CONFIG_VIRTIO_GPU
     qtest_add_func("/display/pci/virtio-gpu", pci_virtio_gpu);
+#endif
 #ifdef CONFIG_VIRTIO_VGA
     qtest_add_func("/display/pci/virtio-vga", pci_virtio_vga);
 #endif
-- 
2.17.1
