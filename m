Received: from eggs.gnu.org ([2001:4830:134:3::10]:55077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOie-0005uo-Cn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiY-0007WP-CP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiY-0007Uv-8b
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D26D877885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:11 +0200
Message-Id: <20180717120414.5852-12-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] check: Only test virtio-rng when it is
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
 hw/virtio/virtio-pci.c | 6 ++++--
 tests/Makefile.include | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bdbc7ab78d..75c96990c0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2472,7 +2472,7 @@ static const TypeInfo virtio_net_pci_info = {
 };
 
 /* virtio-rng-pci */
-
+#ifdef CONFIG_VIRTIO_RNG
 static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
@@ -2521,7 +2521,7 @@ static const TypeInfo virtio_rng_pci_info = {
     .instance_init = virtio_rng_initfn,
     .class_init    = virtio_rng_pci_class_init,
 };
-
+#endif
 /* virtio-input-pci */
 
 static Property virtio_input_pci_properties[] = {
@@ -2693,7 +2693,9 @@ static const TypeInfo virtio_pci_bus_info = {
 
 static void virtio_pci_register_types(void)
 {
+#ifdef CONFIG_VIRTIO_RNG
     type_register_static(&virtio_rng_pci_info);
+#endif
     type_register_static(&virtio_input_pci_info);
     type_register_static(&virtio_input_hid_pci_info);
     type_register_static(&virtio_keyboard_pci_info);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7feda20577..a9cb5e926b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -195,8 +195,8 @@ check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF
 gcov-files-virtio-$(CONFIG_VIRTIO_BALLOON) += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
-gcov-files-virtio-y += hw/virtio/virtio-rng.c
+check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_RNG) += hw/virtio/virtio-rng.c
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
-- 
2.17.1
