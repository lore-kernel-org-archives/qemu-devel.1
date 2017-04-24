Received: from eggs.gnu.org ([2001:4830:134:3::10]:56136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI5-0001OS-6x
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI3-0003M5-VN
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:52 +1000
Message-Id: <20170424015927.8933-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/47] spapr: Workaround for broken radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

For a little while around 4.9, Linux kernels that saw the radix bit in
ibm,pa-features would attempt to set up the MMU as if they were a
hypervisor, even if they were a guest, which would cause them to
crash.

Work around this by detecting pre-ISA 3.0 guests by their lack of that
bit in option vector 1, and then removing the radix bit from
ibm,pa-features. Note: This now requires regeneration of that node
after CAS negotiation.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
[dwg: Fix style nits]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 15 +++++++++++++--
 hw/ppc/spapr_hcall.c        |  6 ++++--
 include/hw/ppc/spapr.h      |  1 +
 include/hw/ppc/spapr_ovec.h |  3 +++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d967ec3..a355512 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -228,7 +228,8 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
 }
 
 /* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
+static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
+                                      bool legacy_guest)
 {
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
@@ -295,6 +296,12 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
     if (kvmppc_has_cap_htm() && pa_size > 24) {
         pa_features[24] |= 0x80;    /* Transactional memory support */
     }
+    if (legacy_guest && pa_size > 40) {
+        /* Workaround for broken kernels that attempt (guest) radix
+         * mode when they can't handle it, if they see the radix bit set
+         * in pa-features. So hide it from them. */
+        pa_features[40 + 2] &= ~0x80; /* Radix MMU */
+    }
 
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
 }
@@ -309,6 +316,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
@@ -350,6 +358,9 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         if (ret < 0) {
             return ret;
         }
+
+        spapr_populate_pa_features(env, fdt, offset,
+                                         spapr->cas_legacy_guest_workaround);
     }
     return ret;
 }
@@ -547,7 +558,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
 
-    spapr_populate_pa_features(env, fdt, offset);
+    spapr_populate_pa_features(env, fdt, offset, false);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index cbd1f29..9f18f75 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1062,7 +1062,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     uint32_t max_compat = cpu->max_compat;
     uint32_t best_compat = 0;
     int i;
-    sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
+    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
     bool guest_radix;
 
     /*
@@ -1114,6 +1114,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     /* For the future use: here @ov_table points to the first option vector */
     ov_table = list;
 
+    ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
     if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
         error_report("guest requested hash and radix MMU, which is invalid.");
@@ -1155,7 +1156,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             exit(EXIT_FAILURE);
         }
     }
-
+    spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
+                                                          OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d234efc..e27de64 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -89,6 +89,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
+    bool cas_legacy_guest_workaround;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index f7f2abe..f088833 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -43,6 +43,9 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 
 #define OV_BIT(byte, bit) ((byte - 1) * BITS_PER_BYTE + bit)
 
+/* option vector 1 */
+#define OV1_PPC_3_00            OV_BIT(3, 0) /* guest supports PowerPC 3.00? */
+
 /* option vector 5 */
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
-- 
2.9.3
