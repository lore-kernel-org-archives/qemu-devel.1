Received: from eggs.gnu.org ([2001:4830:134:3::10]:44244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iu-0005V0-GA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8io-000857-AL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8io-00084e-05
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JELIB126891
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:01 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1fbv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:00 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:00 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:59 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-39-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/54] spapr: Capabilities infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

Because PAPR is a paravirtual environment access to certain CPU (or other)
facilities can be blocked by the hypervisor.  PAPR provides ways to
advertise in the device tree whether or not those features are available to
the guest.

In some places we automatically determine whether to make a feature
available based on whether our host can support it, in most cases this is
based on limitations in the available KVM implementation.

Although we correctly advertise this to the guest, it means that host
factors might make changes to the guest visible environment which is bad:
as well as generaly reducing reproducibility, it means that a migration
between different host environments can easily go bad.

We've mostly gotten away with it because the environments considered mature
enough to be well supported (basically, KVM on POWER8) have had consistent
feature availability.  But, it's still not right and some limitations on
POWER9 is going to make it more of an issue in future.

This introduces an infrastructure for defining "sPAPR capabilities".  These
are set by default based on the machine version, masked by the capabilities
of the chosen cpu, but can be overriden with machine properties.

The intention is at reset time we verify that the requested capabilities
can be supported on the host (considering TCG, KVM and/or host cpu
limitations).  If not we simply fail, rather than silently modifying the
advertised featureset to the guest.

This does mean that certain configurations that "worked" may now fail, but
such configurations were already more subtly broken.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 33face6b8981add8eba1f7cdaf4cf6cede415d2e)
 Conflicts:
	include/hw/ppc/spapr.h
*drop context dep on 60c6823b9bc
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/Makefile.objs   |   2 +-
 hw/ppc/spapr.c         |   7 ++
 hw/ppc/spapr_caps.c    | 181 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  31 +++++++++
 4 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_caps.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 7efc686748..1faff853b7 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,7 +1,7 @@
 # shared objects
 obj-y += ppc.o ppc_booke.o fdt.o
 # IBM pSeries (sPAPR)
-obj-$(CONFIG_PSERIES) += spapr.o spapr_vio.o spapr_events.o
+obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bedc39a2e5..958d894add 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1440,6 +1440,8 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
+    spapr_caps_reset(spapr);
+
     first_ppc_cpu = POWERPC_CPU(first_cpu);
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
         ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
@@ -2285,6 +2287,8 @@ static void ppc_spapr_init(MachineState *machine)
     char *filename;
     Error *resize_hpt_err = NULL;
 
+    spapr_caps_validate(spapr, &error_fatal);
+
     msi_nonbroken = true;
 
     QLIST_INIT(&spapr->phbs);
@@ -3665,6 +3669,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      * in which LMBs are represented and hot-added
      */
     mc->numa_mem_align_shift = 28;
