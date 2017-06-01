Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQq-00043K-Ky
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQp-0005oY-Qd
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:28 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQp-0005oL-JM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:27 -0400
Received: by mail-wm0-x234.google.com with SMTP id d127so58788403wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:46 +0200
Message-Id: <1496320911-51305-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/33] edu: fix memory leak on msi_broken
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

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
index 401039c..01acacf 100644
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
1.8.3.1
