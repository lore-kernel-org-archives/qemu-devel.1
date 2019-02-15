Received: from eggs.gnu.org ([209.51.188.92]:33336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr3-0001oa-LL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr1-0005K6-LP
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47986
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr0-0005ED-Bj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FH03Et142022
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp0ga3ej7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:44 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:42 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:23 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-7-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/12] target/ppc: Fix ordering of hash MMU
 accesses
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
---
 hw/ppc/spapr.c          | 21 +++++++++++++++++++--
 target/ppc/mmu-hash32.c |  6 ++++++
 target/ppc/mmu-hash64.c |  6 ++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 60572eb59275..1afe31ee6163 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1507,8 +1507,25 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
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
index 03ae3c127985..e8562a7c8780 100644
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
index f6c822ef917b..b3c4d33faa55 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -506,6 +506,12 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
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
