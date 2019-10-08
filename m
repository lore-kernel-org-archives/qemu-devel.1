Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F31206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F31206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHq5j-0001QJ-Sy
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iHpzo-0004ll-DA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iHpzi-0005KF-JQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:57:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iHpzi-0005J8-6k
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A5BF3081CFF;
 Tue,  8 Oct 2019 13:57:41 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD994600CE;
 Tue,  8 Oct 2019 13:57:33 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/12] hw/i386: split PCMachineState deriving
 X86MachineState from it
Date: Tue,  8 Oct 2019 15:55:31 +0200
Message-Id: <20191008135537.197867-6-slp@redhat.com>
In-Reply-To: <20191008135537.197867-1-slp@redhat.com>
References: <20191008135537.197867-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 08 Oct 2019 13:57:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split up PCMachineState and PCMachineClass and derive X86MachineState
and X86MachineClass from them. This allows sharing code with non-PC
x86 machine types.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/hw/i386/pc.h  |  27 +------
 include/hw/i386/x86.h |  58 +++++++++++++-
 hw/acpi/cpu_hotplug.c |  10 +--
 hw/i386/acpi-build.c  |  29 ++++---
 hw/i386/amd_iommu.c   |   3 +-
 hw/i386/intel_iommu.c |   3 +-
 hw/i386/pc.c          | 178 ++++++++++++++----------------------------
 hw/i386/pc_piix.c     |  43 +++++-----
 hw/i386/pc_q35.c      |  35 +++++----
 hw/i386/x86.c         | 140 +++++++++++++++++++++++++++++----
 hw/i386/xen/xen-hvm.c |  28 ++++---
 hw/intc/ioapic.c      |   2 +-
 12 files changed, 326 insertions(+), 230 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 73e2847e87..d2a690d05e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -8,6 +8,7 @@
 #include "hw/block/flash.h"
 #include "net/net.h"
 #include "hw/i386/ioapic.h"
+#include "hw/i386/x86.h"
=20
 #include "qemu/range.h"
 #include "qemu/bitmap.h"
@@ -27,7 +28,7 @@
  */
 struct PCMachineState {
     /*< private >*/
-    MachineState parent_obj;
+    X86MachineState parent_obj;
=20
     /* <public> */
=20
@@ -36,16 +37,11 @@ struct PCMachineState {
=20
     /* Pointers to devices and objects: */
     HotplugHandler *acpi_dev;
-    ISADevice *rtc;
     PCIBus *bus;
     I2CBus *smbus;
-    FWCfgState *fw_cfg;
-    qemu_irq *gsi;
     PFlashCFI01 *flash[2];
-    GMappedFile *initrd_mapped_file;
=20
     /* Configuration options: */
-    uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     OnOffAuto smm;
=20
@@ -54,27 +50,13 @@ struct PCMachineState {
     bool sata_enabled;
     bool pit_enabled;
=20
-    /* RAM information (sizes, addresses, configuration): */
-    ram_addr_t below_4g_mem_size, above_4g_mem_size;
-
-    /* CPU and apic information: */
-    bool apic_xrupt_override;
-    unsigned apic_id_limit;
-    uint16_t boot_cpus;
-    unsigned smp_dies;
-
     /* NUMA information: */
     uint64_t numa_nodes;
     uint64_t *node_mem;
-
-    /* Address space used by IOAPIC device. All IOAPIC interrupts
-     * will be translated to MSI messages in the address space. */
-    AddressSpace *ioapic_as;
 };
=20
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
-#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_SMBUS            "smbus"
@@ -99,7 +81,7 @@ struct PCMachineState {
  */
 typedef struct PCMachineClass {
     /*< private >*/
-    MachineClass parent_class;
+    X86MachineClass parent_class;
=20
     /*< public >*/
=20
@@ -141,9 +123,6 @@ typedef struct PCMachineClass {
=20
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
-
-    /* Enables contiguous-apic-ID mode */
-    bool compat_apic_id_mode;
 } PCMachineClass;
=20
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71e2b6985d..d15713e92e 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -17,7 +17,63 @@
 #ifndef HW_I386_X86_H
 #define HW_I386_X86_H
=20
+#include "qemu-common.h"
+#include "exec/hwaddr.h"
+#include "qemu/notify.h"
+
 #include "hw/boards.h"
+#include "hw/nmi.h"
+
+typedef struct {
+    /*< private >*/
+    MachineClass parent;
+
+    /*< public >*/
+
+    /* Enables contiguous-apic-ID mode */
+    bool compat_apic_id_mode;
+} X86MachineClass;
+
+typedef struct {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+
+    /* Pointers to devices and objects: */
+    ISADevice *rtc;
+    FWCfgState *fw_cfg;
+    qemu_irq *gsi;
+    GMappedFile *initrd_mapped_file;
+
+    /* Configuration options: */
+    uint64_t max_ram_below_4g;
+
+    /* RAM information (sizes, addresses, configuration): */
+    ram_addr_t below_4g_mem_size, above_4g_mem_size;
+
+    /* CPU and apic information: */
+    bool apic_xrupt_override;
+    unsigned apic_id_limit;
+    uint16_t boot_cpus;
+    unsigned smp_dies;
+
+    /*
+     * Address space used by IOAPIC device. All IOAPIC interrupts
+     * will be translated to MSI messages in the address space.
+     */
+    AddressSpace *ioapic_as;
+} X86MachineState;
+
+#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
+
+#define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
+#define X86_MACHINE(obj) \
+    OBJECT_CHECK(X86MachineState, (obj), TYPE_X86_MACHINE)
+#define X86_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(X86MachineClass, obj, TYPE_X86_MACHINE)
+#define X86_MACHINE_CLASS(class) \
+    OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
=20
 uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
                                     unsigned int cpu_index);
@@ -30,6 +86,6 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineS=
tate *ms);
=20
 void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
=20
-void x86_load_linux(PCMachineState *x86ms, FWCfgState *fw_cfg);
+void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
=20
 #endif
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 6e8293aac9..3ac2045a95 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -128,7 +128,7 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineSt=
ate *machine,
     Aml *one =3D aml_int(1);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(machine)=
;
-    PCMachineState *pcms =3D PC_MACHINE(machine);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
=20
     /*
      * _MAT method - creates an madt apic buffer
@@ -236,9 +236,9 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineSt=
ate *machine,
     /* The current AML generator can cover the APIC ID range [0..255],
      * inclusive, for VCPU hotplug. */
     QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
-    if (pcms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
+    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
         error_report("max_cpus is too large. APIC ID of last CPU is %u",
-                     pcms->apic_id_limit - 1);
+                     x86ms->apic_id_limit - 1);
         exit(1);
     }
=20
@@ -315,8 +315,8 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineSt=
ate *machine,
      * ith up to 255 elements. Windows guests up to win2k8 fail when
      * VarPackageOp is used.
      */
-    pkg =3D pcms->apic_id_limit <=3D 255 ? aml_package(pcms->apic_id_lim=
it) :
-                                       aml_varpackage(pcms->apic_id_limi=
t);
+    pkg =3D x86ms->apic_id_limit <=3D 255 ? aml_package(x86ms->apic_id_l=
imit) :
+                                        aml_varpackage(x86ms->apic_id_li=
mit);
=20
     for (i =3D 0, apic_idx =3D 0; i < apic_ids->len; i++) {
         int apic_id =3D apic_ids->cpus[i].arch_id;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4e0f9f425a..fc7de46533 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -361,6 +361,7 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(=
pcms));
     int madt_start =3D table_data->len;
     AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev=
);
@@ -390,7 +391,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, PC=
MachineState *pcms)
     io_apic->address =3D cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
     io_apic->interrupt =3D cpu_to_le32(0);
