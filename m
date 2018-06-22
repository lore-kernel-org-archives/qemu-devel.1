Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcw-0007gn-1l
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcu-0003Y3-OQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:18 +1000
Message-Id: <20180622042437.14259-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 04/23] spapr_cpu_core: migrate VPA related state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

QEMU implements the "Shared Processor LPAR" (SPLPAR) option, which allows
the hypervisor to time-slice a physical processor into multiple virtual
processor. The intent is to allow more guests to run, and to optimize
processor utilization.

The guest OS can cede idle VCPUs, so that their processing capacity may
be used by other VCPUs, with the H_CEDE hcall. The guest OS can also
optimize spinlocks, by confering the time-slice of a spinning VCPU to the
spinlock holder if it's currently notrunning, with the H_CONFER hcall.

Both hcalls depend on a "Virtual Processor Area" (VPA) to be registered
by the guest OS, generally during early boot. Other per-VCPU areas can
be registered: the "SLB Shadow Buffer" which allows a more efficient
dispatching of VCPUs, and the "Dispatch Trace Log Buffer" (DTL) which
is used to compute time stolen by the hypervisor. Both DTL and SLB Shadow
areas depend on the VPA to be registered.

The VPA/SLB Shadow/DTL are state that QEMU should migrate, but this doesn't
happen, for no apparent reason other than it was just never coded. This
causes the features listed above to stop working after migration, and it
breaks the logic of the H_REGISTER_VPA hcall in the destination.

The VPA is set at the guest request, ie, we don't have to migrate
it before the guest has actually set it. This patch hence adds an
"spapr_cpu/vpa" subsection to the recently introduced per-CPU machine
data migration stream.

Since DTL and SLB Shadow are optional and both depend on VPA, they get
their own subsections "spapr_cpu/vpa/slb_shadow" and "spapr_cpu/vpa/dtl"
hanging from the "spapr_cpu/vpa" subsection.

Note that this won't break migration to older QEMUs. Is is already handled
by only registering the vmstate handler for per-CPU data with newer machine
types.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f129ac884e..67f1596c57 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -129,6 +129,67 @@ static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
     g_free(sc->threads);
 }
 
+static bool slb_shadow_needed(void *opaque)
+{
+    sPAPRCPUState *spapr_cpu = opaque;
+
+    return spapr_cpu->slb_shadow_addr != 0;
+}
+
+static const VMStateDescription vmstate_spapr_cpu_slb_shadow = {
+    .name = "spapr_cpu/vpa/slb_shadow",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = slb_shadow_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(slb_shadow_addr, sPAPRCPUState),
+        VMSTATE_UINT64(slb_shadow_size, sPAPRCPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool dtl_needed(void *opaque)
+{
+    sPAPRCPUState *spapr_cpu = opaque;
+
+    return spapr_cpu->dtl_addr != 0;
+}
+
+static const VMStateDescription vmstate_spapr_cpu_dtl = {
+    .name = "spapr_cpu/vpa/dtl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = dtl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(dtl_addr, sPAPRCPUState),
+        VMSTATE_UINT64(dtl_size, sPAPRCPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vpa_needed(void *opaque)
+{
+    sPAPRCPUState *spapr_cpu = opaque;
+
+    return spapr_cpu->vpa_addr != 0;
+}
+
+static const VMStateDescription vmstate_spapr_cpu_vpa = {
+    .name = "spapr_cpu/vpa",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vpa_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(vpa_addr, sPAPRCPUState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_spapr_cpu_slb_shadow,
+        &vmstate_spapr_cpu_dtl,
+        NULL
+    }
+};
+
 static const VMStateDescription vmstate_spapr_cpu_state = {
     .name = "spapr_cpu",
     .version_id = 1,
@@ -136,6 +197,10 @@ static const VMStateDescription vmstate_spapr_cpu_state = {
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_spapr_cpu_vpa,
+        NULL
+    }
 };
 
 static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-- 
2.17.1
