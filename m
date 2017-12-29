Received: from eggs.gnu.org ([2001:4830:134:3::10]:34111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8f-0005dj-Um
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8d-0007c0-7j
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUp8d-0007bl-14
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30A29C04AC5E
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 07:31:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Dec 2017 15:31:04 +0800
Message-Id: <20171229073104.3810-6-peterx@redhat.com>
In-Reply-To: <20171229073104.3810-1-peterx@redhat.com>
References: <20171229073104.3810-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] hmp: obsolete "info ioapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

Let's start to use "info pic" just like other platforms.  For now we
keep the command for a while so that old users can know what is the new
command to use.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/kvm/ioapic.c  |  9 ---------
 hw/intc/ioapic.c      | 11 -----------
 include/hw/i386/pc.h  |  3 ---
 target/i386/monitor.c |  8 ++------
 4 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 0db9a89bd1..e6cb468910 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -112,15 +112,6 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
     }
 }
 
-void kvm_ioapic_dump_state(Monitor *mon, const QDict *qdict)
-{
-    IOAPICCommonState *s = IOAPIC_COMMON(object_resolve_path("ioapic", NULL));
-
-    assert(s);
-    kvm_ioapic_get(s);
-    ioapic_print_redtbl(mon, s);
-}
-
 static void kvm_ioapic_reset(DeviceState *dev)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1f0c76571e..aa7f030971 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -235,17 +235,6 @@ void ioapic_eoi_broadcast(int vector)
     }
 }
 
-void ioapic_dump_state(Monitor *mon, const QDict *qdict)
-{
-    int i;
-
-    for (i = 0; i < MAX_IOAPICS; i++) {
-        if (ioapics[i] != 0) {
-            ioapic_print_redtbl(mon, ioapics[i]);
-        }
-    }
-}
-
 static uint64_t
 ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6f77eb0665..b9f8a79967 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -169,9 +169,6 @@ int pic_get_output(DeviceState *d);
 
 /* ioapic.c */
 
-void kvm_ioapic_dump_state(Monitor *mon, const QDict *qdict);
-void ioapic_dump_state(Monitor *mon, const QDict *qdict);
-
 /* Global System Interrupts */
 
 #define GSI_NUM_PINS IOAPIC_NUM_PINS
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 75e155ffb1..4ff81ae676 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -652,10 +652,6 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 
 void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
 {
-    if (kvm_irqchip_in_kernel() &&
-        !kvm_irqchip_is_split()) {
-        kvm_ioapic_dump_state(mon, qdict);
-    } else {
-        ioapic_dump_state(mon, qdict);
-    }
+    monitor_printf(mon, "This command is obsolete and will be "
+                   "removed soon. Please use 'info pic' instead.\n");
 }
-- 
2.14.3
