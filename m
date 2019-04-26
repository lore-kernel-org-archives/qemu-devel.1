Received: from eggs.gnu.org ([209.51.188.92]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1P-0006TO-9m
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1O-0005ks-7n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:24 +1000
Message-Id: <20190426060627.18153-34-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/36] ppc/spapr: Use proper HPTE accessors for
 H_READ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..3534079777 100644
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
