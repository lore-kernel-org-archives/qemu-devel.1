Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWs-0006lm-55
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWn-0003IN-Ty
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:29 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgWl-0003BD-Vb
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:24 -0500
Received: from player714.ha.ovh.net (unknown [10.109.143.225])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1D8F61E9A05
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:25 +0100
Message-Id: <20181205232251.10446-12-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 11/37] spapr/xive: use the VCPU id as a NVT
 identifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The IVPE scans the O/S CAM line of the XIVE thread interrupt contexts
to find a matching Notification Virtual Target (NVT) among the NVTs
dispatched on the HW processor threads.

On a real system, the thread interrupt contexts are updated by the
hypervisor when a Virtual Processor is scheduled to run on a HW
thread. Under QEMU, the model will emulate the same behavior by
hardwiring the NVT identifier in the thread context registers at
reset.

The NVT identifier used by the sPAPRXive model is the VCPU id. The END
identifier is also derived from the VCPU id. A set of helpers doing
the conversion between identifiers are provided for the hcalls
configuring the sources and the ENDs.

The model does not need a NVT table but The XiveRouter NVT operations
are provided to perform some extra checks in the routing algorithm.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index eef5830d45c6..8da7a8bee949 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -26,6 +26,27 @@
 #define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
 #define SPAPR_XIVE_TM_BASE   0x0006030203180000ull
=20
+/*
+ * The allocation of VP blocks is a complex operation in OPAL and the
+ * VP identifiers have a relation with the number of HW chips, the
+ * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
+ * controller model does not have the same constraints and can use a
+ * simple mapping scheme of the CPU vcpu_id
+ *
+ * These identifiers are never returned to the OS.
+ */
+
+#define SPAPR_XIVE_NVT_BASE 0x400
+
+/*
+ * sPAPR NVT and END indexing helpers
+ */
+static uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt_bl=
k,
+                                  uint32_t nvt_idx)
+{
+    return nvt_idx - SPAPR_XIVE_NVT_BASE;
+}
+
 /*
  * On sPAPR machines, use a simplified output for the XIVE END
  * structure dumping only the information related to the OS EQ.
@@ -40,7 +61,8 @@ static void spapr_xive_end_pic_print_info(sPAPRXive *xi=
ve, XiveEND *end,
     uint32_t nvt =3D GETFIELD_BE32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end->w7);
=20
-    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d", nvt,
+    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
+                   spapr_xive_nvt_to_target(xive, 0, nvt),
                    priority, qindex, qentries, qgen);
=20
     xive_end_queue_pic_print_info(end, 6, mon);
@@ -246,6 +268,33 @@ static int spapr_xive_write_end(XiveRouter *xrtr, ui=
nt8_t end_blk,
     return 0;
 }
=20
+static int spapr_xive_get_nvt(XiveRouter *xrtr,
+                              uint8_t nvt_blk, uint32_t nvt_idx, XiveNVT=
 *nvt)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    uint32_t vcpu_id =3D spapr_xive_nvt_to_target(xive, nvt_blk, nvt_idx=
);
+    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    /*
+     * sPAPR does not maintain a NVT table. Return that the NVT is
+     * valid if we have found a matching CPU
+     */
+    nvt->w0 =3D cpu_to_be32(NVT_W0_VALID);
+    return 0;
+}
+
+static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
+                                uint32_t nvt_idx, XiveNVT *nvt,
+                                uint8_t word_number)
+{
+    /* no NVT table */
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -308,6 +357,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_eas =3D spapr_xive_get_eas;
     xrc->get_end =3D spapr_xive_get_end;
     xrc->write_end =3D spapr_xive_write_end;
+    xrc->get_nvt =3D spapr_xive_get_nvt;
+    xrc->write_nvt =3D spapr_xive_write_nvt;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
--=20
2.17.2
