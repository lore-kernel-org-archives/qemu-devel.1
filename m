Received: from eggs.gnu.org ([2001:4830:134:3::10]:59577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQU-0003OS-1K
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQT-0005i7-2s
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQS-0005hq-T5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:05 -0400
Received: by mail-wm0-x244.google.com with SMTP id d127so11019465wmf.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:26 +0200
Message-Id: <1496320911-51305-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] kvm: irqchip: skip update msi when
 disabled
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

From: Peter Xu <peterx@redhat.com>

It's possible that one device kept its irqfd/virq there even when
MSI/MSIX was disabled globally for that device. One example is
virtio-net-pci (see commit f1d0f15a6 and virtio_pci_vq_vector_mask()).
It is used as a fast path to avoid allocate/release irqfd/virq
frequently when guest enables/disables MSIX.

However, this fast path brought a problem to msi_route_list, that the
device MSIRouteEntry is still dangling there even if MSIX disabled -
then we cannot know which message to fetch, even if we can, the messages
are meaningless. In this case, we can just simply ignore this entry.

It's safe, since when MSIX is enabled again, we'll rebuild them no
matter what.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1448813

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1494309644-18743-4-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 011d4a5..82c72d2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -43,6 +43,7 @@
 #include "standard-headers/asm-x86/hyperv.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
 #include "trace.h"
@@ -3510,12 +3511,17 @@ static void kvm_update_msi_routes_all(void *private, bool global,
     int cnt = 0;
     MSIRouteEntry *entry;
     MSIMessage msg;
+    PCIDevice *dev;
+
     /* TODO: explicit route update */
     QLIST_FOREACH(entry, &msi_route_list, list) {
         cnt++;
-        msg = pci_get_msi_message(entry->dev, entry->vector);
-        kvm_irqchip_update_msi_route(kvm_state, entry->virq,
-                                     msg, entry->dev);
+        dev = entry->dev;
+        if (!msix_enabled(dev) && !msi_enabled(dev)) {
+            continue;
+        }
+        msg = pci_get_msi_message(dev, entry->vector);
+        kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
     }
     kvm_irqchip_commit_routes(kvm_state);
     trace_kvm_x86_update_msi_routes(cnt);
-- 
1.8.3.1
