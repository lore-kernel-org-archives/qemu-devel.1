Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTB-000092-O5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmT8-0001ic-Ha
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmT8-0001hk-8c
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5rd0D045386
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:33 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sku8mkr5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:32 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:29 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 17:00:04 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <68067d27a6d6a6e93972a7eaea51f2d0c7bb5376.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 11/12] spapr: Enable ISA 3.0 MMU mode
 selection via CAS
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

Add the new node, /chosen/ibm,arch-vec-5-platform-support to the
device tree. This allows the guest to determine which modes are
supported by the hypervisor.

Update the option vector processing in h_client_architecture_support()
to handle the new MMU bits. This allows guests to request hash or
radix mode and QEMU to create the guest's HPT at this time if it is
necessary but hasn't yet been done.  QEMU will terminate the guest if
it requests an unavailable mode, as required by the architecture.

Extend the ibm,pa-features node with the new ISA 3.0 values
and set the radix bit if KVM supports radix mode. This probably won't
be used directly by guests to determine the availability of radix mode
(that is indicated by the new node added above) but the architecture
requires that it be set when the hardware supports it.

ISA 3.0 guests will now begin to call h_register_process_table(),
which has been added previously.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

* Unused bits removed.
* Logic and bit definitions changed due to architectural change.
* Cleanly terminate QEMU if the guest requests an unavailable mode (as required
  by the new architecture).
* Legacy guest workaround moved to it's own patch.
* I'm sorry for the bitfield constants in spapr_dt_ov5_platform_support() but
  there don't seem to be convienent macros for converting an option vector
  specifier (OV_BIT(x,y)) into a byte-mask. I'm open to suggestions.

 hw/ppc/spapr.c              | 53 +++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c        | 37 ++++++++++++++++++++++++-------
 include/hw/ppc/spapr_ovec.h |  5 +++++
 3 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0c0782b558..e83468a8d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -204,6 +204,20 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
+    uint8_t pa_features_300[70 + 2] = { 70, 0,
+        0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 64 */
+        0x00, 0x00, 0x00, 0x00,             /* 66 - 69 */
+        };
     uint8_t *pa_features;
     size_t pa_size;
 
@@ -216,6 +230,10 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
         break;
+    case POWERPC_MMU_VER_3_00:
+        pa_features = pa_features_300;
+        pa_size = sizeof(pa_features_300);
+        break;
     default:
         return;
     }
@@ -804,6 +822,34 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
+/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU features
+ * that the guest may request and thus the valid values for bytes 24..26 of
+ * option vector 5: */
+static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+{
+    char val[2 * 3] = {
+        24, 0x00, /* Hash/Radix, filled in below. */
+        25, 0x40, /* Hash options: Segment Tables == no, GTSE == no. */
+        26, 0x40, /* Radix options: GTSE == yes. */
+    };
+
+    if (kvm_enabled()) {
+        if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
+            val[1] = 0x80; /* OV5_MMU_BOTH */
+        } else if (kvmppc_has_cap_mmu_radix()) {
+            val[1] = 0x40; /* OV5_MMU_RADIX_300 */
+        } else {
+            assert(kvmppc_has_cap_mmu_hash_v3());
+            val[1] = 0x00; /* Hash */
+        }
+    } else {
+        /* TODO: TCG case, hash */
+        val[1] = 0x00;
+    }
+    _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
+                     val, sizeof(val)));
+}
+
 static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
@@ -857,6 +903,8 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout_path));
     }
 
+    spapr_dt_ov5_platform_support(fdt, chosen);
+
     g_free(stdout_path);
     g_free(bootlist);
 }
@@ -1929,6 +1977,11 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
+    if (kvmppc_has_cap_mmu_radix()) {
+        /* KVM always allows GTSE with radix... */
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
+    }
+    /* ... but not with hash (currently). */
 
     /* advertise support for dedicated HP event source to guests */
     if (spapr->use_hotplug_event_source) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9391619ed6..efaa1a1b19 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -12,6 +12,7 @@
 #include "trace.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "qemu/error-report.h"
 
 struct SPRSyncState {
     int spr;
@@ -933,6 +934,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     uint32_t best_compat = 0;
     int i;
     sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
+    bool guest_radix;
 
     /*
      * We scan the supplied table of PVRs looking for two things
@@ -984,6 +986,13 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov_table = list;
 
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
+    if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
+        error_report("qemu: guest requested hash and radix MMU, which is invalid.");
+        exit(EXIT_FAILURE);
+    }
+    /* The radix/hash bit in byte 24 requires special handling: */
+    guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
+    spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
     /* NOTE: there are actually a number of ov5 bits where input from the
      * guest is always zero, and the platform/QEMU enables them independently
@@ -1002,14 +1011,18 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov5_updates = spapr_ovec_new();
     spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
                                         ov5_cas_old, spapr->ov5_cas);
-    if (kvm_enabled()) {
-        if (kvmppc_has_cap_mmu_radix()) {
-            /* If the HPT hasn't yet been set up (see
-             * ppc_spapr_reset()), and it's needed, do it now: */
-            if (!spapr_ovec_test(ov5_updates, OV5_MMU_RADIX)) {
-                /* legacy hash or new hash: */
-                spapr_setup_hpt_and_vrma(spapr);
-            }
+    /* Now that processing is finished, set the radix/hash bit for the
+     * guest if it requested a valid mode; otherwise terminate the boot. */
+    if (guest_radix) {
+        if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
+            error_report("qemu: Guest requested radix MMU mode when it is not available.");
+            exit(EXIT_FAILURE);
+        }
+        spapr_ovec_set(spapr->ov5_cas, OV5_MMU_RADIX_300);
+    } else {
+        if (kvm_enabled() && !kvmppc_has_cap_mmu_hash_v3()) {
+            error_report("qemu: Guest requested hash MMU mode when it is not available.");
+            exit(EXIT_FAILURE);
         }
     }
 
@@ -1022,6 +1035,14 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (spapr->cas_reboot) {
         qemu_system_reset_request();
+    } else {
+        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
+         * (because the guest isn't going to use radix) then set it up here. */
+        if (kvm_enabled()) {
+            if (kvmppc_has_cap_mmu_radix() && !guest_radix) {
+                spapr_setup_hpt_and_vrma(spapr);
+            }
+        }
     }
 
     return H_SUCCESS;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 355a34411f..e2dfbac558 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -48,6 +48,11 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
 
+/* ISA 3.00 MMU features: */
+#define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */
+#define OV5_MMU_RADIX_300       OV_BIT(24, 1) /* 1 => Radix only, 0 => Hash only */
+#define OV5_MMU_RADIX_GTSE      OV_BIT(26, 1) /* Radix GTSE */
+
 /* interfaces */
 sPAPROptionVector *spapr_ovec_new(void);
 sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *ov_orig);
-- 
2.11.0
