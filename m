Received: from eggs.gnu.org ([2001:4830:134:3::10]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVZ-0002NW-7K
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVF-0000Bq-4N
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJVE-0000BD-72
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32EEEC05AA42
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:46 -0300
Message-Id: <20170329194148.19015-8-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 7/9] Use const variables for *_GET_CLASS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use const variables for the return value of *_GET_CLASS and
object_get_class(). This will allow us to make *_GET_CLASS and
object_get_class() return const pointers later.

Most of the changes were generated using the following Coccinelle
script, but some additional cases had to be udpated by hand after
running the script.

  @@
  type XClass;
  identifier oc;
  identifier X_GET_CLASS =~ ".*_GET_CLASS|object_get_class";
  @@
  -XClass *oc;
  +const XClass *oc;
   <+...
   oc = X_GET_CLASS(...);
   ...+>

  @@
  type XClass;
  identifier oc;
  identifier X_GET_CLASS =~ ".*_GET_CLASS|object_get_class";
  @@
  +const
   XClass *oc = X_GET_CLASS(...);

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h               | 12 ++++----
 include/qom/object.h            |  2 +-
 target/ppc/mmu-book3s-v3.h      |  2 +-
 target/ppc/mmu-hash64.h         |  2 +-
 target/s390x/cpu.h              |  2 +-
 backends/cryptodev.c            | 10 +++----
 backends/hostmem.c              |  2 +-
 backends/rng.c                  |  4 +--
 backends/tpm.c                  | 28 +++++++++----------
 chardev/char-mux.c              |  2 +-
 chardev/char.c                  | 10 +++----
 cpu-exec.c                      | 14 +++++-----
 device-hotplug.c                |  2 +-
 disas.c                         |  4 +--
 exec.c                          |  6 ++--
 gdbstub.c                       | 10 +++----
 hmp.c                           |  4 +--
 hw/acpi/acpi_interface.c        |  2 +-
 hw/acpi/cpu.c                   |  8 +++---
 hw/acpi/cpu_hotplug.c           |  4 +--
 hw/acpi/ipmi.c                  |  2 +-
 hw/acpi/memory_hotplug.c        |  2 +-
 hw/acpi/nvdimm.c                |  4 +--
 hw/acpi/pcihp.c                 |  4 +--
 hw/arm/aspeed.c                 |  2 +-
 hw/arm/aspeed_soc.c             |  4 +--
 hw/arm/boot.c                   |  2 +-
 hw/arm/exynos4_boards.c         |  2 +-
 hw/arm/vexpress.c               |  2 +-
 hw/arm/virt-acpi-build.c        |  6 ++--
 hw/arm/virt.c                   |  6 ++--
 hw/audio/cs4231a.c              | 10 +++----
 hw/audio/gus.c                  |  6 ++--
 hw/audio/intel-hda.c            |  8 +++---
 hw/audio/sb16.c                 |  6 ++--
 hw/block/dataplane/virtio-blk.c |  6 ++--
 hw/block/fdc.c                  |  8 +++---
 hw/block/m25p80.c               |  2 +-
 hw/char/serial-pci.c            |  2 +-
 hw/char/virtio-console.c        |  6 ++--
 hw/char/virtio-serial-bus.c     | 18 ++++++------
 hw/core/bus.c                   |  2 +-
 hw/core/fw-path-provider.c      |  2 +-
 hw/core/generic-loader.c        |  2 +-
 hw/core/hotplug.c               |  8 +++---
 hw/core/loader.c                |  4 +--
 hw/core/machine.c               |  4 +--
 hw/core/nmi.c                   |  2 +-
 hw/core/qdev-properties.c       |  4 +--
 hw/core/qdev.c                  | 32 ++++++++++-----------
 hw/core/stream.c                |  4 +--
 hw/core/sysbus.c                |  6 ++--
 hw/display/cirrus_vga.c         |  2 +-
 hw/i2c/core.c                   | 10 +++----
 hw/i2c/smbus.c                  |  8 +++---
 hw/i386/acpi-build.c            | 16 +++++------
 hw/i386/kvm/i8254.c             |  2 +-
 hw/i386/kvm/i8259.c             |  2 +-
 hw/i386/pc.c                    | 32 ++++++++++-----------
 hw/i386/pc_piix.c               |  4 +--
 hw/i386/pc_q35.c                |  4 +--
 hw/i386/x86-iommu.c             |  2 +-
 hw/ide/microdrive.c             |  4 +--
 hw/ide/qdev.c                   |  2 +-
 hw/input/adb.c                  |  6 ++--
 hw/input/virtio-input.c         | 12 ++++----
 hw/intc/apic_common.c           | 26 ++++++++---------
 hw/intc/arm_gic.c               |  2 +-
 hw/intc/arm_gic_common.c        |  4 +--
 hw/intc/arm_gic_kvm.c           |  4 +--
 hw/intc/arm_gicv3.c             |  2 +-
 hw/intc/arm_gicv3_common.c      |  4 +--
 hw/intc/arm_gicv3_its_common.c  |  6 ++--
 hw/intc/arm_gicv3_kvm.c         |  4 +--
 hw/intc/i8259.c                 |  2 +-
 hw/intc/i8259_common.c          |  4 +--
 hw/intc/ioapic_common.c         |  6 ++--
 hw/intc/xics.c                  | 26 ++++++++---------
 hw/ipack/ipack.c                |  4 +--
 hw/ipack/tpci200.c              | 12 ++++----
 hw/ipmi/ipmi_bmc_extern.c       | 12 ++++----
 hw/ipmi/ipmi_bmc_sim.c          | 24 ++++++++--------
 hw/ipmi/isa_ipmi_bt.c           | 22 +++++++--------
 hw/ipmi/isa_ipmi_kcs.c          | 20 ++++++-------
 hw/mem/pc-dimm.c                | 10 +++----
 hw/misc/imx_ccm.c               |  2 +-
 hw/net/e1000.c                  |  2 +-
 hw/net/vhost_net.c              |  4 +--
 hw/net/vmxnet3.c                |  2 +-
 hw/nvram/fw_cfg.c               |  2 +-
 hw/pci-bridge/pcie_root_port.c  |  8 +++---
 hw/pci/pci.c                    | 16 +++++------
 hw/pcmcia/pxa2xx.c              | 16 +++++------
 hw/ppc/pnv.c                    | 14 +++++-----
 hw/ppc/pnv_core.c               |  2 +-
 hw/ppc/pnv_xscom.c              |  6 ++--
 hw/ppc/prep.c                   |  8 +++---
 hw/ppc/spapr.c                  | 50 ++++++++++++++++-----------------
 hw/ppc/spapr_cpu_core.c         |  4 +--
 hw/ppc/spapr_drc.c              | 20 ++++++-------
 hw/ppc/spapr_events.c           |  6 ++--
 hw/ppc/spapr_hcall.c            |  2 +-
 hw/ppc/spapr_pci.c              | 14 +++++-----
 hw/ppc/spapr_rtas.c             |  8 +++---
 hw/ppc/spapr_vio.c              | 12 ++++----
 hw/s390x/css-bridge.c           |  2 +-
 hw/s390x/css.c                  |  6 ++--
 hw/s390x/event-facility.c       | 14 +++++-----
 hw/s390x/s390-skeys-kvm.c       |  2 +-
 hw/s390x/s390-skeys.c           |  8 +++---
 hw/s390x/s390-virtio-ccw.c      |  8 +++---
 hw/s390x/sclp.c                 | 10 +++----
 hw/s390x/virtio-ccw.c           | 12 ++++----
 hw/scsi/megasas.c               |  8 +++---
 hw/scsi/mptconfig.c             |  6 ++--
 hw/scsi/scsi-bus.c              |  8 +++---
 hw/scsi/vhost-scsi.c            |  4 +--
 hw/scsi/virtio-scsi-dataplane.c |  6 ++--
 hw/scsi/vmw_pvscsi.c            |  2 +-
 hw/sd/core.c                    | 18 ++++++------
 hw/sh4/sh7750.c                 |  2 +-
 hw/smbios/smbios_type_38.c      |  2 +-
 hw/sparc/sun4m.c                |  2 +-
 hw/sparc64/sun4u.c              |  2 +-
 hw/ssi/aspeed_smc.c             |  2 +-
 hw/ssi/ssi.c                    |  8 +++---
 hw/ssi/xilinx_spips.c           |  2 +-
 hw/timer/i8254.c                |  2 +-
 hw/timer/i8254_common.c         | 10 +++----
 hw/timer/m48t59-isa.c           |  2 +-
 hw/timer/m48t59.c               |  2 +-
 hw/usb/bus.c                    | 32 ++++++++++-----------
 hw/usb/dev-smartcard-reader.c   |  8 +++---
 hw/usb/hcd-ehci-pci.c           |  2 +-
 hw/usb/hcd-ehci-sysbus.c        |  2 +-
 hw/usb/hcd-uhci.c               |  2 +-
 hw/vfio/amd-xgbe.c              |  2 +-
 hw/vfio/calxeda-xgmac.c         |  2 +-
 hw/virtio/vhost-vsock.c         |  4 +--
 hw/virtio/vhost.c               |  2 +-
 hw/virtio/virtio-bus.c          | 24 ++++++++--------
 hw/virtio/virtio-mmio.c         |  2 +-
 hw/virtio/virtio-pci.c          | 20 ++++++-------
 hw/virtio/virtio.c              | 62 ++++++++++++++++++++---------------------
 io/channel.c                    | 20 ++++++-------
 kvm-all.c                       |  2 +-
 migration/migration.c           |  2 +-
 migration/savevm.c              |  2 +-
 monitor.c                       |  2 +-
 net/filter.c                    |  6 ++--
 qdev-monitor.c                  |  8 +++---
 qmp.c                           |  4 +--
 qom/cpu.c                       | 26 ++++++++---------
 qom/object.c                    |  2 +-
 qom/object_interfaces.c         |  4 +--
 target/alpha/cpu.c              |  2 +-
 target/arm/cpu.c                |  8 +++---
 target/arm/kvm.c                |  2 +-
 target/cris/cpu.c               | 10 +++----
 target/cris/helper.c            |  2 +-
 target/hppa/cpu.c               |  2 +-
 target/i386/cpu.c               |  8 +++---
 target/i386/kvm.c               |  2 +-
 target/i386/machine.c           |  2 +-
 target/lm32/cpu.c               |  4 +--
 target/lm32/gdbstub.c           |  2 +-
 target/m68k/cpu.c               |  4 +--
 target/microblaze/cpu.c         |  4 +--
 target/microblaze/gdbstub.c     |  2 +-
 target/mips/cpu.c               |  4 +--
 target/moxie/cpu.c              |  4 +--
 target/nios2/cpu.c              |  8 +++---
 target/openrisc/cpu.c           |  4 +--
 target/openrisc/gdbstub.c       |  2 +-
 target/ppc/arch_dump.c          |  2 +-
 target/ppc/compat.c             |  4 +--
 target/ppc/excp_helper.c        |  2 +-
 target/ppc/mmu-hash64.c         |  6 ++--
 target/ppc/mmu_helper.c         |  2 +-
 target/ppc/translate_init.c     | 12 ++++----
 target/s390x/cpu.c              |  4 +--
 target/s390x/cpu_models.c       |  4 +--
 target/s390x/kvm.c              |  4 +--
 target/s390x/mem_helper.c       |  6 ++--
 target/s390x/misc_helper.c      |  6 ++--
 target/s390x/mmu_helper.c       |  2 +-
 target/sh4/cpu.c                |  4 +--
 target/sparc/cpu.c              |  4 +--
 target/tilegx/cpu.c             |  4 +--
 target/tricore/cpu.c            |  4 +--
 target/unicore32/cpu.c          |  2 +-
 target/xtensa/cpu.c             |  6 ++--
 tests/check-qom-interface.c     |  2 +-
 user-exec.c                     |  2 +-
 vl.c                            |  2 +-
 195 files changed, 679 insertions(+), 679 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index c3292efe1c..c6a5bfa8cd 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -549,7 +549,7 @@ void cpu_dump_statistics(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
 static inline hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                                    MemTxAttrs *attrs)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->get_phys_page_attrs_debug) {
         return cc->get_phys_page_attrs_debug(cpu, addr, attrs);
@@ -585,7 +585,7 @@ static inline hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
  */
 static inline int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->asidx_from_attrs) {
         return cc->asidx_from_attrs(cpu, attrs);
@@ -644,7 +644,7 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model);
  */
 static inline bool cpu_has_work(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     g_assert(cc->has_work);
     return cc->has_work(cpu);
@@ -811,7 +811,7 @@ static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
                                          bool is_write, bool is_exec,
                                          int opaque, unsigned size)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->do_unassigned_access) {
         cc->do_unassigned_access(cpu, addr, is_write, is_exec, opaque, size);
@@ -822,7 +822,7 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                         MMUAccessType access_type,
                                         int mmu_idx, uintptr_t retaddr)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     cc->do_unaligned_access(cpu, addr, access_type, mmu_idx, retaddr);
 }
@@ -837,7 +837,7 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
  */
 static inline void cpu_set_pc(CPUState *cpu, vaddr addr)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     cc->set_pc(cpu, addr);
 }
