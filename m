Received: from eggs.gnu.org ([2001:4830:134:3::10]:34066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3CD-0002ux-4M
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3C9-0000YC-SS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dG3C9-0000Y4-MR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:57:49 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EF8864D28
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:57:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 14:57:46 +0200
Message-Id: <20170531125746.17585-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] edu: fix memory leak on msi_broken platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Peter Xu <peterx@redhat.com>

If msi_init fails, the thread has already been created and the
mutex/condvar are not destroyed.  Initialize everything only
after the point where pci_edu_realize cannot fail.

Reported-by: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/edu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 401039c100..01acacf142 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -343,6 +343,12 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     EduState *edu = DO_UPCAST(EduState, pdev, pdev);
     uint8_t *pci_conf = pdev->config;
 
+    pci_config_set_interrupt_pin(pci_conf, 1);
+
+    if (msi_init(pdev, 0, 1, true, false, errp)) {
+        return;
+    }
+
     timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_dma_timer, edu);
 
     qemu_mutex_init(&edu->thr_mutex);
@@ -350,12 +356,6 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
                        edu, QEMU_THREAD_JOINABLE);
 
-    pci_config_set_interrupt_pin(pci_conf, 1);
-
-    if (msi_init(pdev, 0, 1, true, false, errp)) {
-        return;
-    }
-
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 << 20);
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
-- 
2.13.0
