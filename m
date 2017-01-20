Received: from eggs.gnu.org ([2001:4830:134:3::10]:53552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIZ-0004Av-Cw
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIT-0006LX-J6
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIT-0006Ky-Ar
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:05 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D486C04BD21
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:32:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:26 +0100
Message-Id: <20170120133139.31080-23-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/35] x86: ioapic: add traces for ioapic
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

>From time to time, there are issues with ioapic, either on guest side or
on hypervisor side. Good to have some persistent traces for better
triaging and debugging.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1483952153-7221-2-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c     | 17 +++++++++++++++--
 hw/intc/trace-events |  7 +++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index ea7ea0b..d1254f8 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -33,6 +33,7 @@
 #include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
+#include "trace.h"
 
 //#define DEBUG_IOAPIC
 
@@ -115,6 +116,7 @@ static void ioapic_service(IOAPICCommonState *s)
                     s->irr &= ~mask;
                 } else {
                     coalesce = s->ioredtbl[i] & IOAPIC_LVT_REMOTE_IRR;
+                    trace_ioapic_set_remote_irr(i);
                     s->ioredtbl[i] |= IOAPIC_LVT_REMOTE_IRR;
                 }
 
@@ -220,6 +222,8 @@ void ioapic_eoi_broadcast(int vector)
     uint64_t entry;
     int i, n;
 
+    trace_ioapic_eoi_broadcast(vector);
+
     for (i = 0; i < MAX_IOAPICS; i++) {
         s = ioapics[i];
         if (!s) {
@@ -229,6 +233,7 @@ void ioapic_eoi_broadcast(int vector)
             entry = s->ioredtbl[n];
             if ((entry & IOAPIC_LVT_REMOTE_IRR)
                 && (entry & IOAPIC_VECTOR_MASK) == vector) {
+                trace_ioapic_clear_remote_irr(n, vector);
                 s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
                 if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
                     ioapic_service(s);
@@ -256,7 +261,9 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
     int index;
     uint32_t val = 0;
 
-    switch (addr & 0xff) {
+    addr &= 0xff;
+
+    switch (addr) {
     case IOAPIC_IOREGSEL:
         val = s->ioregsel;
         break;
@@ -286,6 +293,9 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
         DPRINTF("read: %08x = %08x\n", s->ioregsel, val);
         break;
     }
+
+    trace_ioapic_mem_read(addr, size, val);
+
     return val;
 }
 
@@ -324,7 +334,10 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     IOAPICCommonState *s = opaque;
     int index;
 
-    switch (addr & 0xff) {
+    addr &= 0xff;
+    trace_ioapic_mem_write(addr, size, val);
+
+    switch (addr) {
     case IOAPIC_IOREGSEL:
         s->ioregsel = val;
         break;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 340f617..180b893 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -14,6 +14,13 @@ apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode, uint8_t
 apic_mem_readl(uint64_t addr, uint32_t val)  "%"PRIx64" = %08x"
 apic_mem_writel(uint64_t addr, uint32_t val) "%"PRIx64" = %08x"
 
+# hw/intc/ioapic.c
+ioapic_set_remote_irr(int n) "set remote irr for pin %d"
+ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
+ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
+ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
+ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
+
 # hw/intc/slavio_intctl.c
 slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = %x"
 slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg 0x%"PRIx64" = %x"
-- 
2.9.3