=20
-    if (pcms->apic_xrupt_override) {
+    if (x86ms->apic_xrupt_override) {
         intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
         intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
         intsrcovr->length =3D sizeof(*intsrcovr);
@@ -1831,6 +1832,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     CrsRangeSet crs_range_set;
     PCMachineState *pcms =3D PC_MACHINE(machine);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(machine);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
     AcpiMcfgInfo mcfg;
     uint32_t nr_mem =3D machine->ram_slots;
     int root_bus_limit =3D 0xFF;
@@ -2098,7 +2100,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
          * with half of the 16-bit control register. Hence, the total si=
ze
          * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, th=
e
          * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
-        uint8_t io_size =3D object_property_get_bool(OBJECT(pcms->fw_cfg=
),
+        uint8_t io_size =3D object_property_get_bool(OBJECT(x86ms->fw_cf=
g),
                                                    "dma_enabled", NULL) =
?
                           ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr=
_t) :
                           FW_CFG_CTL_SIZE;
@@ -2331,6 +2333,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
     int srat_start, numa_start, slots;
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
     const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(machine)=
;
     PCMachineState *pcms =3D PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =3D
@@ -2401,16 +2404,16 @@ build_srat(GArray *table_data, BIOSLinker *linker=
, MachineState *machine)
         }
=20
         /* Cut out the ACPI_PCI hole */
-        if (mem_base <=3D pcms->below_4g_mem_size &&
-            next_base > pcms->below_4g_mem_size) {
-            mem_len -=3D next_base - pcms->below_4g_mem_size;
+        if (mem_base <=3D x86ms->below_4g_mem_size &&
+            next_base > x86ms->below_4g_mem_size) {
+            mem_len -=3D next_base - x86ms->below_4g_mem_size;
             if (mem_len > 0) {
                 numamem =3D acpi_data_push(table_data, sizeof *numamem);
                 build_srat_memory(numamem, mem_base, mem_len, i - 1,
                                   MEM_AFFINITY_ENABLED);
             }
             mem_base =3D 1ULL << 32;
-            mem_len =3D next_base - pcms->below_4g_mem_size;
+            mem_len =3D next_base - x86ms->below_4g_mem_size;
             next_base =3D mem_base + mem_len;
         }
=20
@@ -2629,6 +2632,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
 {
     PCMachineState *pcms =3D PC_MACHINE(machine);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
     GArray *table_offsets;
     unsigned facs, dsdt, rsdt, fadt;
     AcpiPmInfo pm;
@@ -2790,7 +2794,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
          */
         int legacy_aml_len =3D
             pcmc->legacy_acpi_table_size +
-            ACPI_BUILD_LEGACY_CPU_AML_SIZE * pcms->apic_id_limit;
+            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
         int legacy_table_size =3D
             ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
                      ACPI_BUILD_ALIGN_SIZE);
@@ -2880,13 +2884,14 @@ void acpi_setup(void)
 {
     PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
     TPMIf *tpm;
     static FwCfgTPMConfig tpm_config;
=20
-    if (!pcms->fw_cfg) {
+    if (!x86ms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
         return;
     }
@@ -2917,7 +2922,7 @@ void acpi_setup(void)
         acpi_add_rom_blob(acpi_build_update, build_state,
                           tables.linker->cmd_blob, "etc/table-loader", 0=
);
=20
-    fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
+    fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog))=
;
=20
     tpm =3D tpm_find();
@@ -2927,13 +2932,13 @@ void acpi_setup(void)
             .tpm_version =3D tpm_get_version(tpm),
             .tpmppi_version =3D TPM_PPI_VERSION_1_30
         };
-        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
+        fw_cfg_add_file(x86ms->fw_cfg, "etc/tpm/config",
                         &tpm_config, sizeof tpm_config);
     }
=20
     vmgenid_dev =3D find_vmgenid_dev();
     if (vmgenid_dev) {
-        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
+        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
                            tables.vmgenid);
     }
=20
@@ -2946,7 +2951,7 @@ void acpi_setup(void)
         uint32_t rsdp_size =3D acpi_data_len(tables.rsdp);
=20
         build_state->rsdp =3D g_memdup(tables.rsdp->data, rsdp_size);
-        fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
+        fw_cfg_add_file_callback(x86ms->fw_cfg, ACPI_BUILD_RSDP_FILE,
                                  acpi_build_update, NULL, build_state,
                                  build_state->rsdp, rsdp_size, true);
         build_state->rsdp_mr =3D NULL;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d3726361dd..d55dbf07fc 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1540,6 +1540,7 @@ static void amdvi_realize(DeviceState *dev, Error *=
*err)
     X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(dev);
     MachineState *ms =3D MACHINE(qdev_get_machine());
     PCMachineState *pcms =3D PC_MACHINE(ms);
