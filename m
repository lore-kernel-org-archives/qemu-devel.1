Received: from eggs.gnu.org ([2001:4830:134:3::10]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBE1-0004vX-Ga
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBDy-0005Wh-7p
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBDx-0005WO-Ud
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:33:34 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170623144823.42936-1-pasic@linux.vnet.ibm.com> (Halil Pasic's
	message of "Fri, 23 Jun 2017 16:48:23 +0200")
References: <20170623144823.42936-1-pasic@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 13:33:22 +0200
Message-ID: <87shik5ou5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] vmstate: error hint for failed equal
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug,
> but it's actually the best we can do. Especially in these cases a verbose
> error message is required.
>
> Let's introduce infrastructure for specifying a error hint to be used if
> equal check fails. Let's do this by adding a parameter to the _EQUAL
> macros called _err_hint. Also change all current users to pass NULL as
> last parameter so nothing changes for them.
>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Hi

I have had to add this to your patch to make it compile.

Later, Juan.


>From 74573a4190af8a357054493d5451e2b51c553498 Mon Sep 17 00:00:00 2001
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 10:19:25 +0200
Subject: [PATCH] fix missing Macro applications


Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/block/fdc.c          | 2 +-
 hw/display/qxl.c        | 4 ++--
 hw/display/vga.c        | 2 +-
 hw/display/vmware_vga.c | 2 +-
 hw/ide/ahci.c           | 2 +-
 hw/input/vmmouse.c      | 2 +-
 hw/intc/openpic.c       | 2 +-
 hw/intc/xics.c          | 2 +-
 hw/misc/max111x.c       | 2 +-
 hw/ppc/spapr_iommu.c    | 2 +-
 hw/ppc/spapr_pci.c      | 4 ++--
 hw/ppc/spapr_vio.c      | 4 ++--
 hw/usb/hcd-uhci.c       | 2 +-
 target/ppc/machine.c    | 8 ++++----
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 28f6b6e..4011290 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1217,7 +1217,7 @@ static const VMStateDescription vmstate_fdc = {
         VMSTATE_UINT8(config, FDCtrl),
         VMSTATE_UINT8(lock, FDCtrl),
         VMSTATE_UINT8(pwrd, FDCtrl),
-        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl),
+        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl, NULL),
         VMSTATE_STRUCT_ARRAY(drives, FDCtrl, MAX_FD, 1,
                              vmstate_fdrive, FDrive),
         VMSTATE_END_OF_LIST()
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ad09bb9..3c1688e 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2373,12 +2373,12 @@ static VMStateDescription qxl_vmstate = {
         VMSTATE_UINT32(last_release_offset, PCIQXLDevice),
         VMSTATE_UINT32(mode, PCIQXLDevice),
         VMSTATE_UINT32(ssd.unique, PCIQXLDevice),
-        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice),
+        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice, NULL),
         VMSTATE_STRUCT_ARRAY(guest_slots, PCIQXLDevice, NUM_MEMSLOTS, 0,
                              qxl_memslot, struct guest_slots),
         VMSTATE_STRUCT(guest_primary.surface, PCIQXLDevice, 0,
                        qxl_surface, QXLSurfaceCreate),
-        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice),
+        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice, NULL),
         VMSTATE_VARRAY_INT32(guest_surfaces.cmds, PCIQXLDevice,
                              ssd.num_surfaces, 0,
                              vmstate_info_uint64, uint64_t),
diff --git a/hw/display/vga.c b/hw/display/vga.c
index dcc95f8..80508b8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2099,7 +2099,7 @@ const VMStateDescription vmstate_vga_common = {
         VMSTATE_BUFFER(palette, VGACommonState),
 
         VMSTATE_INT32(bank_offset, VGACommonState),
-        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState),
+        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState, NULL),
         VMSTATE_UINT16(vbe_index, VGACommonState),
         VMSTATE_UINT16_ARRAY(vbe_regs, VGACommonState, VBE_DISPI_INDEX_NB),
         VMSTATE_UINT32(vbe_start_addr, VGACommonState),
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ec5f27d..c989cef 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1192,7 +1192,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
     .minimum_version_id = 0,
     .post_load = vmsvga_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s),
