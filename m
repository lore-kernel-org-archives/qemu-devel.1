Received: from eggs.gnu.org ([2001:4830:134:3::10]:35039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwAL-0003pK-5A
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwAG-0003ym-CG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:21 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:58104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAwAG-0003x6-5f
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:16 -0400
Received: from player774.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C73A3F1066
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 13:31:14 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 24 Apr 2018 13:30:44 +0200
Message-Id: <20180424113045.25687-5-clg@kaod.org>
In-Reply-To: <20180424113045.25687-1-clg@kaod.org>
References: <20180424113045.25687-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/5] target/ppc: add hash MMU support for
 PowerNV POWER9 machines
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

On a POWER9 processor, the Partition Table is composed of a pair of
doublewords per partition. The first doubleword indicates whether the
partition uses HPT or Radix Trees translation and contains the address
of the host's translation table structure and size.

The first doubleword of the PTCR holds the Hash Page Table base
address for the host when the hash MMU is in use. Add an helper to
retrieve the HPT base address depending on the MMU revision.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-book3s-v3.h |  5 +++++
 target/ppc/mmu-hash64.c    | 20 ++++++++++++++++++++
 target/ppc/mmu-hash64.h    |  6 ++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index fdf80987d7b2..a7ab580c3140 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -54,6 +54,11 @@ static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx);
=20
+static inline hwaddr ppc64_v3_get_patbe0(PowerPCCPU *cpu)
+{
+    return ldq_phys(CPU(cpu)->as, cpu->env.spr[SPR_PTCR] & PTCR_PATB);
+}
+
 #endif /* TARGET_PPC64 */
=20
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index ecea2ae04dd3..fae164d30706 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -290,6 +290,26 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env, =
target_ulong rb)
     return rt;
 }
=20
+hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    /* We should not reach this routine on sPAPR machines */
+    assert(!cpu->vhyp);
+
+    /* PowerNV machine */
+    if (msr_hv) {
+        if (env->mmu_model & POWERPC_MMU_3_00) {
+            return ppc64_v3_get_patbe0(cpu);
+        } else {
+            return cpu->env.spr[SPR_SDR1];
+        }
+    } else {
+        error_report("PowerNV guest support Unimplemented");
+        exit(1);
+    }
+}
+
 /* Check No-Execute or Guarded Storage */
 static inline int ppc_hash64_pte_noexec_guard(PowerPCCPU *cpu,
                                               ppc_hash_pte64_t pte)
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index a3a0de452b94..daf3ba27e2cc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -129,12 +129,14 @@ static inline target_ulong ppc_hash64_hpte_v_avpn_v=
al(PowerPCCPU *cpu,
         HPTE64_V_AVPN_VAL_3_0(pte0) : HPTE64_V_AVPN_VAL(pte0);
 }
=20
+hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu);
+
 static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 {
     if (cpu->vhyp) {
         return 0;
     }
-    return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
+    return ppc_hash64_hpt_reg(cpu) & SDR_64_HTABORG;
 }
=20
 static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
@@ -144,7 +146,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *=
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