+    X86MachineState *x86ms =3D X86_MACHINE(ms);
     PCIBus *bus =3D pcms->bus;
=20
     s->iotlb =3D g_hash_table_new_full(amdvi_uint64_hash,
@@ -1568,7 +1569,7 @@ static void amdvi_realize(DeviceState *dev, Error *=
*err)
     }
=20
     /* Pseudo address space under root PCI bus. */
-    pcms->ioapic_as =3D amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEV=
ID);
+    x86ms->ioapic_as =3D amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DE=
VID);
=20
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-=
mmio",
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 771bed25c9..14e4e6ad62 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3733,6 +3733,7 @@ static void vtd_realize(DeviceState *dev, Error **e=
rrp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
     PCMachineState *pcms =3D PC_MACHINE(ms);
+    X86MachineState *x86ms =3D X86_MACHINE(ms);
     PCIBus *bus =3D pcms->bus;
     IntelIOMMUState *s =3D INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(dev);
@@ -3773,7 +3774,7 @@ static void vtd_realize(DeviceState *dev, Error **e=
rrp)
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
-    pcms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAP=
IC);
+    x86ms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOA=
PIC);
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05de536a2b..1457a45101 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,7 +79,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "hw/core/cpu.h"
-#include "hw/nmi.h"
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
@@ -680,17 +679,18 @@ void pc_cmos_init(PCMachineState *pcms,
 {
     int val;
     static pc_cmos_init_late_arg arg;
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     /* various important CMOS locations needed by PC/Bochs bios */
=20
     /* memory size */
     /* base memory (first MiB) */
-    val =3D MIN(pcms->below_4g_mem_size / KiB, 640);
+    val =3D MIN(x86ms->below_4g_mem_size / KiB, 640);
     rtc_set_memory(s, 0x15, val);
     rtc_set_memory(s, 0x16, val >> 8);
     /* extended memory (next 64MiB) */
-    if (pcms->below_4g_mem_size > 1 * MiB) {
-        val =3D (pcms->below_4g_mem_size - 1 * MiB) / KiB;
+    if (x86ms->below_4g_mem_size > 1 * MiB) {
+        val =3D (x86ms->below_4g_mem_size - 1 * MiB) / KiB;
     } else {
         val =3D 0;
     }
@@ -701,8 +701,8 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x30, val);
     rtc_set_memory(s, 0x31, val >> 8);
     /* memory between 16MiB and 4GiB */
-    if (pcms->below_4g_mem_size > 16 * MiB) {
-        val =3D (pcms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
+    if (x86ms->below_4g_mem_size > 16 * MiB) {
+        val =3D (x86ms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
     } else {
         val =3D 0;
     }
@@ -711,14 +711,14 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x34, val);
     rtc_set_memory(s, 0x35, val >> 8);
     /* memory above 4GiB */
-    val =3D pcms->above_4g_mem_size / 65536;
+    val =3D x86ms->above_4g_mem_size / 65536;
     rtc_set_memory(s, 0x5b, val);
     rtc_set_memory(s, 0x5c, val >> 8);
     rtc_set_memory(s, 0x5d, val >> 16);
=20
     object_property_add_link(OBJECT(pcms), "rtc_state",
                              TYPE_ISA_DEVICE,
-                             (Object **)&pcms->rtc,
+                             (Object **)&x86ms->rtc,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_link(OBJECT(pcms), OBJECT(s),
@@ -907,7 +907,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int=
 level)
  */
 void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 {
-    PCMachineState *pcms =3D PC_MACHINE(ms);
+    X86MachineState *x86ms =3D X86_MACHINE(ms);
=20
     if (opts) {
         unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 0);
@@ -971,7 +971,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus =3D cpus;
         ms->smp.cores =3D cores;
         ms->smp.threads =3D threads;
-        pcms->smp_dies =3D dies;
+        x86ms->smp_dies =3D dies;
     }
=20
     if (ms->smp.cpus > 1) {
@@ -1024,10 +1024,11 @@ void pc_machine_done(Notifier *notifier, void *da=
ta)
 {
     PCMachineState *pcms =3D container_of(notifier,
                                         PCMachineState, machine_done);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     PCIBus *bus =3D pcms->bus;
=20
     /* set the number of CPUs */
-    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
+    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
=20
     if (bus) {
         int extra_hosts =3D 0;
@@ -1038,23 +1039,23 @@ void pc_machine_done(Notifier *notifier, void *da=
ta)
                 extra_hosts++;
             }
         }
-        if (extra_hosts && pcms->fw_cfg) {
+        if (extra_hosts && x86ms->fw_cfg) {
             uint64_t *val =3D g_malloc(sizeof(*val));
             *val =3D cpu_to_le64(extra_hosts);
-            fw_cfg_add_file(pcms->fw_cfg,
+            fw_cfg_add_file(x86ms->fw_cfg,
                     "etc/extra-pci-roots", val, sizeof(*val));
         }
     }
=20
     acpi_setup();
-    if (pcms->fw_cfg) {
-        fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        fw_cfg_build_feature_control(MACHINE(pcms), pcms->fw_cfg);
+    if (x86ms->fw_cfg) {
+        fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
+        fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpu=
s);
     }
=20
-    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
+    if (x86ms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu =3D INTEL_IOMMU_DEVICE(x86_iommu_get_defa=
ult());
=20
         if (!iommu || !x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu)) |=
|
@@ -1072,8 +1073,9 @@ void pc_guest_info_init(PCMachineState *pcms)
 {
     int i;
     MachineState *ms =3D MACHINE(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
-    pcms->apic_xrupt_override =3D kvm_allows_irq0_override();
+    x86ms->apic_xrupt_override =3D kvm_allows_irq0_override();
     pcms->numa_nodes =3D ms->numa_state->num_nodes;
     pcms->node_mem =3D g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
@@ -1098,11 +1100,12 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     assert(MACHINE(pcms)->kernel_filename !=3D NULL);
=20
     fw_cfg =3D fw_cfg_init_io(FW_CFG_IO_BASE);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
=20
     x86_load_linux(pcms, fw_cfg);
@@ -1113,7 +1116,7 @@ void xen_load_linux(PCMachineState *pcms)
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg =3D fw_cfg;
+    x86ms->fw_cfg =3D fw_cfg;
 }
=20
 void pc_memory_init(PCMachineState *pcms,
@@ -1128,9 +1131,10 @@ void pc_memory_init(PCMachineState *pcms,
     MachineState *machine =3D MACHINE(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
-    assert(machine->ram_size =3D=3D pcms->below_4g_mem_size +
-                                pcms->above_4g_mem_size);
+    assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
+                                x86ms->above_4g_mem_size);
=20
     linux_boot =3D (machine->kernel_filename !=3D NULL);
=20
@@ -1144,17 +1148,17 @@ void pc_memory_init(PCMachineState *pcms,
     *ram_memory =3D ram;
     ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
     memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
-                             0, pcms->below_4g_mem_size);
+                             0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
-    e820_add_entry(0, pcms->below_4g_mem_size, E820_RAM);
-    if (pcms->above_4g_mem_size > 0) {
+    e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
+    if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
         memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
-                                 pcms->below_4g_mem_size,
-                                 pcms->above_4g_mem_size);
+                                 x86ms->below_4g_mem_size,
+                                 x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
                                     ram_above_4g);
-        e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_RAM=
);
+        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RA=
M);
     }
=20
     if (!pcmc->has_reserved_memory &&
@@ -1188,7 +1192,7 @@ void pc_memory_init(PCMachineState *pcms,
         }
=20
         machine->device_memory->base =3D
-            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1 * GiB);
+            ROUND_UP(0x100000000ULL + x86ms->above_4g_mem_size, 1 * GiB)=
;
=20
         if (pcmc->enforce_aligned_dimm) {
             /* size device region assuming 1G page max alignment per slo=
t */
@@ -1223,7 +1227,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         1);
=20
     fw_cfg =3D fw_cfg_arch_create(machine,
-                                pcms->boot_cpus, pcms->apic_id_limit);
+                                x86ms->boot_cpus, x86ms->apic_id_limit);
=20
     rom_set_fw(fw_cfg);
=20
@@ -1246,10 +1250,10 @@ void pc_memory_init(PCMachineState *pcms,
     for (i =3D 0; i < nb_option_roms; i++) {
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg =3D fw_cfg;
+    x86ms->fw_cfg =3D fw_cfg;
=20
     /* Init default IOAPIC address space */
-    pcms->ioapic_as =3D &address_space_memory;
+    x86ms->ioapic_as =3D &address_space_memory;
 }
=20
 /*
@@ -1261,6 +1265,7 @@ uint64_t pc_pci_hole64_start(void)
     PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
     MachineState *ms =3D MACHINE(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     uint64_t hole64_start =3D 0;
=20
     if (pcmc->has_reserved_memory && ms->device_memory->base) {
@@ -1269,7 +1274,7 @@ uint64_t pc_pci_hole64_start(void)
             hole64_start +=3D memory_region_size(&ms->device_memory->mr)=
;
         }
     } else {
-        hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
+        hole64_start =3D 0x100000000ULL + x86ms->above_4g_mem_size;
     }
=20
     return ROUND_UP(hole64_start, 1 * GiB);
@@ -1608,6 +1613,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev=
,
     Error *local_err =3D NULL;
     X86CPU *cpu =3D X86_CPU(dev);
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     if (pcms->acpi_dev) {
         hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loca=
l_err);
@@ -1617,12 +1623,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug_d=
ev,
     }
=20
     /* increment the number of CPUs */
-    pcms->boot_cpus++;
-    if (pcms->rtc) {
-        rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
+    x86ms->boot_cpus++;
+    if (x86ms->rtc) {
+        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
     }
-    if (pcms->fw_cfg) {
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
+    if (x86ms->fw_cfg) {
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpu=
s);
     }
=20
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
@@ -1668,6 +1674,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplu=
g_dev,
     Error *local_err =3D NULL;
     X86CPU *cpu =3D X86_CPU(dev);
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_=
err);
     if (local_err) {
@@ -1679,10 +1686,10 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotp=
lug_dev,
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
=20
     /* decrement the number of CPUs */
-    pcms->boot_cpus--;
+    x86ms->boot_cpus--;
     /* Update the number of CPUs in CMOS */
-    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
-    fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
  out:
     error_propagate(errp, local_err);
 }
@@ -1698,6 +1705,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
     CPUX86State *env =3D &cpu->env;
     MachineState *ms =3D MACHINE(hotplug_dev);
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     unsigned int smp_cores =3D ms->smp.cores;
     unsigned int smp_threads =3D ms->smp.threads;
=20
@@ -1707,7 +1715,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         return;
     }
=20
-    env->nr_dies =3D pcms->smp_dies;
+    env->nr_dies =3D x86ms->smp_dies;
=20
     /*
      * If APIC ID is not set,
@@ -1715,13 +1723,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
      */
     if (cpu->apic_id =3D=3D UNASSIGNED_APIC_ID) {
         int max_socket =3D (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / pcms->smp_dies=
;
+                                smp_threads / smp_cores / x86ms->smp_die=
s;
=20
         /*
          * die-id was optional in QEMU 4.0 and older, so keep it optiona=
l
          * if there's only one die per socket.
          */
-        if (cpu->die_id < 0 && pcms->smp_dies =3D=3D 1) {
+        if (cpu->die_id < 0 && x86ms->smp_dies =3D=3D 1) {
             cpu->die_id =3D 0;
         }
=20
@@ -1736,9 +1744,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         if (cpu->die_id < 0) {
             error_setg(errp, "CPU die-id is not set");
             return;
-        } else if (cpu->die_id > pcms->smp_dies - 1) {
+        } else if (cpu->die_id > x86ms->smp_dies - 1) {
             error_setg(errp, "Invalid CPU die-id: %u must be in range 0:=
%u",
-                       cpu->die_id, pcms->smp_dies - 1);
+                       cpu->die_id, x86ms->smp_dies - 1);
             return;
         }
         if (cpu->core_id < 0) {
@@ -1762,7 +1770,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         topo.die_id =3D cpu->die_id;
         topo.core_id =3D cpu->core_id;
         topo.smt_id =3D cpu->thread_id;
-        cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_cores,
+        cpu->apic_id =3D apicid_from_topo_ids(x86ms->smp_dies, smp_cores=
,
                                             smp_threads, &topo);
     }
=20
@@ -1770,7 +1778,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
     if (!cpu_slot) {
         MachineState *ms =3D MACHINE(pcms);
=20
-        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
                                  smp_cores, smp_threads, &topo);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] wit=
h"
@@ -1792,7 +1800,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realiz=
efn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of glo=
bals */
-    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
                              smp_cores, smp_threads, &topo);
     if (cpu->socket_id !=3D -1 && cpu->socket_id !=3D topo.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-=
id:"
@@ -1974,45 +1982,6 @@ pc_machine_get_device_memory_region_size(Object *o=
bj, Visitor *v,
     visit_type_int(v, name, &value, errp);
 }
=20
-static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
-                                            const char *name, void *opaq=
ue,
-                                            Error **errp)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-    uint64_t value =3D pcms->max_ram_below_4g;
-
-    visit_type_size(v, name, &value, errp);
-}
-
-static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
-                                            const char *name, void *opaq=
ue,
-                                            Error **errp)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-    Error *error =3D NULL;
-    uint64_t value;
-
-    visit_type_size(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    if (value > 4 * GiB) {
-        error_setg(&error,
-                   "Machine option 'max-ram-below-4g=3D%"PRIu64
-                   "' expects size less than or equal to 4G", value);
-        error_propagate(errp, error);
-        return;
-    }
-
-    if (value < 1 * MiB) {
-        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB bounda=
ry,"
-                    "BIOS may not work with less than 1MiB", value);
-    }
-
-    pcms->max_ram_below_4g =3D value;
-}
-
 static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *n=
ame,
                                   void *opaque, Error **errp)
 {
@@ -2118,7 +2087,6 @@ static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    pcms->max_ram_below_4g =3D 0; /* use default */
     pcms->smm =3D ON_OFF_AUTO_AUTO;
 #ifdef CONFIG_VMPORT
     pcms->vmport =3D ON_OFF_AUTO_AUTO;
@@ -2130,7 +2098,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled =3D true;
     pcms->sata_enabled =3D true;
     pcms->pit_enabled =3D true;
-    pcms->smp_dies =3D 1;
=20
     pc_system_flash_create(pcms);
 }
@@ -2161,23 +2128,6 @@ static void pc_machine_wakeup(MachineState *machin=
e)
     cpu_synchronize_all_post_reset();
 }
