Received: from eggs.gnu.org ([2001:4830:134:3::10]:59100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747b-0005G0-Sx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Z-00057Z-TR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com
	([104.47.37.49]:27474
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Z-000562-Ke
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:45 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:39 +0000
Message-ID: <1538423049-29524-7-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 6/9] x86_iommu/amd: Add interrupt remap
 support when VAPIC is not enabled
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

Emulate the interrupt remapping support when guest virtual APIC is
not enabled.

For more info Refer: AMD IOMMU spec Rev 3.0 - section 2.2.5.1

When VAPIC is not enabled, it uses interrupt remapping as defined in
Table 20 and Figure 15 from IOMMU spec.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c  | 199 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 hw/i386/amd_iommu.h  |  46 +++++++++++-
 hw/i386/trace-events |   7 ++
 3 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9118a75..8e2f13c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "hw/i386/apic_internal.h"
 #include "trace.h"
+#include "hw/i386/apic-msidef.h"
=20
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] =3D {
@@ -1032,21 +1033,146 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRe=
gion *iommu, hwaddr addr,
     return ret;
 }
=20
+static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte=
,
+                          union irte *irte, uint16_t devid)
+{
+    uint64_t irte_root, offset;
+
+    irte_root =3D dte[2] & AMDVI_IR_PHYS_ADDR_MASK;
+    offset =3D (origin->data & AMDVI_IRTE_OFFSET) << 2;
+
+    trace_amdvi_ir_irte(irte_root, offset);
+
+    if (dma_memory_read(&address_space_memory, irte_root + offset,
+                        irte, sizeof(*irte))) {
+        trace_amdvi_ir_err("failed to get irte");
+        return -AMDVI_IR_GET_IRTE;
+    }
+
+    trace_amdvi_ir_irte_val(irte->val);
+
+    return 0;
+}
+
+static int amdvi_int_remap_legacy(AMDVIState *iommu,
+                                  MSIMessage *origin,
+                                  MSIMessage *translated,
+                                  uint64_t *dte,
+                                  X86IOMMUIrq *irq,
+                                  uint16_t sid)
+{
+    int ret;
+    union irte irte;
+
+    /* get interrupt remapping table */
+    ret =3D amdvi_get_irte(iommu, origin, dte, &irte, sid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!irte.fields.valid) {
+        trace_amdvi_ir_target_abort("RemapEn is disabled");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    if (irte.fields.guest_mode) {
+        error_report_once("guest mode is not zero");
+        return -AMDVI_IR_ERR;
+    }
+
+    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+        error_report_once("reserved int_type");
+        return -AMDVI_IR_ERR;
+    }
+
+    irq->delivery_mode =3D irte.fields.int_type;
+    irq->vector =3D irte.fields.vector;
+    irq->dest_mode =3D irte.fields.dm;
+    irq->redir_hint =3D irte.fields.rq_eoi;
+    irq->dest =3D irte.fields.destination;
+
+    return 0;
+}
+
+static int __amdvi_int_remap_msi(AMDVIState *iommu,
+                                 MSIMessage *origin,
+                                 MSIMessage *translated,
+                                 uint64_t *dte,
+                                 X86IOMMUIrq *irq,
+                                 uint16_t sid)
+{
+    uint8_t int_ctl;
+
+    int_ctl =3D (dte[2] >> AMDVI_IR_INTCTL_SHIFT) & 3;
+    trace_amdvi_ir_intctl(int_ctl);
+
+    switch (int_ctl) {
+    case AMDVI_IR_INTCTL_PASS:
+        memcpy(translated, origin, sizeof(*origin));
+        return 0;
+    case AMDVI_IR_INTCTL_REMAP:
+        break;
+    case AMDVI_IR_INTCTL_ABORT:
+        trace_amdvi_ir_target_abort("int_ctl abort");
+        return -AMDVI_IR_TARGET_ABORT;
+    default:
+        trace_amdvi_ir_err("int_ctl reserved");
+        return -AMDVI_IR_ERR;
+    }
+
+    return amdvi_int_remap_legacy(iommu, origin, translated, dte, irq, sid=
);
+}
+
 /* Interrupt remapping for MSI/MSI-X entry */
 static int amdvi_int_remap_msi(AMDVIState *iommu,
                                MSIMessage *origin,
                                MSIMessage *translated,
                                uint16_t sid)
 {
+    int ret =3D 0;
+    uint64_t pass =3D 0;
+    uint64_t dte[4] =3D { 0 };
+    X86IOMMUIrq irq =3D { 0 };
+    uint8_t dest_mode, delivery_mode;
+
     assert(origin && translated);
=20
+    /*
+     * When IOMMU is enabled, interrupt remap request will come either fro=
m
+     * IO-APIC or PCI device. If interrupt is from PCI device then it will
+     * have a valid requester id but if the interrupt is from IO-APIC
+     * then requester id will be invalid.
+     */
+    if (sid =3D=3D X86_IOMMU_SID_INVALID) {
+        sid =3D AMDVI_IOAPIC_SB_DEVID;
+    }
+
     trace_amdvi_ir_remap_msi_req(origin->address, origin->data, sid);
=20
-    if (!iommu || !X86_IOMMU_DEVICE(iommu)->intr_supported) {
+    /* check if device table entry is set before we go further. */
+    if (!iommu || !iommu->devtab_len) {
         memcpy(translated, origin, sizeof(*origin));
         goto out;
     }
=20
+    if (!amdvi_get_dte(iommu, sid, dte)) {
+        return -AMDVI_IR_ERR;
+    }
+
+    /* Check if IR is enabled in DTE */
+    if (!(dte[2] & AMDVI_IR_REMAP_ENABLE)) {
+        memcpy(translated, origin, sizeof(*origin));
+        goto out;
+    }
+
+    /* validate that we are configure with intremap=3Don */
+    if (!X86_IOMMU_DEVICE(iommu)->intr_supported) {
+        trace_amdvi_err("Interrupt remapping is enabled in the guest but "
+                        "not in the host. Use intremap=3Don to enable inte=
rrupt "
+                        "remapping in amd-iommu.");
+        return -AMDVI_IR_ERR;
+    }
+
     if (origin->address & AMDVI_MSI_ADDR_HI_MASK) {
         trace_amdvi_err("MSI address high 32 bits non-zero when "
                         "Interrupt Remapping enabled.");
@@ -1058,10 +1184,81 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
=20
+    /*
+     * The MSI data register [10:8] are used to get the upstream interrupt=
 type.
+     *
+     * See MSI/MSI-X format:
+     * https://pdfs.semanticscholar.org/presentation/9420/c279e942eca56815=
7711ef5c92b800c40a79.pdf
+     * (page 5)
+     */
+    delivery_mode =3D (origin->data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 7;
+
+    switch (delivery_mode) {
+    case AMDVI_IOAPIC_INT_TYPE_FIXED:
+    case AMDVI_IOAPIC_INT_TYPE_ARBITRATED:
+        trace_amdvi_ir_delivery_mode("fixed/arbitrated");
+        ret =3D __amdvi_int_remap_msi(iommu, origin, translated, dte, &irq=
, sid);
+        if (ret < 0) {
+            goto remap_fail;
+        } else {
+            /* Translate IRQ to MSI messages */
+            x86_iommu_irq_to_msi_message(&irq, translated);
+            goto out;
+        }
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_SMI:
+        error_report("SMI is not supported!");
+        ret =3D -AMDVI_IR_ERR;
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_NMI:
+        pass =3D dte[3] & AMDVI_DEV_NMI_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("nmi");
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_INIT:
+        pass =3D dte[3] & AMDVI_DEV_INT_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("init");
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_EINT:
+        pass =3D dte[3] & AMDVI_DEV_EINT_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("eint");
+        break;
+    default:
+        trace_amdvi_ir_delivery_mode("unsupported delivery_mode");
+        ret =3D -AMDVI_IR_ERR;
+        break;
+    }
+
+    if (ret < 0) {
+        goto remap_fail;
+    }
+
+    /*
+     * The MSI address register bit[2] is used to get the destination
+     * mode. The dest_mode 1 is valid for fixed and arbitrated interrupts
+     * only.
+     */
+    dest_mode =3D (origin->address >> MSI_ADDR_DEST_MODE_SHIFT) & 1;
+    if (dest_mode) {
+        trace_amdvi_ir_err("invalid dest_mode");
+        ret =3D -AMDVI_IR_ERR;
+        goto remap_fail;
+    }
+
+    if (pass) {
+        memcpy(translated, origin, sizeof(*origin));
+    } else {
+        trace_amdvi_ir_err("passthrough is not enabled");
+        ret =3D -AMDVI_IR_ERR;
+        goto remap_fail;
+    }
+
 out:
     trace_amdvi_ir_remap_msi(origin->address, origin->data,
                              translated->address, translated->data);
     return 0;
+
+remap_fail:
+    return ret;
 }
=20
 static int amdvi_int_remap(X86IOMMUState *iommu,
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 4e7cc27..f73be48 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -217,7 +217,51 @@
=20
 /* Interrupt remapping errors */
 #define AMDVI_IR_ERR            0x1
-
+#define AMDVI_IR_GET_IRTE       0x2
+#define AMDVI_IR_TARGET_ABORT   0x3
+
+/* Interrupt remapping */
+#define AMDVI_IR_REMAP_ENABLE           1ULL
+#define AMDVI_IR_INTCTL_SHIFT           60
+#define AMDVI_IR_INTCTL_ABORT           0
+#define AMDVI_IR_INTCTL_PASS            1
+#define AMDVI_IR_INTCTL_REMAP           2
+
+#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
+
+/* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
+#define AMDVI_IRTE_OFFSET               0x7ff
+
+/* Delivery mode of MSI data (same as IOAPIC deilver mode encoding) */
+#define AMDVI_IOAPIC_INT_TYPE_FIXED          0x0
+#define AMDVI_IOAPIC_INT_TYPE_ARBITRATED     0x1
+#define AMDVI_IOAPIC_INT_TYPE_SMI            0x2
+#define AMDVI_IOAPIC_INT_TYPE_NMI            0x4
+#define AMDVI_IOAPIC_INT_TYPE_INIT           0x5
+#define AMDVI_IOAPIC_INT_TYPE_EINT           0x7
+
+/* Pass through interrupt */
+#define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
+#define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
+#define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
+#define AMDVI_DEV_LINT0_PASS_MASK       (1UL << 62)
+#define AMDVI_DEV_LINT1_PASS_MASK       (1UL << 63)
+
+/* Interrupt remapping table fields (Guest VAPIC not enabled) */
+union irte {
+    uint32_t val;
+    struct {
+        uint32_t valid:1,
+                 no_fault:1,
+                 int_type:3,
+                 rq_eoi:1,
+                 dm:1,
+                 guest_mode:1,
+                 destination:8,
+                 vector:8,
+                 rsvd:8;
+    } fields;
+};
=20
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 #define AMD_IOMMU_DEVICE(obj)\
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 41d533c..98150c9 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -106,6 +106,13 @@ amdvi_mem_ir_write(uint64_t addr, uint64_t val) "addr =
0x%"PRIx64" data 0x%"PRIx6
 amdvi_ir_remap_msi_req(uint64_t addr, uint64_t data, uint8_t devid) "addr =
0x%"PRIx64" data 0x%"PRIx64" devid 0x%"PRIx8
 amdvi_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t =
data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%=
"PRIx64")"
 amdvi_err(const char *str) "%s"
+amdvi_ir_irte(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" offset 0x%"P=
RIx64
+amdvi_ir_irte_val(uint32_t data) "data 0x%"PRIx32
+amdvi_ir_err(const char *str) "%s"
+amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
+amdvi_ir_target_abort(const char *str) "%s"
+amdvi_ir_delivery_mode(const char *str) "%s"
+amdvi_ir_generate_msi_message(uint8_t vector, uint8_t delivery_mode, uint8=
_t dest_mode, uint8_t dest, uint8_t rh) "vector %d delivery-mode %d dest-mo=
de %d dest-id %d rh %d"
=20
 # hw/i386/vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command:=
 0x%02x func: %p opaque: %p"
--=20
2.7.4
