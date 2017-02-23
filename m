Received: from eggs.gnu.org ([2001:4830:134:3::10]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTR-0000Sp-Gp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTO-0001m0-5J
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49798
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmTN-0001ls-VG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5rex7043711
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:49 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sdf5w5cn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:48 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:46 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 17:00:05 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <e2f52ac4317e8caff0cc4ed696e550d6843013ad.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 12/12] spapr: Workaround for broken
 radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

For a little while around 4.9, Linux kernels that saw the radix bit in
ibm,pa-features would attempt to set up the MMU as if they were a
hypervisor, even if they were a guest, which would cause them to
crash.

Work around this by detecting pre-ISA 3.0 guests by their lack of that
bit in option vector 1, and then removing the radix bit from
ibm,pa-features. Note: This now requires regeneration of that node
after CAS negotiation.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c              | 15 +++++++++++++--
 hw/ppc/spapr_hcall.c        |  5 +++--
 include/hw/ppc/spapr.h      |  1 +
 include/hw/ppc/spapr_ovec.h |  3 +++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e83468a8d3..c47600b8ee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -195,7 +195,8 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
 }
 
 /* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
+static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
+                                      bool legacy_guest)
 {
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
@@ -251,6 +252,12 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
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
@@ -265,6 +272,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
@@ -306,6 +314,9 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         if (ret < 0) {
             return ret;
         }
+
+        spapr_populate_pa_features(env, fdt, offset,
+                                         spapr->cas_legacy_guest_workaround);
     }
     return ret;
 }
@@ -503,7 +514,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
 
-    spapr_populate_pa_features(env, fdt, offset);
+    spapr_populate_pa_features(env, fdt, offset, false);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index efaa1a1b19..7660cd7d64 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -933,7 +933,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     uint32_t max_compat = cpu->max_compat;
     uint32_t best_compat = 0;
     int i;
-    sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
+    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
     bool guest_radix;
 
     /*
@@ -985,6 +985,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     /* For the future use: here @ov_table points to the first option vector */
     ov_table = list;
 
+    ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
     if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
         error_report("qemu: guest requested hash and radix MMU, which is invalid.");
@@ -1025,7 +1026,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             exit(EXIT_FAILURE);
         }
     }
-
+    spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest, OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d523db3b4a..1e64e3ada8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -77,6 +77,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
+    bool cas_legacy_guest_workaround;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index e2dfbac558..8807c753e0 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -43,6 +43,9 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 
 #define OV_BIT(byte, bit) ((byte - 1) * BITS_PER_BYTE + bit)
 
+/* option vector 1 */
+#define OV1_PPC_3_00            OV_BIT(3, 0) /* set if we support PowerPC 3.00 */
+
 /* option vector 5 */
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
-- 
2.11.0
