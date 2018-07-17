Received: from eggs.gnu.org ([2001:4830:134:3::10]:54855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiO-0005Uo-8x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiM-00074o-A6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiM-00073c-4r
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC5137C6CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:02 +0200
Message-Id: <20180717120414.5852-3-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 02/14] check: Only test megasas when it is
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
 tests/Makefile.include | 4 ++--
 tests/cdrom-test.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bb1080ecb5..6565206a78 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -245,8 +245,8 @@ check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
-check-qtest-pci-y += tests/megasas-test$(EXESUF)
-gcov-files-pci-y += hw/scsi/megasas.c
+check-qtest-pci-$(CONFIG_MEGASAS_SCSI_PCI) += tests/megasas-test$(EXESUF)
+gcov-files-pci-$(CONFIG_MEGASAS_SCSI_PCI) += hw/scsi/megasas.c
 
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 7a1fce5dfb..42c29524b8 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -143,12 +143,14 @@ static void add_x86_tests(void)
     qtest_add_data_func("cdrom/boot/lsi53c895a",
                         "-device lsi53c895a -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
+#ifdef CONFIG_MEGASAS_SCSI_PCI
     qtest_add_data_func("cdrom/boot/megasas", "-M q35 "
                         "-device megasas -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
     qtest_add_data_func("cdrom/boot/megasas-gen2", "-M q35 "
                         "-device megasas-gen2 -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
+#endif
 }
 
 static void add_s390x_tests(void)
-- 
2.17.1
