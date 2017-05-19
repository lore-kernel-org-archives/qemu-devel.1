Received: from eggs.gnu.org ([2001:4830:134:3::10]:49390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyJ-0004LM-CJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyI-0000wE-AT
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyI-0000vy-3X
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:26 -0400
Received: by mail-wm0-x244.google.com with SMTP id b84so1792230wmh.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:21:00 +0200
Message-Id: <1495192872-27667-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/20] kvm: irqchip: skip update msi when
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
