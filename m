Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalE-0001q9-B0
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalA-0007ve-Dl
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:28 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:38295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNalA-0007v8-5W
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:24 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id B396612775C
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:22 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:33 +0100
Message-Id: <20171209084338.29395-15-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/19] spapr: introduce a helper to map the
 XIVE memory regions
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

When the XIVE exploitation interrupt mode is activated, the machine
needs to expose to the guest the MMIO regions used by the controller :

  - Event State Buffers
  - Thread Interrupt Management Area for the OS and User views

Migration will also need to reflect the current interrupt mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:
=20
 - moved the mapping of the XIVE memory region under the machine reset
   handler.

 hw/intc/spapr_xive.c        | 10 ++++++++++
 hw/ppc/spapr.c              | 10 ++++++++++
 include/hw/ppc/spapr_xive.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index bf30edc87bee..fcdadf727f9d 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -970,3 +970,13 @@ XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t =
server, uint8_t priority)
     }
     return &nvt->eqt[priority];
 }
+
+void spapr_xive_mmio_map(sPAPRXive *xive)
+{
+    /* ESBs */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
+
+    /* Thread Management Interrupt Area: User and OS views */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->tm_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base + (1 << TM_SH=
IFT));
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2e15ee8a9333..73df038a9e8b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1537,6 +1537,11 @@ static void ppc_spapr_reset(void)
         ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
     }
=20
+    /* Setup XIVE resources if required by CAS */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_mmio_map(spapr->xive);
+    }
+
     fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
=20
     spapr_load_rtas(spapr, fdt, rtas_addr);
@@ -1644,6 +1649,11 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    /* Restore XIVE resources if required by CAS */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_mmio_map(spapr->xive);
+    }
+
     return err;
 }
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 8c3b9cb194a9..5d0c178a4984 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -59,6 +59,7 @@ bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t li=
sn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 void spapr_xive_nvt_pic_print_info(sPAPRXiveNVT *nvt, Monitor *mon);
+void spapr_xive_mmio_map(sPAPRXive *xive);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
--=20
2.13.6
