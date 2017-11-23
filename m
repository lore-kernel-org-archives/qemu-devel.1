Received: from eggs.gnu.org ([2001:4830:134:3::10]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrca-0002Kh-6f
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcW-0003RQ-8Y
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:52 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:45348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcW-0003QO-2i
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:48 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id AA5FF171BED
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:51 +0100
Message-Id: <20171123132955.1261-22-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/25] spapr: introduce a helper to map the
 XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When the XIVE interrupt mode is activated, the machine needs to expose
to the guest the MMIO regions use by the controller :

  - Event State Buffer (ESB)
  - Thread Interrupt Management Area (TIMA)

Migration will also need to reflect the current interrupt mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_hcall.c  | 14 ++++++++++++++
 hw/ppc/spapr.c              |  5 +++++
 include/hw/ppc/spapr_xive.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 60c6c9f4be8f..ba217144878e 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -933,3 +933,17 @@ void spapr_xive_populate(sPAPRMachineState *spapr, i=
nt nr_servers,
     _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
                      plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
 }
+
+void spapr_xive_mmio_map(sPAPRMachineState *spapr)
+{
+    sPAPRXive *xive =3D spapr->xive;
+
+    /* ESBs */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
+
+    /* Thread Management Interrupt Areas */
+    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
+     * region needs some rework in the handlers */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1,
+                    xive->tm_base + (1 << xive->tm_shift));
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3a62369883cc..734706c18cb3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1132,6 +1132,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     } else {
         /* Populate device tree for XIVE */
         spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHANDL=
E_XICP);
+        spapr_xive_mmio_map(spapr);
     }
=20
     ret =3D spapr_populate_memory(spapr, fdt);
@@ -1613,6 +1614,10 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_mmio_map(spapr);
+    }
+
     return err;
 }
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index f6d4bf26e06a..88355f7eb643 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -84,5 +84,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers, void =
*fdt,
                          uint32_t phandle);
+void spapr_xive_mmio_map(sPAPRMachineState *spapr);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.6
