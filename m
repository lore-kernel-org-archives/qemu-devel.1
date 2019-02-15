Received: from eggs.gnu.org ([209.51.188.92]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrD-0001tX-Lj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrB-0005iK-Kw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49108
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr9-0005I8-K3
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxuYw141229
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp0ga3ek2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:43 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:27 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-11-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/12] target/ppc: Rename PATB/PATBE -> PATE
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

That "b" means "base address" and thus shouldn't be in the name
of actual entries and related constants.

This patch keeps the synthetic patb_entry field of the spapr
virtual hypervisor unchanged until I figure out if that has
an impact on the migration stream.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h           |  6 +++++-
 target/ppc/mmu-book3s-v3.h | 11 ++++++++++-
 target/ppc/mmu-radix64.h   |  4 ++--
 hw/ppc/spapr.c             | 24 +++++++++++++++---------
 hw/ppc/spapr_hcall.c       | 22 ++++++++++++----------
 target/ppc/mmu-radix64.c   | 18 ++++++++++--------
 6 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e7c9ca8f5f84..e1fee1a03496 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -317,6 +317,10 @@ struct ppc_slb_t {
 #define SEGMENT_SHIFT_1T        40
 #define SEGMENT_MASK_1T         (~((1ULL << SEGMENT_SHIFT_1T) - 1))
=20
+typedef struct ppc_v3_pate_t {
+    uint64_t dw0;
+    uint64_t dw1;
+} ppc_v3_pate_t;
=20
 /***********************************************************************=
******/
 /* Machine state register bits definition                               =
     */
@@ -1239,7 +1243,7 @@ struct PPCVirtualHypervisorClass {
                         hwaddr ptex, int n);
     void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                        uint64_t pte0, uint64_t pte1);
-    uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
+    void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
 };
=20
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 216ff296c088..8474dfec41d9 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -32,7 +32,16 @@
 #define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
=20
 /* Partition Table Entry Fields */
-#define PATBE1_GR 0x8000000000000000
+#define PATE0_HR 0x8000000000000000
+
+/*
+ * WARNING: This field doesn't actually exist in the final version of
+ * the architecture and is unused by hardware. However, qemu uses it
+ * as an indication of a radix guest in the pseudo-PATB entry that it
+ * maintains for SPAPR guests and in the migration stream, so we need
+ * to keep it around
+ */
+#define PATE1_GR 0x8000000000000000
=20
 /* Process Table Entry */
 struct prtb_entry {
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 0ecf063a1751..96228546aa85 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -12,8 +12,8 @@
 #define R_EADDR_QUADRANT3       0xC000000000000000
=20
 /* Radix Partition Table Entry Fields */
-#define PATBE1_R_PRTB           0x0FFFFFFFFFFFF000
-#define PATBE1_R_PRTS           0x000000000000001F
+#define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
+#define PATE1_R_PRTS           0x000000000000001F
=20
 /* Radix Process Table Entry Fields */
 #define PRTBE_R_GET_RTS(rts) \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1afe31ee6163..c77507b82473 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1403,11 +1403,13 @@ void spapr_set_all_lpcrs(target_ulong value, targ=
et_ulong mask)
     }
 }
=20
-static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
+static void spapr_get_pate(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *en=
try)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
=20
-    return spapr->patb_entry;
+    /* Copy PATE1:GR into PATE0:HR */
+    entry->dw0 =3D spapr->patb_entry & PATE0_HR;
+    entry->dw1 =3D spapr->patb_entry;
 }
=20
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
@@ -1650,17 +1652,21 @@ static void spapr_machine_reset(void)
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_0=
0, 0,
                               spapr->max_compat_pvr)) {
-        /* If using KVM with radix mode available, VCPUs can be started
+        /*
+         * If using KVM with radix mode available, VCPUs can be started
          * without a HPT because KVM will start them in radix mode.
-         * Set the GR bit in PATB so that we know there is no HPT. */
-        spapr->patb_entry =3D PATBE1_GR;
+         * Set the GR bit in PATE so that we know there is no HPT.
+         */
+        spapr->patb_entry =3D PATE1_GR;
         spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
     } else {
         spapr_setup_hpt_and_vrma(spapr);
     }
