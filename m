Received: from eggs.gnu.org ([2001:4830:134:3::10]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMT-0004Gw-Ja
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMN-0001Lv-Gc
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:25 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:43875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqKMN-0001Ks-BH
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:19 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1C8539564A
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:34:18 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  8 Sep 2017 16:33:42 +0200
Message-Id: <20170908143344.12960-2-clg@kaod.org>
In-Reply-To: <20170908143344.12960-1-clg@kaod.org>
References: <20170908143344.12960-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] ppc/xive: fix OV5_XIVE_EXPLOIT bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
---
 hw/ppc/spapr.c              | 2 +-
 include/hw/ppc/spapr_ovec.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cec441cbf48d..3e3ff1fbc988 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -914,7 +914,7 @@ static void spapr_dt_ov5_platform_support(void *fdt, =
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
index 9edfa5ff7530..bf25e5d954a1 100644
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
