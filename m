Received: from eggs.gnu.org ([209.51.188.92]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08Y-0005dR-Nu
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08U-0006Xl-FY
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:33 +1100
Message-Id: <20190108224600.23125-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/29] ppc/spapr: Receive and store device tree
 blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

SLOF receives a device tree and updates it with various properties
before switching to the guest kernel and QEMU is not aware of any changes
made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
sense to pass the SLOF final device tree to QEMU to let it implement
RTAS related tasks better, such as PCI host bus adapter hotplug.

Specifially, now QEMU can find out the actual XICS phandle (for PHB
hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
assisted NMI - FWNMI).

This stores the initial DT blob in the sPAPR machine and replaces it
in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.

This adds an @update_dt_enabled machine property to allow backward
migration.

SLOF already has a hypercall since
https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183

This makes use of the new fdt_check_full() helper. In order to allow
the configure script to pick the correct DTC version, this adjusts
the DTC presense test.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 configure              |  2 +-
 hw/ppc/spapr.c         | 43 +++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c   | 42 +++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  3 +++
 include/hw/ppc/spapr.h |  7 ++++++-
 5 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index b9f34afc9e..8049b71eef 100755
--- a/configure
+++ b/configure
@@ -3939,7 +3939,7 @@ if test "$fdt" !=3D "no" ; then
   cat > $TMPC << EOF
 #include <libfdt.h>
 #include <libfdt_env.h>
-int main(void) { fdt_first_subnode(0, 0); return 0; }
+int main(void) { fdt_check_full(NULL, 0); return 0; }
 EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5fba04e7b2..7e61f1e5ff 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1669,7 +1669,10 @@ static void spapr_machine_reset(void)
     /* Load the fdt */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
-    g_free(fdt);
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size =3D fdt_totalsize(fdt);
+    spapr->fdt_initial_size =3D spapr->fdt_size;
+    spapr->fdt_blob =3D fdt;
=20
     /* Set up the entry state */
     spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
@@ -1920,6 +1923,39 @@ static const VMStateDescription vmstate_spapr_irq_=
map =3D {
     },
 };
=20
+static bool spapr_dtb_needed(void *opaque)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
+
+    return smc->update_dt_enabled;
+}
+
+static int spapr_dtb_pre_load(void *opaque)
+{
+    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_blob =3D NULL;
+    spapr->fdt_size =3D 0;
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_spapr_dtb =3D {
+    .name =3D "spapr_dtb",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D spapr_dtb_needed,
+    .pre_load =3D spapr_dtb_pre_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
+        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NUL=
L,
+                                     fdt_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr =3D {
     .name =3D "spapr",
     .version_id =3D 3,
@@ -1949,6 +1985,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_ibs,
         &vmstate_spapr_irq_map,
         &vmstate_spapr_cap_nested_kvm_hv,
+        &vmstate_spapr_dtb,
         NULL
     }
 };
@@ -3931,6 +3968,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     hc->unplug =3D spapr_machine_device_unplug;
=20
     smc->dr_lmb_enabled =3D true;
+    smc->update_dt_enabled =3D true;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
@@ -4023,9 +4061,12 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
  */
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_4_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len)=
;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+    smc->update_dt_enabled =3D false;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f131c7e04c..1ae3e6ff5e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1753,6 +1753,46 @@ static target_ulong h_get_cpu_characteristics(Powe=
rPCCPU *cpu,
=20
     args[0] =3D characteristics;
     args[1] =3D behaviour;
+    return H_SUCCESS;
+}
+
+static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+                                target_ulong opcode, target_ulong *args)
+{
+    target_ulong dt =3D ppc64_phys_to_real(args[0]);
+    struct fdt_header hdr =3D { 0 };
+    unsigned cb;
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    void *fdt;
+
+    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    cb =3D fdt32_to_cpu(hdr.totalsize);
+
+    if (!smc->update_dt_enabled) {
+        return H_SUCCESS;
+    }
+
+    /* Check that the fdt did not grow out of proportion */
+    if (cb > spapr->fdt_initial_size * 2) {
+        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
+                                          fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }
+
+    fdt =3D g_malloc0(cb);
+    cpu_physical_memory_read(dt, fdt, cb);
+
+    /* Check the fdt consistency */
+    if (fdt_check_full(fdt, cb)) {
+        trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
+                                           fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size =3D cb;
+    spapr->fdt_blob =3D fdt;
+    trace_spapr_update_dt(cb);
=20
     return H_SUCCESS;
 }
@@ -1859,6 +1899,8 @@ static void hypercall_register_types(void)
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
=20
+    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
+
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
                              h_home_node_associativity);
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index dc5e65aee9..0af155ed32 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -22,6 +22,9 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "=
current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x%"=
PRIx64", shift=3D%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=3D0x%"P=
RIx64", shift=3D%"PRIu64
+spapr_update_dt(unsigned cb) "New blob %u bytes"
+spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned mag=
ic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
+spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
=20
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId=
64
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index eb04300d3b..fd24e91bd8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -103,6 +103,7 @@ struct sPAPRMachineClass {
=20
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
+    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
@@ -139,6 +140,9 @@ struct sPAPRMachineState {
     int vrma_adjust;
     ssize_t rtas_size;
     void *rtas_blob;
+    uint32_t fdt_size;
+    uint32_t fdt_initial_size;
+    void *fdt_blob;
     long kernel_size;
     bool kernel_le;
     uint32_t initrd_base;
@@ -481,7 +485,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
=20
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
--=20
2.20.1
