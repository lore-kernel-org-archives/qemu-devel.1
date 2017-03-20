Received: from eggs.gnu.org ([2001:4830:134:3::10]:41208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qq-0001oH-2G
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qk-00052n-Bx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qk-00051c-2r
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8j2k025512
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ae098uh8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:36 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:36 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:12 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-49-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 48/81] x86: ioapic: fix fail migration when
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
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit 0f254b1ae04b36e2ab2d91528297ed60d40c8c08)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/ioapic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index fd9208f..5fa8481 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -426,6 +426,11 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
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
2.7.4
