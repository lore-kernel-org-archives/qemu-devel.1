Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB5-0007mZ-QP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB3-00015g-Gj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:03 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB3-00014a-AN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:01 -0400
Received: by mail-wm0-x22e.google.com with SMTP id v16-v6so11056475wmv.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:57 +0200
Message-Id: <1530216310-52873-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/60] ioapic: support "info pic"
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

People start to use "info pic" for all kinds of irqchip dumps.  Let x86
ioapic join the family.  It dumps the same thing as "info ioapic".

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171229073104.3810-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic_common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 3b3d0a7..c62ba27 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -24,6 +24,7 @@
 #include "monitor/monitor.h"
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
+#include "hw/intc/intc.h"
 #include "hw/sysbus.h"
 
 /* ioapic_no count start from 0 to MAX_IOAPICS,
@@ -142,6 +143,15 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
     ioapic_no++;
 }
 
+static void ioapic_print_info(InterruptStatsProvider *obj,
+                              Monitor *mon)
+{
+    IOAPICCommonState *s = IOAPIC_COMMON(obj);
+
+    ioapic_dispatch_pre_save(s);
+    ioapic_print_redtbl(mon, s);
+}
+
 static const VMStateDescription vmstate_ioapic_common = {
     .name = "ioapic",
     .version_id = 3,
@@ -161,9 +171,11 @@ static const VMStateDescription vmstate_ioapic_common = {
 static void ioapic_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = ioapic_common_realize;
     dc->vmsd = &vmstate_ioapic_common;
+    ic->print_info = ioapic_print_info;
 }
 
 static const TypeInfo ioapic_common_type = {
@@ -173,6 +185,10 @@ static const TypeInfo ioapic_common_type = {
     .class_size = sizeof(IOAPICCommonClass),
     .class_init = ioapic_common_class_init,
     .abstract = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_INTERRUPT_STATS_PROVIDER },
+        { }
+    },
 };
 
 static void ioapic_common_register_types(void)
-- 
1.8.3.1
