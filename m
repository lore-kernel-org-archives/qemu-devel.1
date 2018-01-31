Received: from eggs.gnu.org ([2001:4830:134:3::10]:38443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1egnkg-0004ni-Dz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1egnkc-0001Im-0j
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:18 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:48880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1egnkb-0001IB-Mh
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:13 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 249C83626C
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:28:12 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 31 Jan 2018 09:27:48 +0100
Message-Id: <20180131082749.1803-3-clg@kaod.org>
In-Reply-To: <20180131082749.1803-1-clg@kaod.org>
References: <20180131082749.1803-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] target/ppc: add hash MMU support on POWER9
 for PowerNV only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The HPTE bits definitions are slightly modified in ISA v3.0. Let's add
some helpers to hide the differences in the hash MMU code.

On a POWER9 processor, the Partition Table is composed of a pair of
doublewords per partition. The first doubleword indicates whether the
partition uses HPT or Radix Trees translation and contains the address
of the host's translation table structure and size.

The first doubleword of the PTCR holds the Hash Page Table base
address for the host when the hash MMU is in use. Also add an helper
to retrieve the HPT base address depending on the MMU revision.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_hcall.c    |  5 +++--
 target/ppc/mmu-hash64.c | 48 +++++++++++++++++++++++++++++++++++++++----=
-----
 target/ppc/mmu-hash64.h | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3fda7fd39da1..30cfc1f450cc 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -94,7 +94,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
         return H_PARAMETER;
     }
=20
-    raddr =3D (ptel & HPTE64_R_RPN) & ~((1ULL << apshift) - 1);
+    raddr =3D (ptel & ppc_hash64_hpte_r_rpn(cpu)) & ~((1ULL << apshift) =
- 1);
=20
     if (is_ram_address(spapr, raddr)) {
         /* Regular RAM - should have WIMG=3D0010 */
@@ -586,7 +586,8 @@ static int rehash_hpte(PowerPCCPU *cpu,
=20
     base_pg_shift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
     assert(base_pg_shift); /* H_ENTER shouldn't allow a bad encoding */
-    avpn =3D HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << base_pg_shift) - 1) >=
> 23);
+    avpn =3D ppc_hash64_hpte_v_avpn_val(cpu, pte0) &
+        ~(((1ULL << base_pg_shift) - 1) >> 23);
=20
     if (pte0 & HPTE64_V_SECONDARY) {
         pteg =3D ~pteg;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 14d34e512f42..54f052ad717c 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -290,6 +290,22 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env, =
target_ulong rb)
     return rt;
 }
=20
+hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    if (env->mmu_model & POWERPC_MMU_V3) {
+        if (msr_hv) {
+            return ldq_phys(CPU(cpu)->as, cpu->env.spr[SPR_PTCR] & PTCR_=
PTAB);
+        } else {
+            error_report("HPT Support Unimplemented");
+            exit(1);
+        }
+    } else {
+        return cpu->env.spr[SPR_SDR1];
+    }
+}
+
 /* Check No-Execute or Guarded Storage */
 static inline int ppc_hash64_pte_noexec_guard(PowerPCCPU *cpu,
                                               ppc_hash_pte64_t pte)
@@ -452,8 +468,9 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const pp=
c_hash_pte64_t *hptes,
                         false, n * HASH_PTE_SIZE_64);
 }
