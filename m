Received: from eggs.gnu.org ([209.51.188.92]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkp-000508-WA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002PL-R0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:32 +1100
Message-Id: <20190226045304.25618-19-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/50] target/ppc/spapr: Set LPCR:HR when using
 Radix mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The HW relies on LPCR:HR along with the PATE to determine whether
to use Radix or Hash mode. In fact it uses LPCR:HR more commonly
than the PATE.

For us, it's also more efficient to do so, especially since unlike
the HW we do not maintain a cache of the current PATE and HV PATE
in a generic place.

Prepare the grounds for that by ensuring that LPCR:HR is set
properly on SPAPR machines.

Another option would have been to use a callback to get the PATE
but this gets messy when implementing bare metal support, it's
much simpler (and faster) to use LPCR.

Since existing migration streams may not have it, fix it up in
spapr_post_load() as well based on the pseudo-PATE entry that
we keep.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 41 +++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c    | 46 +++++++----------------------------------
 hw/ppc/spapr_rtas.c     |  6 +++---
 include/hw/ppc/spapr.h  |  1 +
 target/ppc/cpu.h        |  1 +
 target/ppc/mmu-hash64.c |  2 +-
 6 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b3631e22c4..84f6e9d9a8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1389,6 +1389,37 @@ static void emulate_spapr_hypercall(PPCVirtualHype=
rvisor *vhyp,
     }
 }
=20
+struct LPCRSyncState {
+    target_ulong value;
+    target_ulong mask;
+};
+
+static void do_lpcr_sync(CPUState *cs, run_on_cpu_data arg)
+{
+    struct LPCRSyncState *s =3D arg.host_ptr;
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    CPUPPCState *env =3D &cpu->env;
+    target_ulong lpcr;
+
+    cpu_synchronize_state(cs);
+    lpcr =3D env->spr[SPR_LPCR];
+    lpcr &=3D ~s->mask;
+    lpcr |=3D s->value;
+    ppc_store_lpcr(cpu, lpcr);
+}
+
+void spapr_set_all_lpcrs(target_ulong value, target_ulong mask)
+{
+    CPUState *cs;
+    struct LPCRSyncState s =3D {
+        .value =3D value,
+        .mask =3D mask
+    };
+    CPU_FOREACH(cs) {
+        run_on_cpu(cs, do_lpcr_sync, RUN_ON_CPU_HOST_PTR(&s));
+    }
+}
+
 static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
@@ -1565,7 +1596,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr,=
 int shift,
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
-    spapr->patb_entry =3D 0;
+    spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
=20
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
@@ -1623,6 +1654,7 @@ static void spapr_machine_reset(void)
          * without a HPT because KVM will start them in radix mode.
          * Set the GR bit in PATB so that we know there is no HPT. */
         spapr->patb_entry =3D PATBE1_GR;
+        spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
     } else {
         spapr_setup_hpt_and_vrma(spapr);
     }
@@ -1781,6 +1813,13 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         bool radix =3D !!(spapr->patb_entry & PATBE1_GR);
         bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
=20
+        /*
+         * Update LPCR:HR and UPRT as they may not be set properly in
+         * the stream
+         */
+        spapr_set_all_lpcrs(radix ? (LPCR_HR | LPCR_UPRT) : 0,
+                            LPCR_HR | LPCR_UPRT);
+
         err =3D kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr->patb_en=
