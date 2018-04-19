Received: from eggs.gnu.org ([2001:4830:134:3::10]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wh-0000yB-Kd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wd-0000bM-OD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:51 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:60483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wd-0000aM-Gz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:47 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.38])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 60D78145D0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:46 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:17 +0200
Message-Id: <20180419124331.3915-22-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/35] spapr: advertise XIVE exploitation
 mode in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Both XIVE and XICS interrupt mode are advertised for the moment.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e3567543e6e6..d05c83cdb322 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1016,10 +1016,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
r, void *fdt)
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
@@ -1042,7 +1043,16 @@ static void spapr_dt_ov5_platform_support(void *fd=
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
@@ -1110,7 +1120,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
     }
=20
-    spapr_dt_ov5_platform_support(fdt, chosen);
+    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -2599,6 +2609,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
         spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
     }
=20
+    /* advertise XIVE if not disabled by the user */
+    if (spapr->xive_exploitation) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+    }
+
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
--=20
2.13.6
