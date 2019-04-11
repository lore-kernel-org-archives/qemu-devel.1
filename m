Received: from eggs.gnu.org ([209.51.188.92]:48394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUe1-00085x-UL
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUe0-0008JO-Ot
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:13 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:53005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUe0-0008Hb-FC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:12 -0400
Received: from player779.ha.ovh.net (unknown [10.109.146.175])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 877765BE7B
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:01:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 10:00:02 +0200
Message-Id: <20190411080004.8690-5-clg@kaod.org>
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] ppc/hash32: Rework R and C bit updates
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

With MT-TCG, we are now running translation in a racy way, thus
we need to mimic hardware when it comes to updating the R and
C bits, by doing byte stores.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-hash32.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3f4dee835e2d..55cf156a0b49 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -345,6 +345,24 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu=
, hwaddr pteg_off,
     return -1;
 }
=20
+static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_=
t pte1)
+{
+    target_ulong base =3D ppc_hash32_hpt_base(cpu);
+    hwaddr offset =3D pte_offset + 6;
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+}
+
+static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_=
t pte1)
+{
+    target_ulong base =3D ppc_hash32_hpt_base(cpu);
+    hwaddr offset =3D pte_offset + 7;
+
+    /* The HW performs a non-atomic byte update */
+    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+}
+
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
                                      target_ulong sr, target_ulong eaddr=
,
                                      ppc_hash_pte32_t *pte)
@@ -403,7 +421,6 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr, int rwx,
     hwaddr pte_offset;
     ppc_hash_pte32_t pte;
     int prot;
-    uint32_t new_pte1;
     const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
=20
@@ -519,20 +536,20 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
=20
     /* 8. Update PTE referenced and changed bits if necessary */
=20
-    new_pte1 =3D pte.pte1 | HPTE32_R_R; /* set referenced bit */
-    if (rwx =3D=3D 1) {
-        new_pte1 |=3D HPTE32_R_C; /* set changed (dirty) bit */
-    } else {
-        /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit
-         */
-        prot &=3D ~PAGE_WRITE;
-    }
-
-    if (new_pte1 !=3D pte.pte1) {
-        ppc_hash32_store_hpte1(cpu, pte_offset, new_pte1);
+    if (!(pte.pte1 & HPTE32_R_R)) {
+        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
     }
+    if (!(pte.pte1 & HPTE32_R_C)) {
+        if (rwx =3D=3D 1) {
+            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
+        } else {
+            /*
+             * Treat the page as read-only for now, so that a later writ=
e
+             * will pass through this function again to set the C bit
+             */
+            prot &=3D ~PAGE_WRITE;
+        }
+     }
=20
     /* 9. Determine the real address from the PTE */
=20
--=20
2.20.1
