Received: from eggs.gnu.org ([209.51.188.92]:58061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlF-0005Mw-B6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUl9-0002rV-BG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:30 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:36 +1100
Message-Id: <20190226045304.25618-23-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/50] target/ppc: Fix ordering of hash MMU
 accesses
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

With mttcg, we can have MMU lookups happening at the same time
as the guest modifying the page tables.

Since the HPTEs of the hash table MMU contains two words (or
double worlds on 64-bit), we need to make sure we read them
in the right order, with the correct memory barrier.

Additionally, when using emulated SPAPR mode, the hypercalls
writing to the hash table must also perform the udpates in
the right order.

Note: This part is still not entirely correct

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 21 +++++++++++++++++++--
 target/ppc/mmu-hash32.c |  6 ++++++
 target/ppc/mmu-hash64.c |  6 ++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 84f6e9d9a8..d2520bc662 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1524,8 +1524,25 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
*vhyp, hwaddr ptex,
     if (!spapr->htab) {
         kvmppc_write_hpte(ptex, pte0, pte1);
     } else {
-        stq_p(spapr->htab + offset, pte0);
-        stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
+        if (pte0 & HPTE64_V_VALID) {
+            stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
+            /*
+             * When setting valid, we write PTE1 first. This ensures
+             * proper synchronization with the reading code in
+             * ppc_hash64_pteg_search()
+             */
+            smp_wmb();
+            stq_p(spapr->htab + offset, pte0);
+        } else {
+            stq_p(spapr->htab + offset, pte0);
+            /*
+             * When clearing it we set PTE0 first. This ensures proper
+             * synchronization with the reading code in
+             * ppc_hash64_pteg_search()
+             */
+            smp_wmb();
+            stq_p(spapr->htab + offset + HASH_PTE_SIZE_64 / 2, pte1);
+        }
     }
 }
=20
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 03ae3c1279..e8562a7c87 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -319,6 +319,12 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu=
, hwaddr pteg_off,
=20
     for (i =3D 0; i < HPTES_PER_GROUP; i++) {
         pte0 =3D ppc_hash32_load_hpte0(cpu, pte_offset);
+        /*
+         * pte0 contains the valid bit and must be read before pte1,
+         * otherwise we might see an old pte1 with a new valid bit and
+         * thus an inconsistent hpte value
+         */
+        smp_rmb();
         pte1 =3D ppc_hash32_load_hpte1(cpu, pte_offset);
=20
         if ((pte0 & HPTE32_V_VALID)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 1175b991d9..fbefe5b5aa 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -507,6 +507,12 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
, hwaddr hash,
     }
     for (i =3D 0; i < HPTES_PER_GROUP; i++) {
         pte0 =3D ppc_hash64_hpte0(cpu, pteg, i);
+        /*
+         * pte0 contains the valid bit and must be read before pte1,
+         * otherwise we might see an old pte1 with a new valid bit and
+         * thus an inconsistent hpte value
+         */
+        smp_rmb();
         pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
=20
         /* This compares V, B, H (secondary) and the AVPN */
--=20
2.20.1