=20
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
-{
-    /* cpu index isn't used */
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        X86CPU *cpu =3D X86_CPU(cs);
-
-        if (!cpu->apic_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
-        } else {
-            apic_deliver_nmi(cpu->apic_state);
-        }
-    }
-}
-
-
 static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error=
 **errp)
 {
     X86IOMMUState *iommu =3D x86_iommu_get_default();
@@ -2202,7 +2152,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     MachineClass *mc =3D MACHINE_CLASS(oc);
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
-    NMIClass *nc =3D NMI_CLASS(oc);
=20
     pcmc->pci_enabled =3D true;
     pcmc->has_acpi_build =3D true;
@@ -2238,7 +2187,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     hc->plug =3D pc_machine_device_plug_cb;
     hc->unplug_request =3D pc_machine_device_unplug_request_cb;
     hc->unplug =3D pc_machine_device_unplug_cb;
-    nc->nmi_monitor_handler =3D x86_nmi;
     mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported =3D true;
     mc->numa_mem_supported =3D true;
@@ -2247,13 +2195,6 @@ static void pc_machine_class_init(ObjectClass *oc,=
 void *data)
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
=20
-    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
-        pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g=
,
-        NULL, NULL, &error_abort);
-
-    object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4=
G,
-        "Maximum ram below the 4G boundary (32bit boundary)", &error_abo=
rt);
-
     object_class_property_add(oc, PC_MACHINE_SMM, "OnOffAuto",
         pc_machine_get_smm, pc_machine_set_smm,
         NULL, NULL, &error_abort);
