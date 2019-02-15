Received: from eggs.gnu.org ([209.51.188.92]:33677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrK-00024x-IZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrE-0005o6-1m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38274
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrD-0005Ml-OI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxqg2146736
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:48 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnxwm7pk7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:45 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:43 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:18 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-2-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/12] target/ppc/spapr: Set LPCR:HR when using
 Radix mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
---
 include/hw/ppc/spapr.h  |  1 +
 target/ppc/cpu.h        |  1 +
 hw/ppc/spapr.c          | 41 +++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c    | 46 +++++++----------------------------------
 hw/ppc/spapr_rtas.c     |  6 +++---
 target/ppc/mmu-hash64.c |  2 +-
 6 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a947a0a0dc14..734fb54b2a2d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -840,4 +840,5 @@ void spapr_check_pagesize(sPAPRMachineState *spapr, h=
waddr pagesize,
 #define SPAPR_OV5_XIVE_EXPLOIT  0x40
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
=20
+void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2c22292e7f41..e7c9ca8f5f84 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -385,6 +385,7 @@ struct ppc_slb_t {
 #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
 #define LPCR_UPRT         PPC_BIT(41) /* Use Process Table */
 #define LPCR_EVIRT        PPC_BIT(42) /* Enhanced Virtualisation */
+#define LPCR_HR           PPC_BIT(43) /* Host Radix */
 #define LPCR_ONL          PPC_BIT(45)
 #define LPCR_LD           PPC_BIT(46) /* Large Decrementer */
 #define LPCR_P7_PECE0     PPC_BIT(49)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 332cba89d425..60572eb59275 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1372,6 +1372,37 @@ static void emulate_spapr_hypercall(PPCVirtualHype=
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
@@ -1548,7 +1579,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr,=
 int shift,
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
-    spapr->patb_entry =3D 0;
+    spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
=20
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
@@ -1606,6 +1637,7 @@ static void spapr_machine_reset(void)
          * without a HPT because KVM will start them in radix mode.
          * Set the GR bit in PATB so that we know there is no HPT. */
         spapr->patb_entry =3D PATBE1_GR;
+        spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
     } else {
         spapr_setup_hpt_and_vrma(spapr);
     }
@@ -1764,6 +1796,13 @@ static int spapr_post_load(void *opaque, int versi=
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
index 17bcaa3822c3..b47241ace62a 100644
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
index d6a0952154ac..7a2cb786a36a 100644
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
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 276d9015e7c4..f1c7729332e6 100644
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