=20
-    /* if this reset wasn't generated by CAS, we should reset our
-     * negotiated options and start from scratch */
+    /*
+     * If this reset wasn't generated by CAS, we should reset our
+     * negotiated options and start from scratch
+     */
     if (!spapr->cas_reboot) {
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas =3D spapr_ovec_new();
@@ -1810,7 +1816,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
=20
     if (kvm_enabled() && spapr->patb_entry) {
         PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
-        bool radix =3D !!(spapr->patb_entry & PATBE1_GR);
+        bool radix =3D !!(spapr->patb_entry & PATE1_GR);
         bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
=20
         /*
@@ -4060,7 +4066,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->map_hptes =3D spapr_map_hptes;
     vhc->unmap_hptes =3D spapr_unmap_hptes;
     vhc->store_hpte =3D spapr_store_hpte;
-    vhc->get_patbe =3D spapr_get_patbe;
+    vhc->get_pate =3D spapr_get_pate;
     vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 2f64c69a6abf..54922b50aadb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1310,12 +1310,12 @@ static void spapr_check_setup_free_hpt(sPAPRMachi=
neState *spapr,
      *       later and so assumed radix and now it's called H_REG_PROC_T=
BL
      */
=20
-    if ((patbe_old & PATBE1_GR) =3D=3D (patbe_new & PATBE1_GR)) {
+    if ((patbe_old & PATE1_GR) =3D=3D (patbe_new & PATE1_GR)) {
         /* We assume RADIX, so this catches all the "Do Nothing" cases *=
/
-    } else if (!(patbe_old & PATBE1_GR)) {
+    } else if (!(patbe_old & PATE1_GR)) {
         /* HASH->RADIX : Free HPT */
         spapr_free_hpt(spapr);
-    } else if (!(patbe_new & PATBE1_GR)) {
+    } else if (!(patbe_new & PATE1_GR)) {
         /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
         spapr_setup_hpt_and_vrma(spapr);
     }
@@ -1353,7 +1353,7 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
                 } else if (table_size > 24) {
                     return H_P4;
                 }
-                cproc =3D PATBE1_GR | proc_tbl | table_size;
+                cproc =3D PATE1_GR | proc_tbl | table_size;
             } else { /* Register new HPT process table */
                 if (flags & FLAG_HASH_PROC_TBL) { /* Hash with Segment T=
ables */
                     /* TODO - Not Supported */
@@ -1372,13 +1372,15 @@ static target_ulong h_register_process_table(Powe=
rPCCPU *cpu,
             }
=20
         } else { /* Deregister current process table */
-            /* Set to benign value: (current GR) | 0. This allows
-             * deregistration in KVM to succeed even if the radix bit in=
 flags
-             * doesn't match the radix bit in the old PATB. */
-            cproc =3D spapr->patb_entry & PATBE1_GR;
+            /*
+             * Set to benign value: (current GR) | 0. This allows
+             * deregistration in KVM to succeed even if the radix bit
+             * in flags doesn't match the radix bit in the old PATE.
+             */
+            cproc =3D spapr->patb_entry & PATE1_GR;
         }
     } else { /* Maintain current registration */
-        if (!(flags & FLAG_RADIX) !=3D !(spapr->patb_entry & PATBE1_GR))=
 {
+        if (!(flags & FLAG_RADIX) !=3D !(spapr->patb_entry & PATE1_GR)) =
{
             /* Technically caused by flag bits =3D> H_PARAMETER */
             return H_PARAMETER; /* Existing Process Table Mismatch */
         }
@@ -1615,7 +1617,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     if (!spapr->cas_reboot) {
         /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
          * (because the guest isn't going to use radix) then set it up h=
ere. */
-        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
+        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
             /* legacy hash or new hash: */
             spapr_setup_hpt_and_vrma(spapr);
         }
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5881efeb8598..f596f3c7774e 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -193,8 +193,9 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
     PPCVirtualHypervisorClass *vhc =3D
         PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
     hwaddr raddr, pte_addr;
-    uint64_t lpid =3D 0, pid =3D 0, offset, size, patbe, prtbe0, pte;
+    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
     int page_size, prot, fault_cause =3D 0;
+    ppc_v3_pate_t pate;
=20
     assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
     assert(!msr_hv); /* For now there is no Radix PowerNV Support */
@@ -219,17 +220,17 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
     }
=20
     /* Get Process Table */
-    patbe =3D vhc->get_patbe(cpu->vhyp);
+    vhc->get_pate(cpu->vhyp, &pate);
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
-    size =3D 1ULL << ((patbe & PATBE1_R_PRTS) + 12);
+    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
     if (offset >=3D size) {
         /* offset exceeds size of the process table */
         ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
         return 1;
     }
-    prtbe0 =3D ldq_phys(cs->as, (patbe & PATBE1_R_PRTB) + offset);
+    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
=20
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     page_size =3D PRTBE_R_GET_RTS(prtbe0);
@@ -257,8 +258,9 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong eaddr)
     PPCVirtualHypervisorClass *vhc =3D
         PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
     hwaddr raddr, pte_addr;
-    uint64_t lpid =3D 0, pid =3D 0, offset, size, patbe, prtbe0, pte;
+    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
     int page_size, fault_cause =3D 0;
+    ppc_v3_pate_t pate;
=20
     /* Handle Real Mode */
     if (msr_dr =3D=3D 0) {
@@ -272,16 +274,16 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *=
cpu, target_ulong eaddr)
     }
=20
     /* Get Process Table */
-    patbe =3D vhc->get_patbe(cpu->vhyp);
+    vhc->get_pate(cpu->vhyp, &pate);
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
-    size =3D 1ULL << ((patbe & PATBE1_R_PRTS) + 12);
+    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
     if (offset >=3D size) {
         /* offset exceeds size of the process table */
         return -1;
     }
-    prtbe0 =3D ldq_phys(cs->as, (patbe & PATBE1_R_PRTB) + offset);
+    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
=20
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     page_size =3D PRTBE_R_GET_RTS(prtbe0);
--=20
2.20.1