@@ -2278,7 +2219,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
=20
 static const TypeInfo pc_machine_info =3D {
     .name =3D TYPE_PC_MACHINE,
-    .parent =3D TYPE_MACHINE,
+    .parent =3D TYPE_X86_MACHINE,
     .abstract =3D true,
     .instance_size =3D sizeof(PCMachineState),
     .instance_init =3D pc_machine_initfn,
@@ -2286,7 +2227,6 @@ static const TypeInfo pc_machine_info =3D {
     .class_init =3D pc_machine_class_init,
     .interfaces =3D (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_NMI },
          { }
     },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1396451abf..0afa8fe6ea 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -74,6 +74,7 @@ static void pc_init1(MachineState *machine,
 {
     PCMachineState *pcms =3D PC_MACHINE(machine);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
     MemoryRegion *system_memory =3D get_system_memory();
     MemoryRegion *system_io =3D get_system_io();
     int i;
@@ -126,11 +127,11 @@ static void pc_init1(MachineState *machine,
     if (xen_enabled()) {
         xen_hvm_init(pcms, &ram_memory);
     } else {
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g =3D 0xe0000000; /* default: 3.5G */
+        if (!x86ms->max_ram_below_4g) {
+            x86ms->max_ram_below_4g =3D 0xe0000000; /* default: 3.5G */
         }
-        lowmem =3D pcms->max_ram_below_4g;
-        if (machine->ram_size >=3D pcms->max_ram_below_4g) {
+        lowmem =3D x86ms->max_ram_below_4g;
+        if (machine->ram_size >=3D x86ms->max_ram_below_4g) {
             if (pcmc->gigabyte_align) {
                 if (lowmem > 0xc0000000) {
                     lowmem =3D 0xc0000000;
@@ -139,17 +140,17 @@ static void pc_init1(MachineState *machine,
                     warn_report("Large machine and max_ram_below_4g "
                                 "(%" PRIu64 ") not a multiple of 1G; "
                                 "possible bad performance.",
-                                pcms->max_ram_below_4g);
+                                x86ms->max_ram_below_4g);
                 }
             }
         }
=20
         if (machine->ram_size >=3D lowmem) {
-            pcms->above_4g_mem_size =3D machine->ram_size - lowmem;
-            pcms->below_4g_mem_size =3D lowmem;
+            x86ms->above_4g_mem_size =3D machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size =3D lowmem;
         } else {
-            pcms->above_4g_mem_size =3D 0;
-            pcms->below_4g_mem_size =3D machine->ram_size;
+            x86ms->above_4g_mem_size =3D 0;
+            x86ms->below_4g_mem_size =3D machine->ram_size;
         }
     }
=20
@@ -191,19 +192,19 @@ static void pc_init1(MachineState *machine,
     gsi_state =3D g_malloc0(sizeof(*gsi_state));
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
+        x86ms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
                                        GSI_NUM_PINS);
     } else {
-        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM=
_PINS);
+        x86ms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NU=
M_PINS);
     }
=20
     if (pcmc->pci_enabled) {
         pci_bus =3D i440fx_init(host_type,
                               pci_type,
-                              &i440fx_state, &piix3_devfn, &isa_bus, pcm=
s->gsi,
+                              &i440fx_state, &piix3_devfn, &isa_bus, x86=
ms->gsi,
                               system_memory, system_io, machine->ram_siz=
e,
-                              pcms->below_4g_mem_size,
-                              pcms->above_4g_mem_size,
+                              x86ms->below_4g_mem_size,
+                              x86ms->above_4g_mem_size,
                               pci_memory, ram_memory);
         pcms->bus =3D pci_bus;
     } else {
@@ -213,7 +214,7 @@ static void pc_init1(MachineState *machine,
                               &error_abort);
         no_hpet =3D 1;
     }
-    isa_bus_irqs(isa_bus, pcms->gsi);
+    isa_bus_irqs(isa_bus, x86ms->gsi);
=20
     if (kvm_pic_in_kernel()) {
         i8259 =3D kvm_i8259_init(isa_bus);
@@ -231,7 +232,7 @@ static void pc_init1(MachineState *machine,
         ioapic_init_gsi(gsi_state, "i440fx");
     }
=20
-    pc_register_ferr_irq(pcms->gsi[13]);
+    pc_register_ferr_irq(x86ms->gsi[13]);
=20
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
=20
@@ -241,7 +242,7 @@ static void pc_init1(MachineState *machine,
     }
=20
     /* init basic PC hardware */
-    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
+    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, true,
                          (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit_e=
nabled,
                          0x4);
=20
@@ -288,7 +289,7 @@ else {
         smi_irq =3D qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, =
0);
         /* TODO: Populate SPD eeprom data.  */
         pcms->smbus =3D piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
-                                    pcms->gsi[9], smi_irq,
+                                    x86ms->gsi[9], smi_irq,
                                     pc_machine_is_smm_enabled(pcms),
                                     &piix4_pm);
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
@@ -304,7 +305,7 @@ else {
=20
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               x86ms->fw_cfg, OBJECT(pcms));
     }
 }
