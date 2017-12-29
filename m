Received: from eggs.gnu.org ([2001:4830:134:3::10]:34034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8R-0005RL-Gg
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8Q-0007XE-Iq
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUp8Q-0007Vg-CB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 819C7491
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 07:31:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Dec 2017 15:31:01 +0800
Message-Id: <20171229073104.3810-3-peterx@redhat.com>
In-Reply-To: <20171229073104.3810-1-peterx@redhat.com>
References: <20171229073104.3810-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] ioapic: support "info pic"
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

People start to use "info pic" for all kinds of irqchip dumps.  Let x86
ioapic join the family.  It dumps the same thing as "info ioapic".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/ioapic_common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 3b3d0a7680..c62ba27018 100644
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
2.14.3
