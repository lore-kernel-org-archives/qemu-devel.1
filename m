Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB7-0007ow-HJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB6-0001Aw-Ei
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:05 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB6-00018x-6n
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:04 -0400
Received: by mail-wr0-x236.google.com with SMTP id k6-v6so6688692wrp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:00 +0200
Message-Id: <1530216310-52873-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/60] hmp: obsolete "info ioapic"
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

Let's start to use "info pic" just like other platforms.  For now we
keep the command for a while so that old users can know what is the new
command to use.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171229073104.3810-6-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/ioapic.c  |  9 ---------
 hw/intc/ioapic.c      | 11 -----------
 include/hw/i386/pc.h  |  3 ---
 target/i386/monitor.c |  8 ++------
 4 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 5274dc7..5b40d75 100644
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
index 222f3f7..b393780 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -234,17 +234,6 @@ void ioapic_eoi_broadcast(int vector)
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
index 316230e..4d99d69 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -154,9 +154,6 @@ int pic_get_output(DeviceState *d);
 
 /* ioapic.c */
 
-void kvm_ioapic_dump_state(Monitor *mon, const QDict *qdict);
-void ioapic_dump_state(Monitor *mon, const QDict *qdict);
-
 /* Global System Interrupts */
 
 #define GSI_NUM_PINS IOAPIC_NUM_PINS
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a890b3c..6bbb3a9 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -658,12 +658,8 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 
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
 
 SevInfo *qmp_query_sev(Error **errp)
-- 
1.8.3.1