diff --git a/include/qom/object.h b/include/qom/object.h
index bb0be22ac7..4af3c8e232 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -989,7 +989,7 @@ ObjectProperty *object_class_property_find(const ObjectClass *klass,
                                            Error **errp);
 
 typedef struct ObjectPropertyIterator {
-    ObjectClass *nextclass;
+    const ObjectClass *nextclass;
     GHashTableIter iter;
 } ObjectPropertyIterator;
 
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 636f6ab95f..0c58891732 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -34,7 +34,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
 
 static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
 {
-    PPCVirtualHypervisorClass *vhc =
+    const PPCVirtualHypervisorClass *vhc =
         PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
 
     return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 54f1e37655..d62882b414 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -102,7 +102,7 @@ static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
 {
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
+        const PPCVirtualHypervisorClass *vhc =
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         return vhc->hpt_mask(cpu->vhyp);
     }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 058ddad83a..1f904ad5d0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -505,7 +505,7 @@ static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
 /* helper functions for run_on_cpu() */
 static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
 
     scc->cpu_reset(cs);
 }
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 832f056266..e0ec00278d 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -67,7 +67,7 @@ void cryptodev_backend_cleanup(
              CryptoDevBackend *backend,
              Error **errp)
 {
-    CryptoDevBackendClass *bc =
+    const CryptoDevBackendClass *bc =
                   CRYPTODEV_BACKEND_GET_CLASS(backend);
 
     if (bc->cleanup) {
@@ -80,7 +80,7 @@ int64_t cryptodev_backend_sym_create_session(
            CryptoDevBackendSymSessionInfo *sess_info,
            uint32_t queue_index, Error **errp)
 {
-    CryptoDevBackendClass *bc =
+    const CryptoDevBackendClass *bc =
                       CRYPTODEV_BACKEND_GET_CLASS(backend);
 
     if (bc->create_session) {
@@ -95,7 +95,7 @@ int cryptodev_backend_sym_close_session(
            uint64_t session_id,
            uint32_t queue_index, Error **errp)
 {
-    CryptoDevBackendClass *bc =
+    const CryptoDevBackendClass *bc =
                       CRYPTODEV_BACKEND_GET_CLASS(backend);
 
     if (bc->close_session) {
@@ -110,7 +110,7 @@ static int cryptodev_backend_sym_operation(
                  CryptoDevBackendSymOpInfo *op_info,
                  uint32_t queue_index, Error **errp)
 {
-    CryptoDevBackendClass *bc =
+    const CryptoDevBackendClass *bc =
                       CRYPTODEV_BACKEND_GET_CLASS(backend);
 
     if (bc->do_sym_op) {
@@ -178,7 +178,7 @@ static void
 cryptodev_backend_complete(UserCreatable *uc, Error **errp)
 {
     CryptoDevBackend *backend = CRYPTODEV_BACKEND(uc);
-    CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
+    const CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
     Error *local_err = NULL;
 
     if (bc->init) {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 89feb9ed75..2f5ca16dde 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -257,7 +257,7 @@ static void
 host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
-    HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
+    const HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     Error *local_err = NULL;
     void *ptr;
     uint64_t sz;
diff --git a/backends/rng.c b/backends/rng.c
index 398ebe4a7d..0f7c42ab9e 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -20,7 +20,7 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
                                  EntropyReceiveFunc *receive_entropy,
                                  void *opaque)
 {
-    RngBackendClass *k = RNG_BACKEND_GET_CLASS(s);
+    const RngBackendClass *k = RNG_BACKEND_GET_CLASS(s);
     RngRequest *req;
 
     if (k->request_entropy) {
@@ -53,7 +53,7 @@ static void rng_backend_complete(UserCreatable *uc, Error **errp)
 static void rng_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 {
     RngBackend *s = RNG_BACKEND(obj);
-    RngBackendClass *k = RNG_BACKEND_GET_CLASS(s);
+    const RngBackendClass *k = RNG_BACKEND_GET_CLASS(s);
     Error *local_err = NULL;
 
     if (value == s->opened) {
diff --git a/backends/tpm.c b/backends/tpm.c
index 536f262bb7..d02f3bdce8 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -22,21 +22,21 @@
 
 enum TpmType tpm_backend_get_type(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->type;
 }
 
 const char *tpm_backend_get_desc(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->desc();
 }
 
 void tpm_backend_destroy(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     k->ops->destroy(s);
 }
@@ -44,70 +44,70 @@ void tpm_backend_destroy(TPMBackend *s)
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->init(s, state, datacb);
 }
 
 int tpm_backend_startup_tpm(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->startup_tpm(s);
 }
 
 bool tpm_backend_had_startup_error(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->had_startup_error(s);
 }
 
 size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->realloc_buffer(sb);
 }
 
 void tpm_backend_deliver_request(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     k->ops->deliver_request(s);
 }
 
 void tpm_backend_reset(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     k->ops->reset(s);
 }
 
 void tpm_backend_cancel_cmd(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     k->ops->cancel_cmd(s);
 }
 
 bool tpm_backend_get_tpm_established_flag(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->get_tpm_established_flag(s);
 }
 
 int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->reset_tpm_established_flag(s, locty);
 }
 
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
 {
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
     return k->ops->get_tpm_version(s);
 }
@@ -127,7 +127,7 @@ void tpm_backend_open(TPMBackend *s, Error **errp)
 static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 {
     TPMBackend *s = TPM_BACKEND(obj);
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    const TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
     Error *local_err = NULL;
 
     if (value == s->opened) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 5547a36a0a..23f73825e3 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -241,7 +241,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxChardev *d = MUX_CHARDEV(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
     if (!cc->chr_add_watch) {
         return NULL;
diff --git a/chardev/char.c b/chardev/char.c
index 3df116350b..f4abfbf0fd 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -102,7 +102,7 @@ static void qemu_chr_fe_write_log(Chardev *s,
 static int qemu_chr_fe_write_buffer(Chardev *s,
                                     const uint8_t *buf, int len, int *offset)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(s);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(s);
     int res = 0;
     *offset = 0;
 
@@ -137,7 +137,7 @@ static bool qemu_chr_replay(Chardev *chr)
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     Chardev *s = be->chr;
-    ChardevClass *cc;
+    const ChardevClass *cc;
     int ret;
 
     if (!s) {
@@ -369,7 +369,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
 static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
     ChardevCommon *common = backend ? backend->u.null.data : NULL;
 
@@ -549,7 +549,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     Chardev *s;
-    ChardevClass *cc;
+    const ChardevClass *cc;
     int fe_open;
 
     s = b->chr;
@@ -603,7 +603,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
 
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
     if (cc->chr_wait_connected) {
         return cc->chr_wait_connected(chr, errp);
diff --git a/cpu-exec.c b/cpu-exec.c
index 748cb66bca..45a4c7d0bd 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -174,7 +174,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
          */
-        CPUClass *cc = CPU_GET_CLASS(cpu);
+        const CPUClass *cc = CPU_GET_CLASS(cpu);
         qemu_log_mask_and_addr(CPU_LOG_EXEC, last_tb->pc,
                                "Stopped execution of TB chain before %p ["
                                TARGET_FMT_lx "] %s\n",
@@ -223,7 +223,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
 static void cpu_exec_step(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
@@ -421,7 +421,7 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUWatchpoint *wp;
 
     if (!cpu->watchpoint_hit) {
@@ -450,7 +450,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
                which will be handled outside the cpu execution
                loop */
 #if defined(TARGET_I386)
-            CPUClass *cc = CPU_GET_CLASS(cpu);
+            const CPUClass *cc = CPU_GET_CLASS(cpu);
             cc->do_interrupt(cpu);
 #endif
             *ret = cpu->exception_index;
@@ -458,7 +458,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             return true;
 #else
             if (replay_exception()) {
-                CPUClass *cc = CPU_GET_CLASS(cpu);
+                const CPUClass *cc = CPU_GET_CLASS(cpu);
                 qemu_mutex_lock_iothread();
                 cc->do_interrupt(cpu);
                 qemu_mutex_unlock_iothread();
@@ -486,7 +486,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
@@ -621,7 +621,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 
 int cpu_exec(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     int ret;
     SyncClocks sc = { 0 };
 
diff --git a/device-hotplug.c b/device-hotplug.c
index 126f73c676..1ac178aa30 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -36,7 +36,7 @@ static DriveInfo *add_init_drive(const char *optstr)
 {
     DriveInfo *dinfo;
     QemuOpts *opts;
-    MachineClass *mc;
+    const MachineClass *mc;
 
     opts = drive_def(optstr);
     if (!opts)
diff --git a/disas.c b/disas.c
index d335c55bbf..4f4d7dddb5 100644
--- a/disas.c
+++ b/disas.c
@@ -181,7 +181,7 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     target_ulong pc;
     int count;
     CPUDebug s;
@@ -369,7 +369,7 @@ monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
 void monitor_disas(Monitor *mon, CPUState *cpu,
                    target_ulong pc, int nb_insn, int is_physical, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     int count, i;
     CPUDebug s;
 
diff --git a/exec.c b/exec.c
index e57a8a2178..56e2a495a2 100644
--- a/exec.c
+++ b/exec.c
@@ -673,7 +673,7 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     cpu_list_remove(cpu);
 
@@ -711,7 +711,7 @@ void cpu_exec_initfn(CPUState *cpu)
 
 void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    CPUClass *cc ATTRIBUTE_UNUSED = CPU_GET_CLASS(cpu);
+    const CPUClass *cc ATTRIBUTE_UNUSED = CPU_GET_CLASS(cpu);
 
     cpu_list_add(cpu);
 
@@ -2207,7 +2207,7 @@ static const MemoryRegionOps notdirty_mem_ops = {
 static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
 {
     CPUState *cpu = current_cpu;
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
     target_ulong pc, cs_base;
     target_ulong vaddr;
diff --git a/gdbstub.c b/gdbstub.c
index 3c7e5f3a96..25216c06a6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -47,7 +47,7 @@
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
@@ -625,7 +625,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
 
 static int gdb_read_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
     GDBRegisterState *r;
 
@@ -643,7 +643,7 @@ static int gdb_read_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
     GDBRegisterState *r;
 
@@ -710,7 +710,7 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
         [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
     };
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     int cputype = xlat[gdbtype];
 
     if (cc->gdb_stop_before_watchpoint) {
@@ -943,7 +943,7 @@ out:
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
-    CPUClass *cc;
+    const CPUClass *cc;
     const char *p;
     uint32_t thread;
     int ch, reg_size, type, res;
diff --git a/hmp.c b/hmp.c
index edb8970461..5e3641ed70 100644
--- a/hmp.c
+++ b/hmp.c
@@ -809,7 +809,7 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
 static int hmp_info_irq_foreach(Object *obj, void *opaque)
 {
     InterruptStatsProvider *intc;
-    InterruptStatsProviderClass *k;
+    const InterruptStatsProviderClass *k;
     Monitor *mon = opaque;
 
     if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
@@ -847,7 +847,7 @@ void hmp_info_irq(Monitor *mon, const QDict *qdict)
 static int hmp_info_pic_foreach(Object *obj, void *opaque)
 {
     InterruptStatsProvider *intc;
-    InterruptStatsProviderClass *k;
+    const InterruptStatsProviderClass *k;
     Monitor *mon = opaque;
 
     if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
index 6583917b8e..ed6c394c98 100644
--- a/hw/acpi/acpi_interface.c
+++ b/hw/acpi/acpi_interface.c
@@ -4,7 +4,7 @@
 
 void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
 {
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(dev);
+    const AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(dev);
     if (adevc->send_event) {
         AcpiDeviceIf *adev = ACPI_DEVICE_IF(dev);
         adevc->send_event(adev, event);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 8c719d3f9d..21b8c16c44 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -189,7 +189,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *id_list;
     int i;
 
@@ -208,7 +208,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
-    CPUClass *k = CPU_GET_CLASS(dev);
+    const CPUClass *k = CPU_GET_CLASS(dev);
     uint64_t cpu_arch_id = k->get_arch_id(CPU(dev));
     int i;
 
@@ -323,11 +323,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
     Aml *sb_scope = aml_scope("_SB");
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
     char *cphp_res_path = g_strdup_printf("%s." CPUHP_RES_DEVICE, res_root);
     Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
+    const AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
     AcpiDeviceIf *adev = ACPI_DEVICE_IF(obj);
 
     cpu_ctrl_dev = aml_device("%s", cphp_res_path);
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5243918125..ab0bf1afb1 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -59,7 +59,7 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
 static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
                                      Error **errp)
 {
-    CPUClass *k = CPU_GET_CLASS(cpu);
+    const CPUClass *k = CPU_GET_CLASS(cpu);
     int64_t cpu_id;
 
     cpu_id = k->get_arch_id(cpu);
@@ -127,7 +127,7 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     Aml *cpus_map = aml_name(CPU_ON_BITMAP);
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
 
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index 651e2e94ea..4dbad05982 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -88,7 +88,7 @@ void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
 
     QTAILQ_FOREACH(kid, &bus->children,  sibling) {
         IPMIInterface *ii;
-        IPMIInterfaceClass *iic;
+        const IPMIInterfaceClass *iic;
         IPMIFwInfo info;
         Object *obj = object_dynamic_cast(OBJECT(kid->child),
                                           TYPE_IPMI_INTERFACE);
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 210073d283..4e5f8a4ae9 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -262,7 +262,7 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
     MemStatus *mdev;
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     if (!dc->hotpluggable) {
         return;
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..05d98dc3ff 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -690,7 +690,7 @@ static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
 static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
                                       hwaddr dsm_mem_addr)
 {
-    NVDIMMClass *nvc = NVDIMM_GET_CLASS(nvdimm);
+    const NVDIMMClass *nvc = NVDIMM_GET_CLASS(nvdimm);
     NvdimmFuncGetLabelDataIn *get_label_data;
     NvdimmFuncGetLabelDataOut *get_label_data_out;
     uint32_t status;
@@ -730,7 +730,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
 static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
                                       hwaddr dsm_mem_addr)
 {
-    NVDIMMClass *nvc = NVDIMM_GET_CLASS(nvdimm);
+    const NVDIMMClass *nvc = NVDIMM_GET_CLASS(nvdimm);
     NvdimmFuncSetLabelDataIn *set_label_data;
     uint32_t status;
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2b0f3e1bfb..48c9f3e583 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -106,8 +106,8 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
 
 static bool acpi_pcihp_pc_no_hotplug(AcpiPciHpState *s, PCIDevice *dev)
 {
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
     /*
      * ACPI doesn't allow hotplug of bridge devices.  Don't allow
      * hot-unplug of bridge devices unless they were added by hotplug
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 283c038814..21a506782d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -164,7 +164,7 @@ static void aspeed_board_init(MachineState *machine,
                               const AspeedBoardConfig *cfg)
 {
     AspeedBoardState *bmc;
-    AspeedSoCClass *sc;
+    const AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
 
     bmc = g_new0(AspeedBoardState, 1);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 571e4f097b..020fe1b159 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -120,7 +120,7 @@ static const MemoryRegionOps aspeed_soc_io_ops = {
 static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    const AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     char *cpu_typename;
     int i;
 
@@ -181,7 +181,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    const AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     Error *err = NULL, *local_err = NULL;
 
     /* IO space */
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4b6a..0e93aca969 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -702,7 +702,7 @@ static int do_arm_linux_init(Object *obj, void *opaque)
 {
     if (object_dynamic_cast(obj, TYPE_ARM_LINUX_BOOT_IF)) {
         ARMLinuxBootIf *albif = ARM_LINUX_BOOT_IF(obj);
-        ARMLinuxBootIfClass *albifc = ARM_LINUX_BOOT_IF_GET_CLASS(obj);
+        const ARMLinuxBootIfClass *albifc = ARM_LINUX_BOOT_IF_GET_CLASS(obj);
         struct arm_boot_info *info = opaque;
 
         if (albifc->arm_linux_init) {
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 0efa194054..7101e38c13 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -98,7 +98,7 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
 static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
                                                    Exynos4BoardType board_type)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
         fprintf(stderr, "%s board supports only %d CPU cores. Ignoring smp_cpus"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index c6b1e674b4..266c27564f 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -543,7 +543,7 @@ static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
 static void vexpress_common_init(MachineState *machine)
 {
     VexpressMachineState *vms = VEXPRESS_MACHINE(machine);
-    VexpressMachineClass *vmc = VEXPRESS_MACHINE_GET_CLASS(machine);
+    const VexpressMachineClass *vmc = VEXPRESS_MACHINE_GET_CLASS(machine);
     VEDBoardInfo *daughterboard = vmc->daughterboard;
     DeviceState *dev, *sysctl, *pl041;
     qemu_irq pic[64];
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0835e59bb2..605f54ee2d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -546,7 +546,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void
 build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int gtdt_start = table_data->len;
     AcpiGenericTimerTable *gtdt;
     uint32_t irqflags;
@@ -581,7 +581,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int madt_start = table_data->len;
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
@@ -746,7 +746,7 @@ struct AcpiBuildState {
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
     unsigned dsdt, rsdt;
     GArray *tables_blob = tables->table_data;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5f62a0321e..6579cb97a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -302,7 +302,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
      * the correct information.
      */
     ARMCPU *armcpu;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
 
     if (vmc->claim_edge_triggered_timers) {
@@ -1197,7 +1197,7 @@ void virt_machine_done(Notifier *notifier, void *data)
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
@@ -1554,7 +1554,7 @@ type_init(machvirt_machine_init);
 static void virt_2_9_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3ecd0582bf..47630c7e77 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -266,7 +266,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
 {
     int xtal;
     struct audsettings as;
-    IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
 
 #ifdef DEBUG_XLAW
     if (val == 0 || val == 32)
@@ -455,7 +455,7 @@ static void cs_write (void *opaque, hwaddr addr,
             }
             else {
                 if (s->dma_running) {
-                    IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+                    const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
                     k->release_DREQ(s->isa_dma, s->dma);
                     AUD_set_active_out (s->voice, 0);
                     s->dma_running = 0;
@@ -521,7 +521,7 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
 {
     int temp, net;
     uint8_t tmpbuf[4096];
-    IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
 
     temp = len;
     net = 0;
@@ -604,7 +604,7 @@ static int cs4231a_pre_load (void *opaque)
     CSState *s = opaque;
 
     if (s->dma_running) {
-        IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+        const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
         k->release_DREQ(s->isa_dma, s->dma);
         AUD_set_active_out (s->voice, 0);
     }
@@ -661,7 +661,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
 {
     ISADevice *d = ISA_DEVICE (dev);
     CSState *s = CS4231A (dev);
-    IsaDmaClass *k;
+    const IsaDmaClass *k;
 
     isa_init_irq (d, &s->pic, s->irq);
     s->isa_dma = isa_get_dma(isa_bus_from_device(d), s->dma);
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 3d08a6576a..07aba884d2 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -175,7 +175,7 @@ void GUS_irqclear (GUSEmuState *emu, int hwirq)
 void GUS_dmarequest (GUSEmuState *emu)
 {
     GUSState *s = emu->opaque;
-    IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
     ldebug ("dma request %d\n", der->gusdma);
     k->hold_DREQ(s->isa_dma, s->emu.gusdma);
 }
@@ -183,7 +183,7 @@ void GUS_dmarequest (GUSEmuState *emu)
 static int GUS_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
 {
     GUSState *s = opaque;
-    IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
     char tmpbuf[4096];
     int pos = dma_pos, mode, left = dma_len - dma_pos;
 
@@ -238,7 +238,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
 {
     ISADevice *d = ISA_DEVICE(dev);
     GUSState *s = GUS (dev);
-    IsaDmaClass *k;
+    const IsaDmaClass *k;
     struct audsettings as;
 
     AUD_register_card ("gus", &s->card);
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 537face94d..afdb3e4912 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -55,7 +55,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
 {
     HDACodecBus *bus = HDA_BUS(qdev->parent_bus);
     HDACodecDevice *dev = HDA_CODEC_DEVICE(qdev);
-    HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
+    const HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
 
     if (dev->cad == -1) {
         dev->cad = bus->next_cad;
@@ -73,7 +73,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
 static int hda_codec_dev_exit(DeviceState *qdev)
 {
     HDACodecDevice *dev = HDA_CODEC_DEVICE(qdev);
-    HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
+    const HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
 
     if (cdc->exit) {
         cdc->exit(dev);
@@ -280,7 +280,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
 {
     uint32_t cad, nid, data;
     HDACodecDevice *codec;
-    HDACodecDeviceClass *cdc;
+    const HDACodecDeviceClass *cdc;
 
     cad = (verb >> 28) & 0x0f;
     if (verb & (1 << 27)) {
@@ -493,7 +493,7 @@ static void intel_hda_notify_codecs(IntelHDAState *d, uint32_t stream, bool runn
 
     QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
         DeviceState *qdev = kid->child;
-        HDACodecDeviceClass *cdc;
+        const HDACodecDeviceClass *cdc;
 
         cdev = HDA_CODEC_DEVICE(qdev);
         cdc = HDA_CODEC_DEVICE_GET_CLASS(cdev);
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6b4427f242..912ca5cf0e 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -170,7 +170,7 @@ static void control (SB16State *s, int hold)
 {
     int dma = s->use_hdma ? s->hdma : s->dma;
     IsaDma *isa_dma = s->use_hdma ? s->isa_hdma : s->isa_dma;
-    IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
     s->dma_running = hold;
 
     ldebug ("hold %d high %d dma %d\n", hold, s->use_hdma, dma);
@@ -1143,7 +1143,7 @@ static int write_audio (SB16State *s, int nchan, int dma_pos,
                         int dma_len, int len)
 {
     IsaDma *isa_dma = nchan == s->dma ? s->isa_dma : s->isa_hdma;
-    IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
+    const IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
     int temp, net;
     uint8_t tmpbuf[4096];
 
@@ -1362,7 +1362,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
 {
     ISADevice *isadev = ISA_DEVICE (dev);
     SB16State *s = SB16 (dev);
-    IsaDmaClass *k;
+    const IsaDmaClass *k;
 
     isa_init_irq (isadev, &s->pic, s->irq);
 
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e64e..81cc13e7e2 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -82,7 +82,7 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
 {
     VirtIOBlockDataPlane *s;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     *dataplane = NULL;
 
@@ -164,7 +164,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     VirtIOBlock *vblk = VIRTIO_BLK(vdev);
     VirtIOBlockDataPlane *s = vblk->dataplane;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vblk)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     unsigned i;
     unsigned nvqs = s->conf->num_queues;
     int r;
@@ -232,7 +232,7 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     VirtIOBlock *vblk = VIRTIO_BLK(vdev);
     VirtIOBlockDataPlane *s = vblk->dataplane;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vblk));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     unsigned i;
     unsigned nvqs = s->conf->num_queues;
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index a328693d15..8e8bd3d589 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1629,7 +1629,7 @@ static void fdctrl_stop_transfer(FDCtrl *fdctrl, uint8_t status0,
     fdctrl->fifo[6] = FD_SECTOR_SC;
     fdctrl->data_dir = FD_DIR_READ;
     if (!(fdctrl->msr & FD_MSR_NONDMA)) {
-        IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
+        const IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
         k->release_DREQ(fdctrl->dma, fdctrl->dma_chann);
     }
     fdctrl->msr |= FD_MSR_RQM | FD_MSR_DIO;
@@ -1717,7 +1717,7 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
     fdctrl->eot = fdctrl->fifo[6];
     if (fdctrl->dor & FD_DOR_DMAEN) {
         IsaDmaTransferMode dma_mode;
-        IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
+        const IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
         bool dma_mode_ok;
         /* DMA transfer are enabled. Check if DMA channel is well programmed */
         dma_mode = k->get_transfer_mode(fdctrl->dma, fdctrl->dma_chann);
@@ -1791,7 +1791,7 @@ static int fdctrl_transfer_handler (void *opaque, int nchan,
     FDrive *cur_drv;
     int len, start_pos, rel_pos;
     uint8_t status0 = 0x00, status1 = 0x00, status2 = 0x00;
-    IsaDmaClass *k;
+    const IsaDmaClass *k;
 
     fdctrl = opaque;
     if (fdctrl->msr & FD_MSR_RQM) {
@@ -2667,7 +2667,7 @@ static void fdctrl_realize_common(DeviceState *dev, FDCtrl *fdctrl,
     fdctrl->num_floppies = MAX_FD;
 
     if (fdctrl->dma_chann != -1) {
-        IsaDmaClass *k;
+        const IsaDmaClass *k;
         assert(fdctrl->dma);
         k = ISADMA_GET_CLASS(fdctrl->dma);
         k->register_channel(fdctrl->dma, fdctrl->dma_chann,
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 190573cefa..e5585eeca9 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1214,7 +1214,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
 static void m25p80_realize(SSISlave *ss, Error **errp)
 {
     Flash *s = M25P80(ss);
-    M25P80Class *mc = M25P80_GET_CLASS(s);
+    const M25P80Class *mc = M25P80_GET_CLASS(s);
     int ret;
 
     s->pi = mc->pi;
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 303104dd19..be683a5559 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -88,7 +88,7 @@ static void multi_serial_irq_mux(void *opaque, int n, int level)
 
 static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 {
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
     Error *err = NULL;
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 798d9b69fd..d23ebe29f0 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -58,7 +58,7 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     trace_virtio_console_flush_buf(port->id, len, ret);
 
     if (ret < len) {
-        VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        const VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         /*
          * Ideally we'd get a better error code than just -1, but
@@ -106,7 +106,7 @@ static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
     VirtConsole *vcon = VIRTIO_CONSOLE(port);
     DeviceState *dev = DEVICE(port);
-    VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+    const VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
     if (!k->is_console) {
         qemu_chr_fe_set_open(&vcon->chr, guest_connected);
@@ -167,7 +167,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
-    VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
+    const VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
     Chardev *chr = qemu_chr_fe_get_driver(&vcon->chr);
 
     if (port->id == 0 && !k->is_console) {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d797a6796e..dcb4aa0055 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -80,7 +80,7 @@ static VirtIOSerialPort *find_first_connected_console(VirtIOSerial *vser)
     VirtIOSerialPort *port;
 
     QTAILQ_FOREACH(port, &vser->ports, next) {
-        VirtIOSerialPortClass const *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        const VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
         if (vsc->is_console && port->host_connected) {
             return port;
         }
@@ -157,7 +157,7 @@ static void discard_throttle_data(VirtIOSerialPort *port)
 static void do_flush_queued_data(VirtIOSerialPort *port, VirtQueue *vq,
                                  VirtIODevice *vdev)
 {
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
 
     assert(port);
     assert(virtio_queue_ready(vq));
@@ -342,7 +342,7 @@ static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
     struct VirtIOSerialPort *port;
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
     struct virtio_console_control cpkt, *gcpkt;
     uint8_t *buffer;
     size_t buffer_len;
@@ -524,7 +524,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
      */
     VirtIOSerial *vser;
     VirtIOSerialPort *port;
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
 
     vser = VIRTIO_SERIAL(vdev);
     port = find_port_by_vq(vser, vq);
@@ -579,7 +579,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
         (struct virtio_console_config *)config_data;
     uint8_t emerg_wr_lo = le32_to_cpu(config->emerg_wr);
     VirtIOSerialPort *port = find_first_connected_console(vser);
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
 
     if (!config->emerg_wr) {
         return;
@@ -597,7 +597,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
 static void guest_reset(VirtIOSerial *vser)
 {
     VirtIOSerialPort *port;
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
 
     QTAILQ_FOREACH(port, &vser->ports, next) {
         vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
@@ -702,7 +702,7 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
     VirtIOSerial *s = VIRTIO_SERIAL(opaque);
     VirtIOSerialPort *port;
     uint8_t host_connected;
-    VirtIOSerialPortClass *vsc;
+    const VirtIOSerialPortClass *vsc;
 
     if (!s->post_load) {
         return;
@@ -919,7 +919,7 @@ static void remove_port(VirtIOSerial *vser, uint32_t port_id)
 static void virtser_port_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
-    VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+    const VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
     VirtIOSerialBus *bus = VIRTIO_SERIAL_BUS(qdev_get_parent_bus(dev));
     int max_nr_ports;
     bool plugging_port0;
@@ -996,7 +996,7 @@ static void virtser_port_device_plug(HotplugHandler *hotplug_dev,
 static void virtser_port_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
-    VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
+    const VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
     VirtIOSerial *vser = port->vser;
 
     qemu_bh_delete(port->bh);
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 9233f8723b..1d913606b7 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -156,7 +156,7 @@ static bool bus_get_realized(Object *obj, Error **errp)
 static void bus_set_realized(Object *obj, bool value, Error **errp)
 {
     BusState *bus = BUS(obj);
-    BusClass *bc = BUS_GET_CLASS(bus);
+    const BusClass *bc = BUS_GET_CLASS(bus);
     BusChild *kid;
     Error *local_err = NULL;
 
diff --git a/hw/core/fw-path-provider.c b/hw/core/fw-path-provider.c
index 33b99830e7..808b4a0699 100644
--- a/hw/core/fw-path-provider.c
+++ b/hw/core/fw-path-provider.c
@@ -21,7 +21,7 @@
 char *fw_path_provider_get_dev_path(FWPathProvider *p, BusState *bus,
                                     DeviceState *dev)
 {
-    FWPathProviderClass *k = FW_PATH_PROVIDER_GET_CLASS(p);
+    const FWPathProviderClass *k = FW_PATH_PROVIDER_GET_CLASS(p);
 
     return k->get_dev_path(p, bus, dev);
 }
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 58f1f02902..84d9134c7f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -45,7 +45,7 @@ static void generic_loader_reset(void *opaque)
     GenericLoaderState *s = GENERIC_LOADER(opaque);
 
     if (s->set_pc) {
-        CPUClass *cc = CPU_GET_CLASS(s->cpu);
+        const CPUClass *cc = CPU_GET_CLASS(s->cpu);
         cpu_reset(s->cpu);
         if (cc) {
             cc->set_pc(s->cpu, s->addr);
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac986685..9ef66a9f15 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -17,7 +17,7 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->pre_plug) {
         hdc->pre_plug(plug_handler, plugged_dev, errp);
@@ -28,7 +28,7 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->plug) {
         hdc->plug(plug_handler, plugged_dev, errp);
@@ -39,7 +39,7 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug_request) {
         hdc->unplug_request(plug_handler, plugged_dev, errp);
@@ -50,7 +50,7 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug) {
         hdc->unplug(plug_handler, plugged_dev, errp);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index bf17b42cbe..3ea6ace302 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -884,7 +884,7 @@ int rom_add_file(const char *file, const char *fw_dir,
                  bool option_rom, MemoryRegion *mr,
                  AddressSpace *as)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
     int rc, fd = -1;
     char devpath[100];
@@ -989,7 +989,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                    FWCfgReadCallback fw_callback, void *callback_opaque,
                    AddressSpace *as, bool read_only)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
     MemoryRegion *mr = NULL;
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6aa452a792..d49214a095 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -342,7 +342,7 @@ static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
 static void machine_init_notify(Notifier *notifier, void *data)
 {
     Object *machine = qdev_get_machine();
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (mc->has_dynamic_sysbus) {
         /* Our machine can handle dynamic sysbus devices, we're all good */
@@ -610,7 +610,7 @@ static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
 
 void machine_register_compat_props(MachineState *machine)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
     GlobalProperty *p;
     ObjectClass *oc;
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index bfd0896daf..ee90ae9b13 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -39,7 +39,7 @@ static int do_nmi(Object *o, void *opaque)
     NMIState *n = (NMIState *) object_dynamic_cast(o, TYPE_NMI);
 
     if (n) {
-        NMIClass *nc = NMI_GET_CLASS(n);
+        const NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
         nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ab4265eb4..6d0ef1ffe4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -937,7 +937,7 @@ static Property *qdev_prop_walk(Property *props, const char *name)
 
 static Property *qdev_prop_find(DeviceState *dev, const char *name)
 {
-    ObjectClass *class;
+    const ObjectClass *class;
     Property *prop;
 
     /* device properties */
@@ -1118,7 +1118,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
 
 void qdev_prop_set_globals(DeviceState *dev)
 {
-    ObjectClass *class = object_get_class(OBJECT(dev));
+    const ObjectClass *class = object_get_class(OBJECT(dev));
 
     do {
         qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e7fb33246..87f46743d6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -45,13 +45,13 @@ static bool qdev_hot_removed = false;
 
 const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
     return dc->vmsd;
 }
 
 const char *qdev_fw_name(DeviceState *dev)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     if (dc->fw_name) {
         return dc->fw_name;
@@ -222,7 +222,7 @@ void device_listener_unregister(DeviceListener *listener)
 
 static void device_realize(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     if (dc->init) {
         int rc = dc->init(dev);
@@ -235,7 +235,7 @@ static void device_realize(DeviceState *dev, Error **errp)
 
 static void device_unrealize(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     if (dc->exit) {
         int rc = dc->exit(dev);
@@ -262,7 +262,7 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
         hotplug_ctrl = dev->parent_bus->hotplug_handler;
     } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
         MachineState *machine = MACHINE(qdev_get_machine());
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
         if (mc->get_hotplug_handler) {
             hotplug_ctrl = mc->get_hotplug_handler(machine, dev);
@@ -273,9 +273,9 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
 
     if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
@@ -314,7 +314,7 @@ static int qdev_reset_one(DeviceState *dev, void *opaque)
 
 static int qbus_reset_one(BusState *bus, void *opaque)
 {
-    BusClass *bc = BUS_GET_CLASS(bus);
+    const BusClass *bc = BUS_GET_CLASS(bus);
     if (bc->reset) {
         bc->reset(bus);
     }
@@ -656,7 +656,7 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id)
 
 static char *bus_get_fw_dev_path(BusState *bus, DeviceState *dev)
 {
-    BusClass *bc = BUS_GET_CLASS(bus);
+    const BusClass *bc = BUS_GET_CLASS(bus);
 
     if (bc->get_fw_dev_path) {
         return bc->get_fw_dev_path(dev);
@@ -721,7 +721,7 @@ char* qdev_get_fw_dev_path(DeviceState *dev)
 
 char *qdev_get_dev_path(DeviceState *dev)
 {
-    BusClass *bc;
+    const BusClass *bc;
 
     if (!dev || !dev->parent_bus) {
         return NULL;
@@ -847,12 +847,12 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
  */
 void qdev_alias_all_properties(DeviceState *target, Object *source)
 {
-    ObjectClass *class;
+    const ObjectClass *class;
     Property *prop;
 
     class = object_get_class(OBJECT(target));
     do {
-        DeviceClass *dc = DEVICE_CLASS(class);
+        const DeviceClass *dc = DEVICE_CLASS(class);
 
         for (prop = dc->props; prop && prop->name; prop++) {
             object_property_add_alias(source, prop->name,
@@ -898,7 +898,7 @@ static bool device_get_realized(Object *obj, Error **errp)
 static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    const DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     BusState *bus;
     Error *local_err = NULL;
@@ -1023,7 +1023,7 @@ fail:
 
 static bool device_get_hotpluggable(Object *obj, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+    const DeviceClass *dc = DEVICE_GET_CLASS(obj);
     DeviceState *dev = DEVICE(obj);
 
     return dc->hotpluggable && (dev->parent_bus == NULL ||
@@ -1047,7 +1047,7 @@ static void device_set_hotplugged(Object *obj, bool value, Error **err)
 static void device_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
-    ObjectClass *class;
+    const ObjectClass *class;
     Property *prop;
 
     if (qdev_hotplug) {
@@ -1163,7 +1163,7 @@ static void device_class_init(ObjectClass *class, void *data)
 
 void device_reset(DeviceState *dev)
 {
-    DeviceClass *klass = DEVICE_GET_CLASS(dev);
+    const DeviceClass *klass = DEVICE_GET_CLASS(dev);
 
     if (klass->reset) {
         klass->reset(dev);
diff --git a/hw/core/stream.c b/hw/core/stream.c
index 4439ecdf0b..e2e32da3d2 100644
--- a/hw/core/stream.c
+++ b/hw/core/stream.c
@@ -4,7 +4,7 @@
 size_t
 stream_push(StreamSlave *sink, uint8_t *buf, size_t len)
 {
-    StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
+    const StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
 
     return k->push(sink, buf, len);
 }
@@ -13,7 +13,7 @@ bool
 stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
                 void *notify_opaque)
 {
-    StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
+    const StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
 
     return k->can_push ? k->can_push(sink, notify, notify_opaque) : true;
 }
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index c0f560b289..05a6e43b6a 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -110,7 +110,7 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n)
 
 void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq)
 {
-    SysBusDeviceClass *sbd = SYS_BUS_DEVICE_GET_CLASS(dev);
+    const SysBusDeviceClass *sbd = SYS_BUS_DEVICE_GET_CLASS(dev);
 
     qdev_connect_gpio_out_named(DEVICE(dev), SYSBUS_DEVICE_GPIO_IRQ, n, irq);
 
@@ -203,7 +203,7 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
 static int sysbus_device_init(DeviceState *dev)
 {
     SysBusDevice *sd = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
+    const SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
 
     if (!sbc->init) {
         return 0;
@@ -288,7 +288,7 @@ static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 static char *sysbus_get_fw_dev_path(DeviceState *dev)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(s);
+    const SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(s);
     /* for the explicit unit address fallback case: */
     char *addr, *fw_dev_path;
 
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index afc290ab91..1897898fee 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3096,7 +3096,7 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
 {
      PCICirrusVGAState *d = PCI_CIRRUS_VGA(dev);
      CirrusVGAState *s = &d->cirrus_vga;
-     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+     const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
      int16_t device_id = pc->device_id;
 
      /* follow real hardware, cirrus card emulated has 4 MB video memory.
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 2c1234cdff..7ec283c5ff 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -105,7 +105,7 @@ int i2c_bus_busy(I2CBus *bus)
 int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
 {
     BusChild *kid;
-    I2CSlaveClass *sc;
+    const I2CSlaveClass *sc;
     I2CNode *node;
     bool bus_scanned = false;
 
@@ -168,7 +168,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
 
 void i2c_end_transfer(I2CBus *bus)
 {
-    I2CSlaveClass *sc;
+    const I2CSlaveClass *sc;
     I2CNode *node, *next;
 
     QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
@@ -184,7 +184,7 @@ void i2c_end_transfer(I2CBus *bus)
 
 int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
 {
-    I2CSlaveClass *sc;
+    const I2CSlaveClass *sc;
     I2CNode *node;
     int ret = 0;
 
@@ -232,7 +232,7 @@ int i2c_recv(I2CBus *bus)
 
 void i2c_nack(I2CBus *bus)
 {
-    I2CSlaveClass *sc;
+    const I2CSlaveClass *sc;
     I2CNode *node;
 
     if (QLIST_EMPTY(&bus->current_devs)) {
@@ -277,7 +277,7 @@ const VMStateDescription vmstate_i2c_slave = {
 static int i2c_slave_qdev_init(DeviceState *dev)
 {
     I2CSlave *s = I2C_SLAVE(dev);
-    I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
+    const I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
 
     if (sc->init) {
         return sc->init(s);
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a689..42a01ca7b7 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -38,7 +38,7 @@ enum {
 
 static void smbus_do_quick_cmd(SMBusDevice *dev, int recv)
 {
-    SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+    const SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
     DPRINTF("Quick Command %d\n", recv);
     if (sc->quick_cmd) {
@@ -48,7 +48,7 @@ static void smbus_do_quick_cmd(SMBusDevice *dev, int recv)
 
 static void smbus_do_write(SMBusDevice *dev)
 {
-    SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+    const SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
     if (dev->data_len == 0) {
         smbus_do_quick_cmd(dev, 0);
@@ -155,7 +155,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
 static int smbus_i2c_recv(I2CSlave *s)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
-    SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+    const SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
     int ret;
 
     switch (dev->mode) {
@@ -205,7 +205,7 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
 static int smbus_device_init(I2CSlave *i2c)
 {
     SMBusDevice *dev = SMBUS_DEVICE(i2c);
-    SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
+    const SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
     return sc->init(dev);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108577..47dba40ebd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -373,10 +373,10 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    const MachineClass *mc = MACHINE_GET_CLASS(pcms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
+    const AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
     AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
     bool x2apic_mode = false;
 
@@ -507,8 +507,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     }
 
     for (i = 0; i < ARRAY_SIZE(bus->devices); i += PCI_FUNC_MAX) {
-        DeviceClass *dc;
-        PCIDeviceClass *pc;
+        const DeviceClass *dc;
+        const PCIDeviceClass *pc;
         PCIDevice *pdev = bus->devices[i];
         int slot = PCI_SLOT(i);
         bool hotplug_enabled_dev;
@@ -1854,7 +1854,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
     PCIBus *bus = NULL;
@@ -2293,7 +2293,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int i;
     int srat_start, numa_start, slots;
     uint64_t mem_len, mem_base, next_base;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =
@@ -2600,7 +2600,7 @@ static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     GArray *table_offsets;
     unsigned facs, dsdt, rsdt, fadt;
     AcpiPmInfo pm;
@@ -2829,7 +2829,7 @@ static const VMStateDescription vmstate_acpi_build = {
 void acpi_setup(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 521a58498a..6d5f079e26 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -255,7 +255,7 @@ static void kvm_pit_vm_state_change(void *opaque, int running,
 static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 {
     PITCommonState *pit = PIT_COMMON(dev);
-    KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
+    const KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
     KVMPITState *s = KVM_PIT(pit);
     struct kvm_pit_config config = {
         .flags = 0,
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 11d1b726b6..ee1058ef9e 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -118,7 +118,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     PICCommonState *s = PIC_COMMON(dev);
-    KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
+    const KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_reservation(&s->base_io, NULL, "kvm-pic", 2);
     memory_region_init_reservation(&s->elcr_io, NULL, "kvm-elcr", 1);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e05f..a376fd6f0a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -841,7 +841,7 @@ static void load_linux(PCMachineState *pcms,
     FILE *f;
     char *vmode;
     MachineState *machine = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     struct setup_data *setup_data;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -1111,7 +1111,7 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
-    ObjectClass *oc;
+    const ObjectClass *oc;
     MachineState *ms = MACHINE(qdev_get_machine());
     int64_t apic_id = x86_cpu_apic_id_from_index(id);
     Error *local_err = NULL;
@@ -1146,7 +1146,7 @@ void pc_cpus_init(PCMachineState *pcms)
     gchar **model_pieces;
     const CPUArchIdList *possible_cpus;
     MachineState *machine = MACHINE(pcms);
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    const MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
     /* init CPUs */
     if (machine->cpu_model == NULL) {
@@ -1362,7 +1362,7 @@ void pc_memory_init(PCMachineState *pcms,
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
     assert(machine->ram_size == pcms->below_4g_mem_size +
                                 pcms->above_4g_mem_size);
@@ -1395,7 +1395,7 @@ void pc_memory_init(PCMachineState *pcms,
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
         error_report("\"-memory 'slots|maxmem'\" is not supported by: %s",
                      mc->name);
@@ -1460,7 +1460,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
         uint64_t *val = g_malloc(sizeof(*val));
-        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+        const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = pcms->hotplug_memory.base;
 
         if (!pcmc->broken_reserved_end) {
@@ -1688,12 +1688,12 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 static void pc_dimm_plug(HotplugHandler *hotplug_dev,
                          DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t align = TARGET_PAGE_SIZE;
 
@@ -1730,7 +1730,7 @@ out:
 static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
@@ -1758,9 +1758,9 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
 
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
@@ -1807,7 +1807,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -1838,7 +1838,7 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     int idx = -1;
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -1866,7 +1866,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
-    HotplugHandlerClass *hhc;
+    const HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -2033,7 +2033,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa388..ead6e75503 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -66,7 +66,7 @@ static void pc_init1(MachineState *machine,
                      const char *host_type, const char *pci_type)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     int i;
@@ -164,7 +164,7 @@ static void pc_init1(MachineState *machine,
     pc_guest_info_init(pcms);
 
     if (pcmc->smbios_defaults) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
                             mc->name, pcmc->smbios_legacy_mode,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8547..9d21572ab9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -55,7 +55,7 @@
 static void pc_q35_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     Q35PCIHost *q35_host;
     PCIHostState *phb;
     PCIBus *host_bus;
@@ -75,7 +75,7 @@ static void pc_q35_init(MachineState *machine)
     PCIDevice *ahci;
     ram_addr_t lowmem;
     DriveInfo *hd[MAX_SATA_PORTS];
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     /* Check whether RAM fits below 4G (leaving 1/2 GByte for IO memory
      * and 256 Mbytes for PCI Express Enhanced Configuration Access Mapping
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 23dcd3f039..4be7ee0609 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -79,7 +79,7 @@ IommuType x86_iommu_get_type(void)
 static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
-    X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
+    const X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
     QLIST_INIT(&x86_iommu->iec_notifiers);
     if (x86_class->realize) {
         x86_class->realize(dev, errp);
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index e3fd30e457..3103d15243 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -129,7 +129,7 @@ static void md_reset(DeviceState *dev)
 static uint8_t md_attr_read(PCMCIACardState *card, uint32_t at)
 {
     MicroDriveState *s = MICRODRIVE(card);
-    PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
+    const PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
 
     if (at < s->attr_base) {
         if (at < pcc->cis_len) {
@@ -536,7 +536,7 @@ static const uint8_t dscm1xxxx_cis[0x14a] = {
 static int dscm1xxxx_attach(PCMCIACardState *card)
 {
     MicroDriveState *md = MICRODRIVE(card);
-    PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
+    const PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
 
     md->attr_base = pcc->cis[0x74] | (pcc->cis[0x76] << 8);
     md->io_base = 0x0;
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 299e592fa2..28700d1a03 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -83,7 +83,7 @@ static char *idebus_get_fw_dev_path(DeviceState *dev)
 static int ide_qdev_init(DeviceState *qdev)
 {
     IDEDevice *dev = IDE_DEVICE(qdev);
-    IDEDeviceClass *dc = IDE_DEVICE_GET_CLASS(dev);
+    const IDEDeviceClass *dc = IDE_DEVICE_GET_CLASS(dev);
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, qdev->parent_bus);
 
     if (dev->unit == -1) {
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 43d3205472..51b510db73 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -87,7 +87,7 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
     for(i = 0; i < s->nb_devices; i++) {
         d = s->devices[i];
         if (d->devaddr == devaddr) {
-            ADBDeviceClass *adc = ADB_DEVICE_GET_CLASS(d);
+            const ADBDeviceClass *adc = ADB_DEVICE_GET_CLASS(d);
             return adc->devreq(d, obuf, buf, len);
         }
     }
@@ -491,7 +491,7 @@ static QemuInputHandler adb_keyboard_handler = {
 
 static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
 {
-    ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
+    const ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
     akc->parent_realize(dev, errp);
     qemu_input_handler_register(dev, &adb_keyboard_handler);
 }
@@ -707,7 +707,7 @@ static const VMStateDescription vmstate_adb_mouse = {
 static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
 {
     MouseState *s = ADB_MOUSE(dev);
-    ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
+    const ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
 
     amc->parent_realize(dev, errp);
 
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..9757a4cdeb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -75,7 +75,7 @@ static void virtio_input_handle_evt(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_input_handle_sts(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
     VirtIOInput *vinput = VIRTIO_INPUT(vdev);
     virtio_input_event event;
     VirtQueueElement *elem;
@@ -190,7 +190,7 @@ static uint64_t virtio_input_get_features(VirtIODevice *vdev, uint64_t f,
 
 static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
     VirtIOInput *vinput = VIRTIO_INPUT(vdev);
 
     if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
@@ -205,7 +205,7 @@ static void virtio_input_set_status(VirtIODevice *vdev, uint8_t val)
 
 static void virtio_input_reset(VirtIODevice *vdev)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vdev);
     VirtIOInput *vinput = VIRTIO_INPUT(vdev);
 
     if (vinput->active) {
@@ -219,7 +219,7 @@ static void virtio_input_reset(VirtIODevice *vdev)
 static int virtio_input_post_load(void *opaque, int version_id)
 {
     VirtIOInput *vinput = opaque;
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vinput);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(vinput);
     VirtIODevice *vdev = VIRTIO_DEVICE(vinput);
 
     vinput->active = vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
@@ -231,7 +231,7 @@ static int virtio_input_post_load(void *opaque, int version_id)
 
 static void virtio_input_device_realize(DeviceState *dev, Error **errp)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     VirtIOInputConfig *cfg;
@@ -276,7 +276,7 @@ static void virtio_input_finalize(Object *obj)
 }
 static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
+    const VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     Error *local_err = NULL;
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index c3829e31b5..a6748879d5 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -40,7 +40,7 @@ void cpu_set_apic_base(DeviceState *dev, uint64_t val)
 
     if (dev) {
         APICCommonState *s = APIC_COMMON(dev);
-        APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+        const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
         /* switching to x2APIC, reset possibly modified xAPIC ID */
         if (!(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
             (val & MSR_IA32_APICBASE_EXTD)) {
@@ -65,7 +65,7 @@ uint64_t cpu_get_apic_base(DeviceState *dev)
 void cpu_set_apic_tpr(DeviceState *dev, uint8_t val)
 {
     APICCommonState *s;
-    APICCommonClass *info;
+    const APICCommonClass *info;
 
     if (!dev) {
         return;
@@ -80,7 +80,7 @@ void cpu_set_apic_tpr(DeviceState *dev, uint8_t val)
 uint8_t cpu_get_apic_tpr(DeviceState *dev)
 {
     APICCommonState *s;
-    APICCommonClass *info;
+    const APICCommonClass *info;
 
     if (!dev) {
         return 0;
@@ -95,7 +95,7 @@ uint8_t cpu_get_apic_tpr(DeviceState *dev)
 void apic_enable_tpr_access_reporting(DeviceState *dev, bool enable)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     apic_report_tpr_access = enable;
     if (info->enable_tpr_reporting) {
@@ -106,7 +106,7 @@ void apic_enable_tpr_access_reporting(DeviceState *dev, bool enable)
 void apic_enable_vapic(DeviceState *dev, hwaddr paddr)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     s->vapic_paddr = paddr;
     info->vapic_base_update(s);
@@ -149,7 +149,7 @@ int apic_get_irq_delivered(void)
 void apic_deliver_nmi(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     info->external_nmi(s);
 }
@@ -190,7 +190,7 @@ bool apic_next_timer(APICCommonState *s, int64_t current_time)
 void apic_init_reset(DeviceState *dev)
 {
     APICCommonState *s;
-    APICCommonClass *info;
+    const APICCommonClass *info;
     int i;
 
     if (!dev) {
@@ -244,7 +244,7 @@ void apic_designate_bsp(DeviceState *dev, bool bsp)
 static void apic_reset_common(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
     uint32_t bsp;
 
     bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
@@ -263,7 +263,7 @@ static void apic_reset_common(DeviceState *dev)
 static int apic_load_old(QEMUFile *f, void *opaque, int version_id)
 {
     APICCommonState *s = opaque;
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
     int i;
 
     if (version_id > 2) {
@@ -310,7 +310,7 @@ static const VMStateDescription vmstate_apic_common;
 static void apic_common_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info;
+    const APICCommonClass *info;
     static DeviceState *vapic;
     int instance_id = s->id;
 
@@ -337,7 +337,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
 static void apic_common_unrealize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     vmstate_unregister(NULL, &vmstate_apic_common, s);
     info->unrealize(dev, errp);
@@ -363,7 +363,7 @@ static int apic_pre_load(void *opaque)
 static void apic_dispatch_pre_save(void *opaque)
 {
     APICCommonState *s = APIC_COMMON(opaque);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -373,7 +373,7 @@ static void apic_dispatch_pre_save(void *opaque)
 static int apic_dispatch_post_load(void *opaque, int version_id)
 {
     APICCommonState *s = APIC_COMMON(opaque);
-    APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
+    const APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b305d9032a..82a6c872bf 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1403,7 +1403,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     int i;
     GICState *s = ARM_GIC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    ARMGICClass *agc = ARM_GIC_GET_CLASS(s);
+    const ARMGICClass *agc = ARM_GIC_GET_CLASS(s);
     Error *local_err = NULL;
 
     agc->parent_realize(dev, &local_err);
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 70f1134823..eab755209a 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -26,7 +26,7 @@
 static void gic_pre_save(void *opaque)
 {
     GICState *s = (GICState *)opaque;
-    ARMGICCommonClass *c = ARM_GIC_COMMON_GET_CLASS(s);
+    const ARMGICCommonClass *c = ARM_GIC_COMMON_GET_CLASS(s);
 
     if (c->pre_save) {
         c->pre_save(s);
@@ -36,7 +36,7 @@ static void gic_pre_save(void *opaque)
 static int gic_post_load(void *opaque, int version_id)
 {
     GICState *s = (GICState *)opaque;
-    ARMGICCommonClass *c = ARM_GIC_COMMON_GET_CLASS(s);
+    const ARMGICCommonClass *c = ARM_GIC_COMMON_GET_CLASS(s);
 
     if (c->post_load) {
         c->post_load(s);
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index ec952ece93..522573b9eb 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -481,7 +481,7 @@ static void kvm_arm_gic_get(GICState *s)
 static void kvm_arm_gic_reset(DeviceState *dev)
 {
     GICState *s = ARM_GIC_COMMON(dev);
-    KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
+    const KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
 
     kgc->parent_reset(dev);
 
@@ -494,7 +494,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
 {
     int i;
     GICState *s = KVM_ARM_GIC(dev);
-    KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
+    const KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
     Error *local_err = NULL;
     int ret;
 
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index f0c967b304..dc7eaae45b 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -364,7 +364,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
     GICv3State *s = ARM_GICV3(dev);
-    ARMGICv3Class *agc = ARM_GICV3_GET_CLASS(s);
+    const ARMGICv3Class *agc = ARM_GICV3_GET_CLASS(s);
     Error *local_err = NULL;
 
     agc->parent_realize(dev, &local_err);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index c6493d6c07..bb86b35cd7 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -31,7 +31,7 @@
 static void gicv3_pre_save(void *opaque)
 {
     GICv3State *s = (GICv3State *)opaque;
-    ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
+    const ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
 
     if (c->pre_save) {
         c->pre_save(s);
@@ -41,7 +41,7 @@ static void gicv3_pre_save(void *opaque)
 static int gicv3_post_load(void *opaque, int version_id)
 {
     GICv3State *s = (GICv3State *)opaque;
-    ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
+    const ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
 
     if (c->post_load) {
         c->post_load(s);
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 9d67c5c1ee..4e8870736c 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -26,7 +26,7 @@
 static void gicv3_its_pre_save(void *opaque)
 {
     GICv3ITSState *s = (GICv3ITSState *)opaque;
-    GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+    const GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
 
     if (c->pre_save) {
         c->pre_save(s);
@@ -36,7 +36,7 @@ static void gicv3_its_pre_save(void *opaque)
 static int gicv3_its_post_load(void *opaque, int version_id)
 {
     GICv3ITSState *s = (GICv3ITSState *)opaque;
-    GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+    const GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
 
     if (c->post_load) {
         c->post_load(s);
@@ -65,7 +65,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
 {
     if (offset == 0x0040 && ((size == 2) || (size == 4))) {
         GICv3ITSState *s = ARM_GICV3_ITS_COMMON(opaque);
-        GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+        const GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
         int ret = c->send_msi(s, le64_to_cpu(value), attrs.requester_id);
 
         if (ret <= 0) {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 81f0403117..f3fe3916b4 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -633,7 +633,7 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 static void kvm_arm_gicv3_reset(DeviceState *dev)
 {
     GICv3State *s = ARM_GICV3_COMMON(dev);
-    KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
+    const KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
 
     DPRINTF("Reset\n");
 
@@ -678,7 +678,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
-    KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
+    const KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
     Error *local_err = NULL;
     int i;
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe9ecd6bd4..f0ed3fc75d 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -448,7 +448,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 static void pic_realize(DeviceState *dev, Error **errp)
 {
     PICCommonState *s = PIC_COMMON(dev);
-    PICClass *pc = PIC_GET_CLASS(dev);
+    const PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
                           "pic", 2);
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index d9a5e8b217..8b3ab19aef 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -49,7 +49,7 @@ void pic_reset_common(PICCommonState *s)
 static void pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    const PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -59,7 +59,7 @@ static void pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    const PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 97c4f9c2df..ab2f981aa6 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -105,7 +105,7 @@ void ioapic_reset_common(DeviceState *dev)
 static void ioapic_dispatch_pre_save(void *opaque)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(opaque);
-    IOAPICCommonClass *info = IOAPIC_COMMON_GET_CLASS(s);
+    const IOAPICCommonClass *info = IOAPIC_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -115,7 +115,7 @@ static void ioapic_dispatch_pre_save(void *opaque)
 static int ioapic_dispatch_post_load(void *opaque, int version_id)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(opaque);
-    IOAPICCommonClass *info = IOAPIC_COMMON_GET_CLASS(s);
+    const IOAPICCommonClass *info = IOAPIC_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -126,7 +126,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
 static void ioapic_common_realize(DeviceState *dev, Error **errp)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
-    IOAPICCommonClass *info;
+    const IOAPICCommonClass *info;
 
     if (ioapic_no >= MAX_IOAPICS) {
         error_setg(errp, "Only %d ioapics allowed", MAX_IOAPICS);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e740989a11..85f3b3ebd0 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -66,7 +66,7 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     ICPState *icp = xics_icp_get(xi, cs->cpu_index);
-    ICPStateClass *icpc;
+    const ICPStateClass *icpc;
 
     assert(icp);
 
@@ -142,7 +142,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
 
 static void ics_reject(ICSState *ics, uint32_t nr)
 {
-    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
+    const ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
 
     if (k->reject) {
         k->reject(ics, nr);
@@ -151,7 +151,7 @@ static void ics_reject(ICSState *ics, uint32_t nr)
 
 void ics_resend(ICSState *ics)
 {
-    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
+    const ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
 
     if (k->resend) {
         k->resend(ics);
@@ -160,7 +160,7 @@ void ics_resend(ICSState *ics)
 
 static void ics_eoi(ICSState *ics, int nr)
 {
-    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
+    const ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
 
     if (k->eoi) {
         k->eoi(ics, nr);
@@ -188,7 +188,7 @@ static void icp_check_ipi(ICPState *icp)
 void icp_resend(ICPState *icp)
 {
     XICSFabric *xi = icp->xics;
-    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
+    const XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
 
     if (icp->mfrr < CPPR(icp)) {
         icp_check_ipi(icp);
@@ -256,7 +256,7 @@ uint32_t icp_ipoll(ICPState *icp, uint32_t *mfrr)
 void icp_eoi(ICPState *icp, uint32_t xirr)
 {
     XICSFabric *xi = icp->xics;
-    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
+    const XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
     ICSState *ics;
     uint32_t irq;
 
@@ -299,7 +299,7 @@ static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 static void icp_dispatch_pre_save(void *opaque)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
+    const ICPStateClass *info = ICP_GET_CLASS(icp);
 
     if (info->pre_save) {
         info->pre_save(icp);
@@ -309,7 +309,7 @@ static void icp_dispatch_pre_save(void *opaque)
 static int icp_dispatch_post_load(void *opaque, int version_id)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
+    const ICPStateClass *info = ICP_GET_CLASS(icp);
 
     if (info->post_load) {
         return info->post_load(icp, version_id);
@@ -545,7 +545,7 @@ static void ics_simple_reset(void *dev)
 static void ics_simple_dispatch_pre_save(void *opaque)
 {
     ICSState *ics = opaque;
-    ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
+    const ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
 
     if (info->pre_save) {
         info->pre_save(ics);
@@ -555,7 +555,7 @@ static void ics_simple_dispatch_pre_save(void *opaque)
 static int ics_simple_dispatch_post_load(void *opaque, int version_id)
 {
     ICSState *ics = opaque;
-    ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
+    const ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
 
     if (info->post_load) {
         return info->post_load(ics, version_id);
@@ -645,7 +645,7 @@ static const TypeInfo ics_simple_info = {
 
 static void ics_base_realize(DeviceState *dev, Error **errp)
 {
-    ICSStateClass *icsc = ICS_BASE_GET_CLASS(dev);
+    const ICSStateClass *icsc = ICS_BASE_GET_CLASS(dev);
     ICSState *ics = ICS_BASE(dev);
     Object *obj;
     Error *err = NULL;
@@ -691,7 +691,7 @@ static const TypeInfo xics_fabric_info = {
  */
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
 {
-    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
+    const XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
     ICSState *ics = xic->ics_get(xi, irq);
 
     if (ics) {
@@ -703,7 +703,7 @@ qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
 
 ICPState *xics_icp_get(XICSFabric *xi, int server)
 {
-    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
+    const XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(xi);
 
     return xic->icp_get(xi, server);
 }
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 6021e6d135..3b944b75cf 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -40,7 +40,7 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
 {
     IPackDevice *idev = IPACK_DEVICE(dev);
     IPackBus *bus = IPACK_BUS(qdev_get_parent_bus(dev));
-    IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
+    const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
 
     if (idev->slot < 0) {
         idev->slot = bus->free_slot;
@@ -59,7 +59,7 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
 static void ipack_device_unrealize(DeviceState *dev, Error **errp)
 {
     IPackDevice *idev = IPACK_DEVICE(dev);
-    IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
+    const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
     Error *err = NULL;
 
     if (k->unrealize) {
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 4dfa6b33f3..162753d512 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -321,7 +321,7 @@ static uint64_t tpci200_read_las1(void *opaque, hwaddr addr, unsigned size)
     if (ip == NULL) {
         DPRINTF("Read LAS1: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         switch (space) {
 
         case IP_ID_SPACE:
@@ -383,7 +383,7 @@ static void tpci200_write_las1(void *opaque, hwaddr addr, uint64_t val,
     if (ip == NULL) {
         DPRINTF("Write LAS1: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         switch (space) {
 
         case IP_ID_SPACE:
@@ -431,7 +431,7 @@ static uint64_t tpci200_read_las2(void *opaque, hwaddr addr, unsigned size)
     if (ip == NULL) {
         DPRINTF("Read LAS2: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         if (k->mem_read16) {
             ret = k->mem_read16(ip, offset);
         }
@@ -462,7 +462,7 @@ static void tpci200_write_las2(void *opaque, hwaddr addr, uint64_t val,
     if (ip == NULL) {
         DPRINTF("Write LAS2: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         if (k->mem_write16) {
             k->mem_write16(ip, offset, val);
         }
@@ -486,7 +486,7 @@ static uint64_t tpci200_read_las3(void *opaque, hwaddr addr, unsigned size)
     if (ip == NULL) {
         DPRINTF("Read LAS3: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         if (k->mem_read8) {
             ret = k->mem_read8(ip, offset);
         }
@@ -512,7 +512,7 @@ static void tpci200_write_las3(void *opaque, hwaddr addr, uint64_t val,
     if (ip == NULL) {
         DPRINTF("Write LAS3: IP module %u not installed\n", ip_n);
     } else {
-        IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
+        const IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(ip);
         if (k->mem_write8) {
             k->mem_write8(ip, offset, val);
         }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e8e3d250b6..2ea02f0478 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -152,7 +152,7 @@ static void extern_timeout(void *opaque)
 
     if (ibe->connected) {
         if (ibe->waiting_rsp && (ibe->outlen == 0)) {
-            IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+            const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
             /* The message response timed out, return an error. */
             ibe->waiting_rsp = false;
             ibe->inbuf[1] = ibe->outbuf[1] | 0x04;
@@ -208,7 +208,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         err = IPMI_CC_BMC_INIT_IN_PROGRESS;
     }
     if (err) {
-        IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+        const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
         unsigned char rsp[3];
         rsp[0] = cmd[0] | 0x04;
         rsp[1] = cmd[1];
@@ -238,7 +238,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
 static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
 {
     IPMIInterface *s = ibe->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     switch (hw_op) {
     case VM_CMD_VERSION:
@@ -285,7 +285,7 @@ static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
 
 static void handle_msg(IPMIBmcExtern *ibe)
 {
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(ibe->parent.intf);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(ibe->parent.intf);
 
     if (ibe->in_escape) {
         ipmi_debug("msg escape not ended\n");
@@ -385,7 +385,7 @@ static void chr_event(void *opaque, int event)
 {
     IPMIBmcExtern *ibe = opaque;
     IPMIInterface *s = ibe->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     unsigned char v;
 
     switch (event) {
@@ -466,7 +466,7 @@ static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
      */
     if (ibe->waiting_rsp) {
         IPMIInterface *ii = ibe->parent.intf;
-        IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+        const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
         ibe->waiting_rsp = false;
         ibe->inbuf[1] = ibe->outbuf[1] | 0x04;
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index c7883d6f5e..819bfad4ee 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -448,7 +448,7 @@ static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
                       uint8_t evd1, uint8_t evd2, uint8_t evd3)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     uint8_t evt[16];
     IPMISensor *sens = ibs->sensors + sens_num;
 
@@ -617,7 +617,7 @@ static void ipmi_sim_handle_command(IPMIBmc *b,
 {
     IPMIBmcSim *ibs = IPMI_BMC_SIMULATOR(b);
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     const IPMICmdHandler *hdl;
     RspBuffer rsp = RSP_BUFFER_INITIALIZER;
 
@@ -670,7 +670,7 @@ static void ipmi_sim_handle_command(IPMIBmc *b,
 static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     if (!ibs->watchdog_running) {
         goto out;
@@ -761,7 +761,7 @@ static void chassis_control(IPMIBmcSim *ibs,
                             RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     switch (cmd[2] & 0xf) {
     case 0: /* power down */
@@ -818,7 +818,7 @@ static void get_device_id(IPMIBmcSim *ibs,
 static void set_global_enables(IPMIBmcSim *ibs, uint8_t val)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     bool irqs_on;
 
     ibs->bmc_global_enables = val;
@@ -834,7 +834,7 @@ static void cold_reset(IPMIBmcSim *ibs,
                        RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     /* Disable all interrupts */
     set_global_enables(ibs, 1 << IPMI_BMC_EVENT_LOG_BIT);
@@ -849,7 +849,7 @@ static void warm_reset(IPMIBmcSim *ibs,
                        RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     if (k->reset) {
         k->reset(s, false);
@@ -901,7 +901,7 @@ static void clr_msg_flags(IPMIBmcSim *ibs,
                           RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
     ibs->msg_flags &= ~cmd[2];
     k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
@@ -919,7 +919,7 @@ static void read_evt_msg_buf(IPMIBmcSim *ibs,
                              RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     unsigned int i;
 
     if (!(ibs->msg_flags & IPMI_BMC_MSG_FLAG_EVT_BUF_FULL)) {
@@ -951,7 +951,7 @@ static void get_msg(IPMIBmcSim *ibs,
 
     if (QTAILQ_EMPTY(&ibs->rcvbufs)) {
         IPMIInterface *s = ibs->parent.intf;
-        IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+        const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
 
         ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE;
         k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
@@ -976,7 +976,7 @@ static void send_msg(IPMIBmcSim *ibs,
                      RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     IPMIRcvBufEntry *msg;
     uint8_t *buf;
     uint8_t netfn, rqLun, rsLun, rqSeq;
@@ -1092,7 +1092,7 @@ static void set_watchdog_timer(IPMIBmcSim *ibs,
                                RspBuffer *rsp)
 {
     IPMIInterface *s = ibs->parent.intf;
-    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    const IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
     unsigned int val;
 
     val = cmd[2] & 0x7; /* Validate use */
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 1c69cb33f8..3a60369d6b 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -125,7 +125,7 @@ typedef struct IPMIBT {
 
 static void ipmi_bt_handle_event(IPMIInterface *ii)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (ib->inlen < 4) {
@@ -173,7 +173,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
     ib->waiting_seq = ib->inmsg[2];
     ib->inmsg[2] = ib->inmsg[1];
     {
-        IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ib->bmc);
+        const IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ib->bmc);
         bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
                            sizeof(ib->inmsg), ib->waiting_rsp);
     }
@@ -184,7 +184,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
 static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
                                 unsigned char *rsp, unsigned int rsp_len)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (ib->waiting_rsp == msg_id) {
@@ -218,7 +218,7 @@ static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
 static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
 {
     IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
     uint32_t ret = 0xff;
 
@@ -247,7 +247,7 @@ static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
 
 static void ipmi_bt_signal(IPMIBT *ib, IPMIInterface *ii)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
     ib->do_wake = 1;
     while (ib->do_wake) {
@@ -260,7 +260,7 @@ static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned size)
 {
     IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     switch (addr & 3) {
@@ -333,7 +333,7 @@ static const MemoryRegionOps ipmi_bt_io_ops = {
 
 static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (!!val == IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
@@ -359,7 +359,7 @@ static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
 
 static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (is_cold) {
@@ -374,7 +374,7 @@ static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
 
 static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     ib->irqs_enabled = val;
@@ -382,7 +382,7 @@ static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
 
 static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
     ib->io_length = 3;
@@ -436,7 +436,7 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     ISADevice *isadev = ISA_DEVICE(dev);
     ISAIPMIBTDevice *iib = ISA_IPMI_BT(dev);
     IPMIInterface *ii = IPMI_INTERFACE(dev);
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
     if (!iib->bt.bmc) {
         error_setg(errp, "IPMI device requires a bmc attribute to be set");
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 80444977a0..b036acc697 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -118,7 +118,7 @@ typedef struct IPMIKCS {
 
 static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
     ik->do_wake = 1;
     while (ik->do_wake) {
@@ -129,7 +129,7 @@ static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
 
 static void ipmi_kcs_handle_event(IPMIInterface *ii)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     if (ik->cmd_reg == IPMI_KCS_ABORT_STATUS_CMD) {
@@ -186,7 +186,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
             ik->inlen++;
         }
         if (ik->write_end) {
-            IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
+            const IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
             ik->outlen = 0;
             ik->write_end = 0;
             ik->outpos = 0;
@@ -228,7 +228,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
 static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
                                 unsigned char *rsp, unsigned int rsp_len)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     if (ik->waiting_rsp == msg_id) {
@@ -252,7 +252,7 @@ static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
 static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
 {
     IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
     uint32_t ret;
 
@@ -284,7 +284,7 @@ static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
                                   unsigned size)
 {
     IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     if (IPMI_KCS_GET_IBF(ik->status_reg)) {
@@ -316,7 +316,7 @@ const MemoryRegionOps ipmi_kcs_io_ops = {
 
 static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
@@ -339,7 +339,7 @@ static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
 
 static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     ik->irqs_enabled = val;
@@ -347,7 +347,7 @@ static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
 
 static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
 {
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
     ik->io_length = 2;
@@ -398,7 +398,7 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     ISADevice *isadev = ISA_DEVICE(dev);
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(dev);
     IPMIInterface *ii = IPMI_INTERFACE(dev);
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    const IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
     if (!iik->kcs.bmc) {
         error_setg(errp, "IPMI device requires a bmc attribute to be set");
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0e89..259454a3bc 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -40,7 +40,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     int slot;
     MachineState *machine = MACHINE(qdev_get_machine());
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
     uint64_t existing_dimms_capacity = 0;
@@ -118,7 +118,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
                            MemoryRegion *mr)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
 
     numa_unset_mem_node_id(dimm->addr, memory_region_size(mr), dimm->node);
@@ -169,7 +169,7 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
             MemoryDeviceInfoList *elem = g_new0(MemoryDeviceInfoList, 1);
             MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
             PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
-            DeviceClass *dc = DEVICE_GET_CLASS(obj);
+            const DeviceClass *dc = DEVICE_GET_CLASS(obj);
             PCDIMMDevice *dimm = PC_DIMM(obj);
 
             if (dev->id) {
@@ -358,7 +358,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     int64_t value;
     MemoryRegion *mr;
     PCDIMMDevice *dimm = PC_DIMM(obj);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
 
     mr = ddc->get_memory_region(dimm);
     value = memory_region_size(mr);
@@ -398,7 +398,7 @@ static void pc_dimm_init(Object *obj)
 static void pc_dimm_realize(DeviceState *dev, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
 
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
diff --git a/hw/misc/imx_ccm.c b/hw/misc/imx_ccm.c
index 7f239a41d8..8343526a84 100644
--- a/hw/misc/imx_ccm.c
+++ b/hw/misc/imx_ccm.c
@@ -31,7 +31,7 @@
 uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
-    IMXCCMClass *klass = IMX_GET_CLASS(dev);
+    const IMXCCMClass *klass = IMX_GET_CLASS(dev);
 
     if (klass->get_clock_frequency) {
         freq = klass->get_clock_frequency(dev, clock);
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 93249497f4..9c501706b6 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -353,7 +353,7 @@ e1000_autoneg_timer(void *opaque)
 static void e1000_reset(void *opaque)
 {
     E1000State *d = opaque;
-    E1000BaseClass *edc = E1000_DEVICE_GET_CLASS(d);
+    const E1000BaseClass *edc = E1000_DEVICE_GET_CLASS(d);
     uint8_t *macaddr = d->conf.macaddr.a;
 
     timer_del(d->autoneg_timer);
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 22874a9777..e63b2d0108 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -294,7 +294,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
     int r, e, i;
 
     if (!k->set_guest_notifiers) {
@@ -360,7 +360,7 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
     int i, r;
 
     for (i = 0; i < total_queues; i++) {
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8b1fab24fd..c3050c2819 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2604,7 +2604,7 @@ static Property vmxnet3_properties[] = {
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
 {
-    VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
+    const VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     VMXNET3State *s = VMXNET3(qdev);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9bc1..c1135b748a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -792,7 +792,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
 {
     int i, index, count;
     size_t dsize;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     int order = 0;
 
     if (!s->files) {
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index cf3631806f..d558610494 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -18,7 +18,7 @@
 
 static void rp_aer_vector_update(PCIDevice *d)
 {
-    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    const PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
 
     if (rpc->aer_vector) {
         pcie_aer_root_set_vector(d, rpc->aer_vector(d));
@@ -56,8 +56,8 @@ static void rp_realize(PCIDevice *d, Error **errp)
 {
     PCIEPort *p = PCIE_PORT(d);
     PCIESlot *s = PCIE_SLOT(d);
-    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
-    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    const PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
+    const PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     int rc;
     Error *local_err = NULL;
 
@@ -122,7 +122,7 @@ err_bridge:
 
 static void rp_exit(PCIDevice *d)
 {
-    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    const PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     PCIESlot *s = PCIE_SLOT(d);
 
     pcie_aer_exit(d);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9151057bf5..eaf4c14e28 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -353,7 +353,7 @@ const char *pci_root_bus_path(PCIDevice *dev)
 {
     PCIBus *rootbus = pci_device_root_bus(dev);
     PCIHostState *host_bridge = PCI_HOST_BRIDGE(rootbus->qbus.parent);
-    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
+    const PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
 
     assert(host_bridge->bus == rootbus);
 
@@ -451,7 +451,7 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
                                  VMStateField *field)
 {
     PCIDevice *s = container_of(pv, PCIDevice, config);
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(s);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(s);
     uint8_t *config;
     int i;
 
@@ -952,7 +952,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
                                          Error **errp)
 {
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     PCIConfigReadFunc *config_read = pc->config_read;
     PCIConfigWriteFunc *config_write = pc->config_write;
     Error *local_err = NULL;
@@ -1070,7 +1070,7 @@ static void pci_unregister_io_regions(PCIDevice *pci_dev)
 static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_dev = PCI_DEVICE(dev);
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
@@ -1195,7 +1195,7 @@ static pcibus_t pci_bar_address(PCIDevice *d,
     int bar = pci_bar(d, reg);
     uint16_t cmd = pci_get_word(d->config + PCI_COMMAND);
     Object *machine = qdev_get_machine();
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     bool allow_0_address = mc->pci_allow_0_address;
 
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
@@ -1975,7 +1975,7 @@ PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn)
 static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 {
     PCIDevice *pci_dev = (PCIDevice *)qdev;
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     Error *local_err = NULL;
     PCIBus *bus;
     bool is_default_rom;
@@ -2018,7 +2018,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 
 static void pci_default_realize(PCIDevice *dev, Error **errp)
 {
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
 
     if (pc->init) {
         if (pc->init(dev) < 0) {
@@ -2549,7 +2549,7 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     uint16_t cmd = pci_get_word(dev->config + PCI_COMMAND);
     int i;
 
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 20c9c753d2..6f3f3274df 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -39,7 +39,7 @@ static uint64_t pxa2xx_pcmcia_common_read(void *opaque,
                 hwaddr offset, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -53,7 +53,7 @@ static void pxa2xx_pcmcia_common_write(void *opaque, hwaddr offset,
                                        uint64_t value, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -65,7 +65,7 @@ static uint64_t pxa2xx_pcmcia_attr_read(void *opaque,
                 hwaddr offset, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -79,7 +79,7 @@ static void pxa2xx_pcmcia_attr_write(void *opaque, hwaddr offset,
                                      uint64_t value, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -91,7 +91,7 @@ static uint64_t pxa2xx_pcmcia_io_read(void *opaque,
                 hwaddr offset, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -105,7 +105,7 @@ static void pxa2xx_pcmcia_io_write(void *opaque, hwaddr offset,
                                    uint64_t value, unsigned size)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         pcc = PCMCIA_CARD_GET_CLASS(s->card);
@@ -195,7 +195,7 @@ static void pxa2xx_pcmcia_initfn(Object *obj)
 int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (s->slot.attached) {
         return -EEXIST;
@@ -219,7 +219,7 @@ int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card)
 int pxa2xx_pcmcia_detach(void *opaque)
 {
     PXA2xxPCMCIAState *s = (PXA2xxPCMCIAState *) opaque;
-    PCMCIACardClass *pcc;
+    const PCMCIACardClass *pcc;
 
     if (!s->slot.attached) {
         return -ENOENT;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa722af82..7900b8176a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -109,11 +109,11 @@ static int get_cpus_node(void *fdt)
 static void powernv_create_core_node(PnvChip *chip, PnvCore *pc, void *fdt)
 {
     CPUState *cs = CPU(DEVICE(pc->threads));
-    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    const DeviceClass *dc = DEVICE_GET_CLASS(cs);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     int smt_threads = CPU_CORE(pc)->nr_threads;
     CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     uint32_t servers_prop[smt_threads];
     int i;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
@@ -217,7 +217,7 @@ static void powernv_create_core_node(PnvChip *chip, PnvCore *pc, void *fdt)
 
 static void powernv_populate_chip(PnvChip *chip, void *fdt)
 {
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     char *typename = pnv_core_typename(pcc->cpu_model);
     size_t typesize = object_type_get_instance_size(typename);
     int i;
@@ -330,7 +330,7 @@ static ISABus *pnv_isa_create(PnvChip *chip)
     PnvLpcController *lpc = &chip->lpc;
     ISABus *isa_bus;
     qemu_irq *irqs;
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
 
     /* let isa_bus_new() create its own bridge on SysBus otherwise
      * devices speficied on the command line won't find the bus and
@@ -601,7 +601,7 @@ static const TypeInfo pnv_chip_power9_info = {
 
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     int cores_max;
 
     /*
@@ -632,7 +632,7 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 static void pnv_chip_init(Object *obj)
 {
     PnvChip *chip = PNV_CHIP(obj);
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
 
     chip->xscom_base = pcc->xscom_base;
 
@@ -644,7 +644,7 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
 {
     PnvChip *chip = PNV_CHIP(dev);
     Error *error = NULL;
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     char *typename = pnv_core_typename(pcc->cpu_model);
     size_t typesize = object_type_get_instance_size(typename);
     int i, core_hwid;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index d79d530b48..a13fae4329 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -133,7 +133,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 {
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    PnvCoreClass *pcc = PNV_CORE_GET_CLASS(OBJECT(dev));
+    const PnvCoreClass *pcc = PNV_CORE_GET_CLASS(OBJECT(dev));
     const char *typename = object_class_get_name(pcc->cpu_oc);
     size_t size = object_type_get_instance_size(typename);
     Error *local_err = NULL;
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 38bc85f117..272e6b646e 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -51,7 +51,7 @@ static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 
 static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 {
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
 
     addr &= (PNV_XSCOM_SIZE - 1);
     if (pcc->chip_type == PNV_CHIP_POWER9) {
@@ -212,7 +212,7 @@ static int xscom_populate_child(Object *child, void *opaque)
     if (object_dynamic_cast(child, TYPE_PNV_XSCOM_INTERFACE)) {
         ForeachPopulateArgs *args = opaque;
         PnvXScomInterface *xd = PNV_XSCOM_INTERFACE(child);
-        PnvXScomInterfaceClass *xc = PNV_XSCOM_INTERFACE_GET_CLASS(xd);
+        const PnvXScomInterfaceClass *xc = PNV_XSCOM_INTERFACE_GET_CLASS(xd);
 
         if (xc->populate) {
             _FDT((xc->populate(xd, args->fdt, args->xscom_offset)));
@@ -231,7 +231,7 @@ int pnv_xscom_populate(PnvChip *chip, void *fdt, int root_offset)
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
-    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    const PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
 
     name = g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset = fdt_add_subnode(fdt, root_offset, name);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 961230c569..4a684ab750 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -222,14 +222,14 @@ static void PREP_io_800_writeb (void *opaque, uint32_t addr, uint32_t val)
     case 0x0810:
         /* Password protect 1 register */
         if (sysctrl->nvram != NULL) {
-            NvramClass *k = NVRAM_GET_CLASS(sysctrl->nvram);
+            const NvramClass *k = NVRAM_GET_CLASS(sysctrl->nvram);
             (k->toggle_lock)(sysctrl->nvram, 1);
         }
         break;
     case 0x0812:
         /* Password protect 2 register */
         if (sysctrl->nvram != NULL) {
-            NvramClass *k = NVRAM_GET_CLASS(sysctrl->nvram);
+            const NvramClass *k = NVRAM_GET_CLASS(sysctrl->nvram);
             (k->toggle_lock)(sysctrl->nvram, 2);
         }
         break;
@@ -350,13 +350,13 @@ static PortioList prep_port_list;
 /* NVRAM helpers */
 static inline uint32_t nvram_read(Nvram *nvram, uint32_t addr)
 {
-    NvramClass *k = NVRAM_GET_CLASS(nvram);
+    const NvramClass *k = NVRAM_GET_CLASS(nvram);
     return (k->read)(nvram, addr);
 }
 
 static inline void nvram_write(Nvram *nvram, uint32_t addr, uint32_t val)
 {
-    NvramClass *k = NVRAM_GET_CLASS(nvram);
+    const NvramClass *k = NVRAM_GET_CLASS(nvram);
     (k->write)(nvram, addr, val);
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8aecea3dd1..45a0a7c6b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -236,7 +236,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        DeviceClass *dc = DEVICE_GET_CLASS(cs);
+        const DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
 
@@ -444,7 +444,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     int index = ppc_get_vcpu_dt_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
@@ -457,7 +457,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
     int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     int drc_index;
 
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
@@ -566,7 +566,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
     CPU_FOREACH_REVERSE(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
-        DeviceClass *dc = DEVICE_GET_CLASS(cs);
+        const DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
         if ((index % smt) != 0) {
@@ -642,7 +642,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
 
         if (i >= hotplug_lmb_start) {
             sPAPRDRConnector *drc;
-            sPAPRDRConnectorClass *drck;
+            const sPAPRDRConnectorClass *drck;
 
             drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB, i);
             g_assert(drc);
@@ -705,7 +705,7 @@ out:
 static int spapr_dt_cas_updates(sPAPRMachineState *spapr, void *fdt,
                                 sPAPROptionVector *ov5_updates)
 {
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int ret = 0, offset;
 
     /* Generate ibm,dynamic-reconfiguration-memory node if required */
@@ -927,8 +927,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
                              hwaddr rtas_size)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int ret;
     void *fdt;
     sPAPRPHBState *phb;
@@ -1910,7 +1910,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void spapr_init_cpus(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
     char *type = spapr_get_cpu_core_type(machine->cpu_model);
     int smt = kvmppc_smt_threads();
     const CPUArchIdList *possible_cpus;
@@ -1977,7 +1977,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 static void ppc_spapr_init(MachineState *machine)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     PCIHostState *phb;
@@ -2455,7 +2455,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            Error **errp)
 {
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     uint32_t nr_lmbs = size/SPAPR_MEMORY_BLOCK_SIZE;
     int i, fdt_offset, fdt_size;
     void *fdt;
@@ -2503,7 +2503,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Error *local_err = NULL;
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t align = memory_region_get_alignment(mr);
     uint64_t size = memory_region_size(mr);
@@ -2569,7 +2569,7 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            Error **errp)
 {
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     int i;
     sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
@@ -2599,7 +2599,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
 
     pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
@@ -2611,7 +2611,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t size = memory_region_size(mr);
     uint64_t addr;
@@ -2630,7 +2630,7 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    const DeviceClass *dc = DEVICE_GET_CLASS(cs);
     int id = ppc_get_vcpu_dt_id(cpu);
     void *fdt;
     int offset, fdt_size;
@@ -2672,7 +2672,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     int index;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     int smt = kvmppc_smt_threads();
@@ -2704,7 +2704,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(spapr);
+    const MachineClass *mc = MACHINE_GET_CLASS(spapr);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
     CPUState *cs = CPU(core->threads);
@@ -2735,7 +2735,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (drc) {
-        sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+        const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
         drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
         if (local_err) {
             g_free(fdt);
@@ -2755,7 +2755,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
          * Set the right DRC states for cold plugged CPU.
          */
         if (drc) {
-            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+            const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
             drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
         }
@@ -2767,7 +2767,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
@@ -2809,7 +2809,7 @@ out:
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(qdev_get_machine());
+    const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(qdev_get_machine());
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         int node;
@@ -2859,7 +2859,7 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -2880,7 +2880,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -2932,7 +2932,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 {
     int i;
     int spapr_max_cores = max_cpus / smp_threads;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (!mc->has_hotpluggable_cpus) {
         spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 6883f0991a..364c7ae74a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -116,7 +116,7 @@ char *spapr_get_cpu_core_type(const char *model)
 static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
+    const sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     const char *typename = object_class_get_name(scc->cpu_class);
     size_t size = object_type_get_instance_size(typename);
     CPUCore *cc = CPU_CORE(dev);
@@ -158,7 +158,7 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
+    const sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
     const char *typename = object_class_get_name(scc->cpu_class);
     size_t size = object_type_get_instance_size(typename);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 150f6bf2c7..b55d8c8f1b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -54,7 +54,7 @@ static uint32_t get_index(sPAPRDRConnector *drc)
 static uint32_t set_isolation_state(sPAPRDRConnector *drc,
                                     sPAPRDRIsolationState state)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     trace_spapr_drc_set_isolation_state(get_index(drc), state);
 
@@ -122,7 +122,7 @@ static uint32_t set_indicator_state(sPAPRDRConnector *drc,
 static uint32_t set_allocation_state(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     trace_spapr_drc_set_allocation_state(get_index(drc), state);
 
@@ -233,7 +233,7 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     uint32_t value = (uint32_t)drck->get_index(drc);
     visit_type_uint32(v, name, &value, errp);
 }
@@ -242,7 +242,7 @@ static void prop_get_type(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     uint32_t value = (uint32_t)drck->get_type(drc);
     visit_type_uint32(v, name, &value, errp);
 }
@@ -250,7 +250,7 @@ static void prop_get_type(Object *obj, Visitor *v, const char *name,
 static char *prop_get_name(Object *obj, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     return g_strdup(drck->get_name(drc));
 }
 
@@ -258,7 +258,7 @@ static void prop_get_entity_sense(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     uint32_t value;
 
     drck->entity_sense(drc, &value);
@@ -465,7 +465,7 @@ static bool release_pending(sPAPRDRConnector *drc)
 static void reset(DeviceState *d)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     sPAPRDREntitySense state;
 
     trace_spapr_drc_reset(drck->get_index(drc));
@@ -504,7 +504,7 @@ static void reset(DeviceState *d)
 static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     Object *root_container;
     char link_name[256];
     gchar *child_name;
@@ -535,7 +535,7 @@ static void realize(DeviceState *d, Error **errp)
 static void unrealize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     Object *root_container;
     char name[256];
     Error *err = NULL;
@@ -773,7 +773,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
     while ((prop = object_property_iter_next(&iter))) {
         Object *obj;
         sPAPRDRConnector *drc;
-        sPAPRDRConnectorClass *drck;
+        const sPAPRDRConnectorClass *drck;
         uint32_t drc_index, drc_power_domain;
 
         if (!strstart(prop->type, "link<", NULL)) {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 24a5758e62..38bacc5fc3 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -489,7 +489,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
 static void spapr_hotplug_set_signalled(uint32_t drc_index)
 {
     sPAPRDRConnector *drc = spapr_dr_connector_by_index(drc_index);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     drck->set_signalled(drc);
 }
 
@@ -581,7 +581,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
 
 void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     sPAPRDRConnectorType drc_type = drck->get_type(drc);
     union drc_identifier drc_id;
 
@@ -592,7 +592,7 @@ void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc)
 
 void spapr_hotplug_req_remove_by_index(sPAPRDRConnector *drc)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     sPAPRDRConnectorType drc_type = drck->get_type(drc);
     union drc_identifier drc_id;
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f05a90ed2c..f4d70b17be 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -836,7 +836,7 @@ static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
                                                         target_ulong value2)
 {
     CPUState *cs;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
         return H_P2;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e411f..394a7ede9d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1351,7 +1351,7 @@ static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
                                      PCIDevice *pdev,
                                      Error **errp)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     DeviceState *dev = DEVICE(pdev);
     void *fdt = NULL;
     int fdt_start_offset = 0, fdt_size;
@@ -1392,7 +1392,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConnector *drc,
                                         PCIDevice *pdev,
                                         Error **errp)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    const sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     drck->detach(drc, DEVICE(pdev), spapr_phb_remove_pci_device_cb, phb, errp);
 }
@@ -1418,7 +1418,7 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
                                             PCIDevice *pdev)
 {
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
 
     if (!drc) {
         return 0;
@@ -1480,7 +1480,7 @@ static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
 
         for (i = 0; i < 8; i++) {
             sPAPRDRConnector *func_drc;
-            sPAPRDRConnectorClass *func_drck;
+            const sPAPRDRConnectorClass *func_drck;
             sPAPRDREntitySense state;
 
             func_drc = spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus),
@@ -1500,7 +1500,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
 {
     sPAPRPHBState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
     Error *local_err = NULL;
 
@@ -1517,7 +1517,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
         PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
         uint32_t slotnr = PCI_SLOT(pdev->devfn);
         sPAPRDRConnector *func_drc;
-        sPAPRDRConnectorClass *func_drck;
+        const sPAPRDRConnectorClass *func_drck;
         sPAPRDREntitySense state;
         int i;
 
@@ -1577,7 +1577,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
 
     if (sphb->index != (uint32_t)-1) {
-        sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+        const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
         Error *local_err = NULL;
 
         if ((sphb->buid != (uint64_t)-1) || (sphb->dma_liobn[0] != (uint32_t)-1)
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 619f32c054..47a5c0e11a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -173,7 +173,7 @@ static void spapr_cpu_update_tb_offset(PowerPCCPU *cpu)
 static void spapr_cpu_set_endianness(PowerPCCPU *cpu)
 {
     PowerPCCPU *fcpu = POWERPC_CPU(first_cpu);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(fcpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(fcpu);
 
     if (!pcc->interrupts_big_endian(fcpu)) {
         cpu->env.spr[SPR_LPCR] |= LPCR_ILE;
@@ -412,7 +412,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     uint32_t sensor_state;
     uint32_t ret = RTAS_OUT_SUCCESS;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
 
     if (nargs != 3 || nret != 1) {
         ret = RTAS_OUT_PARAM_ERROR;
@@ -482,7 +482,7 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     uint32_t sensor_index;
     uint32_t sensor_state = 0;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     uint32_t ret = RTAS_OUT_SUCCESS;
 
     if (nargs != 2 || nret != 2) {
@@ -544,7 +544,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     uint64_t wa_offset;
     uint32_t drc_index;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    const sPAPRDRConnectorClass *drck;
     sPAPRConfigureConnectorState *ccs;
     sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index a0ee4fd265..f8d4f714a8 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -49,7 +49,7 @@ static Property spapr_vio_props[] = {
 static char *spapr_vio_get_dev_name(DeviceState *qdev)
 {
     VIOsPAPRDevice *dev = VIO_SPAPR_DEVICE(qdev);
-    VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    const VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
 
     /* Device tree style name device@reg */
     return g_strdup_printf("%s@%x", pc->dt_name, dev->reg);
@@ -88,7 +88,7 @@ VIOsPAPRDevice *spapr_vio_find_by_reg(VIOsPAPRBus *bus, uint32_t reg)
 static int vio_make_devnode(VIOsPAPRDevice *dev,
                             void *fdt)
 {
-    VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    const VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
     int vdevice_off, node_off, ret;
     char *dt_name;
 
@@ -402,7 +402,7 @@ static VIOsPAPRDevice *reg_conflict(VIOsPAPRDevice *dev)
 static void spapr_vio_busdev_reset(DeviceState *qdev)
 {
     VIOsPAPRDevice *dev = VIO_SPAPR_DEVICE(qdev);
-    VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    const VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
 
     /* Shut down the request queue and TCEs if necessary */
     spapr_vio_quiesce_one(dev);
@@ -419,7 +419,7 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     VIOsPAPRDevice *dev = (VIOsPAPRDevice *)qdev;
-    VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    const VIOsPAPRDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
     char *id;
     Error *local_err = NULL;
 
@@ -489,7 +489,7 @@ static target_ulong h_vio_signal(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     target_ulong reg = args[0];
     target_ulong mode = args[1];
     VIOsPAPRDevice *dev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRDeviceClass *pc;
+    const VIOsPAPRDeviceClass *pc;
 
     if (!dev) {
         return H_PARAMETER;
@@ -651,7 +651,7 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
      * to know that will mean they are in forward order in the tree. */
     for (i = num - 1; i >= 0; i--) {
         VIOsPAPRDevice *dev = (VIOsPAPRDevice *)(qdevs[i]);
-        VIOsPAPRDeviceClass *vdc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+        const VIOsPAPRDeviceClass *vdc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
 
         ret = vio_make_devnode(dev, fdt);
         if (ret < 0) {
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 9a7f7ee60c..cd1f3ec678 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -27,7 +27,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
                               DeviceState *dev, Error **errp)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
-    CCWDeviceClass *k = CCW_DEVICE_GET_CLASS(ccw_dev);
+    const CCWDeviceClass *k = CCW_DEVICE_GET_CLASS(ccw_dev);
     SubchDev *sch = ccw_dev->sch;
     Error *err = NULL;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 37caa98195..bfdc7b7826 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -100,7 +100,7 @@ static int s390_io_adapter_map(AdapterInfo *adapter, uint64_t map_addr,
                                bool do_map)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    const S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
 
     return fsc->io_adapter_map(fs, adapter->adapter_id, map_addr, do_map);
 }
@@ -162,7 +162,7 @@ int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
     bool found = false;
     int ret;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    const S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
 
     *id = 0;
     QTAILQ_FOREACH(adapter, &channel_subsys.io_adapters, sibling) {
@@ -201,7 +201,7 @@ static void css_clear_io_interrupt(uint16_t subchannel_id,
     Error *err = NULL;
     static bool no_clear_irq;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    const S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
     int r;
 
     if (unlikely(no_clear_irq)) {
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 34b2faf013..d1312b678f 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -38,7 +38,7 @@ static bool event_pending(SCLPEventFacility *ef)
 {
     BusChild *kid;
     SCLPEvent *event;
-    SCLPEventClass *event_class;
+    const SCLPEventClass *event_class;
 
     QTAILQ_FOREACH(kid, &ef->sbus.qbus.children, sibling) {
         DeviceState *qdev = kid->child;
@@ -56,7 +56,7 @@ static unsigned int get_host_send_mask(SCLPEventFacility *ef)
 {
     unsigned int mask;
     BusChild *kid;
-    SCLPEventClass *child;
+    const SCLPEventClass *child;
 
     mask = 0;
 
@@ -72,7 +72,7 @@ static unsigned int get_host_receive_mask(SCLPEventFacility *ef)
 {
     unsigned int mask;
     BusChild *kid;
-    SCLPEventClass *child;
+    const SCLPEventClass *child;
 
     mask = 0;
 
@@ -111,7 +111,7 @@ static uint16_t handle_write_event_buf(SCLPEventFacility *ef,
     uint16_t rc;
     BusChild *kid;
     SCLPEvent *event;
-    SCLPEventClass *ec;
+    const SCLPEventClass *ec;
 
     rc = SCLP_RC_INVALID_FUNCTION;
 
@@ -187,7 +187,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
     unsigned elen;
     BusChild *kid;
     SCLPEvent *event;
-    SCLPEventClass *ec;
+    const SCLPEventClass *ec;
     EventBufferHeader *event_buf;
     ReadEventData *red = (ReadEventData *) sccb;
 
@@ -397,7 +397,7 @@ static const TypeInfo sclp_event_facility_info = {
 static void event_realize(DeviceState *qdev, Error **errp)
 {
     SCLPEvent *event = SCLP_EVENT(qdev);
-    SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
+    const SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
 
     if (child->init) {
         int rc = child->init(event);
@@ -411,7 +411,7 @@ static void event_realize(DeviceState *qdev, Error **errp)
 static void event_unrealize(DeviceState *qdev, Error **errp)
 {
     SCLPEvent *event = SCLP_EVENT(qdev);
-    SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
+    const SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
     if (child->exit) {
         int rc = child->exit(event);
         if (rc < 0) {
diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index 131da56bbe..dac3440441 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -16,7 +16,7 @@
 
 static int kvm_s390_skeys_enabled(S390SKeysState *ss)
 {
-    S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
+    const S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     uint8_t single_key;
     int r;
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index e2d4e1af79..207699212d 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -70,7 +70,7 @@ static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
 void hmp_info_skeys(Monitor *mon, const QDict *qdict)
 {
     S390SKeysState *ss = s390_get_skeys_device();
-    S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
+    const S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     uint64_t addr = qdict_get_int(qdict, "addr");
     uint8_t key;
     int r;
@@ -104,7 +104,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
 void qmp_dump_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
-    S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
+    const S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     const uint64_t total_count = ram_size / TARGET_PAGE_SIZE;
     uint64_t handled_count = 0, cur_count;
     Error *lerr = NULL;
@@ -247,7 +247,7 @@ static const TypeInfo qemu_s390_skeys_info = {
 static void s390_storage_keys_save(QEMUFile *f, void *opaque)
 {
     S390SKeysState *ss = S390_SKEYS(opaque);
-    S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
+    const S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     uint64_t pages_left = ram_size / TARGET_PAGE_SIZE;
     uint64_t read_count, eos = S390_SKEYS_SAVE_FLAG_EOS;
     vaddr cur_gfn = 0;
@@ -299,7 +299,7 @@ end_stream:
 static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
 {
     S390SKeysState *ss = S390_SKEYS(opaque);
-    S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
+    const S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     int ret = 0;
 
     while (!ret) {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 40914fde6f..da82af6886 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -244,10 +244,10 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
 bool ri_allowed(void)
 {
     if (kvm_enabled()) {
-        MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+        const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (object_class_dynamic_cast(OBJECT_CLASS(mc),
                                       TYPE_S390_CCW_MACHINE)) {
-            S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+            const S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
 
             return s390mc->ri_allowed;
         }
@@ -262,10 +262,10 @@ bool ri_allowed(void)
 
 bool cpu_model_allowed(void)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    const MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     if (object_class_dynamic_cast(OBJECT_CLASS(mc),
                                   TYPE_S390_CCW_MACHINE)) {
-        S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+        const S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
 
         return s390mc->cpu_model_allowed;
     }
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index e741da1141..42bf7d0fbf 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -348,9 +348,9 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
 
 static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
 {
-    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    const SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCLPEventFacility *ef = sclp->event_facility;
-    SCLPEventFacilityClass *efc = EVENT_FACILITY_GET_CLASS(ef);
+    const SCLPEventFacilityClass *efc = EVENT_FACILITY_GET_CLASS(ef);
 
     switch (code & SCLP_CMD_CODE_MASK) {
     case SCLP_CMDW_READ_SCP_INFO:
@@ -391,7 +391,7 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
-    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    const SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     int r = 0;
     SCCB work_sccb;
 
@@ -440,7 +440,7 @@ out:
 static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
 {
     SCLPEventFacility *ef = sclp->event_facility;
-    SCLPEventFacilityClass *efc = EVENT_FACILITY_GET_CLASS(ef);
+    const SCLPEventFacilityClass *efc = EVENT_FACILITY_GET_CLASS(ef);
 
     uint32_t param = sccb & ~3;
 
@@ -457,7 +457,7 @@ static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
 void sclp_service_interrupt(uint32_t sccb)
 {
     SCLPDevice *sclp = get_sclp_device();
-    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    const SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
 
     sclp_c->service_interrupt(sclp, sccb);
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 00b3bde4e9..f092c92c0a 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -314,7 +314,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+            const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
             features.index = address_space_ldub(&address_space_memory,
                                                 ccw.cda
@@ -678,7 +678,7 @@ static void virtio_sch_disable_cb(SubchDev *sch)
 
 static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
 {
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
+    const VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = css_create_virtual_sch(ccw_dev->bus_id, errp);
     Error *err = NULL;
@@ -1067,7 +1067,7 @@ static int virtio_ccw_setup_irqroutes(VirtioCcwDevice *dev, int nvqs)
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
     int ret;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    const S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
 
     ret = virtio_ccw_get_mappings(dev);
     if (ret) {
@@ -1085,7 +1085,7 @@ static int virtio_ccw_setup_irqroutes(VirtioCcwDevice *dev, int nvqs)
 static void virtio_ccw_release_irqroutes(VirtioCcwDevice *dev, int nvqs)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    const S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
 
     fsc->release_adapter_routes(fs, &dev->routes);
 }
@@ -1118,7 +1118,7 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     if (assign) {
         int r = event_notifier_init(notifier, 0);
@@ -1619,7 +1619,7 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 static int virtio_ccw_busdev_exit(DeviceState *dev)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
-    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
+    const VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
     return _info->exit(_dev);
 }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf901..01faf2cdec 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -711,8 +711,8 @@ static void megasas_finish_dcmd(MegasasCmd *cmd, uint32_t iov_size)
 static int megasas_ctrl_get_info(MegasasState *s, MegasasCmd *cmd)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
-    PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(pci_dev);
-    MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
+    const PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(pci_dev);
+    const MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
     struct mfi_ctrl_info info;
     size_t dcmd_size = sizeof(info);
     BusChild *kid;
@@ -2003,7 +2003,7 @@ static uint64_t megasas_mmio_read(void *opaque, hwaddr addr,
 {
     MegasasState *s = opaque;
     PCIDevice *pci_dev = PCI_DEVICE(s);
-    MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
+    const MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
     uint32_t retval = 0;
 
     switch (addr) {
@@ -2326,7 +2326,7 @@ static const struct SCSIBusInfo megasas_scsi_info = {
 static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 {
     MegasasState *s = MEGASAS(dev);
-    MegasasBaseClass *b = MEGASAS_DEVICE_GET_CLASS(s);
+    const MegasasBaseClass *b = MEGASAS_DEVICE_GET_CLASS(s);
     uint8_t *pci_conf;
     int i, bar_type;
     Error *err = NULL;
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 87a416a5cb..e5cd7dd6b8 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -209,7 +209,7 @@ size_t mptsas_config_manufacturing_1(MPTSASState *s, uint8_t **data, int address
 static
 size_t mptsas_config_manufacturing_2(MPTSASState *s, uint8_t **data, int address)
 {
-    PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
+    const PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
     return MPTSAS_CONFIG_PACK(2, MPI_CONFIG_PAGETYPE_MANUFACTURING, 0x00,
                               "wb*b*l",
                               pcic->device_id, pcic->revision);
@@ -218,7 +218,7 @@ size_t mptsas_config_manufacturing_2(MPTSASState *s, uint8_t **data, int address
 static
 size_t mptsas_config_manufacturing_3(MPTSASState *s, uint8_t **data, int address)
 {
-    PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
+    const PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
     return MPTSAS_CONFIG_PACK(3, MPI_CONFIG_PAGETYPE_MANUFACTURING, 0x00,
                               "wb*b*l",
                               pcic->device_id, pcic->revision);
@@ -323,7 +323,7 @@ size_t mptsas_config_io_unit_4(MPTSASState *s, uint8_t **data, int address)
 static
 size_t mptsas_config_ioc_0(MPTSASState *s, uint8_t **data, int address)
 {
-    PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
+    const PCIDeviceClass *pcic = PCI_DEVICE_GET_CLASS(s);
 
     return MPTSAS_CONFIG_PACK(0, MPI_CONFIG_PAGETYPE_IOC, 0x01,
                               "*l*lwwb*b*b*blww",
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f5574469c8..3013a7caea 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -48,7 +48,7 @@ static int next_scsi_bus;
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
 {
-    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
+    const SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
     if (sc->realize) {
         sc->realize(s, errp);
     }
@@ -71,7 +71,7 @@ int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
 static SCSIRequest *scsi_device_alloc_req(SCSIDevice *s, uint32_t tag, uint32_t lun,
                                           uint8_t *buf, void *hba_private)
 {
-    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
+    const SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
     if (sc->alloc_req) {
         return sc->alloc_req(s, tag, lun, buf, hba_private);
     }
@@ -81,7 +81,7 @@ static SCSIRequest *scsi_device_alloc_req(SCSIDevice *s, uint32_t tag, uint32_t
 
 void scsi_device_unit_attention_reported(SCSIDevice *s)
 {
-    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
+    const SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
     if (sc->unit_attention_reported) {
         sc->unit_attention_reported(s);
     }
@@ -635,7 +635,7 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
 {
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, d->qdev.parent_bus);
     const SCSIReqOps *ops;
-    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(d);
+    const SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(d);
     SCSIRequest *req;
     SCSICommand cmd = { .len = 0 };
     int ret;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c491ece1f2..dc47a33667 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -71,7 +71,7 @@ static int vhost_scsi_start(VHostSCSI *s)
     int ret, abi_version, i;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     const VhostOps *vhost_ops = s->dev.vhost_ops;
 
     if (!k->set_guest_notifiers) {
@@ -138,7 +138,7 @@ static void vhost_scsi_stop(VHostSCSI *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
     if (k->set_guest_notifiers) {
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 944ea4eb53..9644dae780 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -27,7 +27,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     if (vs->conf.iothread) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
@@ -126,7 +126,7 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
     int i;
     int rc;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
@@ -188,7 +188,7 @@ fail_guest_notifiers:
 void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     int i;
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 75575461e2..a56712086f 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1264,7 +1264,7 @@ static Property pvscsi_properties[] = {
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
 {
-    PVSCSIClass *pvs_c = PVSCSI_DEVICE_GET_CLASS(qdev);
+    const PVSCSIClass *pvs_c = PVSCSI_DEVICE_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     PVSCSIState *s = PVSCSI(qdev);
 
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 295dc44ab7..2078c4ce5e 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -40,7 +40,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         return sc->do_command(card, req, response);
     }
@@ -53,7 +53,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         sc->write_data(card, value);
     }
@@ -64,7 +64,7 @@ uint8_t sdbus_read_data(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         return sc->read_data(card);
     }
@@ -77,7 +77,7 @@ bool sdbus_data_ready(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         return sc->data_ready(card);
     }
@@ -90,7 +90,7 @@ bool sdbus_get_inserted(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         return sc->get_inserted(card);
     }
@@ -103,7 +103,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        const SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
         return sc->get_readonly(card);
     }
@@ -113,7 +113,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
 
 void sdbus_set_inserted(SDBus *sdbus, bool inserted)
 {
-    SDBusClass *sbc = SD_BUS_GET_CLASS(sdbus);
+    const SDBusClass *sbc = SD_BUS_GET_CLASS(sdbus);
     BusState *qbus = BUS(sdbus);
 
     if (sbc->set_inserted) {
@@ -123,7 +123,7 @@ void sdbus_set_inserted(SDBus *sdbus, bool inserted)
 
 void sdbus_set_readonly(SDBus *sdbus, bool readonly)
 {
-    SDBusClass *sbc = SD_BUS_GET_CLASS(sdbus);
+    const SDBusClass *sbc = SD_BUS_GET_CLASS(sdbus);
     BusState *qbus = BUS(sdbus);
 
     if (sbc->set_readonly) {
@@ -134,7 +134,7 @@ void sdbus_set_readonly(SDBus *sdbus, bool readonly)
 void sdbus_reparent_card(SDBus *from, SDBus *to)
 {
     SDState *card = get_card(from);
-    SDCardClass *sc;
+    const SDCardClass *sc;
     bool readonly;
 
     /* We directly reparent the card object rather than implementing this
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..1990afc92c 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -256,7 +256,7 @@ static uint32_t sh7750_mem_readw(void *opaque, hwaddr addr)
 static uint32_t sh7750_mem_readl(void *opaque, hwaddr addr)
 {
     SH7750State *s = opaque;
-    SuperHCPUClass *scc;
+    const SuperHCPUClass *scc;
 
     switch (addr) {
     case SH7750_BCR1_A7:
diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index 56e8609c00..ae896ffe01 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -89,7 +89,7 @@ static void smbios_add_ipmi_devices(BusState *bus)
 
         if (obj) {
             IPMIInterface *ii;
-            IPMIInterfaceClass *iic;
+            const IPMIInterfaceClass *iic;
             IPMIFwInfo info;
 
             ii = IPMI_INTERFACE(obj);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 873cd7df9a..19ec555fcd 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -120,7 +120,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
     unsigned int i;
     int sysp_end;
     uint8_t image[0x1ff0];
-    NvramClass *k = NVRAM_GET_CLASS(nvram);
+    const NvramClass *k = NVRAM_GET_CLASS(nvram);
 
     memset(image, '\0', sizeof(image));
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d347b6616d..c49f5798cc 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -108,7 +108,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
     unsigned int i;
     int sysp_end;
     uint8_t image[0x1ff0];
-    NvramClass *k = NVRAM_GET_CLASS(nvram);
+    const NvramClass *k = NVRAM_GET_CLASS(nvram);
 
     memset(image, '\0', sizeof(image));
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index cb515730c5..794136f99a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -714,7 +714,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedSMCState *s = ASPEED_SMC(dev);
-    AspeedSMCClass *mc = ASPEED_SMC_GET_CLASS(s);
+    const AspeedSMCClass *mc = ASPEED_SMC_GET_CLASS(s);
     int i;
     char name[32];
     hwaddr offset = 0;
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 7eaaf565fd..77b248a4e7 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -34,7 +34,7 @@ static void ssi_cs_default(void *opaque, int n, int level)
     bool cs = !!level;
     assert(n == 0);
     if (s->cs != cs) {
-        SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
+        const SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
         if (ssc->set_cs) {
             ssc->set_cs(s, cs);
         }
@@ -44,7 +44,7 @@ static void ssi_cs_default(void *opaque, int n, int level)
 
 static uint32_t ssi_transfer_raw_default(SSISlave *dev, uint32_t val)
 {
-    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(dev);
+    const SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(dev);
 
     if ((dev->cs && ssc->cs_polarity == SSI_CS_HIGH) ||
             (!dev->cs && ssc->cs_polarity == SSI_CS_LOW) ||
@@ -57,7 +57,7 @@ static uint32_t ssi_transfer_raw_default(SSISlave *dev, uint32_t val)
 static void ssi_slave_realize(DeviceState *dev, Error **errp)
 {
     SSISlave *s = SSI_SLAVE(dev);
-    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
+    const SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(s);
 
     if (ssc->transfer_raw == ssi_transfer_raw_default &&
             ssc->cs_polarity != SSI_CS_NONE) {
@@ -111,7 +111,7 @@ uint32_t ssi_transfer(SSIBus *bus, uint32_t val)
 {
     BusState *b = BUS(bus);
     BusChild *kid;
-    SSISlaveClass *ssc;
+    const SSISlaveClass *ssc;
     uint32_t r = 0;
 
     QTAILQ_FOREACH(kid, &b->children, sibling) {
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index da8adfa443..23758fa251 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -606,7 +606,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
 {
     XilinxSPIPS *s = XILINX_SPIPS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    XilinxSPIPSClass *xsc = XILINX_SPIPS_GET_CLASS(s);
+    const XilinxSPIPSClass *xsc = XILINX_SPIPS_GET_CLASS(s);
     qemu_irq *cs;
     int i;
 
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 5e61ad50a8..b6f8188010 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -332,7 +332,7 @@ static void pit_post_load(PITCommonState *s)
 static void pit_realizefn(DeviceState *dev, Error **errp)
 {
     PITCommonState *pit = PIT_COMMON(dev);
-    PITClass *pc = PIT_GET_CLASS(dev);
+    const PITClass *pc = PIT_GET_CLASS(dev);
     PITChannelState *s;
 
     s = &pit->channels[0];
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index e18299a482..243f8bbb28 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -35,7 +35,7 @@ void pit_set_gate(ISADevice *dev, int channel, int val)
 {
     PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
-    PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
+    const PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
     c->set_channel_gate(pit, s, val);
 }
@@ -144,7 +144,7 @@ void pit_get_channel_info(ISADevice *dev, int channel, PITChannelInfo *info)
 {
     PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
-    PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
+    const PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
     c->get_channel_info(pit, s, info);
 }
@@ -203,7 +203,7 @@ static const VMStateDescription vmstate_pit_channel = {
 static int pit_load_old(QEMUFile *f, void *opaque, int version_id)
 {
     PITCommonState *pit = opaque;
-    PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
+    const PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
     PITChannelState *s;
     int i;
 
@@ -240,7 +240,7 @@ static int pit_load_old(QEMUFile *f, void *opaque, int version_id)
 static void pit_dispatch_pre_save(void *opaque)
 {
     PITCommonState *s = opaque;
-    PITCommonClass *c = PIT_COMMON_GET_CLASS(s);
+    const PITCommonClass *c = PIT_COMMON_GET_CLASS(s);
 
     if (c->pre_save) {
         c->pre_save(s);
@@ -250,7 +250,7 @@ static void pit_dispatch_pre_save(void *opaque)
 static int pit_dispatch_post_load(void *opaque, int version_id)
 {
     PITCommonState *s = opaque;
-    PITCommonClass *c = PIT_COMMON_GET_CLASS(s);
+    const PITCommonClass *c = PIT_COMMON_GET_CLASS(s);
 
     if (c->post_load) {
         c->post_load(s);
diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
index ea1ba703d7..baacf1311b 100644
--- a/hw/timer/m48t59-isa.c
+++ b/hw/timer/m48t59-isa.c
@@ -112,7 +112,7 @@ static void m48t59_reset_isa(DeviceState *d)
 
 static void m48t59_isa_realize(DeviceState *dev, Error **errp)
 {
-    M48txxISADeviceClass *u = M48TXX_ISA_GET_CLASS(dev);
+    const M48txxISADeviceClass *u = M48TXX_ISA_GET_CLASS(dev);
     ISADevice *isadev = ISA_DEVICE(dev);
     M48txxISAState *d = M48TXX_ISA(dev);
     M48t59State *s = &d->state;
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 474981a6ac..89e9060b00 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -646,7 +646,7 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
 
 static int m48t59_init1(SysBusDevice *dev)
 {
-    M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(dev);
+    const M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(dev);
     M48txxSysBusState *d = M48TXX_SYS_BUS(dev);
     Object *o = OBJECT(dev);
     M48t59State *s = &d->state;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 24f1608b4b..b85bc02433 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -119,7 +119,7 @@ USBBus *usb_bus_find(int busnr)
 
 static void usb_device_realize(USBDevice *dev, Error **errp)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
 
     if (klass->realize) {
         klass->realize(dev, errp);
@@ -128,7 +128,7 @@ static void usb_device_realize(USBDevice *dev, Error **errp)
 
 USBDevice *usb_device_find_device(USBDevice *dev, uint8_t addr)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->find_device) {
         return klass->find_device(dev, addr);
     }
@@ -137,7 +137,7 @@ USBDevice *usb_device_find_device(USBDevice *dev, uint8_t addr)
 
 static void usb_device_unrealize(USBDevice *dev, Error **errp)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
 
     if (klass->unrealize) {
         klass->unrealize(dev, errp);
@@ -146,7 +146,7 @@ static void usb_device_unrealize(USBDevice *dev, Error **errp)
 
 void usb_device_cancel_packet(USBDevice *dev, USBPacket *p)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->cancel_packet) {
         klass->cancel_packet(dev, p);
     }
@@ -154,7 +154,7 @@ void usb_device_cancel_packet(USBDevice *dev, USBPacket *p)
 
 void usb_device_handle_attach(USBDevice *dev)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->handle_attach) {
         klass->handle_attach(dev);
     }
@@ -162,7 +162,7 @@ void usb_device_handle_attach(USBDevice *dev)
 
 void usb_device_handle_reset(USBDevice *dev)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->handle_reset) {
         klass->handle_reset(dev);
     }
@@ -171,7 +171,7 @@ void usb_device_handle_reset(USBDevice *dev)
 void usb_device_handle_control(USBDevice *dev, USBPacket *p, int request,
                                int value, int index, int length, uint8_t *data)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->handle_control) {
         klass->handle_control(dev, p, request, value, index, length, data);
     }
@@ -179,7 +179,7 @@ void usb_device_handle_control(USBDevice *dev, USBPacket *p, int request,
 
 void usb_device_handle_data(USBDevice *dev, USBPacket *p)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->handle_data) {
         klass->handle_data(dev, p);
     }
@@ -187,13 +187,13 @@ void usb_device_handle_data(USBDevice *dev, USBPacket *p)
 
 const char *usb_device_get_product_desc(USBDevice *dev)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     return klass->product_desc;
 }
 
 const USBDesc *usb_device_get_usb_desc(USBDevice *dev)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (dev->usb_desc) {
         return dev->usb_desc;
     }
@@ -203,7 +203,7 @@ const USBDesc *usb_device_get_usb_desc(USBDevice *dev)
 void usb_device_set_interface(USBDevice *dev, int interface,
                               int alt_old, int alt_new)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->set_interface) {
         klass->set_interface(dev, interface, alt_old, alt_new);
     }
@@ -211,7 +211,7 @@ void usb_device_set_interface(USBDevice *dev, int interface,
 
 void usb_device_flush_ep_queue(USBDevice *dev, USBEndpoint *ep)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->flush_ep_queue) {
         klass->flush_ep_queue(dev, ep);
     }
@@ -219,7 +219,7 @@ void usb_device_flush_ep_queue(USBDevice *dev, USBEndpoint *ep)
 
 void usb_device_ep_stopped(USBDevice *dev, USBEndpoint *ep)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->ep_stopped) {
         klass->ep_stopped(dev, ep);
     }
@@ -228,7 +228,7 @@ void usb_device_ep_stopped(USBDevice *dev, USBEndpoint *ep)
 int usb_device_alloc_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps,
                              int streams)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->alloc_streams) {
         return klass->alloc_streams(dev, eps, nr_eps, streams);
     }
@@ -237,7 +237,7 @@ int usb_device_alloc_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps,
 
 void usb_device_free_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps)
 {
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
     if (klass->free_streams) {
         klass->free_streams(dev, eps, nr_eps);
     }
@@ -773,7 +773,7 @@ static void usb_set_attached(Object *obj, bool value, Error **errp)
 static void usb_device_instance_init(Object *obj)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
+    const USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
 
     if (klass->attached_settable) {
         object_property_add_bool(obj, "attached",
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 757b8b3f5a..df15e99946 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -489,7 +489,7 @@ static const USBDesc desc_ccid = {
 
 static const uint8_t *ccid_card_get_atr(CCIDCardState *card, uint32_t *len)
 {
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
+    const CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
 
     if (cc->get_atr) {
         return cc->get_atr(card, len);
@@ -501,7 +501,7 @@ static void ccid_card_apdu_from_guest(CCIDCardState *card,
                                       const uint8_t *apdu,
                                       uint32_t len)
 {
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
+    const CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
 
     if (cc->apdu_from_guest) {
         cc->apdu_from_guest(card, apdu, len);
@@ -510,7 +510,7 @@ static void ccid_card_apdu_from_guest(CCIDCardState *card,
 
 static void ccid_card_exitfn(CCIDCardState *card)
 {
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
+    const CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
 
     if (cc->exitfn) {
         cc->exitfn(card);
@@ -520,7 +520,7 @@ static void ccid_card_exitfn(CCIDCardState *card)
 
 static int ccid_card_initfn(CCIDCardState *card)
 {
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
+    const CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
 
     if (cc->initfn) {
         return cc->initfn(card);
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 6dedcb8989..337ee330fc 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -71,7 +71,7 @@ static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
 
 static void usb_ehci_pci_init(Object *obj)
 {
-    DeviceClass *dc = OBJECT_GET_CLASS(DeviceClass, obj, TYPE_DEVICE);
+    const DeviceClass *dc = OBJECT_GET_CLASS(DeviceClass, obj, TYPE_DEVICE);
     EHCIPCIState *i = PCI_EHCI(obj);
     EHCIState *s = &i->ehci;
 
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 6c20604d07..1c890eb84f 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -56,7 +56,7 @@ static void ehci_sysbus_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
     EHCISysBusState *i = SYS_BUS_EHCI(obj);
-    SysBusEHCIClass *sec = SYS_BUS_EHCI_GET_CLASS(obj);
+    const SysBusEHCIClass *sec = SYS_BUS_EHCI_GET_CLASS(obj);
     EHCIState *s = &i->ehci;
 
     s->capsbase = sec->capsbase;
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index ca72a80f27..a7e8295e1c 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1209,7 +1209,7 @@ static USBBusOps uhci_bus_ops = {
 static void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
 {
     Error *err = NULL;
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    const PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     UHCIPCIDeviceClass *u = container_of(pc, UHCIPCIDeviceClass, parent_class);
     UHCIState *s = UHCI(dev);
     uint8_t *pci_conf = s->dev.config;
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 2c60310cf9..3c49fcc62e 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -17,7 +17,7 @@
 static void amd_xgbe_realize(DeviceState *dev, Error **errp)
 {
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
-    VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
+    const VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
 
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index bb15d588e5..f8cad99dc7 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -17,7 +17,7 @@
 static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
 {
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
-    VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
+    const VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("calxeda,hb-xgmac");
 
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index b4815629e1..51636ef571 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -75,7 +75,7 @@ static void vhost_vsock_start(VirtIODevice *vdev)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
     int i;
 
@@ -131,7 +131,7 @@ static void vhost_vsock_stop(VirtIODevice *vdev)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
     if (!k->set_guest_notifiers) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index febe519bbd..43ac6948b6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -946,7 +946,7 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
     hwaddr s, l, a;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232daf..ef1d49223b 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -46,8 +46,8 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     DeviceState *qdev = DEVICE(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(qdev));
     VirtioBusState *bus = VIRTIO_BUS(qbus);
-    VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
     Error *local_err = NULL;
 
@@ -102,7 +102,7 @@ void virtio_bus_device_unplugged(VirtIODevice *vdev)
 {
     DeviceState *qdev = DEVICE(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(qdev));
-    VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(qbus);
 
     DPRINTF("%s: remove device.\n", qbus->name);
 
@@ -133,7 +133,7 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus)
 uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioDeviceClass *k;
+    const VirtioDeviceClass *k;
 
     assert(vdev != NULL);
     k = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -148,7 +148,7 @@ uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
 void virtio_bus_get_vdev_config(VirtioBusState *bus, uint8_t *config)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioDeviceClass *k;
+    const VirtioDeviceClass *k;
 
     assert(vdev != NULL);
     k = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -161,7 +161,7 @@ void virtio_bus_get_vdev_config(VirtioBusState *bus, uint8_t *config)
 void virtio_bus_set_vdev_config(VirtioBusState *bus, uint8_t *config)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioDeviceClass *k;
+    const VirtioDeviceClass *k;
 
     assert(vdev != NULL);
     k = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -173,7 +173,7 @@ void virtio_bus_set_vdev_config(VirtioBusState *bus, uint8_t *config)
 /* On success, ioeventfd ownership belongs to the caller.  */
 int virtio_bus_grab_ioeventfd(VirtioBusState *bus)
 {
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
 
     /* vhost can be used even if ioeventfd=off in the proxy device,
      * so do not check k->ioeventfd_enabled.
@@ -205,10 +205,10 @@ void virtio_bus_release_ioeventfd(VirtioBusState *bus)
 
 int virtio_bus_start_ioeventfd(VirtioBusState *bus)
 {
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
     DeviceState *proxy = DEVICE(BUS(bus)->parent);
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     int r;
 
     if (!k->ioeventfd_assign || !k->ioeventfd_enabled(proxy)) {
@@ -233,7 +233,7 @@ int virtio_bus_start_ioeventfd(VirtioBusState *bus)
 void virtio_bus_stop_ioeventfd(VirtioBusState *bus)
 {
     VirtIODevice *vdev;
-    VirtioDeviceClass *vdc;
+    const VirtioDeviceClass *vdc;
 
     if (!bus->ioeventfd_started) {
         return;
@@ -250,7 +250,7 @@ void virtio_bus_stop_ioeventfd(VirtioBusState *bus)
 
 bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
 {
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
     DeviceState *proxy = DEVICE(BUS(bus)->parent);
 
     return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
@@ -263,7 +263,7 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
 int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
 {
     VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
     DeviceState *proxy = DEVICE(BUS(bus)->parent);
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_host_notifier(vq);
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..e2a449f458 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -366,7 +366,7 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244808..75e2ae54b7 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -739,7 +739,7 @@ static int kvm_virtio_pci_vector_use(VirtIOPCIProxy *proxy, int nvqs)
 {
     PCIDevice *dev = &proxy->pci_dev;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     unsigned int vector;
     int ret, queue_no;
 
@@ -788,7 +788,7 @@ static void kvm_virtio_pci_vector_release(VirtIOPCIProxy *proxy, int nvqs)
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     unsigned int vector;
     int queue_no;
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     for (queue_no = 0; queue_no < nvqs; queue_no++) {
         if (!virtio_queue_get_num(vdev, queue_no)) {
@@ -814,7 +814,7 @@ static int virtio_pci_vq_vector_unmask(VirtIOPCIProxy *proxy,
                                        MSIMessage msg)
 {
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     VirtQueue *vq = virtio_get_queue(vdev, queue_no);
     EventNotifier *n = virtio_queue_get_guest_notifier(vq);
     VirtIOIRQFD *irqfd;
@@ -853,7 +853,7 @@ static void virtio_pci_vq_vector_mask(VirtIOPCIProxy *proxy,
                                              unsigned int vector)
 {
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     /* If guest supports masking, keep irqfd but mask it.
      * Otherwise, clean it up now.
@@ -928,7 +928,7 @@ static void virtio_pci_vector_poll(PCIDevice *dev,
 {
     VirtIOPCIProxy *proxy = container_of(dev, VirtIOPCIProxy, pci_dev);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     int queue_no;
     unsigned int vector;
     EventNotifier *notifier;
@@ -960,7 +960,7 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     VirtQueue *vq = virtio_get_queue(vdev, n);
     EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
 
@@ -994,7 +994,7 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     int r, n;
     bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
         kvm_msi_via_irqfd_enabled();
@@ -1186,7 +1186,7 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_DF:
         if (proxy->dfselect <= 1) {
-            VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+            const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
             val = (vdev->host_features & ~vdc->legacy_features) >>
                 (32 * proxy->dfselect);
@@ -1736,7 +1736,7 @@ static void virtio_pci_device_unplugged(DeviceState *d)
 static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
-    VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(pci_dev);
+    const VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(pci_dev);
     bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
                      !pci_bus_is_root(pci_dev->bus);
 
@@ -1918,7 +1918,7 @@ static Property virtio_pci_properties[] = {
 
 static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
 {
-    VirtioPCIClass *vpciklass = VIRTIO_PCI_GET_CLASS(qdev);
+    const VirtioPCIClass *vpciklass = VIRTIO_PCI_GET_CLASS(qdev);
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     PCIDevice *pci_dev = &proxy->pci_dev;
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c542a..3d0fd9cdd6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1095,7 +1095,7 @@ void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem)
 static void virtio_notify_vector(VirtIODevice *vdev, uint16_t vector)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     if (unlikely(vdev->broken)) {
         return;
@@ -1113,7 +1113,7 @@ void virtio_update_irq(VirtIODevice *vdev)
 
 static int virtio_validate_features(VirtIODevice *vdev)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
         !virtio_vdev_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
@@ -1129,7 +1129,7 @@ static int virtio_validate_features(VirtIODevice *vdev)
 
 int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     trace_virtio_set_status(vdev, val);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
@@ -1161,7 +1161,7 @@ static enum virtio_device_endian virtio_default_endian(void)
 
 static enum virtio_device_endian virtio_current_cpu_endian(void)
 {
-    CPUClass *cc = CPU_GET_CLASS(current_cpu);
+    const CPUClass *cc = CPU_GET_CLASS(current_cpu);
 
     if (cc->virtio_is_big_endian(current_cpu)) {
         return VIRTIO_DEVICE_ENDIAN_BIG;
@@ -1184,7 +1184,7 @@ static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     int i;
 
     virtio_set_status(vdev, 0);
@@ -1227,7 +1227,7 @@ void virtio_reset(void *opaque)
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint8_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1242,7 +1242,7 @@ uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr)
 
 uint32_t virtio_config_readw(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint16_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1257,7 +1257,7 @@ uint32_t virtio_config_readw(VirtIODevice *vdev, uint32_t addr)
 
 uint32_t virtio_config_readl(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1272,7 +1272,7 @@ uint32_t virtio_config_readl(VirtIODevice *vdev, uint32_t addr)
 
 void virtio_config_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint8_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1288,7 +1288,7 @@ void virtio_config_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 void virtio_config_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint16_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1304,7 +1304,7 @@ void virtio_config_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1320,7 +1320,7 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 uint32_t virtio_config_modern_readb(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint8_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1335,7 +1335,7 @@ uint32_t virtio_config_modern_readb(VirtIODevice *vdev, uint32_t addr)
 
 uint32_t virtio_config_modern_readw(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint16_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1350,7 +1350,7 @@ uint32_t virtio_config_modern_readw(VirtIODevice *vdev, uint32_t addr)
 
 uint32_t virtio_config_modern_readl(VirtIODevice *vdev, uint32_t addr)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t val;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1366,7 +1366,7 @@ uint32_t virtio_config_modern_readl(VirtIODevice *vdev, uint32_t addr)
 void virtio_config_modern_writeb(VirtIODevice *vdev,
                                  uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint8_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1383,7 +1383,7 @@ void virtio_config_modern_writeb(VirtIODevice *vdev,
 void virtio_config_modern_writew(VirtIODevice *vdev,
                                  uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint16_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1400,7 +1400,7 @@ void virtio_config_modern_writew(VirtIODevice *vdev,
 void virtio_config_modern_writel(VirtIODevice *vdev,
                                  uint32_t addr, uint32_t data)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t val = data;
 
     if (addr + sizeof(val) > vdev->config_len) {
@@ -1483,7 +1483,7 @@ int virtio_get_num_queues(VirtIODevice *vdev)
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     /* virtio-1 compliant devices cannot change the alignment */
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
@@ -1739,7 +1739,7 @@ static bool virtio_extra_state_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     return k->has_extra_state &&
         k->has_extra_state(qbus->parent);
@@ -1802,7 +1802,7 @@ static int get_extra_state(QEMUFile *f, void *pv, size_t size,
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     if (!k->load_extra_state) {
         return -1;
@@ -1816,7 +1816,7 @@ static int put_extra_state(QEMUFile *f, void *pv, size_t size,
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     k->save_extra_state(qbus->parent, f);
     return 0;
@@ -1902,8 +1902,8 @@ static const VMStateDescription vmstate_virtio = {
 void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
 
@@ -1970,7 +1970,7 @@ static int virtio_device_get(QEMUFile *f, void *opaque, size_t size,
                              VMStateField *field)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
-    DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
+    const DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
 
     return virtio_load(vdev, f, dc->vmsd->version_id);
 }
@@ -1983,7 +1983,7 @@ const VMStateInfo  virtio_vmstate_info = {
 
 static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
 {
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     bool bad = (val & ~(vdev->host_features)) != 0;
 
     val &= vdev->host_features;
@@ -2013,8 +2013,8 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     uint32_t num;
     uint32_t features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     /*
      * We poison the endianness to ensure it does not get used before
@@ -2200,7 +2200,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
 {
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     bool backend_run = running && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
     vdev->vm_running = running;
 
@@ -2232,7 +2232,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
                  uint16_t device_id, size_t config_size)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    const VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int i;
     int nvectors = k->query_nvectors ? k->query_nvectors(qbus->parent) : 0;
 
@@ -2475,7 +2475,7 @@ static void virtio_memory_listener_commit(MemoryListener *listener)
 static void virtio_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
     Error *err = NULL;
 
     /* Devices should either use vmsd or the load/save methods */
@@ -2502,7 +2502,7 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
 static void virtio_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
+    const VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
     Error *err = NULL;
 
     virtio_bus_device_unplugged(vdev);
diff --git a/io/channel.c b/io/channel.c
index cdf74540c1..1ced119375 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -52,7 +52,7 @@ ssize_t qio_channel_readv_full(QIOChannel *ioc,
                                size_t *nfds,
                                Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if ((fds || nfds) &&
         !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
@@ -72,7 +72,7 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
                                 size_t nfds,
                                 Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if ((fds || nfds) &&
         !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
@@ -127,7 +127,7 @@ int qio_channel_set_blocking(QIOChannel *ioc,
                               bool enabled,
                               Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
     return klass->io_set_blocking(ioc, enabled, errp);
 }
 
@@ -135,7 +135,7 @@ int qio_channel_set_blocking(QIOChannel *ioc,
 int qio_channel_close(QIOChannel *ioc,
                       Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
     return klass->io_close(ioc, errp);
 }
 
@@ -143,7 +143,7 @@ int qio_channel_close(QIOChannel *ioc,
 GSource *qio_channel_create_watch(QIOChannel *ioc,
                                   GIOCondition condition)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
     GSource *ret = klass->io_create_watch(ioc, condition);
 
     if (ioc->name) {
@@ -160,7 +160,7 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
                                     IOHandler *io_write,
                                     void *opaque)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
 }
@@ -189,7 +189,7 @@ int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if (!klass->io_shutdown) {
         error_setg(errp, "Data path shutdown not supported");
@@ -203,7 +203,7 @@ int qio_channel_shutdown(QIOChannel *ioc,
 void qio_channel_set_delay(QIOChannel *ioc,
                            bool enabled)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if (klass->io_set_delay) {
         klass->io_set_delay(ioc, enabled);
@@ -214,7 +214,7 @@ void qio_channel_set_delay(QIOChannel *ioc,
 void qio_channel_set_cork(QIOChannel *ioc,
                           bool enabled)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if (klass->io_set_cork) {
         klass->io_set_cork(ioc, enabled);
@@ -227,7 +227,7 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
                           int whence,
                           Error **errp)
 {
-    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+    const QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
     if (!klass->io_seek) {
         error_setg(errp, "Channel does not support random access");
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573656..f80b0ddf26 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1563,7 +1563,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
 
 static int kvm_init(MachineState *ms)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
     static const char upgrade_note[] =
         "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
         "(see http://sourceforge.net/projects/kvm).\n";
diff --git a/migration/migration.c b/migration/migration.c
index 54060f749a..84fdd5c0ac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1157,7 +1157,7 @@ void migrate_del_blocker(Error *reason)
 
 int check_migratable(Object *obj, Error **err)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+    const DeviceClass *dc = DEVICE_GET_CLASS(obj);
     if (only_migratable && dc->vmsd) {
         if (dc->vmsd->unmigratable) {
             error_setg(err, "Device %s is not migratable, but "
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a274..f8d00934ef 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -453,7 +453,7 @@ static void dump_vmstate_vmsd(FILE *out_file,
 
 static void dump_machine_type(FILE *out_file)
 {
-    MachineClass *mc;
+    const MachineClass *mc;
 
     mc = MACHINE_GET_CLASS(current_machine);
 
diff --git a/monitor.c b/monitor.c
index be282ecb80..5cc633c199 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4132,7 +4132,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     if (!mc->has_hotpluggable_cpus) {
         error_setg(errp, QERR_FEATURE_DISABLED, "query-hotpluggable-cpus");
diff --git a/net/filter.c b/net/filter.c
index 1dfd2caa23..121a5d7cfc 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -153,7 +153,7 @@ static char *netfilter_get_status(Object *obj, Error **errp)
 static void netfilter_set_status(Object *obj, const char *str, Error **errp)
 {
     NetFilterState *nf = NETFILTER(obj);
-    NetFilterClass *nfc = NETFILTER_GET_CLASS(obj);
+    const NetFilterClass *nfc = NETFILTER_GET_CLASS(obj);
 
     if (strcmp(str, "on") && strcmp(str, "off")) {
         error_setg(errp, "Invalid value for netfilter status, "
@@ -191,7 +191,7 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
 {
     NetFilterState *nf = NETFILTER(uc);
     NetClientState *ncs[MAX_QUEUE_NUM];
-    NetFilterClass *nfc = NETFILTER_GET_CLASS(uc);
+    const NetFilterClass *nfc = NETFILTER_GET_CLASS(uc);
     int queues;
     Error *local_err = NULL;
 
@@ -232,7 +232,7 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
 static void netfilter_finalize(Object *obj)
 {
     NetFilterState *nf = NETFILTER(obj);
-    NetFilterClass *nfc = NETFILTER_GET_CLASS(obj);
+    const NetFilterClass *nfc = NETFILTER_GET_CLASS(obj);
 
     if (nfc->cleanup) {
         nfc->cleanup(nf);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 339775e49d..f8091d6459 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -390,7 +390,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
     }
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
-        DeviceClass *dc = DEVICE_GET_CLASS(dev);
+        const DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
         if (qdev_class_has_alias(dc) &&
             strcmp(qdev_class_get_alias(dc), elem) == 0) {
@@ -402,7 +402,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
 
 static inline bool qbus_is_full(BusState *bus)
 {
-    BusClass *bus_class = BUS_GET_CLASS(bus);
+    const BusClass *bus_class = BUS_GET_CLASS(bus);
     return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
 }
 
@@ -664,7 +664,7 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
 
 static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int indent)
 {
-    BusClass *bc = BUS_GET_CLASS(bus);
+    const BusClass *bc = BUS_GET_CLASS(bus);
 
     if (bc->print_dev) {
         bc->print_dev(mon, dev, indent);
@@ -673,7 +673,7 @@ static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int ind
 
 static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
 {
-    ObjectClass *class;
+    const ObjectClass *class;
     BusState *child;
     NamedGPIOList *ngl;
 
diff --git a/qmp.c b/qmp.c
index fa82b598c6..eb8a1ae977 100644
--- a/qmp.c
+++ b/qmp.c
@@ -120,7 +120,7 @@ void qmp_cpu(int64_t index, Error **errp)
 
 void qmp_cpu_add(int64_t id, Error **errp)
 {
-    MachineClass *mc;
+    const MachineClass *mc;
 
     mc = MACHINE_GET_CLASS(current_machine);
     if (mc->hot_add_cpu) {
@@ -707,7 +707,7 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
     Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, &ambig);
 
     if (obj) {
-        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
+        const AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
         AcpiDeviceIf *adev = ACPI_DEVICE_IF(obj);
 
         adevc->ospm_status(adev, &prev);
diff --git a/qom/cpu.c b/qom/cpu.c
index f02e9c0fae..991f8cea64 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -36,7 +36,7 @@ bool cpu_exists(int64_t id)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
+        const CPUClass *cc = CPU_GET_CLASS(cpu);
 
         if (cc->get_arch_id(cpu) == id) {
             return true;
@@ -88,7 +88,7 @@ out:
 
 bool cpu_paging_enabled(const CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     return cc->get_paging_enabled(cpu);
 }
@@ -101,7 +101,7 @@ static bool cpu_common_get_paging_enabled(const CPUState *cpu)
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     cc->get_memory_mapping(cpu, list, errp);
 }
@@ -139,7 +139,7 @@ void cpu_exit(CPUState *cpu)
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     return (*cc->write_elf32_qemunote)(f, cpu, opaque);
 }
@@ -153,7 +153,7 @@ static int cpu_common_write_elf32_qemunote(WriteCoreDumpFunction f,
 int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     return (*cc->write_elf32_note)(f, cpu, cpuid, opaque);
 }
@@ -168,7 +168,7 @@ static int cpu_common_write_elf32_note(WriteCoreDumpFunction f,
 int cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     return (*cc->write_elf64_qemunote)(f, cpu, opaque);
 }
@@ -182,7 +182,7 @@ static int cpu_common_write_elf64_qemunote(WriteCoreDumpFunction f,
 int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     return (*cc->write_elf64_note)(f, cpu, cpuid, opaque);
 }
@@ -230,7 +230,7 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, int int_req)
 
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     GuestPanicInformation *res = NULL;
 
     if (cc->get_crash_info) {
@@ -242,7 +242,7 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                     int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->dump_state) {
         cpu_synchronize_state(cpu);
@@ -253,7 +253,7 @@ void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
 void cpu_dump_statistics(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->dump_statistics) {
         cc->dump_statistics(cpu, f, cpu_fprintf, flags);
@@ -262,7 +262,7 @@ void cpu_dump_statistics(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
 
 void cpu_reset(CPUState *cpu)
 {
-    CPUClass *klass = CPU_GET_CLASS(cpu);
+    const CPUClass *klass = CPU_GET_CLASS(cpu);
 
     if (klass->reset != NULL) {
         (*klass->reset)(cpu);
@@ -273,7 +273,7 @@ void cpu_reset(CPUState *cpu)
 
 static void cpu_common_reset(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const CPUClass *cc = CPU_GET_CLASS(cpu);
     int i;
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
@@ -383,7 +383,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
 static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
-    CPUClass *cc = CPU_GET_CLASS(obj);
+    const CPUClass *cc = CPU_GET_CLASS(obj);
 
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
diff --git a/qom/object.c b/qom/object.c
index a25b1fffad..41dae18420 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -993,7 +993,7 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
                                      Error **errp)
 {
     ObjectProperty *prop;
-    ObjectClass *klass = object_get_class(obj);
+    const ObjectClass *klass = object_get_class(obj);
 
     prop = object_class_property_find(klass, name, NULL);
     if (prop) {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index d4253a88de..c20c9043fa 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -8,7 +8,7 @@
 void user_creatable_complete(Object *obj, Error **errp)
 {
 
-    UserCreatableClass *ucc;
+    const UserCreatableClass *ucc;
     UserCreatable *uc =
         (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
 
@@ -25,7 +25,7 @@ void user_creatable_complete(Object *obj, Error **errp)
 bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
 {
 
-    UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
+    const UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
 
     if (ucc->can_be_deleted) {
         return ucc->can_be_deleted(uc, errp);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b4f97983e5..15d1ab4b80 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -58,7 +58,7 @@ static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
+    const AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 04b062cb7e..f943db7c73 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -117,7 +117,7 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
 static void arm_cpu_reset(CPUState *s)
 {
     ARMCPU *cpu = ARM_CPU(s);
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
+    const ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
     CPUARMState *env = &cpu->env;
 
     acc->parent_reset(s);
@@ -251,7 +251,7 @@ static void arm_cpu_reset(CPUState *s)
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cs->env_ptr;
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
@@ -333,7 +333,7 @@ static void arm_v7m_unassigned_access(CPUState *cpu, hwaddr addr,
 
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     bool ret = false;
@@ -648,7 +648,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     ARMCPU *cpu = ARM_CPU(dev);
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
+    const ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 45554682f2..8a2a71877e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -146,7 +146,7 @@ static void kvm_arm_host_cpu_class_init(ObjectClass *oc, void *data)
 
 static void kvm_arm_host_cpu_initfn(Object *obj)
 {
-    ARMHostCPUClass *ahcc = ARM_HOST_CPU_GET_CLASS(obj);
+    const ARMHostCPUClass *ahcc = ARM_HOST_CPU_GET_CLASS(obj);
     ARMCPU *cpu = ARM_CPU(obj);
     CPUARMState *env = &cpu->env;
 
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 5f766f09d6..b4e67fec56 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -45,7 +45,7 @@ static bool cris_cpu_has_work(CPUState *cs)
 static void cris_cpu_reset(CPUState *s)
 {
     CRISCPU *cpu = CRIS_CPU(s);
-    CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(cpu);
+    const CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(cpu);
     CPUCRISState *env = &cpu->env;
     uint32_t vr;
 
@@ -97,8 +97,8 @@ CRISCPU *cpu_cris_init(const char *cpu_model)
 /* Sort alphabetically by VR. */
 static gint cris_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
-    CRISCPUClass *ccc_a = CRIS_CPU_CLASS(a);
-    CRISCPUClass *ccc_b = CRIS_CPU_CLASS(b);
+    const CRISCPUClass *ccc_a = CRIS_CPU_CLASS(a);
+    const CRISCPUClass *ccc_b = CRIS_CPU_CLASS(b);
 
     /*  */
     if (ccc_a->vr > ccc_b->vr) {
@@ -140,7 +140,7 @@ void cris_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(dev);
+    const CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -188,7 +188,7 @@ static void cris_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     CRISCPU *cpu = CRIS_CPU(obj);
-    CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
+    const CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
     CPUCRISState *env = &cpu->env;
     static bool tcg_initialized;
 
diff --git a/target/cris/helper.c b/target/cris/helper.c
index af78cca8b9..3219063334 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -289,7 +289,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     bool ret = false;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1d791d0f80..6b227095fa 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -52,7 +52,7 @@ static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
+    const HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b1d6252ae0..2234049de3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3021,7 +3021,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 static void x86_cpu_reset(CPUState *s)
 {
     X86CPU *cpu = X86_CPU(s);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
+    const X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
     target_ulong cr4;
     uint64_t xcr0;
@@ -3479,7 +3479,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     X86CPU *cpu = X86_CPU(dev);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+    const X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
     static bool ht_warned;
@@ -3671,7 +3671,7 @@ out:
 static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 {
     X86CPU *cpu = X86_CPU(dev);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
+    const X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
@@ -3838,7 +3838,7 @@ static void x86_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     X86CPU *cpu = X86_CPU(obj);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
+    const X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
     CPUX86State *env = &cpu->env;
     FeatureWord w;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865dbee0..7584d65dfe 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3468,7 +3468,7 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     if (iommu) {
         int ret;
         MSIMessage src, dst;
-        X86IOMMUClass *class = X86_IOMMU_GET_CLASS(iommu);
+        const X86IOMMUClass *class = X86_IOMMU_GET_CLASS(iommu);
 
         src.address = route->u.msi.address_hi;
         src.address <<= VTD_MSI_ADDR_HI_SHIFT;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 5b9eb3a2f6..5eae5949b5 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -893,7 +893,7 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(qdev_get_machine());
+    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(qdev_get_machine());
     return env->tsc_khz && pcmc->save_tsc_khz;
 }
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 2b8c36b6d0..0ad15f5ac5 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -122,7 +122,7 @@ static bool lm32_cpu_has_work(CPUState *cs)
 static void lm32_cpu_reset(CPUState *s)
 {
     LM32CPU *cpu = LM32_CPU(s);
-    LM32CPUClass *lcc = LM32_CPU_GET_CLASS(cpu);
+    const LM32CPUClass *lcc = LM32_CPU_GET_CLASS(cpu);
     CPULM32State *env = &cpu->env;
 
     lcc->parent_reset(s);
@@ -142,7 +142,7 @@ static void lm32_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    LM32CPUClass *lcc = LM32_CPU_GET_CLASS(dev);
+    const LM32CPUClass *lcc = LM32_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index cf929dd392..066c96fb04 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -55,7 +55,7 @@ int lm32_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 int lm32_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     LM32CPU *cpu = LM32_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPULM32State *env = &cpu->env;
     uint32_t tmp;
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fa10b6e4cd..94c57a6d4c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -47,7 +47,7 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
 static void m68k_cpu_reset(CPUState *s)
 {
     M68kCPU *cpu = M68K_CPU(s);
-    M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
+    const M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
     CPUM68KState *env = &cpu->env;
 
     mcc->parent_reset(s);
@@ -218,7 +218,7 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     M68kCPU *cpu = M68K_CPU(dev);
-    M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
+    const M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 3d58869716..1782713c91 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -98,7 +98,7 @@ static void microblaze_cpu_set_irq(void *opaque, int irq, int level)
 static void mb_cpu_reset(CPUState *s)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(s);
-    MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(cpu);
+    const MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(cpu);
     CPUMBState *env = &cpu->env;
 
     mcc->parent_reset(s);
@@ -132,7 +132,7 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(dev);
+    const MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(dev);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     uint8_t version_code = 0;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 7fb076c2e9..e59bd6aaa7 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -38,7 +38,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPUMBState *env = &cpu->env;
     uint32_t tmp;
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1bb66b7a5a..5554632a45 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -95,7 +95,7 @@ static bool mips_cpu_has_work(CPUState *cs)
 static void mips_cpu_reset(CPUState *s)
 {
     MIPSCPU *cpu = MIPS_CPU(s);
-    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
+    const MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
     CPUMIPSState *env = &cpu->env;
 
     mcc->parent_reset(s);
@@ -122,7 +122,7 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
+    const MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 927b1a1e44..281714e8bc 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -40,7 +40,7 @@ static bool moxie_cpu_has_work(CPUState *cs)
 static void moxie_cpu_reset(CPUState *s)
 {
     MoxieCPU *cpu = MOXIE_CPU(s);
-    MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(cpu);
+    const MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(cpu);
     CPUMoxieState *env = &cpu->env;
 
     mcc->parent_reset(s);
@@ -58,7 +58,7 @@ static void moxie_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(dev);
+    const MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index d56bb7245a..331758eada 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -43,7 +43,7 @@ static bool nios2_cpu_has_work(CPUState *cs)
 static void nios2_cpu_reset(CPUState *cs)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
-    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
+    const Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
     CPUNios2State *env = &cpu->env;
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
@@ -95,7 +95,7 @@ Nios2CPU *cpu_nios2_init(const char *cpu_model)
 static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
+    const Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -139,7 +139,7 @@ static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPUNios2State *env = &cpu->env;
 
     if (n > cc->gdb_num_core_regs) {
@@ -161,7 +161,7 @@ static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 static int nios2_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPUNios2State *env = &cpu->env;
 
     if (n > cc->gdb_num_core_regs) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 7fd2b9a216..b0e545d572 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -40,7 +40,7 @@ static bool openrisc_cpu_has_work(CPUState *cs)
 static void openrisc_cpu_reset(CPUState *s)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(s);
-    OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(cpu);
+    const OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(cpu);
 
     occ->parent_reset(s);
 
@@ -74,7 +74,7 @@ static inline void set_feature(OpenRISCCPU *cpu, int feature)
 static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
+    const OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index b18c7e9f05..a78a8e61e4 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -50,7 +50,7 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    const CPUClass *cc = CPU_GET_CLASS(cs);
     CPUOpenRISCState *env = &cpu->env;
     uint32_t tmp;
 
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 28d9cc7d79..9d2d226dd9 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -225,7 +225,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index e8ec1e19e7..e43d58f325 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -85,7 +85,7 @@ static const CompatInfo *compat_by_pvr(uint32_t pvr)
 bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
                       uint32_t min_compat_pvr, uint32_t max_compat_pvr)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     const CompatInfo *compat = compat_by_pvr(compat_pvr);
     const CompatInfo *min = compat_by_pvr(min_compat_pvr);
     const CompatInfo *max = compat_by_pvr(max_compat_pvr);
@@ -115,7 +115,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 {
     const CompatInfo *compat = compat_by_pvr(compat_pvr);
     CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     uint64_t pcr;
 
     if (!compat_pvr) {
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f4ee7aacd2..b51dc2da45 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -314,7 +314,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
 
         /* "PAPR mode" built-in hypercall emulation */
         if ((lev == 1) && cpu->vhyp) {
-            PPCVirtualHypervisorClass *vhc =
+            const PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
             return;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 14d34e512f..c895543fbd 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -422,7 +422,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
     const ppc_hash_pte64_t *hptes;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
+        const PPCVirtualHypervisorClass *vhc =
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         return vhc->map_hptes(cpu->vhyp, ptex, n);
     }
@@ -442,7 +442,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n)
 {
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
+        const PPCVirtualHypervisorClass *vhc =
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
         return;
@@ -922,7 +922,7 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
     hwaddr offset = ptex * HASH_PTE_SIZE_64;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
+        const PPCVirtualHypervisorClass *vhc =
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
         return;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 65d1c8692d..64f12db168 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2902,7 +2902,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
               int mmu_idx, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     CPUPPCState *env = &cpu->env;
     int ret;
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index ee8ff04fd2..de6f7e0be8 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9049,7 +9049,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 /* Generic CPU instantiation routine                                         */
 static void init_ppc_proc(PowerPCCPU *cpu)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 #if !defined(CONFIG_USER_ONLY)
     int i;
@@ -9471,7 +9471,7 @@ static void fix_opcode_tables (opc_handler_t **ppc_opcodes)
 /*****************************************************************************/
 static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
     opcode_t *opc;
 
@@ -9788,7 +9788,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 #if !defined(CONFIG_USER_ONLY)
     int max_smt = kvmppc_smt_threads();
@@ -10036,7 +10036,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
 static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(dev);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
     Error *local_err = NULL;
     opc_handler_t **table, **table_2;
@@ -10412,7 +10412,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
 static void ppc_cpu_reset(CPUState *s)
 {
     PowerPCCPU *cpu = POWERPC_CPU(s);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr;
     int i;
@@ -10503,7 +10503,7 @@ static void ppc_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     PowerPCCPU *cpu = POWERPC_CPU(obj);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 
     cs->env_ptr = env;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 07eb8b745f..b862c914af 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -75,7 +75,7 @@ static void s390_cpu_load_normal(CPUState *s)
 static void s390_cpu_reset(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
 
     env->pfault_token = -1UL;
@@ -123,7 +123,7 @@ static void s390_cpu_initial_reset(CPUState *s)
 static void s390_cpu_full_reset(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
     int i;
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1434d15315..b904083871 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -716,7 +716,7 @@ static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
 
 void s390_realize_cpu_model(CPUState *cs, Error **errp)
 {
-    S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
+    const S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
     S390CPU *cpu = S390_CPU(cs);
     const S390CPUModel *max_model;
 
@@ -886,7 +886,7 @@ void s390_cpu_model_register_props(Object *obj)
 static void s390_cpu_model_initfn(Object *obj)
 {
     S390CPU *cpu = S390_CPU(obj);
-    S390CPUClass *xcc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *xcc = S390_CPU_GET_CLASS(cpu);
 
     cpu->model = g_malloc0(sizeof(*cpu->model));
     /* copy the model, so we can modify it */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac47154b83..cb9f368099 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1620,7 +1620,7 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
 static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
@@ -1632,7 +1632,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 675aba2e44..16782c9ae1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -944,7 +944,7 @@ uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
 uint64_t HELPER(iske)(CPUS390XState *env, uint64_t r2)
 {
     static S390SKeysState *ss;
-    static S390SKeysClass *skeyclass;
+    static const S390SKeysClass *skeyclass;
     uint64_t addr = get_address(env, 0, 0, r2);
     uint8_t key;
 
@@ -967,7 +967,7 @@ uint64_t HELPER(iske)(CPUS390XState *env, uint64_t r2)
 void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     static S390SKeysState *ss;
-    static S390SKeysClass *skeyclass;
+    static const S390SKeysClass *skeyclass;
     uint64_t addr = get_address(env, 0, 0, r2);
     uint8_t key;
 
@@ -988,7 +988,7 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t r2)
 {
     static S390SKeysState *ss;
-    static S390SKeysClass *skeyclass;
+    static const S390SKeysClass *skeyclass;
     uint8_t re, key;
 
     if (r2 > ram_size) {
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 93b0e61366..cbbd16eac5 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -124,7 +124,7 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 #ifndef CONFIG_USER_ONLY
 static int modified_clear_reset(S390CPU *cpu)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUState *t;
 
     pause_all_vcpus();
@@ -143,7 +143,7 @@ static int modified_clear_reset(S390CPU *cpu)
 
 static int load_normal_reset(S390CPU *cpu)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    const S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUState *t;
 
     pause_all_vcpus();
@@ -167,7 +167,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
     uint64_t action = env->regs[r3];
     Object *obj;
     DIAG288State *diag288;
-    DIAG288Class *diag288_class;
+    const DIAG288Class *diag288_class;
 
     if (r1 % 2 || action != 0) {
         return -1;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b11a02706c..56570a6879 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -313,7 +313,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc)
 {
     static S390SKeysState *ss;
-    static S390SKeysClass *skeyclass;
+    static const S390SKeysClass *skeyclass;
     int r = -1;
     uint8_t key;
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9a481c35dc..11da19d62f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -51,7 +51,7 @@ static bool superh_cpu_has_work(CPUState *cs)
 static void superh_cpu_reset(CPUState *s)
 {
     SuperHCPU *cpu = SUPERH_CPU(s);
-    SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(cpu);
+    const SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(cpu);
     CPUSH4State *env = &cpu->env;
 
     scc->parent_reset(s);
@@ -242,7 +242,7 @@ static const TypeInfo sh7785_type_info = {
 static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
+    const SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d606eb53f4..188f544290 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -31,7 +31,7 @@ static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char *cpu_model);
 static void sparc_cpu_reset(CPUState *s)
 {
     SPARCCPU *cpu = SPARC_CPU(s);
-    SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(cpu);
+    const SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(cpu);
     CPUSPARCState *env = &cpu->env;
 
     scc->parent_reset(s);
@@ -799,7 +799,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
 static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
+    const SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 #if defined(CONFIG_USER_ONLY)
     SPARCCPU *cpu = SPARC_CPU(dev);
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index d90e38e88c..71d9c23e03 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -79,7 +79,7 @@ static bool tilegx_cpu_has_work(CPUState *cs)
 static void tilegx_cpu_reset(CPUState *s)
 {
     TileGXCPU *cpu = TILEGX_CPU(s);
-    TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(cpu);
+    const TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(cpu);
     CPUTLGState *env = &cpu->env;
 
     tcc->parent_reset(s);
@@ -90,7 +90,7 @@ static void tilegx_cpu_reset(CPUState *s)
 static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(dev);
+    const TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 08f50e2ba7..73a3dd436d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -48,7 +48,7 @@ static void tricore_cpu_synchronize_from_tb(CPUState *cs,
 static void tricore_cpu_reset(CPUState *s)
 {
     TriCoreCPU *cpu = TRICORE_CPU(s);
-    TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(cpu);
+    const TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(cpu);
     CPUTriCoreState *env = &cpu->env;
 
     tcc->parent_reset(s);
@@ -65,7 +65,7 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     TriCoreCPU *cpu = TRICORE_CPU(dev);
-    TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(dev);
+    const TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(dev);
     CPUTriCoreState *env = &cpu->env;
     Error *local_err = NULL;
 
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index c9b78ce68e..a10881be88 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -102,7 +102,7 @@ static const UniCore32CPUInfo uc32_cpus[] = {
 static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    UniCore32CPUClass *ucc = UNICORE32_CPU_GET_CLASS(dev);
+    const UniCore32CPUClass *ucc = UNICORE32_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index cd7f95823f..4500f7f556 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -54,7 +54,7 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 static void xtensa_cpu_reset(CPUState *s)
 {
     XtensaCPU *cpu = XTENSA_CPU(s);
-    XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(cpu);
+    const XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(cpu);
     CPUXtensaState *env = &cpu->env;
 
     xcc->parent_reset(s);
@@ -100,7 +100,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
+    const XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -120,7 +120,7 @@ static void xtensa_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     XtensaCPU *cpu = XTENSA_CPU(obj);
-    XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
+    const XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
     CPUXtensaState *env = &cpu->env;
     static bool tcg_inited;
 
diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
index f87c9aaa8a..42ff3aa5a7 100644
--- a/tests/check-qom-interface.c
+++ b/tests/check-qom-interface.c
@@ -72,7 +72,7 @@ static void test_interface_impl(const char *type)
 {
     Object *obj = object_new(type);
     TestIf *iobj = TEST_IF(obj);
-    TestIfClass *ioc = TEST_IF_GET_CLASS(iobj);
+    const TestIfClass *ioc = TEST_IF_GET_CLASS(iobj);
 
     g_assert(iobj);
     g_assert(ioc->test == PATTERN);
diff --git a/user-exec.c b/user-exec.c
index a8f95fa1e1..177c764385 100644
--- a/user-exec.c
+++ b/user-exec.c
@@ -58,7 +58,7 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
                                     int is_write, sigset_t *old_set)
 {
     CPUState *cpu = current_cpu;
-    CPUClass *cc;
+    const CPUClass *cc;
     int ret;
 
     /* For synchronous signals we expect to be coming from the vCPU
diff --git a/vl.c b/vl.c
index 0b4ed5241c..fba5a16aad 100644
--- a/vl.c
+++ b/vl.c
@@ -1687,7 +1687,7 @@ static int qemu_debug_requested(void)
 
 void qemu_system_reset(bool report)
 {
-    MachineClass *mc;
+    const MachineClass *mc;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
-- 
2.11.0.259.g40922b1
