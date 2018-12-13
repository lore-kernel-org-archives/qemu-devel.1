Received: from eggs.gnu.org ([2001:4830:134:3::10]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICD-0003ln-Pu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICA-0002KN-IA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:24 +1100
Message-Id: <20181213040126.6768-26-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/27] ppc/xive: notify the CPU when the
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

After the event data was enqueued in the O/S Event Queue, the IVPE
raises the bit corresponding to the priority of the pending interrupt
in the register IBP (Interrupt Pending Buffer) to indicate there is an
event pending in one of the 8 priority queues. The Pending Interrupt
Priority Register (PIPR) is also updated using the IPB. This register
represent the priority of the most favored pending notification.

The PIPR is then compared to the the Current Processor Priority
Register (CPPR). If it is more favored (numerically less than), the
CPU interrupt line is raised and the EO bit of the Notification Source
Register (NSR) is updated to notify the presence of an exception for
the O/S. The check needs to be done whenever the PIPR or the CPPR are
changed.

The O/S acknowledges the interrupt with a special load in the Thread
Interrupt Management Area. If the EO bit of the NSR is set, the CPPR
takes the value of PIPR. The bit number in the IBP corresponding to
the priority of the pending interrupt is reseted and so is the EO bit
of the NSR.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3eecffe99b..ea5385ff77 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -22,9 +22,73 @@
  * XIVE Thread Interrupt Management context
  */
=20
+/* Convert a priority number to an Interrupt Pending Buffer (IPB)
+ * register, which indicates a pending interrupt at the priority
+ * corresponding to the bit number
+ */
+static uint8_t priority_to_ipb(uint8_t priority)
+{
+    return priority > XIVE_PRIORITY_MAX ?
+        0 : 1 << (XIVE_PRIORITY_MAX - priority);
+}
+
+/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
+ * Interrupt Priority Register (PIPR), which contains the priority of
+ * the most favored pending notification.
+ */
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
+static void ipb_update(uint8_t *regs, uint8_t priority)
+{
+    regs[TM_IPB] |=3D priority_to_ipb(priority);
+    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
+}
+
+static uint8_t exception_mask(uint8_t ring)
+{
+    switch (ring) {
+    case TM_QW1_OS:
+        return TM_QW1_NSR_EO;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
-    return 0;
+    uint8_t *regs =3D &tctx->regs[ring];
+    uint8_t nsr =3D regs[TM_NSR];
+    uint8_t mask =3D exception_mask(ring);
+
+    qemu_irq_lower(tctx->output);
+
+    if (regs[TM_NSR] & mask) {
+        uint8_t cppr =3D regs[TM_PIPR];
+
+        regs[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        regs[TM_IPB] &=3D ~priority_to_ipb(cppr);
+        regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
+
+        /* Drop Exception bit */
+        regs[TM_NSR] &=3D ~mask;
+    }
+
+    return (nsr << 8) | regs[TM_CPPR];
+}
+
+static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
+{
+    uint8_t *regs =3D &tctx->regs[ring];
+
+    if (regs[TM_PIPR] < regs[TM_CPPR]) {
+        regs[TM_NSR] |=3D exception_mask(ring);
+        qemu_irq_raise(tctx->output);
+    }
 }
=20
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cpp=
r)
@@ -34,6 +98,9 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t =
ring, uint8_t cppr)
     }
=20
     tctx->regs[ring + TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, check if we need to raise a pending exception *=
/
+    xive_tctx_notify(tctx, ring);
 }
=20
 /*
@@ -189,6 +256,17 @@ static void xive_tm_set_os_cppr(XiveTCTX *tctx, hwad=
dr offset,
     xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
=20
+/*
+ * Adjust the IPB to allow a CPU to process event queues of other
+ * priorities during one physical interrupt cycle.
+ */
+static void xive_tm_set_os_pending(XiveTCTX *tctx, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
+    xive_tctx_notify(tctx, TM_QW1_OS);
+}
+
 /*
  * Define a mapping of "special" operations depending on the TIMA page
  * offset and the size of the operation.
@@ -211,6 +289,7 @@ static const XiveTmOp xive_tm_operations[] =3D {
=20
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_re=
g },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending,=
 NULL },
 };
=20
 static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, boo=
l write)
@@ -373,6 +452,13 @@ static void xive_tctx_reset(void *dev)
     tctx->regs[TM_QW1_OS + TM_LSMFB] =3D 0xFF;
     tctx->regs[TM_QW1_OS + TM_ACK_CNT] =3D 0xFF;
     tctx->regs[TM_QW1_OS + TM_AGE] =3D 0xFF;
+
+    /*
+     * Initialize PIPR to 0xFF to avoid phantom interrupts when the
+     * CPPR is first set.
+     */
+    tctx->regs[TM_QW1_OS + TM_PIPR] =3D
+        ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
@@ -1150,9 +1236,15 @@ static void xive_presenter_notify(XiveRouter *xrtr=
, uint8_t format,
     found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
                                  priority, logic_serv, &match);
     if (found) {
+        ipb_update(&match.tctx->regs[match.ring], priority);
+        xive_tctx_notify(match.tctx, match.ring);
         return;
     }
=20
+    /* Record the IPB in the associated NVT structure */
+    ipb_update((uint8_t *) &nvt.w4, priority);
+    xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
+
     /* If no matching NVT is dispatched on a HW thread :
      * - update the NVT structure if backlog is activated
      * - escalate (ESe PQ bits and EAS in w4-5) if escalation is
--=20
2.19.2
