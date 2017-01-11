Received: from eggs.gnu.org ([2001:4830:134:3::10]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgl-0003Sr-9o
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgj-0003Sz-GV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:19 +0100
Message-Id: <1484163327-111841-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/33] x86: ioapic: fix fail migration when
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
1.8.3.1
