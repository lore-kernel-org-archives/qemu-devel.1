Received: from eggs.gnu.org ([2001:4830:134:3::10]:59103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747b-0005G4-UY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Z-000578-3V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com
	([104.47.37.49]:27474
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Y-000562-RK
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:45 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:29 +0000
Message-ID: <1538423049-29524-3-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 2/9] x86_iommu: move
 vtd_generate_msi_message in common file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

The vtd_generate_msi_message() in intel-iommu is used to construct a MSI
Message from IRQ. A similar function will be needed when we add interrupt
remapping support in amd-iommu. Moving the function in common file to
avoid the code duplication. Rename it to x86_iommu_irq_to_msi_message().
There is no logic changes in the code flow.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/intel_iommu.c         | 32 +++------------------
 hw/i386/x86-iommu.c           | 24 ++++++++++++++++
 include/hw/i386/intel_iommu.h | 59 --------------------------------------
 include/hw/i386/x86-iommu.h   | 66 +++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 94 insertions(+), 87 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 84dbc20..014418b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2701,7 +2701,7 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint1=
6_t index,
=20
 /* Fetch IRQ information of specific IR index */
 static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
-                             VTDIrq *irq, uint16_t sid)
+                             X86IOMMUIrq *irq, uint16_t sid)
 {
     VTD_IR_TableEntry irte =3D {};
     int ret =3D 0;
@@ -2730,30 +2730,6 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu,=
 uint16_t index,
     return 0;
 }
=20
-/* Generate one MSI message from VTDIrq info */
-static void vtd_generate_msi_message(VTDIrq *irq, MSIMessage *msg_out)
-{
-    VTD_MSIMessage msg =3D {};
-
-    /* Generate address bits */
-    msg.dest_mode =3D irq->dest_mode;
-    msg.redir_hint =3D irq->redir_hint;
-    msg.dest =3D irq->dest;
-    msg.__addr_hi =3D irq->dest & 0xffffff00;
-    msg.__addr_head =3D cpu_to_le32(0xfee);
-    /* Keep this from original MSI address bits */
-    msg.__not_used =3D irq->msi_addr_last_bits;
-
-    /* Generate data bits */
-    msg.vector =3D irq->vector;
-    msg.delivery_mode =3D irq->delivery_mode;
-    msg.level =3D 1;
-    msg.trigger_mode =3D irq->trigger_mode;
-
-    msg_out->address =3D msg.msi_addr;
-    msg_out->data =3D msg.msi_data;
-}
-
 /* Interrupt remapping for MSI/MSI-X entry */
 static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
                                    MSIMessage *origin,
@@ -2763,7 +2739,7 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *i=
ommu,
     int ret =3D 0;
     VTD_IR_MSIAddress addr;
     uint16_t index;
-    VTDIrq irq =3D {};
+    X86IOMMUIrq irq =3D {};
=20
     assert(origin && translated);
=20
@@ -2842,8 +2818,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *i=
ommu,
      */
     irq.msi_addr_last_bits =3D addr.addr.__not_care;
=20
-    /* Translate VTDIrq to MSI message */
-    vtd_generate_msi_message(&irq, translated);
+    /* Translate X86IOMMUIrq to MSI message */
+    x86_iommu_irq_to_msi_message(&irq, translated);
=20
 out:
     trace_vtd_ir_remap_msi(origin->address, origin->data,
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 7440cb8..abc3c03 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -53,6 +53,30 @@ void x86_iommu_iec_notify_all(X86IOMMUState *iommu, bool=
 global,
     }
 }
=20
+/* Generate one MSI message from VTDIrq info */
+void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
+{
+    X86IOMMU_MSIMessage msg =3D {};
+
+    /* Generate address bits */
+    msg.dest_mode =3D irq->dest_mode;
+    msg.redir_hint =3D irq->redir_hint;
+    msg.dest =3D irq->dest;
+    msg.__addr_hi =3D irq->dest & 0xffffff00;
+    msg.__addr_head =3D cpu_to_le32(0xfee);
+    /* Keep this from original MSI address bits */
+    msg.__not_used =3D irq->msi_addr_last_bits;
+
+    /* Generate data bits */
+    msg.vector =3D irq->vector;
+    msg.delivery_mode =3D irq->delivery_mode;
+    msg.level =3D 1;
+    msg.trigger_mode =3D irq->trigger_mode;
+
+    msg_out->address =3D msg.msi_addr;
+    msg_out->data =3D msg.msi_data;
+}
+
 /* Default X86 IOMMU device */
 static X86IOMMUState *x86_iommu_default =3D NULL;
=20
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fbfedcb..ed4e758 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -66,8 +66,6 @@ typedef struct VTDIOTLBEntry VTDIOTLBEntry;
 typedef struct VTDBus VTDBus;
 typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
