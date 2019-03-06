Received: from eggs.gnu.org ([209.51.188.92]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH5-0006db-J4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH3-00024S-TW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56410
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SH3-0001EV-Bi
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:37 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mk41030523
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r29dadrbr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:51 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:50 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:14 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-10-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/27] ppc/xive: activate HV support
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

The NSR register of the HV ring has a different, although similar, bit
layout. TM_QW3_NSR_HE_PHYS bit should now be raised when the
Hypervisor interrupt line is signaled. Other bits TM_QW3_NSR_HE_POOL
and TM_QW3_NSR_HE_LSI are not modeled. LSI are for special interrupts
reserved for HW bringup and the POOL bit is used when signaling a
group of VPs. This is not currently implemented in Linux but it is in
pHyp.

The most important special commands on the HV TIMA page are added to
let the core manage interrupts : acking and changing the CPU priority.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7d7992c0ce3f..a0b87001da25 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -54,6 +54,8 @@ static uint8_t exception_mask(uint8_t ring)
     switch (ring) {
     case TM_QW1_OS:
         return TM_QW1_NSR_EO;
+    case TM_QW3_HV_PHYS:
+        return TM_QW3_NSR_HE;
     default:
         g_assert_not_reached();
     }
@@ -88,7 +90,16 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t r=
ing)
     uint8_t *regs =3D &tctx->regs[ring];
=20
     if (regs[TM_PIPR] < regs[TM_CPPR]) {
-        regs[TM_NSR] |=3D exception_mask(ring);
+        switch (ring) {
+        case TM_QW1_OS:
+            regs[TM_NSR] |=3D TM_QW1_NSR_EO;
+            break;
+        case TM_QW3_HV_PHYS:
+            regs[TM_NSR] |=3D (TM_QW3_NSR_HE_PHYS << 6);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         qemu_irq_raise(tctx->output);
     }
 }
@@ -109,6 +120,38 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
  * XIVE Thread Interrupt Management Area (TIMA)
  */
=20
+static void xive_tm_set_hv_cppr(XiveTCTX *tctx, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    xive_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
+static uint64_t xive_tm_ack_hv_reg(XiveTCTX *tctx, hwaddr offset, unsign=
ed size)
+{
+    return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
+}
+
+static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tctx, hwaddr offset,
+                                      unsigned size)
+{
+    uint64_t ret;
+
+    ret =3D tctx->regs[TM_QW2_HV_POOL + TM_WORD2] & TM_QW2W2_POOL_CAM;
+    tctx->regs[TM_QW2_HV_POOL + TM_WORD2] &=3D ~TM_QW2W2_POOL_CAM;
+    return ret;
+}
+
+static void xive_tm_vt_push(XiveTCTX *tctx, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] =3D value & 0xff;
+}
+
+static uint64_t xive_tm_vt_poll(XiveTCTX *tctx, hwaddr offset, unsigned =
size)
+{
+    return tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] & 0xff;
+}
+
 /*
  * Define an access map for each page of the TIMA that we will use in
  * the memory region ops to filter values when doing loads and stores
@@ -288,10 +331,16 @@ static const XiveTmOp xive_tm_operations[] =3D {
      * effects
      */
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NU=
LL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr,=
 NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NU=
LL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_po=
ll },
=20
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_re=
g },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending,=
 NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_re=
g },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool=
_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool=
_ctx },
 };
=20
 static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, boo=
l write)
@@ -323,7 +372,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
     const XiveTmOp *xto;
=20
     /*
-     * TODO: check V bit in Q[0-3]W2, check PTER bit associated with CPU
+     * TODO: check V bit in Q[0-3]W2
      */
=20
     /*
@@ -360,7 +409,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size)
     const XiveTmOp *xto;
=20
     /*
-     * TODO: check V bit in Q[0-3]W2, check PTER bit associated with CPU
+     * TODO: check V bit in Q[0-3]W2
      */
=20
     /*
@@ -472,6 +521,8 @@ static void xive_tctx_reset(void *dev)
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =3D
         ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+    tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
+        ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
--=20
2.20.1