+        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s, NULL),
         VMSTATE_INT32(enable, struct vmsvga_state_s),
         VMSTATE_INT32(config, struct vmsvga_state_s),
         VMSTATE_INT32(cursor.id, struct vmsvga_state_s),
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f60826d..874d3fe 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1669,7 +1669,7 @@ const VMStateDescription vmstate_ahci = {
         VMSTATE_UINT32(control_regs.impl, AHCIState),
         VMSTATE_UINT32(control_regs.version, AHCIState),
         VMSTATE_UINT32(idp_index, AHCIState),
-        VMSTATE_INT32_EQUAL(ports, AHCIState),
+        VMSTATE_INT32_EQUAL(ports, AHCIState, NULL),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
index 4747da9..b6d2208 100644
--- a/hw/input/vmmouse.c
+++ b/hw/input/vmmouse.c
@@ -243,7 +243,7 @@ static const VMStateDescription vmstate_vmmouse = {
     .minimum_version_id = 0,
     .post_load = vmmouse_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(queue_size, VMMouseState),
+        VMSTATE_INT32_EQUAL(queue_size, VMMouseState, NULL),
         VMSTATE_UINT32_ARRAY(queue, VMMouseState, VMMOUSE_QUEUE_SIZE),
         VMSTATE_UINT16(nb_queue, VMMouseState),
         VMSTATE_UINT16(status, VMMouseState),
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index f966d06..5595bb2 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1499,7 +1499,7 @@ static const VMStateDescription vmstate_openpic = {
         VMSTATE_UINT32(max_irq, OpenPICState),
         VMSTATE_STRUCT_VARRAY_UINT32(src, OpenPICState, max_irq, 0,
                                      vmstate_openpic_irqsource, IRQSource),
-        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState),
+        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState, NULL),
         VMSTATE_STRUCT_VARRAY_UINT32(dst, OpenPICState, nb_cpus, 0,
                                      vmstate_openpic_irqdest, IRQDest),
         VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 0,
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 7ccfb53..d4194d6 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -574,7 +574,7 @@ static const VMStateDescription vmstate_ics_simple = {
     .post_load = ics_simple_dispatch_post_load,
     .fields = (VMStateField[]) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState),
+        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
 
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
                                              vmstate_ics_simple_irq,
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 2a277bd..6dbdc03 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -116,7 +116,7 @@ static const VMStateDescription vmstate_max111x = {
         VMSTATE_UINT8(tb1, MAX111xState),
         VMSTATE_UINT8(rb2, MAX111xState),
         VMSTATE_UINT8(rb3, MAX111xState),
-        VMSTATE_INT32_EQUAL(inputs, MAX111xState),
+        VMSTATE_INT32_EQUAL(inputs, MAX111xState, NULL),
         VMSTATE_INT32(com, MAX111xState),
         VMSTATE_ARRAY_INT32_UNSAFE(input, MAX111xState, inputs,
                                    vmstate_info_uint8, uint8_t),
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 0341bc0..8656a54 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -231,7 +231,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
     .post_load = spapr_tce_table_post_load,
     .fields      = (VMStateField []) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(liobn, sPAPRTCETable),
+        VMSTATE_UINT32_EQUAL(liobn, sPAPRTCETable, NULL),
 
         /* IOMMU state */
         VMSTATE_UINT32(mig_nb_table, sPAPRTCETable),
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0b447f2..3b37dcd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1848,7 +1848,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi),
+        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
 
         VMSTATE_END_OF_LIST()
     },
@@ -1936,7 +1936,7 @@ static const VMStateDescription vmstate_spapr_pci = {
     .pre_save = spapr_pci_pre_save,
     .post_load = spapr_pci_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT64_EQUAL(buid, sPAPRPHBState),
+        VMSTATE_UINT64_EQUAL(buid, sPAPRPHBState, NULL),
         VMSTATE_UINT32_TEST(mig_liobn, sPAPRPHBState, pre_2_8_migration),
         VMSTATE_UINT64_TEST(mig_mem_win_addr, sPAPRPHBState, pre_2_8_migration),
         VMSTATE_UINT64_TEST(mig_mem_win_size, sPAPRPHBState, pre_2_8_migration),
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index a0ee4fd..ea3bc8b 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -557,8 +557,8 @@ const VMStateDescription vmstate_spapr_vio = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(reg, VIOsPAPRDevice),
-        VMSTATE_UINT32_EQUAL(irq, VIOsPAPRDevice),
+        VMSTATE_UINT32_EQUAL(reg, VIOsPAPRDevice, NULL),
+        VMSTATE_UINT32_EQUAL(irq, VIOsPAPRDevice, NULL),
 
         /* General VIO device state */
         VMSTATE_UINT64(signal_state, VIOsPAPRDevice),
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index ca72a80..e3562a4 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -415,7 +415,7 @@ static const VMStateDescription vmstate_uhci = {
     .post_load = uhci_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, UHCIState),
-        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState),
+        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
         VMSTATE_STRUCT_ARRAY(ports, UHCIState, NB_PORTS, 1,
                              vmstate_uhci_port, UHCIPort),
         VMSTATE_UINT16(cmd, UHCIState),
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 6cb3a48..445f489 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -419,7 +419,7 @@ static const VMStateDescription vmstate_slb = {
     .needed = slb_needed,
     .post_load = slb_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU),
