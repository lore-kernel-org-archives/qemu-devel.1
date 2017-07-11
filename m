Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxS-0002Qq-TM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxR-0007Xq-Vg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:16 +1000
Message-Id: <20170711043917.1757-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/17] spapr: introduce the XIVE_EXPLOIT option
 in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On POWER9, the Client Architecture Support (CAS) negotiation process
determines whether the guest operates in XIVE Legacy compatibility
(the former POWER8 interrupt model) or in XIVE exploitation mode (the
newer POWER9 interrupt model).

Bit 7 of Byte 23 of vector 5 is used for this purpose.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 13 +++++++------
 include/hw/ppc/spapr_ovec.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ba8f57a..ff78a22 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -910,7 +910,8 @@ static void spapr_dt_ov5_platform_support(void *fdt, =
int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
-    char val[2 * 3] =3D {
+    char val[2 * 4] =3D {
+        23, 0x00, /* Xive mode: 0 =3D legacy (as in ISA 2.7), 1 =3D Expl=
oitation */
         24, 0x00, /* Hash/Radix, filled in below. */
         25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
         26, 0x40, /* Radix options: GTSE =3D=3D yes. */
@@ -918,19 +919,19 @@ static void spapr_dt_ov5_platform_support(void *fdt=
, int chosen)
=20
     if (kvm_enabled()) {
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) =
{
-            val[1] =3D 0x80; /* OV5_MMU_BOTH */
+            val[3] =3D 0x80; /* OV5_MMU_BOTH */
         } else if (kvmppc_has_cap_mmu_radix()) {
-            val[1] =3D 0x40; /* OV5_MMU_RADIX_300 */
+            val[3] =3D 0x40; /* OV5_MMU_RADIX_300 */
         } else {
-            val[1] =3D 0x00; /* Hash */
+            val[3] =3D 0x00; /* Hash */
         }
     } else {
         if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
             /* V3 MMU supports both hash and radix (with dynamic switchi=
ng) */
-            val[1] =3D 0xC0;
+            val[3] =3D 0xC0;
         } else {
             /* Otherwise we can only do hash */
-            val[1] =3D 0x00;
+            val[3] =3D 0x00;
         }
     }
     _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index f088833..0b464e2 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -50,6 +50,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
+#define OV5_XIVE_EXPLOIT        OV_BIT(23, 7)
=20
 /* ISA 3.00 MMU features: */
 #define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */
--=20
2.9.4