+
+    smc->default_caps = spapr_caps(0);
+    spapr_caps_add_properties(smc, &error_abort);
 }
 
 static const TypeInfo spapr_machine_info = {
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
new file mode 100644
index 0000000000..968ba7b857
--- /dev/null
+++ b/hw/ppc/spapr_caps.c
@@ -0,0 +1,181 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition capabilities handling
+ *
+ * Copyright (c) 2017 David Gibson, Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+
+#include "hw/ppc/spapr.h"
+
+typedef struct sPAPRCapabilityInfo {
+    const char *name;
+    const char *description;
+    uint64_t flag;
+
+    /* Make sure the virtual hardware can support this capability */
+    void (*allow)(sPAPRMachineState *spapr, Error **errp);
+
+    /* If possible, tell the virtual hardware not to allow the cap to
+     * be used at all */
+    void (*disallow)(sPAPRMachineState *spapr, Error **errp);
+} sPAPRCapabilityInfo;
+
+static sPAPRCapabilityInfo capability_table[] = {
+};
+
+static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
+                                               CPUState *cs)
+{
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    sPAPRCapabilities caps;
+
+    caps = smc->default_caps;
+
+    /* TODO: clamp according to cpu model */
+
+    return caps;
+}
+
+void spapr_caps_reset(sPAPRMachineState *spapr)
+{
+    Error *local_err = NULL;
+    sPAPRCapabilities caps;
+    int i;
+
+    /* First compute the actual set of caps we're running with.. */
+    caps = default_caps_with_cpu(spapr, first_cpu);
+
+    caps.mask |= spapr->forced_caps.mask;
+    caps.mask &= ~spapr->forbidden_caps.mask;
+
+    spapr->effective_caps = caps;
+
+    /* .. then apply those caps to the virtual hardware */
+
+    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
+        sPAPRCapabilityInfo *info = &capability_table[i];
+
+        if (spapr->effective_caps.mask & info->flag) {
+            /* Failure to allow a cap is fatal - if the guest doesn't
+             * have it, we'll be supplying an incorrect environment */
+            if (info->allow) {
+                info->allow(spapr, &error_fatal);
+            }
+        } else {
+            /* Failure to enforce a cap is only a warning.  The guest
+             * shouldn't be using it, since it's not advertised, so it
+             * doesn't get to complain about weird behaviour if it
+             * goes ahead anyway */
+            if (info->disallow) {
+                info->disallow(spapr, &local_err);
+            }
+            if (local_err) {
+                warn_report_err(local_err);
+                local_err = NULL;
+            }
+        }
+    }
+}
+
+static void spapr_cap_get(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    bool value = spapr_has_cap(spapr, cap->flag);
+
+    /* TODO: Could this get called before effective_caps is finalized
+     * in spapr_caps_reset()? */
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void spapr_cap_set(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    bool value;
+    Error *local_err = NULL;
+
+    visit_type_bool(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (value) {
+        spapr->forced_caps.mask |= cap->flag;
+    } else {
+        spapr->forbidden_caps.mask |= cap->flag;
+    }
+}
+
+void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp)
+{
+    uint64_t allcaps = 0;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
+        g_assert((allcaps & capability_table[i].flag) == 0);
+        allcaps |= capability_table[i].flag;
+    }
+
+    g_assert((spapr->forced_caps.mask & ~allcaps) == 0);
+    g_assert((spapr->forbidden_caps.mask & ~allcaps) == 0);
+
+    if (spapr->forced_caps.mask & spapr->forbidden_caps.mask) {
+        error_setg(errp, "Some sPAPR capabilities set both on and off");
+        return;
+    }
+
+    /* Check for any caps incompatible with other caps.  Nothing to do
+     * yet */
+}
+
+void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
+{
+    Error *local_err = NULL;
+    ObjectClass *klass = OBJECT_CLASS(smc);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
+        sPAPRCapabilityInfo *cap = &capability_table[i];
+        const char *name = g_strdup_printf("cap-%s", cap->name);
+
+        object_class_property_add(klass, name, "bool",
+                                  spapr_cap_get, spapr_cap_set, NULL,
+                                  cap, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        object_class_property_set_description(klass, name, cap->description,
+                                              &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d21ca9bde..c8852dfbba 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -51,6 +51,15 @@ typedef enum {
 } sPAPRResizeHPT;
 
 /**
+ * Capabilities
+ */
+
+typedef struct sPAPRCapabilities sPAPRCapabilities;
+struct sPAPRCapabilities {
+    uint64_t mask;
+};
+
+/**
  * sPAPRMachineClass:
  */
 struct sPAPRMachineClass {
@@ -66,6 +75,7 @@ struct sPAPRMachineClass {
                           hwaddr *mmio32, hwaddr *mmio64,
                           unsigned n_dma, uint32_t *liobns, Error **errp);
     sPAPRResizeHPT resize_hpt_default;
+    sPAPRCapabilities default_caps;
 };
 
 /**
@@ -127,6 +137,9 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
 
     const char *icp_type;
+
+    sPAPRCapabilities forced_caps, forbidden_caps;
+    sPAPRCapabilities effective_caps;
 };
 
 #define H_SUCCESS         0
@@ -707,4 +720,22 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 int spapr_vcpu_id(PowerPCCPU *cpu);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
+/*
+ * Handling of optional capabilities
+ */
+static inline sPAPRCapabilities spapr_caps(uint64_t mask)
+{
+    sPAPRCapabilities caps = { mask };
+    return caps;
+}
+
+static inline bool spapr_has_cap(sPAPRMachineState *spapr, uint64_t cap)
+{
+    return !!(spapr->effective_caps.mask & cap);
+}
+
+void spapr_caps_reset(sPAPRMachineState *spapr);
+void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp);
+void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
+
 #endif /* HW_SPAPR_H */
-- 
2.11.0
