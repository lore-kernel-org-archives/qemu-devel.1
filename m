Received: from eggs.gnu.org ([2001:4830:134:3::10]:59083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747b-0005Fh-Ct
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Z-00057f-UE
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from mail-by2nam05on061d.outbound.protection.outlook.com
	([2a01:111:f400:fe52::61d]:56961
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Z-00056Z-JQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:45 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:37 +0000
Message-ID: <1538423049-29524-6-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 5/9] x86_iommu/amd: Prepare for interrupt
 remap support
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

Register the interrupt remapping callback and read/write ops for the
amd-iommu-ir memory region.

amd-iommu-ir is set to higher priority to ensure that this region won't
be masked out by other memory regions.

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
 hw/i386/amd_iommu.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 hw/i386/amd_iommu.h  |  14 ++++++-
 hw/i386/trace-events |   5 +++
 3 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4bec1c6..9118a75 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,6 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/i386/apic_internal.h"
 #include "trace.h"
=20
 /* used AMD-Vi MMIO registers */
@@ -1031,6 +1032,99 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegi=
on *iommu, hwaddr addr,
     return ret;
 }
=20
+/* Interrupt remapping for MSI/MSI-X entry */
+static int amdvi_int_remap_msi(AMDVIState *iommu,
+                               MSIMessage *origin,
+                               MSIMessage *translated,
+                               uint16_t sid)
+{
+    assert(origin && translated);
+
+    trace_amdvi_ir_remap_msi_req(origin->address, origin->data, sid);
+
+    if (!iommu || !X86_IOMMU_DEVICE(iommu)->intr_supported) {
+        memcpy(translated, origin, sizeof(*origin));
+        goto out;
+    }
+
+    if (origin->address & AMDVI_MSI_ADDR_HI_MASK) {
+        trace_amdvi_err("MSI address high 32 bits non-zero when "
+                        "Interrupt Remapping enabled.");
+        return -AMDVI_IR_ERR;
+    }
+
+    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) !=3D APIC_DEFAULT_ADDRE=
SS) {
+        trace_amdvi_err("MSI is not from IOAPIC.");
+        return -AMDVI_IR_ERR;
+    }
+
+out:
+    trace_amdvi_ir_remap_msi(origin->address, origin->data,
+                             translated->address, translated->data);
+    return 0;
+}
+
+static int amdvi_int_remap(X86IOMMUState *iommu,
+                           MSIMessage *origin,
+                           MSIMessage *translated,
+                           uint16_t sid)
+{
+    return amdvi_int_remap_msi(AMD_IOMMU_DEVICE(iommu), origin,
+                               translated, sid);
+}
+
+static MemTxResult amdvi_mem_ir_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    int ret;
+    MSIMessage from =3D { 0, 0 }, to =3D { 0, 0 };
+    uint16_t sid =3D AMDVI_IOAPIC_SB_DEVID;
+
+    from.address =3D (uint64_t) addr + AMDVI_INT_ADDR_FIRST;
+    from.data =3D (uint32_t) value;
+
+    trace_amdvi_mem_ir_write_req(addr, value, size);
+
+    if (!attrs.unspecified) {
+        /* We have explicit Source ID */
+        sid =3D attrs.requester_id;
+    }
+
+    ret =3D amdvi_int_remap_msi(opaque, &from, &to, sid);
+    if (ret < 0) {
+        /* TODO: log the event using IOMMU log event interface */
+        error_report_once("failed to remap interrupt from devid 0x%x", sid=
);
+        return MEMTX_ERROR;
+    }
+
+    apic_get_class()->send_msi(&to);
+
+    trace_amdvi_mem_ir_write(to.address, to.data);
+    return MEMTX_OK;
+}
+
+static MemTxResult amdvi_mem_ir_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps amdvi_ir_ops =3D {
+    .read_with_attrs =3D amdvi_mem_ir_read,
+    .write_with_attrs =3D amdvi_mem_ir_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    }
+};
+
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int d=
evfn)
 {
     char name[128];
@@ -1066,6 +1160,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus=
, void *opaque, int devfn)
          * |-----------------+-------------------+----------+
          * | amdvi_root      | 00000000-ffffffff |        0 |
          * |  amdvi_iommu    | 00000000-ffffffff |        1 |
+         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
          * |-----------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
@@ -1076,6 +1171,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bu=
s, void *opaque, int devfn)
         memory_region_init(&amdvi_dev_as->root, OBJECT(s),
                            "amdvi_root", UINT64_MAX);
         address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
+        memory_region_init_io(&amdvi_dev_as->iommu_ir, OBJECT(s),
+                              &amdvi_ir_ops, s, "amd_iommu_ir",
+                              AMDVI_INT_ADDR_SIZE);
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root,
+                                            AMDVI_INT_ADDR_FIRST,
+                                            &amdvi_dev_as->iommu_ir,
+                                            64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->i=
ommu),
                                             1);
@@ -1196,6 +1298,9 @@ static void amdvi_realize(DeviceState *dev, Error **e=
rr)
         return;
     }
=20
+    /* Pseudo address space under root PCI bus. */
+    pcms->ioapic_as =3D amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID=
);
+
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mm=
io",
                           AMDVI_MMIO_SIZE);
@@ -1229,6 +1334,7 @@ static void amdvi_class_init(ObjectClass *klass, void=
* data)
     dc->vmsd =3D &vmstate_amdvi;
     dc->hotpluggable =3D false;
     dc_class->realize =3D amdvi_realize;
+    dc_class->int_remap =3D amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable =3D true;
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8740305..4e7cc27 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -206,8 +206,18 @@
=20
 #define AMDVI_COMMAND_SIZE   16
=20
-#define AMDVI_INT_ADDR_FIRST 0xfee00000
-#define AMDVI_INT_ADDR_LAST  0xfeefffff
+#define AMDVI_INT_ADDR_FIRST    0xfee00000
+#define AMDVI_INT_ADDR_LAST     0xfeefffff
+#define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - AMDVI_INT_ADDR_FIRS=
T + 1)
+#define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
+#define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)
+
+/* SB IOAPIC is always on this device in AMD systems */
+#define AMDVI_IOAPIC_SB_DEVID   PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
+
+/* Interrupt remapping errors */
+#define AMDVI_IR_ERR            0x1
+
=20
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 #define AMD_IOMMU_DEVICE(obj)\
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 9e6fc4d..41d533c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -101,6 +101,11 @@ amdvi_mode_invalid(uint8_t level, uint64_t addr)"error=
: translation level 0x%"PR
 amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physica=
l address 0x%"PRIx64
 amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, ui=
nt64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
 amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t=
 addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
+amdvi_mem_ir_write_req(uint64_t addr, uint64_t val, uint32_t size) "addr 0=
x%"PRIx64" data 0x%"PRIx64" size 0x%"PRIx32
+amdvi_mem_ir_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" data 0x%=
"PRIx64
+amdvi_ir_remap_msi_req(uint64_t addr, uint64_t data, uint8_t devid) "addr =
0x%"PRIx64" data 0x%"PRIx64" devid 0x%"PRIx8
+amdvi_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t =
data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%=
"PRIx64")"
+amdvi_err(const char *str) "%s"
=20
 # hw/i386/vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command:=
 0x%02x func: %p opaque: %p"
--=20
2.7.4
