Received: from eggs.gnu.org ([2001:4830:134:3::10]:46204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalj-0002Gg-0U
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalf-0008Mm-3s
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:59 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:40941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNale-0008M3-Tk
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:55 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A08751277E1
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:38 +0100
Message-Id: <20171209084338.29395-20-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/19] spapr: advertise XIVE exploitation
 mode in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 867c9d759f3b..e52c510812d9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -989,10 +989,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
     spapr_dt_rtas_tokens(fdt, rtas);
 }
=20
-/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU feat=
ures
- * that the guest may request and thus the valid values for bytes 24..26=
 of
- * option vector 5: */
-static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
+ * and the XIVE features that the guest may request and thus the valid
+ * values for bytes 23..26 of option vector 5: */
+static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
+                                          int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
@@ -1015,7 +1016,16 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
+         * irqchip=3Doff for now
+         */
+        if (spapr->xive_exploitation) {
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        }
     } else {
+        if (spapr->xive_exploitation) {
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        }
         /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
         val[3] =3D 0xC0;
     }
@@ -1076,7 +1086,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout=
_path));
     }
=20
-    spapr_dt_ov5_platform_support(fdt, chosen);
+    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -2487,6 +2497,11 @@ static void ppc_spapr_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
     }
=20
+    /* advertise XIVE if not disabled by the user */
+    if (spapr->xive_exploitation) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+    }
+
     /* init CPUs */
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
--=20
2.13.6
