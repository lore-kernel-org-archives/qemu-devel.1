Received: from eggs.gnu.org ([2001:4830:134:3::10]:44905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uA-00018d-RS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9u8-0003I2-2u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:50 -0500
Received: from mail-eopbgr00098.outbound.protection.outlook.com
	([40.107.0.98]:32000
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9u7-0003GM-SC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:48 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:36 +0300
Message-Id: <20180206203048.11096-23-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 22/34] i386: Hyper-V VMBus ACPI DSDT entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

From: Andrey Smetanin <asmetanin@virtuozzo.com>

Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
entry to DSDT in case vmbus has been enabled.

Experimentally Windows guests were found to require this entry to
include two IRQ resources, so this patch adds two semi-arbitrarily
chosen ones (7 and 13).  This results, in particular, in parallel port
conflicting with vmbus.

TODO: discover and use spare IRQs to avoid conflicts.

Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/i386/acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ed78c4ed9f..6f8cd3eb41 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -46,6 +46,7 @@
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
 #include "sysemu/numa.h"
+#include "hw/vmbus/vmbus.h"
 
 /* Supported chipsets: */
 #include "hw/acpi/piix4.h"
@@ -1317,6 +1318,43 @@ static Aml *build_com_device_aml(uint8_t uid)
     return dev;
 }
 
+static Aml *build_vmbus_device_aml(void)
+{
+    Aml *dev;
+    Aml *method;
+    Aml *crs;
+
+    dev = aml_device("VMBS");
+    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
+    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
+
+    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_name("STA"), aml_local(0)));
+    aml_append(method, aml_return(aml_local(0)));
+    aml_append(dev, method);
+
+    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_irq_no_flags(7));
+    aml_append(crs, aml_irq_no_flags(13));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    return dev;
+}
+
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
@@ -1343,6 +1381,10 @@ static void build_isa_devices_aml(Aml *table)
         build_acpi_ipmi_devices(scope, BUS(obj));
     }
 
+    if (vmbus_exists()) {
+        aml_append(scope, build_vmbus_device_aml());
+    }
+
     aml_append(table, scope);
 }
 
-- 
2.14.3