+        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU, NULL),
         VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
         VMSTATE_END_OF_LIST()
     }
@@ -452,7 +452,7 @@ static const VMStateDescription vmstate_tlb6xx = {
     .minimum_version_id = 1,
     .needed = tlb6xx_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlb6, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlb6xx_entry,
@@ -510,7 +510,7 @@ static const VMStateDescription vmstate_tlbemb = {
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbe, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlbemb_entry,
@@ -551,7 +551,7 @@ static const VMStateDescription vmstate_tlbmas = {
     .minimum_version_id = 1,
     .needed = tlbmas_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbm, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlbmas_entry,
-- 
2.9.4



>
> ---
>
> I have  already had an RFC series prior to this patch trying to do the
> same: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01413.html
> We decided with the migration maintainers to rather add an parameter
> than introduce a load of new macros. All the other feedback from there
> was incorporated too. The RFC also contains the direct motivation for
> this change, which is vmstate conversion of virtio-ccw, and is intended
> to happen on top of this.
> ---
>  hw/display/virtio-gpu.c     |  2 +-
>  hw/nvram/eeprom93xx.c       |  2 +-
>  hw/pci/pci.c                |  2 +-
>  hw/pci/pcie_aer.c           |  2 +-
>  include/migration/vmstate.h | 51 +++++++++++++++++++++++++++++++--------------
>  migration/vmstate-types.c   | 15 +++++++++++++
>  6 files changed, 54 insertions(+), 20 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 58dc0b2737..0506d2c1b0 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -962,7 +962,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
>      .version_id = 1,
>      .fields = (VMStateField[]) {
>          VMSTATE_INT32(enable, struct VirtIOGPU),
> -        VMSTATE_UINT32_EQUAL(conf.max_outputs, struct VirtIOGPU),
> +        VMSTATE_UINT32_EQUAL(conf.max_outputs, struct VirtIOGPU, NULL),
>          VMSTATE_STRUCT_VARRAY_UINT32(scanout, struct VirtIOGPU,
>                                       conf.max_outputs, 1,
>                                       vmstate_virtio_gpu_scanout,
> diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
> index 848692abc0..2fd0e3c29f 100644
> --- a/hw/nvram/eeprom93xx.c
> +++ b/hw/nvram/eeprom93xx.c
> @@ -143,7 +143,7 @@ static const VMStateDescription vmstate_eeprom = {
>          VMSTATE_UINT8(addrbits, eeprom_t),
>          VMSTATE_UINT16_HACK_TEST(size, eeprom_t, is_old_eeprom_version),
>          VMSTATE_UNUSED_TEST(is_old_eeprom_version, 1),
> -        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION),
> +        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION, NULL),
>          VMSTATE_UINT16(data, eeprom_t),
>          VMSTATE_VARRAY_UINT16_UNSAFE(contents, eeprom_t, size, 0,
>                                       vmstate_info_uint16, uint16_t),
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 98ccc27533..b7fee4bdf2 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -74,7 +74,7 @@ static const VMStateDescription vmstate_pcibus = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(nirq, PCIBus),
> +        VMSTATE_INT32_EQUAL(nirq, PCIBus, NULL),
>          VMSTATE_VARRAY_INT32(irq_count, PCIBus,
>                               nirq, 0, vmstate_info_int32,
>                               int32_t),
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 828052b0c0..97200742b4 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -813,7 +813,7 @@ const VMStateDescription vmstate_pcie_aer_log = {
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT16(log_num, PCIEAERLog),
> -        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
> +        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog, NULL),
>          VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
>                                vmstate_pcie_aer_err, PCIEAERErr),
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index e85fbd81fc..85e43da568 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -155,6 +155,7 @@ typedef enum {
>  
>  struct VMStateField {
>      const char *name;
> +    const char *err_hint;
>      size_t offset;
>      size_t size;
>      size_t start;
> @@ -256,6 +257,18 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .offset       = vmstate_offset_value(_state, _field, _type),     \
>  }
>  
> +#define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
> +                            _type, _err_hint) {                      \
> +    .name         = (stringify(_field)),                             \
> +    .err_hint     = (_err_hint),                                     \
> +    .version_id   = (_version),                                      \
> +    .field_exists = (_test),                                         \
> +    .size         = sizeof(_type),                                   \
> +    .info         = &(_info),                                        \
> +    .flags        = VMS_SINGLE,                                      \
> +    .offset       = vmstate_offset_value(_state, _field, _type),     \
> +}
> +
>  /* Validate state using a boolean predicate. */
>  #define VMSTATE_VALIDATE(_name, _test) { \
>      .name         = (_name),                                         \
> @@ -762,29 +775,35 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64(_f, _s)                                        \
>      VMSTATE_UINT64_V(_f, _s, 0)
>  
> -#define VMSTATE_UINT8_EQUAL(_f, _s)                                   \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint8_equal, uint8_t)
> +#define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
> +                        vmstate_info_uint8_equal, uint8_t, _err_hint)
>  
> -#define VMSTATE_UINT16_EQUAL(_f, _s)                                  \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint16_equal, uint16_t)
> +#define VMSTATE_UINT16_EQUAL(_f, _s, _err_hint)                       \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
> +                        vmstate_info_uint16_equal, uint16_t, _err_hint)
>  
> -#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16_equal, uint16_t)
> +#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v, _err_hint)                 \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
> +                        vmstate_info_uint16_equal, uint16_t, _err_hint)
>  
> -#define VMSTATE_INT32_EQUAL(_f, _s)                                   \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_equal, int32_t)
> +#define VMSTATE_INT32_EQUAL(_f, _s, _err_hint)                        \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
> +                        vmstate_info_int32_equal, int32_t, _err_hint)
>  
> -#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32_equal, uint32_t)
> +#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v, _err_hint)                 \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
> +                        vmstate_info_uint32_equal, uint32_t, _err_hint)
>  
> -#define VMSTATE_UINT32_EQUAL(_f, _s)                                  \
> -    VMSTATE_UINT32_EQUAL_V(_f, _s, 0)
> +#define VMSTATE_UINT32_EQUAL(_f, _s, _err_hint)                       \
> +    VMSTATE_UINT32_EQUAL_V(_f, _s, 0, _err_hint)
>  
> -#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64_equal, uint64_t)
> +#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v, _err_hint)                 \
> +    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
> +                        vmstate_info_uint64_equal, uint64_t, _err_hint)
>  
> -#define VMSTATE_UINT64_EQUAL(_f, _s)                                  \
> -    VMSTATE_UINT64_EQUAL_V(_f, _s, 0)
> +#define VMSTATE_UINT64_EQUAL(_f, _s, _err_hint)                       \
> +    VMSTATE_UINT64_EQUAL_V(_f, _s, 0, _err_hint)
>  
>  #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
>      VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 02f05a3359..c056c98bdb 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -126,6 +126,9 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>      error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +    if (field->err_hint) {
> +        error_printf("%s\n", field->err_hint);
> +    }
>      return -EINVAL;
>  }
>  
> @@ -267,6 +270,9 @@ static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>      error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +    if (field->err_hint) {
> +        error_printf("%s\n", field->err_hint);
> +    }
>      return -EINVAL;
>  }
>  
> @@ -341,6 +347,9 @@ static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>      error_report("%" PRIx64 " != %" PRIx64, *v, v2);
> +    if (field->err_hint) {
> +        error_printf("%s\n", field->err_hint);
> +    }
>      return -EINVAL;
>  }
>  
> @@ -364,6 +373,9 @@ static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>      error_report("%x != %x", *v, v2);
> +    if (field->err_hint) {
> +        error_printf("%s\n", field->err_hint);
> +    }
>      return -EINVAL;
>  }
>  
> @@ -387,6 +399,9 @@ static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>      error_report("%x != %x", *v, v2);
> +    if (field->err_hint) {
> +        error_printf("%s\n", field->err_hint);
> +    }
>      return -EINVAL;
>  }
