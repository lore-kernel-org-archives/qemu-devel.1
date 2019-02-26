Received: from eggs.gnu.org ([209.51.188.92]:57862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkq-00051D-Vb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkp-0002Um-Cb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:37 +1100
Message-Id: <20190226045304.25618-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/50] target/ppc: Add basic support for "new
 format" HPTE as found on POWER9
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

POWER9 (arch v3) slightly changes the HPTE format. The B bits move
from the first to the second half of the HPTE, and the AVPN/ARPN
are slightly shorter.

However, under SPAPR, the hypercalls still take the old format
(and probably will for the foreseable future).

The simplest way to support this is thus to convert the HPTEs from
new to old format when reading them if the MMU model is v3 and there
is no virtual hypervisor, leaving the rest of the code unchanged.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-8-clg@kaod.org>
[dwg: Moved function to .c since there was no real need for it in the .h]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 17 +++++++++++++++++
 target/ppc/mmu-hash64.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index fbefe5b5aa..3c057a8c70 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -490,6 +490,18 @@ static unsigned hpte_page_shift(const PPCHash64Segme=
ntPageSizes *sps,
     return 0; /* Bad page size encoding */
 }
=20
+static void ppc64_v3_new_to_old_hpte(target_ulong *pte0, target_ulong *p=
te1)
+{
+    /* Insert B into pte0 */
+    *pte0 =3D (*pte0 & HPTE64_V_COMMON_BITS) |
+            ((*pte1 & HPTE64_R_3_0_SSIZE_MASK) <<
+             (HPTE64_V_SSIZE_SHIFT - HPTE64_R_3_0_SSIZE_SHIFT));
+
+    /* Remove B from pte1 */
+    *pte1 =3D *pte1 & ~HPTE64_R_3_0_SSIZE_MASK;
+}
+
+
 static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
                                      const PPCHash64SegmentPageSizes *sp=
s,
                                      target_ulong ptem,
@@ -515,6 +527,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
, hwaddr hash,
         smp_rmb();
         pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
=20
+        /* Convert format if necessary */
+        if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00 && !cpu->vhyp) {
+            ppc64_v3_new_to_old_hpte(&pte0, &pte1);
+        }
+
         /* This compares V, B, H (secondary) and the AVPN */
         if (HPTE64_V_COMPARE(pte0, ptem)) {
             *pshift =3D hpte_page_shift(sps, pte0, pte1);
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f11efc9cbc..016d6b44ee 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -102,6 +102,11 @@ void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
 #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
 #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
=20
+/* Format changes for ARCH v3 */
+#define HPTE64_V_COMMON_BITS    0x000fffffffffffffULL
+#define HPTE64_R_3_0_SSIZE_SHIFT 58
+#define HPTE64_R_3_0_SSIZE_MASK (3ULL << HPTE64_R_3_0_SSIZE_SHIFT)
+
 static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 {
     if (cpu->vhyp) {
--=20
2.20.1
