Received: from eggs.gnu.org ([2001:4830:134:3::10]:34367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dhTgY-0000FB-9L
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dhTgV-0003zc-4s
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:42:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49068
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dhTgU-0003z6-UP
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:42:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7F4cnlR108513
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 00:42:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cbp1hs9kb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 00:42:29 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 15 Aug 2017 14:42:26 +1000
Date: Tue, 15 Aug 2017 14:42:21 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1502771785.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1502771785.git.sam.bobroff@au1.ibm.com>
Message-Id: <beaad4313aaf2569939bab4831acb8f6b39ef993.1502771785.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] PPC: KVM: Support machine option to set
 VSMT mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, groug@kaod.org

KVM now allows writing to KVM_CAP_PPC_SMT which has previously been
read only. Doing so causes KVM to act, for that VM, as if the host's
SMT mode was the given value. This is particularly important on Power
9 systems because their default value is 1, but they are able to
support values up to 8.

This patch introduces a way to control this capability via a new
machine property called VSMT ("Virtual SMT"). If the value is not set
on the command line a default is chosen that is, when possible,
compatible with legacy systems.

Note that the intialization of KVM_CAP_PPC_SMT has changed slightly
because it has changed (in KVM) from a global capability to a
VM-specific one. This won't cause a problem on older KVMs because VM
capabilities fall back to global ones.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
Changes in v3:

* Suggested by Greg Kurz:
    * Comment on show_vsmt_possible() converted in to an assert().
    * Better use of g_string_new().
    * Removed trailing periods from several error_report() strings.
    * Shortened overly long line.
    * Converted some helpful error_report() calls into error_printf().
    * Simplified error handling in spapr_set_vsmt().
    * Use error_abort when adding properties (instead of ignoring errors), as it's a bug if it fails.
    * Moved the explanation about KVM_CAP_PPC_SMT into the commit so that it's not lost with the cover letter.

 hw/ppc/spapr.c              | 96 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h      |  1 +
 target/ppc/kvm.c            | 20 +++++++++-
 target/ppc/kvm_ppc.h        | 12 ++++++
 target/ppc/translate_init.c | 14 -------
 5 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cd6eb2d4a9..e266cdd36a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -26,6 +26,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "hw/hw.h"
@@ -2140,6 +2141,82 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     g_free(type);
 }
 
+static void show_vsmt_possible(void)
+{
+    int i;
+    GString *g;
+    char *s;
+
+    assert(kvm_enabled());
+    if (kvmppc_smt_possible()) {
+        g = g_string_new("Available VSMT modes:");
+        for (i = 63; i >= 0; i--) {
+            if ((1UL << i) & kvmppc_smt_possible()) {
+                g_string_append_printf(g, " %lu", (1UL << i));
+            }
+        }
+        s = g_string_free(g, false);
+        error_printf("%s.\n", s);
+        g_free(s);
+    } else {
+        error_printf("This KVM seems to be too old to support VSMT.\n");
+    }
+}
+
+static void spapr_set_vsmt_mode(sPAPRMachineState *spapr)
+{
+    bool vsmt_user = !!spapr->vsmt;
+    int kvm_smt = kvmppc_smt_threads();
+    int ret;
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    const char *machine_name = object_class_get_name(OBJECT_CLASS(smc));
+
+    if (!kvm_enabled() && (smp_threads > 1)) {
+        error_report("TCG cannot support more than 1 thread/core "
+                     "on a %s", machine_name);
+        exit(1);
+    }
+    if (!is_power_of_2(smp_threads)) {
+        error_report("Cannot support %d threads/core on a %s because "
+                     "it must be a power of 2", smp_threads, machine_name);
+        exit(1);
+    }
+
+    /* Detemine the VSMT mode to use: */
+    if (vsmt_user) {
+        if (spapr->vsmt < smp_threads) {
+            error_report("Cannot support VSMT mode %d"
+                         " because it must be >= threads/core (%d)",
+                         spapr->vsmt, smp_threads);
+            exit(1);
+        }
+        /* In this case, spapr->vsmt has been set by the command line */
+    } else {
+        /* Choose a VSMT mode that may be higher than necessary but is
+         * likely to be compatible with hosts that don't have VSMT. */
+        spapr->vsmt = MAX(kvm_smt, smp_threads);
+    }
+
+    /* KVM: If necessary, set the SMT mode: */
+    if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
+        ret = kvmppc_set_smt_threads(spapr->vsmt);
+        if (ret) {
+            error_report("Failed to set KVM's VSMT mode to %d (errno %d)",
+                         spapr->vsmt, ret);
+            if (!vsmt_user) {
+                error_printf("On PPC, a VM with %d threads/core on a host"
+                             " with %d threads/core requires the use of"
+                             " VSMT mode %d.\n",
+                             smp_threads, kvm_smt, spapr->vsmt);
+            }
+            show_vsmt_possible();
+            exit(1);
+        }
+    }
+    /* else TCG: nothing to do currently */
+    return;
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void ppc_spapr_init(MachineState *machine)
 {
@@ -2272,6 +2349,8 @@ static void ppc_spapr_init(MachineState *machine)
 
     spapr_cpu_parse_features(spapr);
 
+    spapr_set_vsmt_mode(spapr);
+
     spapr_init_cpus(spapr);
 
     if (kvm_enabled()) {
@@ -2656,6 +2735,18 @@ static void spapr_set_resize_hpt(Object *obj, const char *value, Error **errp)
     }
 }
 
