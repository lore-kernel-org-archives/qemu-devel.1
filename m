Received: from eggs.gnu.org ([209.51.188.92]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdl-0007kp-Sf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdk-0008AS-OR
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:57 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:49650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUdk-00086V-AM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:56 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.230])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 943A1121D05
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:00:50 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 10:00:00 +0200
Message-Id: <20190411080004.8690-3-clg@kaod.org>
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] ppc/spapr: Use proper HPTE accessors for
 H_READ
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

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_hcall.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index be8044a92f2f..7761d4a841af 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -304,8 +304,8 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
 {
     target_ulong flags =3D args[0];
     target_ulong ptex =3D args[1];
-    uint8_t *hpte;
     int i, ridx, n_entries =3D 1;
+    const ppc_hash_pte64_t *hptes;
=20
     if (!valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
@@ -317,13 +317,12 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
         n_entries =3D 4;
     }
=20
-    hpte =3D spapr->htab + (ptex * HASH_PTE_SIZE_64);
-
+    hptes =3D ppc_hash64_map_hptes(cpu, ptex, n_entries);
     for (i =3D 0, ridx =3D 0; i < n_entries; i++) {
-        args[ridx++] =3D ldq_p(hpte);
-        args[ridx++] =3D ldq_p(hpte + (HASH_PTE_SIZE_64/2));
-        hpte +=3D HASH_PTE_SIZE_64;
+        args[ridx++] =3D ppc_hash64_hpte0(cpu, hptes, i);
+        args[ridx++] =3D ppc_hash64_hpte1(cpu, hptes, i);
     }
+    ppc_hash64_unmap_hptes(cpu, hptes, ptex, n_entries);
=20
     return H_SUCCESS;
 }
--=20
2.20.1