=20
-static unsigned hpte_page_shift(const struct ppc_one_seg_page_size *sps,
-    uint64_t pte0, uint64_t pte1)
+static unsigned hpte_page_shift(PowerPCCPU *cpu,
+                                const struct ppc_one_seg_page_size *sps,
+                                uint64_t pte0, uint64_t pte1)
 {
     int i;
=20
@@ -479,7 +496,7 @@ static unsigned hpte_page_shift(const struct ppc_one_=
seg_page_size *sps,
             continue;
         }
=20
-        mask =3D ((1ULL << ps->page_shift) - 1) & HPTE64_R_RPN;
+        mask =3D ((1ULL << ps->page_shift) - 1) & ppc_hash64_hpte_r_rpn(=
cpu);
=20
         if ((pte1 & mask) =3D=3D ((uint64_t)ps->pte_enc << HPTE64_R_RPN_=
SHIFT)) {
             return ps->page_shift;
@@ -489,6 +506,18 @@ static unsigned hpte_page_shift(const struct ppc_one=
_seg_page_size *sps,
     return 0; /* Bad page size encoding */
 }
=20
+static bool ppc_hash64_hpte_v_compare(PowerPCCPU *cpu, target_ulong pte0=
,
+                                      target_ulong ptem)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    if (env->mmu_model & POWERPC_MMU_V3) {
+        return HPTE64_V_COMPARE_3_0(pte0, ptem);
+    } else {
+        return HPTE64_V_COMPARE(pte0, ptem);
+    }
+}
+
 static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
                                      const struct ppc_one_seg_page_size =
*sps,
                                      target_ulong ptem,
@@ -509,8 +538,8 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu,=
 hwaddr hash,
         pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
=20
         /* This compares V, B, H (secondary) and the AVPN */
-        if (HPTE64_V_COMPARE(pte0, ptem)) {
-            *pshift =3D hpte_page_shift(sps, pte0, pte1);
+        if (ppc_hash64_hpte_v_compare(cpu, pte0, ptem)) {
+            *pshift =3D hpte_page_shift(cpu, sps, pte0, pte1);
             /*
              * If there is no match, ignore the PTE, it could simply
              * be for a different segment size encoding and the
@@ -570,7 +599,8 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cpu,
         epn =3D (eaddr & ~SEGMENT_MASK_256M) & epnmask;
         hash =3D vsid ^ (epn >> sps->page_shift);
     }
-    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) & HPTE64_V_AVPN)=
;
+    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) &
+                                          ppc_hash64_hpte_v_avpn(cpu));
     ptem |=3D HPTE64_V_VALID;
=20
     /* Page address translation */
@@ -625,7 +655,7 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU =
*cpu,
             break;
         }
=20
-        shift =3D hpte_page_shift(sps, pte0, pte1);
+        shift =3D hpte_page_shift(cpu, sps, pte0, pte1);
         if (shift) {
             return shift;
         }
@@ -861,7 +891,7 @@ skip_slb_search:
=20
     /* 7. Determine the real address from the PTE */
=20
-    raddr =3D deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
+    raddr =3D deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, apshif=
t, eaddr);
=20
     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
                  prot, mmu_idx, 1ULL << apshift);
@@ -911,7 +941,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
         return -1;
     }
=20
-    return deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, addr)
+    return deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, apshift, =
addr)
         & TARGET_PAGE_MASK;
 }
=20
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 4fb00ac17abb..4dc6b3968ec0 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -69,8 +69,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_V_SSIZE_SHIFT    62
 #define HPTE64_V_AVPN_SHIFT     7
 #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
+#define HPTE64_V_AVPN_3_0       0x000fffffffffff80ULL
 #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >> HPTE64_V_AVPN_=
SHIFT)
+#define HPTE64_V_AVPN_VAL_3_0(x)                        \
+    (((x) & HPTE64_V_AVPN_3_0) >> HPTE64_V_AVPN_SHIFT)
 #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) & 0xffffffffffffff83ULL))
+#define HPTE64_V_COMPARE_3_0(x, y)  (!(((x) ^ (y)) & 0x3fffffffffffff83U=
LL))
 #define HPTE64_V_BOLTED         0x0000000000000010ULL
 #define HPTE64_V_LARGE          0x0000000000000004ULL
 #define HPTE64_V_SECONDARY      0x0000000000000002ULL
@@ -81,6 +85,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_R_KEY_HI         0x3000000000000000ULL
 #define HPTE64_R_RPN_SHIFT      12
 #define HPTE64_R_RPN            0x0ffffffffffff000ULL
+#define HPTE64_R_RPN_3_0        0x01fffffffffff000ULL
 #define HPTE64_R_FLAGS          0x00000000000003ffULL
 #define HPTE64_R_PP             0x0000000000000003ULL
 #define HPTE64_R_N              0x0000000000000004ULL
@@ -104,9 +109,34 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define PTCR_PTAB               0x0FFFFFFFFFFFF000ULL /* Partition Table=
 Base */
 #define PTCR_PTAS               0x000000000000001FULL /* Partition Table=
 Size */
=20
+static inline target_ulong ppc_hash64_hpte_r_rpn(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    return env->mmu_model & POWERPC_MMU_V3 ? HPTE64_R_RPN_3_0 : HPTE64_R=
_RPN;
+}
+
+static inline target_ulong ppc_hash64_hpte_v_avpn(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    return env->mmu_model & POWERPC_MMU_V3 ? HPTE64_V_AVPN_3_0 : HPTE64_=
V_AVPN;
+}
+
+static inline target_ulong ppc_hash64_hpte_v_avpn_val(PowerPCCPU *cpu,
+                                                      target_ulong pte0)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    return env->mmu_model & POWERPC_MMU_V3 ?
+        HPTE64_V_AVPN_VAL_3_0(pte0) : HPTE64_V_AVPN_VAL(pte0);
+}
+
+hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu);
+
 static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 {
-    return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
+    return ppc_hash64_hpt_reg(cpu) & SDR_64_HTABORG;
 }
=20
 static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
@@ -116,7 +146,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *=
cpu)
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         return vhc->hpt_mask(cpu->vhyp);
     }
-    return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 - 7=
)) - 1;
+    return (1ULL << ((ppc_hash64_hpt_reg(cpu) & SDR_64_HTABSIZE) + 18 - =
7)) - 1;
 }
=20
 struct ppc_hash_pte64 {
--=20
2.13.6