=20
@@ -729,7 +730,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compa=
t_1_4_fn,
=20
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("1.3.0")
         { "usb-tablet", "usb_version", "1" },
@@ -740,7 +741,7 @@ static void pc_i440fx_1_3_machine_options(MachineClas=
s *m)
=20
     pc_i440fx_1_4_machine_options(m);
     m->hw_version =3D "1.3.0";
-    pcmc->compat_apic_id_mode =3D true;
+    x86mc->compat_apic_id_mode =3D true;
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8920bd8978..374ac6c068 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -116,6 +116,7 @@ static void pc_q35_init(MachineState *machine)
 {
     PCMachineState *pcms =3D PC_MACHINE(machine);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
     Q35PCIHost *q35_host;
     PCIHostState *phb;
     PCIBus *host_bus;
@@ -153,27 +154,27 @@ static void pc_q35_init(MachineState *machine)
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(qemu limit, user limit).
      */
-    if (!pcms->max_ram_below_4g) {
-        pcms->max_ram_below_4g =3D 1ULL << 32; /* default: 4G */;
+    if (!x86ms->max_ram_below_4g) {
+        x86ms->max_ram_below_4g =3D 4 * GiB;
     }
-    if (lowmem > pcms->max_ram_below_4g) {
-        lowmem =3D pcms->max_ram_below_4g;
+    if (lowmem > x86ms->max_ram_below_4g) {
+        lowmem =3D x86ms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & (1 * GiB - 1)) {
             warn_report("There is possibly poor performance as the ram s=
ize "
                         " (0x%" PRIx64 ") is more then twice the size of=
"
                         " max-ram-below-4g (%"PRIu64") and"
                         " max-ram-below-4g is not a multiple of 1G.",
-                        (uint64_t)machine->ram_size, pcms->max_ram_below=
_4g);
+                        (uint64_t)machine->ram_size, x86ms->max_ram_belo=
w_4g);
         }
     }
=20
     if (machine->ram_size >=3D lowmem) {
-        pcms->above_4g_mem_size =3D machine->ram_size - lowmem;
-        pcms->below_4g_mem_size =3D lowmem;
+        x86ms->above_4g_mem_size =3D machine->ram_size - lowmem;
+        x86ms->below_4g_mem_size =3D lowmem;
     } else {
-        pcms->above_4g_mem_size =3D 0;
-        pcms->below_4g_mem_size =3D machine->ram_size;
+        x86ms->above_4g_mem_size =3D 0;
+        x86ms->below_4g_mem_size =3D machine->ram_size;
     }
=20
     if (xen_enabled()) {
@@ -214,10 +215,10 @@ static void pc_q35_init(MachineState *machine)
     gsi_state =3D g_malloc0(sizeof(*gsi_state));
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
+        x86ms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
                                        GSI_NUM_PINS);
     } else {
-        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM=
_PINS);
+        x86ms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NU=
M_PINS);
     }
=20
     /* create pci host bus */
@@ -232,9 +233,9 @@ static void pc_q35_init(MachineState *machine)
                              MCH_HOST_PROP_SYSTEM_MEM, NULL);
     object_property_set_link(OBJECT(q35_host), OBJECT(system_io),
                              MCH_HOST_PROP_IO_MEM, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->below_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), x86ms->below_4g_mem_size,
                             PCI_HOST_BELOW_4G_MEM_SIZE, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->above_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size,
                             PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
     /* pci */
     qdev_init_nofail(DEVICE(q35_host));
