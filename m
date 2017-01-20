Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIW-00048c-MI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIV-0006OQ-S7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:08 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:28 +0100
Message-Id: <20170120133139.31080-25-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/35] x86: ioapic: fix fail migration when
 irqchip=split
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable@nongnu.org

From: Peter Xu <peterx@redhat.com>

Split irqchip works based on the fact that we kept the first 24 gsi
routing entries inside KVM for userspace ioapic's use. When system
boot, we'll reserve these MSI routing entries before hand. However,
after migration, we forgot to re-configure it up in the destination
side. The result is, we'll get invalid gsi routing entries after
migration (all empty), and we get interrupts with vector=0, then
strange things happen, like keyboard hang.

The solution is simple - we update them after migration, which is a
one line fix.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1483952153-7221-4-git-send-email-peterx@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index d1254f8..9047b89 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -439,6 +439,11 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = ioapic_realize;
+    /*
+     * If APIC is in kernel, we need to update the kernel cache after
+     * migration, otherwise first 24 gsi routes will be invalid.
+     */
+    k->post_load = ioapic_update_kvm_routes;
     dc->reset = ioapic_reset_common;
     dc->props = ioapic_properties;
 }
-- 
2.9.3