try);
         if (err) {
             error_report("Process table config unsupported by the host")=
;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 17bcaa3822..b47241ace6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -17,37 +17,6 @@
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
=20
-struct LPCRSyncState {
-    target_ulong value;
-    target_ulong mask;
-};
-
-static void do_lpcr_sync(CPUState *cs, run_on_cpu_data arg)
-{
-    struct LPCRSyncState *s =3D arg.host_ptr;
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    CPUPPCState *env =3D &cpu->env;
-    target_ulong lpcr;
-
-    cpu_synchronize_state(cs);
-    lpcr =3D env->spr[SPR_LPCR];
-    lpcr &=3D ~s->mask;
-    lpcr |=3D s->value;
-    ppc_store_lpcr(cpu, lpcr);
-}
-
-static void set_all_lpcrs(target_ulong value, target_ulong mask)
-{
-    CPUState *cs;
-    struct LPCRSyncState s =3D {
-        .value =3D value,
-        .mask =3D mask
-    };
-    CPU_FOREACH(cs) {
-        run_on_cpu(cs, do_lpcr_sync, RUN_ON_CPU_HOST_PTR(&s));
-    }
-}
-
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
     /* We can test whether the SPR is defined by checking for a valid na=
me */
@@ -1255,12 +1224,12 @@ static target_ulong h_set_mode_resource_le(PowerP=
CCPU *cpu,
=20
     switch (mflags) {
     case H_SET_MODE_ENDIAN_BIG:
-        set_all_lpcrs(0, LPCR_ILE);
+        spapr_set_all_lpcrs(0, LPCR_ILE);
         spapr_pci_switch_vga(true);
         return H_SUCCESS;
=20
     case H_SET_MODE_ENDIAN_LITTLE:
-        set_all_lpcrs(LPCR_ILE, LPCR_ILE);
+        spapr_set_all_lpcrs(LPCR_ILE, LPCR_ILE);
         spapr_pci_switch_vga(false);
         return H_SUCCESS;
     }
@@ -1289,7 +1258,7 @@ static target_ulong h_set_mode_resource_addr_trans_=
mode(PowerPCCPU *cpu,
         return H_UNSUPPORTED_FLAG;
     }
=20
-    set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
+    spapr_set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
=20
     return H_SUCCESS;
 }
@@ -1422,10 +1391,11 @@ static target_ulong h_register_process_table(Powe=
rPCCPU *cpu,
=20
     spapr->patb_entry =3D cproc; /* Save new process table */
=20
-    /* Update the UPRT and GTSE bits in the LPCR for all cpus */
-    set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UP=
RT : 0) |
-                  ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
-                  LPCR_UPRT | LPCR_GTSE);
+    /* Update the UPRT, HR and GTSE bits in the LPCR for all cpus */
+    spapr_set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ?
+                         (LPCR_UPRT | LPCR_HR) : 0) |
+                        ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
+                        LPCR_UPRT | LPCR_HR | LPCR_GTSE);
=20
     if (kvm_enabled()) {
         return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d6a0952154..7a2cb786a3 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -172,10 +172,10 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPA=
PRMachineState *spapr,
          * New cpus are expected to start in the same radix/hash mode
          * as the existing CPUs
          */
-        if (ppc64_radix_guest(callcpu)) {
-            lpcr |=3D LPCR_UPRT | LPCR_GTSE;
+        if (ppc64_v3_radix(callcpu)) {
+            lpcr |=3D LPCR_UPRT | LPCR_GTSE | LPCR_HR;
         } else {
-            lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE);
+            lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
         }
     }
     ppc_store_lpcr(newcpu, lpcr);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fec0f26f49..659204ea93 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -841,4 +841,5 @@ void spapr_check_pagesize(sPAPRMachineState *spapr, h=
waddr pagesize,
 #define SPAPR_OV5_XIVE_EXPLOIT  0x40
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
=20
+void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ececad9f1f..3f39a77750 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -388,6 +388,7 @@ struct ppc_slb_t {
 #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
 #define LPCR_UPRT         PPC_BIT(41) /* Use Process Table */
 #define LPCR_EVIRT        PPC_BIT(42) /* Enhanced Virtualisation */
+#define LPCR_HR           PPC_BIT(43) /* Host Radix */
 #define LPCR_ONL          PPC_BIT(45)
 #define LPCR_LD           PPC_BIT(46) /* Large Decrementer */
 #define LPCR_P7_PECE0     PPC_BIT(49)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 276d9015e7..f1c7729332 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1084,7 +1084,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
     case POWERPC_MMU_3_00: /* P9 */
         lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
                       (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
-                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
+                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR |
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
--=20
2.20.1