@@ -256,7 +257,7 @@ static void pc_q35_init(MachineState *machine)
     ich9_lpc =3D ICH9_LPC_DEVICE(lpc);
     lpc_dev =3D DEVICE(lpc);
     for (i =3D 0; i < GSI_NUM_PINS; i++) {
-        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, pcms->gsi=
[i]);
+        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gs=
i[i]);
     }
     pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lpc,
                  ICH9_LPC_NB_PIRQS);
@@ -280,7 +281,7 @@ static void pc_q35_init(MachineState *machine)
         ioapic_init_gsi(gsi_state, "q35");
     }
=20
-    pc_register_ferr_irq(pcms->gsi[13]);
+    pc_register_ferr_irq(x86ms->gsi[13]);
=20
     assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
@@ -288,7 +289,7 @@ static void pc_q35_init(MachineState *machine)
     }
=20
     /* init basic PC hardware */
-    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
+    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy=
,
                          (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit_e=
nabled,
                          0xff0104);
=20
@@ -331,7 +332,7 @@ static void pc_q35_init(MachineState *machine)
=20
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               x86ms->fw_cfg, OBJECT(pcms));
     }
 }
=20
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 1b6e668af6..2270e2de1e 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -65,13 +65,14 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState *p=
cms,
                                     unsigned int cpu_index)
 {
     MachineState *ms =3D MACHINE(pcms);
-    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
+    X86MachineClass *x86mc =3D X86_MACHINE_GET_CLASS(x86ms);
     uint32_t correct_id;
     static bool warned;
=20
-    correct_id =3D x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores=
,
+    correct_id =3D x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.core=
s,
                                          ms->smp.threads, cpu_index);
-    if (pcmc->compat_apic_id_mode) {
+    if (x86mc->compat_apic_id_mode) {
         if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
                          "CPU topology won't match the configuration");
@@ -88,11 +89,12 @@ void x86_cpu_new(PCMachineState *pcms, int64_t apic_i=
d, Error **errp)
     Object *cpu =3D NULL;
     Error *local_err =3D NULL;
     CPUX86State *env =3D NULL;
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     cpu =3D object_new(MACHINE(pcms)->cpu_type);
=20
     env =3D &X86_CPU(cpu)->env;
-    env->nr_dies =3D pcms->smp_dies;
+    env->nr_dies =3D x86ms->smp_dies;
=20
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
@@ -108,6 +110,7 @@ void x86_cpus_init(PCMachineState *pcms)
     MachineState *ms =3D MACHINE(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     x86_cpu_set_default_version(pcmc->default_cpu_version);
=20
@@ -119,8 +122,8 @@ void x86_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_cre=
ate().
      */
-    pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
-                                                     ms->smp.max_cpus - =
1) + 1;
+    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
+                                                      ms->smp.max_cpus -=
 1) + 1;
     possible_cpus =3D mc->possible_cpu_arch_ids(ms);
     for (i =3D 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
@@ -140,11 +143,11 @@ x86_cpu_index_to_props(MachineState *ms, unsigned c=
pu_index)
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoInfo topo;
-   PCMachineState *pcms =3D PC_MACHINE(ms);
+   X86MachineState *x86ms =3D X86_MACHINE(ms);
=20
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            pcms->smp_dies, ms->smp.cores,
+                            x86ms->smp_dies, ms->smp.cores,
                             ms->smp.threads, &topo);
    return topo.pkg_id % ms->numa_state->num_nodes;
 }
@@ -152,6 +155,7 @@ int64_t x86_get_default_cpu_node_id(const MachineStat=
e *ms, int idx)
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     PCMachineState *pcms =3D PC_MACHINE(ms);
+    X86MachineState *x86ms =3D X86_MACHINE(ms);
     int i;
     unsigned int max_cpus =3D ms->smp.max_cpus;
=20
@@ -175,11 +179,11 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Mach=
ineState *ms)
         ms->possible_cpus->cpus[i].arch_id =3D
             x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 pcms->smp_dies, ms->smp.cores,
+                                 x86ms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
         ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
-        if (pcms->smp_dies > 1) {
+        if (x86ms->smp_dies > 1) {
             ms->possible_cpus->cpus[i].props.has_die_id =3D true;
             ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
         }
@@ -191,6 +195,22 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machi=
neState *ms)
     return ms->possible_cpus;
 }
=20
+static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    /* cpu index isn't used */
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        X86CPU *cpu =3D X86_CPU(cs);
+
+        if (!cpu->apic_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
+        } else {
+            apic_deliver_nmi(cpu->apic_state);
+        }
+    }
+}
+
 static long get_file_size(FILE *f)
 {
     long where, size;
@@ -328,6 +348,7 @@ void x86_load_linux(PCMachineState *pcms,
     char *vmode;
     MachineState *machine =3D MACHINE(pcms);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     struct setup_data *setup_data;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -400,11 +421,12 @@ void x86_load_linux(PCMachineState *pcms,
                             initrd_filename, gerr->message);
                     exit(1);
                 }
-                pcms->initrd_mapped_file =3D mapped_file;
+                x86ms->initrd_mapped_file =3D mapped_file;
=20
                 initrd_data =3D g_mapped_file_get_contents(mapped_file);
                 initrd_size =3D g_mapped_file_get_length(mapped_file);
-                initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_data=
_size - 1;
+                initrd_max =3D
+                    x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
                 if (initrd_size >=3D initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot s=
upport."
                             "(max: %"PRIu32", need %"PRId64")\n",
@@ -472,8 +494,8 @@ void x86_load_linux(PCMachineState *pcms,
         initrd_max =3D 0x37ffffff;
     }
=20
-    if (initrd_max >=3D pcms->below_4g_mem_size - pcmc->acpi_data_size) =
{
-        initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_data_size - =
1;
+    if (initrd_max >=3D x86ms->below_4g_mem_size - pcmc->acpi_data_size)=
 {
+        initrd_max =3D x86ms->below_4g_mem_size - pcmc->acpi_data_size -=
 1;
     }
=20
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
@@ -544,7 +566,7 @@ void x86_load_linux(PCMachineState *pcms,
                     initrd_filename, gerr->message);
             exit(1);
         }
-        pcms->initrd_mapped_file =3D mapped_file;
+        x86ms->initrd_mapped_file =3D mapped_file;
=20
         initrd_data =3D g_mapped_file_get_contents(mapped_file);
         initrd_size =3D g_mapped_file_get_length(mapped_file);
@@ -688,3 +710,91 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, boo=
l isapc_ram_fw)
                                 (uint32_t)(-bios_size),
                                 bios);
 }
