Received: from eggs.gnu.org ([2001:4830:134:3::10]:41054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsV-0003DK-GY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsQ-0002gM-Un
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:15 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:35252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnsQ-0002di-OU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:10 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 57EFAFCC8B
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:03 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:14 +0200
Message-Id: <1499274819-15607-2-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 01/26] spapr: introduce the XIVE_EXPLOIT
 option in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On POWER9, the Client Architecture Support (CAS) negotiation process
determines whether the guest operates in XIVE Legacy compatibility
(the former POWER8 interrupt model) or in XIVE exploitation mode (the
newer POWER9 interrupt model).

Bit 7 of Byte 23 of vector 5 is used for this purpose.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c              | 13 +++++++------
 include/hw/ppc/spapr_ovec.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4d781876b27..27b12adc3582 100644
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
index f088833204de..0b464e22e75d 100644
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
2.7.5
