Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI9-0001Ta-B3
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI6-0003OO-Rh
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:51 +1000
Message-Id: <20170424015927.8933-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/47] spapr: Enable ISA 3.0 MMU mode selection
 via CAS
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

If QEMU is using KVM, and KVM is capable of running in radix mode,
guests can be run in real-mode without allocating a HPT (because KVM
will use a minimal RPT). So in this case, we avoid creating the HPT
at reset time and later (during CAS) create it if it is necessary.

ISA 3.0 guests will now begin to call h_register_process_table(),
which has been added previously.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
[dwg: Strip some unneeded prefix from error messages]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 71 ++++++++++++++++++++++++++++++++++++---------
 hw/ppc/spapr_hcall.c        | 30 +++++++++++++++++++
 include/hw/ppc/spapr_ovec.h |  5 ++++
 3 files changed, 93 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 21da9a1..d967ec3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -237,20 +237,31 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
-    /* Currently we don't advertise any of the "new" ISAv3.00 functionality */
-    uint8_t pa_features_300[] = { 64, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
+    uint8_t pa_features_300[] = { 66, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
-        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
-        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
-
+        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
+        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+    };
     uint8_t *pa_features;
     size_t pa_size;
 
@@ -856,6 +867,33 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
+/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU features
+ * that the guest may request and thus the valid values for bytes 24..26 of
+ * option vector 5: */
+static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+{
+    char val[2 * 3] = {
+        24, 0x00, /* Hash/Radix, filled in below. */
+        25, 0x00, /* Hash options: Segment Tables == no, GTSE == no. */
+        26, 0x40, /* Radix options: GTSE == yes. */
+    };
+
+    if (kvm_enabled()) {
+        if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
+            val[1] = 0x80; /* OV5_MMU_BOTH */
+        } else if (kvmppc_has_cap_mmu_radix()) {
+            val[1] = 0x40; /* OV5_MMU_RADIX_300 */
+        } else {
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
@@ -909,6 +947,8 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout_path));
     }
 
+    spapr_dt_ov5_platform_support(fdt, chosen);
+
     g_free(stdout_path);
     g_free(bootlist);
 }
@@ -2078,6 +2118,11 @@ static void ppc_spapr_init(MachineState *machine)
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
index a958fee..cbd1f29 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1063,6 +1063,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     uint32_t best_compat = 0;
     int i;
     sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
+    bool guest_radix;
 
     /*
      * We scan the supplied table of PVRs looking for two things
@@ -1114,6 +1115,13 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov_table = list;
 
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
+    if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
+        error_report("guest requested hash and radix MMU, which is invalid.");
+        exit(EXIT_FAILURE);
+    }
+    /* The radix/hash bit in byte 24 requires special handling: */
+    guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
+    spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
     /* NOTE: there are actually a number of ov5 bits where input from the
      * guest is always zero, and the platform/QEMU enables them independently
@@ -1132,6 +1140,21 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov5_updates = spapr_ovec_new();
     spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
                                         ov5_cas_old, spapr->ov5_cas);
+    /* Now that processing is finished, set the radix/hash bit for the
+     * guest if it requested a valid mode; otherwise terminate the boot. */
+    if (guest_radix) {
+        if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
+            error_report("Guest requested unavailable MMU mode (radix).");
+            exit(EXIT_FAILURE);
+        }
+        spapr_ovec_set(spapr->ov5_cas, OV5_MMU_RADIX_300);
+    } else {
+        if (kvm_enabled() && kvmppc_has_cap_mmu_radix()
+            && !kvmppc_has_cap_mmu_hash_v3()) {
+            error_report("Guest requested unavailable MMU mode (hash).");
+            exit(EXIT_FAILURE);
+        }
+    }
 
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
@@ -1142,6 +1165,13 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (spapr->cas_reboot) {
         qemu_system_reset_request();
+    } else {
+        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
+         * (because the guest isn't going to use radix) then set it up here. */
+        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
+            /* legacy hash or new hash: */
+            spapr_setup_hpt_and_vrma(spapr);
+        }
     }
 
     return H_SUCCESS;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 355a344..f7f2abe 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -48,6 +48,11 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
 
+/* ISA 3.00 MMU features: */
+#define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */
+#define OV5_MMU_RADIX_300       OV_BIT(24, 1) /* 1=Radix only, 0=Hash only */
+#define OV5_MMU_RADIX_GTSE      OV_BIT(26, 1) /* Radix GTSE */
+
 /* interfaces */
 sPAPROptionVector *spapr_ovec_new(void);
 sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *ov_orig);
-- 
2.9.3
