Received: from eggs.gnu.org ([209.51.188.92]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrF-0001y9-Te
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrD-0005nN-QZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33546
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrD-0005J6-JD
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FH0H9E078751
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnyvrcnfe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:24 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-8-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/12] target/ppc: Add basic support for "new
 format" HPTE as found on POWER9
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
---
 target/ppc/mmu-book3s-v3.h | 12 ++++++++++++
 target/ppc/mmu-hash64.h    |  5 +++++
 target/ppc/mmu-hash64.c    |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 4e59742d7eac..216ff296c088 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -56,6 +56,18 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
     return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
 }
=20
+static inline void ppc64_v3_new_to_old_hpte(target_ulong *pte0,
+                                            target_ulong *pte1)
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
 hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
=20
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f11efc9cbc1f..016d6b44ee75 100644
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
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index b3c4d33faa55..9afaab8a177c 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -514,6 +514,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
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
--=20
2.20.1
