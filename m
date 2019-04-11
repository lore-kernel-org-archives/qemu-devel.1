Received: from eggs.gnu.org ([209.51.188.92]:48504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUeR-0000AI-Se
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUeQ-00008F-G6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:39 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:43711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUeN-0008Qu-T6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:37 -0400
Received: from player779.ha.ovh.net (unknown [10.109.143.146])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 8716710E81D
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:01:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 10:00:04 +0200
Message-Id: <20190411080004.8690-7-clg@kaod.org>
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] ppc: Fix radix RC updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

They should be atomic for MTTCG. Note: a real POWER9 core doesn't actuall=
y
implement atomic PTE updates, it always fault for SW to handle it. Only
the nest MMU (used by some accelerator devices and GPUs) implements
those HW updates.

However, the architecture does allow the core to do it, and doing so
in TCG is faster than letting the guest do it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         |  1 +
 target/ppc/mmu-radix64.c | 70 +++++++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a4420636dde0..5b4249ebdcbf 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -503,6 +503,7 @@ typedef struct ppc_v3_pate_t {
 #define DSISR_AMR                0x00200000
 /* Unsupported Radix Tree Configuration */
 #define DSISR_R_BADCONFIG        0x00080000
+#define DSISR_ATOMIC_RC          0x00040000
=20
 /* SRR1 error code fields */
=20
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index cac076ee92d9..458085d79ee0 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -28,6 +28,15 @@
 #include "mmu-radix64.h"
 #include "mmu-book3s-v3.h"
=20
+static inline bool ppc_radix64_hw_rc_updates(CPUPPCState *env)
+{
+#ifdef CONFIG_ATOMIC64
+    return true;
+#else
+    return !qemu_tcg_mttcg_enabled();
+#endif
+}
+
 static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr=
 eaddr,
                                                  uint64_t *lpid, uint64_=
t *pid)
 {
@@ -136,11 +145,19 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 int rwx, uint64_t pte,
         return true;
     }
=20
+    /* Check RC bits if necessary */
+    if (!ppc_radix64_hw_rc_updates(env)) {
+        if (!(pte & R_PTE_R) || ((rwx =3D=3D 1) && !(pte & R_PTE_C))) {
+            *fault_cause |=3D DSISR_ATOMIC_RC;
+            return true;
+        }
+    }
+
     return false;
 }
=20
-static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
-                               hwaddr pte_addr, int *prot)
+static uint64_t ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pt=
e,
+                                   hwaddr pte_addr)
 {
     CPUState *cs =3D CPU(cpu);
     uint64_t npte;
@@ -149,17 +166,39 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int=
 rwx, uint64_t pte,
=20
     if (rwx =3D=3D 1) { /* Store/Write */
         npte |=3D R_PTE_C; /* Set change bit */
-    } else {
+    }
+    if (pte =3D=3D npte) {
+        return pte;
+    }
+
+#ifdef CONFIG_ATOMIC64
+    if (qemu_tcg_mttcg_enabled()) {
+        uint64_t old_be =3D cpu_to_be32(pte);
+        uint64_t new_be =3D cpu_to_be32(npte);
+        MemTxResult result;
+        uint64_t old_ret;
+
+        old_ret =3D address_space_cmpxchgq_notdirty(cs->as, pte_addr,
+                                                  old_be, new_be,
+                                                  MEMTXATTRS_UNSPECIFIED=
,
+                                                  &result);
+        if (result =3D=3D MEMTX_OK) {
+            if (old_ret !=3D old_be && old_ret !=3D new_be) {
+                return 0;
+            }
+            return npte;
+        }
+
         /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit.
+         * Do we need to support this case where PTEs aren't in RAM ?
+         *
+         * For now fallback to non-atomic case
          */
-        *prot &=3D ~PAGE_WRITE;
     }
+#endif
=20
-    if (pte ^ npte) { /* If pte has changed then write it back */
-        stq_phys(cs->as, pte_addr, npte);
-    }
+    stq_phys(cs->as, pte_addr, npte);
+    return npte;
 }
=20
 static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
@@ -288,6 +327,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
=20
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     page_size =3D PRTBE_R_GET_RTS(prtbe0);
+ restart:
     pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
                                 prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
                                 &raddr, &page_size, &fault_cause, &pte_a=
ddr);
@@ -298,8 +338,16 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
     }
=20
     /* Update Reference and Change Bits */
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
-
+    if (ppc_radix64_hw_rc_updates(env)) {
+        pte =3D ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
+        if (!pte) {
+            goto restart;
+        }
+    }
+    /* If the page doesn't have C, treat it as read only */
+    if (!(pte & R_PTE_C)) {
+        prot &=3D ~PAGE_WRITE;
+    }
     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
                  prot, mmu_idx, 1UL << page_size);
     return 0;
--=20
2.20.1
