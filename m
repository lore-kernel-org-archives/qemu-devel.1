Received: from eggs.gnu.org ([2001:4830:134:3::10]:54135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006eP-Sk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003Mw-LG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:19 +1000
Message-Id: <20170915035130.8354-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/18] ppc/xive: fix OV5_XIVE_EXPLOIT bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On POWER9, the Client Architecture Support (CAS) negotiation process
determines whether the guest operates in XIVE Legacy compatibility or
in XIVE exploitation mode. Now that we have initial guest support for
the XIVE interrupt controller, let's fix the bits definition which have
evolved in the latest specs.

The platform advertises the XIVE Exploitation Mode support using the
property "ibm,arch-vec-5-platform-support-vec-5", byte 23 bits 0-1 :

 - 0b00 XIVE legacy mode Only
 - 0b01 XIVE exploitation mode Only
 - 0b10 XIVE legacy or exploitation mode

The OS asks for XIVE Exploitation Mode support using the property
"ibm,architecture-vec-5", byte 23 bits 0-1:

 - 0b00 XIVE legacy mode Only
 - 0b01 XIVE exploitation mode Only

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 2 +-
 include/hw/ppc/spapr_ovec.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 06a008b43c..f680f28a15 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -937,7 +937,7 @@ static void spapr_dt_ov5_platform_support(void *fdt, =
int chosen)
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
     char val[2 * 4] =3D {
-        23, 0x00, /* Xive mode: 0 =3D legacy (as in ISA 2.7), 1 =3D Expl=
oitation */
+        23, 0x00, /* Xive mode, filled in below. */
         24, 0x00, /* Hash/Radix, filled in below. */
         25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
         26, 0x40, /* Radix options: GTSE =3D=3D yes. */
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 9edfa5ff75..bf25e5d954 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -51,7 +51,8 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
 #define OV5_HPT_RESIZE          OV_BIT(6, 7)
-#define OV5_XIVE_EXPLOIT        OV_BIT(23, 7)
+#define OV5_XIVE_BOTH           OV_BIT(23, 0)
+#define OV5_XIVE_EXPLOIT        OV_BIT(23, 1) /* 1=3Dexploitation 0=3Dle=
gacy */
=20
 /* ISA 3.00 MMU features: */
 #define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */
--=20
2.13.5