+static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
+static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -2686,6 +2777,11 @@ static void spapr_machine_initfn(Object *obj)
     object_property_set_description(obj, "resize-hpt",
                                     "Resizing of the Hash Page Table (enabled, disabled, required)",
                                     NULL);
+    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
+                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort);
+    object_property_set_description(obj, "vsmt",
+                                    "Virtual SMT: KVM behaves as if this were"
+                                    " the host's SMT mode", &error_abort);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 86c982cf2c..68c510339f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -99,6 +99,7 @@ struct sPAPRMachineState {
     uint64_t rtc_offset; /* Now used only during incoming migration */
     struct PPCTimebase tb;
     bool has_graphics;
+    uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5fc7f238eb..0b9d5b83fa 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -74,6 +74,7 @@ static int cap_interrupt_level = false;
 static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
+static int cap_ppc_smt_possible;
 static int cap_ppc_rma;
 static int cap_spapr_tce;
 static int cap_spapr_tce_64;
@@ -130,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_interrupt_level = kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL);
     cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
-    cap_ppc_smt = kvm_check_extension(s, KVM_CAP_PPC_SMT);
+    cap_ppc_smt_possible = kvm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
     cap_ppc_rma = kvm_check_extension(s, KVM_CAP_PPC_RMA);
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
@@ -144,6 +145,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * only activated after this by kvmppc_set_papr() */
     cap_htab_fd = kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls = kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
+    cap_ppc_smt = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
@@ -2134,6 +2136,22 @@ int kvmppc_smt_threads(void)
     return cap_ppc_smt ? cap_ppc_smt : 1;
 }
 
+int kvmppc_set_smt_threads(int smt)
+{
+    int ret;
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SMT, 0, smt, 0);
+    if (!ret) {
+        cap_ppc_smt = smt;
+    }
+    return ret;
+}
+
+int kvmppc_smt_possible(void)
+{
+    return cap_ppc_smt_possible;
+}
+
 #ifdef TARGET_PPC64
 off_t kvmppc_alloc_rma(void **rma)
 {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 381afe6240..7b2962eb86 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -29,6 +29,8 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 int kvmppc_smt_threads(void);
+int kvmppc_smt_possible(void);
+int kvmppc_set_smt_threads(int smt);
 int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_set_tcr(PowerPCCPU *cpu);
@@ -148,6 +150,16 @@ static inline int kvmppc_smt_threads(void)
     return 1;
 }
 
+static inline int kvmppc_smt_possible(void)
+{
+    return 1;
+}
+
+static inline int kvmppc_set_smt_threads(int smt)
+{
+    return 0;
+}
+
 static inline int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
 {
     return 0;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 0ce923be46..7f6a349e43 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9907,20 +9907,6 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     int max_smt = kvmppc_smt_threads();
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
-    if (smp_threads > max_smt) {
-        error_setg(errp, "Cannot support more than %d threads on PPC with %s",
-                   max_smt, kvm_enabled() ? "KVM" : "TCG");
-        return;
-    }
-    if (!is_power_of_2(smp_threads)) {
-        error_setg(errp, "Cannot support %d threads on PPC with %s, "
-                   "threads count must be a power of 2.",
-                   smp_threads, kvm_enabled() ? "KVM" : "TCG");
-        return;
-    }
-#endif
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.14.1.2.g4274c698f