-typedef struct VTDIrq VTDIrq;
-typedef struct VTD_MSIMessage VTD_MSIMessage;
=20
 /* Context-Entry */
 struct VTDContextEntry {
@@ -197,63 +195,6 @@ union VTD_IR_MSIAddress {
     uint32_t data;
 };
=20
-/* Generic IRQ entry information */
-struct VTDIrq {
-    /* Used by both IOAPIC/MSI interrupt remapping */
-    uint8_t trigger_mode;
-    uint8_t vector;
-    uint8_t delivery_mode;
-    uint32_t dest;
-    uint8_t dest_mode;
-
-    /* only used by MSI interrupt remapping */
-    uint8_t redir_hint;
-    uint8_t msi_addr_last_bits;
-};
-
-struct VTD_MSIMessage {
-    union {
-        struct {
-#ifdef HOST_WORDS_BIGENDIAN
-            uint32_t __addr_head:12; /* 0xfee */
-            uint32_t dest:8;
-            uint32_t __reserved:8;
-            uint32_t redir_hint:1;
-            uint32_t dest_mode:1;
-            uint32_t __not_used:2;
-#else
-            uint32_t __not_used:2;
-            uint32_t dest_mode:1;
-            uint32_t redir_hint:1;
-            uint32_t __reserved:8;
-            uint32_t dest:8;
-            uint32_t __addr_head:12; /* 0xfee */
-#endif
-            uint32_t __addr_hi;
-        } QEMU_PACKED;
-        uint64_t msi_addr;
-    };
-    union {
-        struct {
-#ifdef HOST_WORDS_BIGENDIAN
-            uint16_t trigger_mode:1;
-            uint16_t level:1;
-            uint16_t __resved:3;
-            uint16_t delivery_mode:3;
-            uint16_t vector:8;
-#else
-            uint16_t vector:8;
-            uint16_t delivery_mode:3;
-            uint16_t __resved:3;
-            uint16_t level:1;
-            uint16_t trigger_mode:1;
-#endif
-            uint16_t __resved1;
-        } QEMU_PACKED;
-        uint32_t msi_data;
-    };
-};
-
 /* When IR is enabled, all MSI/MSI-X data bits should be zero */
 #define VTD_IR_MSI_DATA          (0)
=20
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 7c71fc7..2b22a57 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -22,6 +22,7 @@
=20
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
=20
 #define  TYPE_X86_IOMMU_DEVICE  ("x86-iommu")
 #define  X86_IOMMU_DEVICE(obj) \
@@ -35,6 +36,8 @@
=20
 typedef struct X86IOMMUState X86IOMMUState;
 typedef struct X86IOMMUClass X86IOMMUClass;
+typedef struct X86IOMMUIrq X86IOMMUIrq;
+typedef struct X86IOMMU_MSIMessage X86IOMMU_MSIMessage;
=20
 typedef enum IommuType {
     TYPE_INTEL,
@@ -78,6 +81,63 @@ struct X86IOMMUState {
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
=20
+/* Generic IRQ entry information when interrupt remapping is enabled */
+struct X86IOMMUIrq {
+    /* Used by both IOAPIC/MSI interrupt remapping */
+    uint8_t trigger_mode;
+    uint8_t vector;
+    uint8_t delivery_mode;
+    uint32_t dest;
+    uint8_t dest_mode;
+
+    /* only used by MSI interrupt remapping */
+    uint8_t redir_hint;
+    uint8_t msi_addr_last_bits;
+};
+
+struct X86IOMMU_MSIMessage {
+    union {
+        struct {
+#ifdef HOST_WORDS_BIGENDIAN
+            uint32_t __addr_head:12; /* 0xfee */
+            uint32_t dest:8;
+            uint32_t __reserved:8;
+            uint32_t redir_hint:1;
+            uint32_t dest_mode:1;
+            uint32_t __not_used:2;
+#else
+            uint32_t __not_used:2;
+            uint32_t dest_mode:1;
+            uint32_t redir_hint:1;
+            uint32_t __reserved:8;
+            uint32_t dest:8;
+            uint32_t __addr_head:12; /* 0xfee */
+#endif
+            uint32_t __addr_hi;
+        } QEMU_PACKED;
+        uint64_t msi_addr;
+    };
+    union {
+        struct {
+#ifdef HOST_WORDS_BIGENDIAN
+            uint16_t trigger_mode:1;
+            uint16_t level:1;
+            uint16_t __resved:3;
+            uint16_t delivery_mode:3;
+            uint16_t vector:8;
+#else
+            uint16_t vector:8;
+            uint16_t delivery_mode:3;
+            uint16_t __resved:3;
+            uint16_t level:1;
+            uint16_t trigger_mode:1;
+#endif
+            uint16_t __resved1;
+        } QEMU_PACKED;
+        uint32_t msi_data;
+    };
+};
+
 /**
  * x86_iommu_get_default - get default IOMMU device
  * @return: pointer to default IOMMU device
@@ -110,4 +170,10 @@ void x86_iommu_iec_register_notifier(X86IOMMUState *io=
mmu,
 void x86_iommu_iec_notify_all(X86IOMMUState *iommu, bool global,
                               uint32_t index, uint32_t mask);
=20
+/**
+ * x86_iommu_irq_to_msi_message - Populate one MSIMessage from X86IOMMUIrq
+ * @X86IOMMUIrq: The IRQ information
+ * @out: Output MSI message
+ */
+void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *out);
 #endif
--=20
2.7.4
