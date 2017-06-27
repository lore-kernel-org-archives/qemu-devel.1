Received: from eggs.gnu.org ([2001:4830:134:3::10]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPk-0004tK-9J
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPj-00034T-AO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPj-00034E-2C
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20935C04B93B
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:04:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:34 +0800
Message-Id: <1498554219-4942-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] intel_iommu: support "info iommu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Dump critical information for VT-d. Sample output:

(qemu) info iommu
Version: 1
Cap: 0x12008c22260286
Extended Cap: 0xf00f5a
DMAR: enabled, root=0x7435f000 (extended=0)
IR: enabled, root=0x17a400000, size=0x10000 (eim=1)
QI: enabled, root=0x17aadf000, head=156, tail=156, size=256
Caching-mode: enabled
Misc: next_frr=0, context_gen=2, buggy_eim=0

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c       | 39 +++++++++++++++++++++++++++++++++++++++
 hw/i386/x86-iommu.c         | 17 +++++++++++++++++
 include/hw/i386/x86-iommu.h |  5 +++++
 3 files changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a5c83dd..39f772a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2991,6 +2991,44 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     return true;
 }
 
+#define DUMP(...) monitor_printf(mon, ## __VA_ARGS__)
+static void vtd_info_dump(X86IOMMUState *x86_iommu, Monitor *mon,
+                          const QDict *qdict)
+{
+    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(x86_iommu);
+
+    DUMP("Version: %d\n", 1);
+    DUMP("Cap: 0x%"PRIx64"\n", s->cap);
+    DUMP("Extended Cap: 0x%"PRIx64"\n", s->ecap);
+
+    DUMP("DMAR: %s", s->dmar_enabled ? "enabled" : "disabled");
+    if (s->dmar_enabled) {
+        DUMP(", root=0x%"PRIx64" (extended=%d)",
+             s->root, s->root_extended);
+    }
+    DUMP("\n");
+
+    DUMP("IR: %s", s->intr_enabled ? "enabled" : "disabled");
+    if (s->intr_enabled) {
+        DUMP(", root=0x%"PRIx64", size=0x%"PRIx32" (eim=%d)",
+             s->intr_root, s->intr_size, s->intr_eime);
+    }
+    DUMP("\n");
+
+    DUMP("QI: %s", s->qi_enabled ? "enabled" : "disabled");
+    if (s->qi_enabled) {
+        DUMP(", root=0x%"PRIx64", head=%u, tail=%u, size=%u",
+             s->iq, s->iq_head, s->iq_tail, s->iq_size);
+    }
+    DUMP("\n");
+
+    DUMP("Caching-mode: %s\n", s->caching_mode ? "enabled" : "disabled");
+    DUMP("Misc: next_frr=%d, context_gen=%d, buggy_eim=%d\n",
+         s->next_frcd_reg, s->context_cache_gen, s->buggy_eim);
+    DUMP("      iotlb_size=%d\n", g_hash_table_size(s->iotlb));
+}
+#undef DUMP
+
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -3042,6 +3080,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
+    x86_class->info_dump = vtd_info_dump;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
 }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 293caf8..fed35b4 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -76,6 +76,23 @@ IommuType x86_iommu_get_type(void)
     return x86_iommu_default->type;
 }
 
+void arch_iommu_info(Monitor *mon, const QDict *qdict)
+{
+    X86IOMMUState *iommu = x86_iommu_get_default();
+    X86IOMMUClass *class;
+
+    if (!iommu) {
+        monitor_printf(mon, "No IOMMU is detected.\n");
+        return;
+    }
+
+    class = X86_IOMMU_GET_CLASS(iommu);
+
+    if (class->info_dump) {
+        class->info_dump(iommu, mon, qdict);
+    }
+}
+
 static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index ef89c0c..c414b65 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -22,6 +22,8 @@
 
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
+#include "hw/iommu.h"
+#include "monitor/monitor.h"
 
 #define  TYPE_X86_IOMMU_DEVICE  ("x86-iommu")
 #define  X86_IOMMU_DEVICE(obj) \
@@ -50,6 +52,9 @@ struct X86IOMMUClass {
     /* MSI-based interrupt remapping */
     int (*int_remap)(X86IOMMUState *iommu, MSIMessage *src,
                      MSIMessage *dst, uint16_t sid);
+    /* Dump IOMMU information */
+    void (*info_dump)(X86IOMMUState *iommu, Monitor *mon,
+                      const QDict *qdict);
 };
 
 /**
-- 
2.7.4
