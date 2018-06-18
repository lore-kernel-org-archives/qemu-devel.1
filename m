Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm3-0008OU-Lz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm1-0001RO-Ps
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:36:02 +1000
Message-Id: <20180618063606.2513-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 5/9] spapr: Maximum (HPT) pagesize property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The way the POWER Hash Page Table (HPT) MMU is virtualized by KVM HV means
that every page that the guest puts in the pagetables must be truly
physically contiguous, not just GPA-contiguous.  In effect this means that
an HPT guest can't use any pagesizes greater than the host page size used
to back its memory.

At present we handle this by changing what we advertise to the guest based
on the backing pagesizes.  This is pretty bad, because it means the guest
sees a different environment depending on what should be host configuration
details.

As a start on fixing this, we add a new capability parameter to the pseries
machine type which gives the maximum allowed pagesizes for an HPT guest (as
a shift).  For now we just create and validate the parameter without making
it do anything.

For backwards compatibility, on older machine types we set it to the max
available page size for the host.  For the 3.0 machine type, we fix it to
16, the intention being to only allow HPT pagesizes up to 64kiB by default
in future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 12 +++++++++
 hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  4 ++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 40858d047c..74a76e7e09 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -63,6 +63,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -4043,6 +4044,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     spapr_caps_add_properties(smc, &error_abort);
 }
 
@@ -4126,8 +4128,18 @@ static void spapr_machine_2_12_instance_options(MachineState *machine)
 
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+    uint8_t mps;
+
     spapr_machine_3_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
+
+    if (kvmppc_hpt_needs_host_contiguous_pages()) {
+        mps = ctz64(qemu_getrampagesize());
+    } else {
+        mps = 34; /* allow everything up to 16GiB, i.e. everything */
+    }
+    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
 }
 
 DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 68a4243efc..6cdc0c94e7 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
 #include "target/ppc/cpu.h"
+#include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
 #include "kvm_ppc.h"
 
@@ -144,6 +145,42 @@ out:
     g_free(val);
 }
 
+static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    uint8_t val = spapr_get_cap(spapr, cap->index);
+    uint64_t pagesize = (1ULL << val);
+
+    visit_type_size(v, name, &pagesize, errp);
+}
+
+static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    uint64_t pagesize;
+    uint8_t val;
+    Error *local_err = NULL;
+
+    visit_type_size(v, name, &pagesize, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!is_power_of_2(pagesize)) {
+        error_setg(errp, "cap-%s must be a power of 2", cap->name);
+        return;
+    }
+
+    val = ctz64(pagesize);
+    spapr->cmd_line_caps[cap->index] = true;
+    spapr->eff.caps[cap->index] = val;
+}
+
 static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
 {
     if (!val) {
@@ -267,6 +304,16 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
 
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
+static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
+                                      uint8_t val, Error **errp)
+{
+    if (val < 12) {
+        error_setg(errp, "Require at least 4kiB hpt-max-page-size");
+    } else if (val < 16) {
+        warn_report("Many guests require at least 64kiB hpt-max-page-size");
+    }
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -326,6 +373,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .possible = &cap_ibs_possible,
         .apply = cap_safe_indirect_branch_apply,
     },
+    [SPAPR_CAP_HPT_MAXPAGESIZE] = {
+        .name = "hpt-max-page-size",
+        .description = "Maximum page size for Hash Page Table guests",
+        .index = SPAPR_CAP_HPT_MAXPAGESIZE,
+        .get = spapr_cap_get_pagesize,
+        .set = spapr_cap_set_pagesize,
+        .type = "int",
+        .apply = cap_hpt_maxpagesize_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9dd46a72f6..c97593d032 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -66,8 +66,10 @@ typedef enum {
 #define SPAPR_CAP_SBBC                  0x04
 /* Indirect Branch Serialisation */
 #define SPAPR_CAP_IBS                   0x05
+/* HPT Maximum Page Size (encoded as a shift) */
+#define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MAXPAGESIZE + 1)
 
 /*
  * Capability Values
-- 
2.17.1
