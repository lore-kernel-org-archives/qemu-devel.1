Received: from eggs.gnu.org ([2001:4830:134:3::10]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZpH-0007uy-3s
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZpC-0002bK-76
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:51 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxZpC-0002b0-0b
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:46 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D03F23571F
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:57:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Apr 2017 15:56:58 +0200
Message-Id: <1491832618-27536-9-git-send-email-clg@kaod.org>
In-Reply-To: <1491832618-27536-1-git-send-email-clg@kaod.org>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] ppc/pnv: generate an OEM SEL event on
 shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

OpenPOWER systems expect to be notified with such an event before a
shutdown or a reboot. An OEM SEL message is sent with specific
identifiers and a user data containing the request : OFF or REBOOT.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 Changes since v1:

 - changed the prototype of the helper routine

 hw/ppc/pnv.c         | 14 ++++++++++++++
 hw/ppc/pnv_bmc.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h |  2 ++
 3 files changed, 57 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bb9bb746e04a..f7ee592180dc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -467,6 +467,15 @@ static void *powernv_create_fdt(MachineState *machin=
e)
     return fdt;
 }
=20
+static void pnv_powerdown_notify(Notifier *n, void *opaque)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
+
+    if (pnv->bmc) {
+        pnv_bmc_powerdown(pnv->bmc);
+    }
+}
+
 static void ppc_powernv_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
@@ -620,6 +629,11 @@ static void ppc_powernv_init(MachineState *machine)
=20
     /* Create an RTC ISA device too */
     rtc_init(pnv->isa_bus, 2000, NULL);
+
+    /* OpenPOWER systems use a IPMI SEL Event message to notify the
+     * host to powerdown */
+    pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
+    qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
 }
=20
 /*
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index a0820dca559b..7b60b4c36071 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -32,6 +32,47 @@
 /* TODO: include definition in ipmi.h */
 #define IPMI_SDR_FULL_TYPE 1
=20
+/*
+ * OEM SEL Event data packet sent by BMC in response of a Read Event
+ * Message Buffer command
+ */
+typedef struct OemSel {
+    /* SEL header */
+    uint8_t id[2];
+    uint8_t type;
+    uint8_t timestamp[4];
+    uint8_t manuf_id[3];
+
+    /* OEM SEL data (6 bytes) follows */
+    uint8_t netfun;
+    uint8_t cmd;
+    uint8_t data[4];
+} OemSel;
+
+#define SOFT_OFF        0x00
+#define SOFT_REBOOT     0x01
+
+static void pnv_gen_oem_sel(IPMIBmc *bmc, uint8_t reboot)
+{
+    /* IPMI SEL Event are 16 bytes long */
+    OemSel sel =3D {
+        .id        =3D { 0x55 , 0x55 },
+        .type      =3D 0xC0, /* OEM */
+        .manuf_id  =3D { 0x0, 0x0, 0x0 },
+        .timestamp =3D { 0x0, 0x0, 0x0, 0x0 },
+        .netfun    =3D 0x3A, /* IBM */
+        .cmd       =3D 0x04, /* AMI OEM SEL Power Notification */
+        .data      =3D { reboot, 0xFF, 0xFF, 0xFF },
+    };
+
+    ipmi_bmc_gen_event(bmc, (uint8_t *) &sel, 0 /* do not log the event =
*/);
+}
+
+void pnv_bmc_powerdown(IPMIBmc *bmc)
+{
+    pnv_gen_oem_sel(bmc, SOFT_OFF);
+}
+
 void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt)
 {
     int offset;
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 02f6cf565ca4..c1288f974d4a 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -134,6 +134,7 @@ typedef struct PnvMachineState {
     uint32_t     cpld_irqstate;
=20
     IPMIBmc      *bmc;
+    Notifier     powerdown_notifier;
 } PnvMachineState;
=20
 #define PNV_FDT_ADDR          0x01000000
@@ -143,6 +144,7 @@ typedef struct PnvMachineState {
  * BMC helpers
  */
 void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt);
+void pnv_bmc_powerdown(IPMIBmc *bmc);
=20
 /*
  * POWER8 MMIO base addresses
--=20
2.7.4
