Received: from eggs.gnu.org ([209.51.188.92]:33648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrI-00022h-L5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrG-0005v7-EN
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55640
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrF-0005Js-Q6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxnOQ096133
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0u6spem-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:28 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-12-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/12] target/ppc: Support for POWER9 native
 hash
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

(Might need more patch splitting)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-book3s-v3.h | 45 ++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h    | 19 +---------------
 target/ppc/mmu-book3s-v3.c | 18 +++++++++++++++
 target/ppc/mmu-hash64.c    |  6 +++--
 4 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 8474dfec41d9..f423d51f68ab 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -55,6 +55,9 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
     return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
 }
=20
+bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid,
+                       ppc_v3_pate_t *entry);
+
 /*
  * The LPCR:HR bit is a shortcut that avoids having to
  * dig out the partition table in the fast path. This is
@@ -82,6 +85,48 @@ hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, v=
addr eaddr);
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx);
=20
+static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        return 0;
+    }
+    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base =3D pate.dw0;
+    } else {
+        base =3D cpu->env.spr[SPR_SDR1];
+    }
+    return base & SDR_64_HTABORG;
+}
+
+static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
+{
+    uint64_t base;
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        return vhc->hpt_mask(cpu->vhyp);
+    }
+    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            return 0;
+        }
+        base =3D pate.dw0;
+    } else {
+        base =3D cpu->env.spr[SPR_SDR1];
+    }
+    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
+}
+
 #endif /* TARGET_PPC64 */
=20
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 016d6b44ee75..6b555b72200f 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -63,6 +63,7 @@ void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
 #define SDR_64_HTABORG         0x0FFFFFFFFFFC0000ULL
 #define SDR_64_HTABSIZE        0x000000000000001FULL
=20
+#define PATE0_HTABORG           0x0FFFFFFFFFFC0000ULL
 #define HPTES_PER_GROUP         8
 #define HASH_PTE_SIZE_64        16
 #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
@@ -107,24 +108,6 @@ void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
 #define HPTE64_R_3_0_SSIZE_SHIFT 58
 #define HPTE64_R_3_0_SSIZE_MASK (3ULL << HPTE64_R_3_0_SSIZE_SHIFT)
=20
-static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
-{
-    if (cpu->vhyp) {
-        return 0;
-    }
-    return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
-}
-
-static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
-{
-    if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =3D
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        return vhc->hpt_mask(cpu->vhyp);
-    }
-    return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 - 7=
)) - 1;
-}
-
 struct ppc_hash_pte64 {
     uint64_t pte0, pte1;
 };
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index ccbae3213cc1..400529d683cf 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -39,3 +39,21 @@ hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, v=
addr eaddr)
         return ppc_hash64_get_phys_page_debug(cpu, eaddr);
     }
 }
+
+bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t=
 *entry)
+{
+    uint64_t patb =3D cpu->env.spr[SPR_PTCR] & PTCR_PATB;
+    uint64_t pats =3D cpu->env.spr[SPR_PTCR] & PTCR_PATS;
+
+    /* Calculate number of entries */
+    pats =3D 1ull << (pats + 12 - 4);
+    if (pats <=3D lpid) {
+        return false;
+    }
+
+    /* Grab entry */
+    patb +=3D 16 * lpid;
+    entry->dw0 =3D ldq_phys(CPU(cpu)->as, patb);
+    entry->dw1 =3D ldq_phys(CPU(cpu)->as, patb + 8);
+    return true;
+}
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 9afaab8a177c..a401f257a34f 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -416,7 +416,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCC=
PU *cpu,
                                              hwaddr ptex, int n)
 {
     hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
-    hwaddr base =3D ppc_hash64_hpt_base(cpu);
+    hwaddr base;
     hwaddr plen =3D n * HASH_PTE_SIZE_64;
     const ppc_hash_pte64_t *hptes;
=20
@@ -425,6 +425,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCC=
PU *cpu,
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         return vhc->map_hptes(cpu->vhyp, ptex, n);
     }
+    base =3D ppc_hash64_hpt_base(cpu);
=20
     if (!base) {
         return NULL;
@@ -928,7 +929,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
 void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                            uint64_t pte0, uint64_t pte1)
 {
-    hwaddr base =3D ppc_hash64_hpt_base(cpu);
+    hwaddr base;
     hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
=20
     if (cpu->vhyp) {
@@ -937,6 +938,7 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr pt=
ex,
         vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
         return;
     }
+    base =3D ppc_hash64_hpt_base(cpu);
=20
     stq_phys(CPU(cpu)->as, base + offset, pte0);
     stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, pte1);
--=20
2.20.1