+
+static void x86_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
+                                             const char *name, void *opa=
que,
+                                             Error **errp)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(obj);
+    uint64_t value =3D x86ms->max_ram_below_4g;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void x86_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
+                                             const char *name, void *opa=
que,
+                                             Error **errp)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(obj);
+    Error *error =3D NULL;
+    uint64_t value;
+
+    visit_type_size(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    if (value > 4 * GiB) {
+        error_setg(&error,
+                   "Machine option 'max-ram-below-4g=3D%"PRIu64
+                   "' expects size less than or equal to 4G", value);
+        error_propagate(errp, error);
+        return;
+    }
+
+    if (value < 1 * MiB) {
+        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB bounda=
ry,"
+                    "BIOS may not work with less than 1MiB", value);
+    }
+
+    x86ms->max_ram_below_4g =3D value;
+}
+
+static void x86_machine_initfn(Object *obj)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(obj);
+
+    x86ms->max_ram_below_4g =3D 0; /* use default */
+    x86ms->smp_dies =3D 1;
+}
+
+static void x86_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
+    NMIClass *nc =3D NMI_CLASS(oc);
+
+    mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
+    mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
+    x86mc->compat_apic_id_mode =3D false;
+    nc->nmi_monitor_handler =3D x86_nmi;
+
+    object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
+        x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_=
4g,
+        NULL, NULL, &error_abort);
+
+    object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_=
4G,
+        "Maximum ram below the 4G boundary (32bit boundary)", &error_abo=
rt);
+}
+
+static const TypeInfo x86_machine_info =3D {
+    .name =3D TYPE_X86_MACHINE,
+    .parent =3D TYPE_MACHINE,
+    .abstract =3D true,
+    .instance_size =3D sizeof(X86MachineState),
+    .instance_init =3D x86_machine_initfn,
+    .class_size =3D sizeof(X86MachineClass),
+    .class_init =3D x86_machine_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+         { TYPE_NMI },
+         { }
+    },
+};
+
+static void x86_machine_register_types(void)
+{
+    type_register_static(&x86_machine_info);
+}
+
+type_init(x86_machine_register_types)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 6b5e5bb7f5..95f23a263c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -197,11 +197,13 @@ qemu_irq *xen_interrupt_controller_init(void)
 static void xen_ram_init(PCMachineState *pcms,
                          ram_addr_t ram_size, MemoryRegion **ram_memory_=
p)
 {
+    X86MachineState *x86ms =3D X86_MACHINE(pcms);
     MemoryRegion *sysmem =3D get_system_memory();
     ram_addr_t block_len;
-    uint64_t user_lowmem =3D object_property_get_uint(qdev_get_machine()=
,
-                                                    PC_MACHINE_MAX_RAM_B=
ELOW_4G,
-                                                    &error_abort);
+    uint64_t user_lowmem =3D
+        object_property_get_uint(qdev_get_machine(),
+                                 X86_MACHINE_MAX_RAM_BELOW_4G,
+                                 &error_abort);
=20
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(xen limit, user limit).
@@ -214,20 +216,20 @@ static void xen_ram_init(PCMachineState *pcms,
     }
=20
     if (ram_size >=3D user_lowmem) {
-        pcms->above_4g_mem_size =3D ram_size - user_lowmem;
-        pcms->below_4g_mem_size =3D user_lowmem;
+        x86ms->above_4g_mem_size =3D ram_size - user_lowmem;
+        x86ms->below_4g_mem_size =3D user_lowmem;
     } else {
-        pcms->above_4g_mem_size =3D 0;
-        pcms->below_4g_mem_size =3D ram_size;
+        x86ms->above_4g_mem_size =3D 0;
+        x86ms->below_4g_mem_size =3D ram_size;
     }
-    if (!pcms->above_4g_mem_size) {
+    if (!x86ms->above_4g_mem_size) {
         block_len =3D ram_size;
     } else {
         /*
          * Xen does not allocate the memory continuously, it keeps a
          * hole of the size computed above or passed in.
          */
-        block_len =3D (1ULL << 32) + pcms->above_4g_mem_size;
+        block_len =3D (1ULL << 32) + x86ms->above_4g_mem_size;
     }
     memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
@@ -244,12 +246,12 @@ static void xen_ram_init(PCMachineState *pcms,
      */
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
                              &ram_memory, 0xc0000,
-                             pcms->below_4g_mem_size - 0xc0000);
+                             x86ms->below_4g_mem_size - 0xc0000);
     memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
-    if (pcms->above_4g_mem_size > 0) {
+    if (x86ms->above_4g_mem_size > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
                                  &ram_memory, 0x100000000ULL,
-                                 pcms->above_4g_mem_size);
+                                 x86ms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
 }
@@ -265,7 +267,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t si=
ze, MemoryRegion *mr,
         /* RAM already populated in Xen */
         fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
                 " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGR=
ATE\n",
-                __func__, size, ram_addr);=20
+                __func__, size, ram_addr);
         return;
     }
=20
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1ede055387..ead14e1888 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -89,7 +89,7 @@ static void ioapic_entry_parse(uint64_t entry, struct i=
oapic_entry_info *info)
=20
 static void ioapic_service(IOAPICCommonState *s)
 {
-    AddressSpace *ioapic_as =3D PC_MACHINE(qdev_get_machine())->ioapic_a=
s;
+    AddressSpace *ioapic_as =3D X86_MACHINE(qdev_get_machine())->ioapic_=
as;
     struct ioapic_entry_info info;
     uint8_t i;
     uint32_t mask;
--=20
2.21.0


