Received: from eggs.gnu.org ([209.51.188.92]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH0-0006T0-TQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGy-0001z0-RK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34392
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGy-0001IJ-KL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268nMRc115993
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r2a1ebce1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:57 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:24 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-20-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/27] ppc/pnv: add SerIRQ routing registers
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

This is just a simple reminder that SerIRQ routing should be
addressed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_lpc.h |  2 ++
 hw/ppc/pnv_lpc.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 24fe23f0f63b..ede7802f3420 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -57,6 +57,8 @@ typedef struct PnvLpcController {
     MemoryRegion opb_master_regs;
=20
     /* OPB Master LS registers */
+    uint32_t opb_irq_route0;
+    uint32_t opb_irq_route1;
     uint32_t opb_irq_stat;
     uint32_t opb_irq_mask;
     uint32_t opb_irq_pol;
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 6df694e0abc1..641e2046db92 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -39,6 +39,8 @@ enum {
 };
=20
 /* OPB Master LS registers */
+#define OPB_MASTER_LS_ROUTE0    0x8
+#define OPB_MASTER_LS_ROUTE1    0xC
 #define OPB_MASTER_LS_IRQ_STAT  0x50
 #define   OPB_MASTER_IRQ_LPC            0x00000800
 #define OPB_MASTER_LS_IRQ_MASK  0x54
@@ -521,6 +523,12 @@ static uint64_t opb_master_read(void *opaque, hwaddr=
 addr, unsigned size)
     uint64_t val =3D 0xfffffffffffffffful;
=20
     switch (addr) {
+    case OPB_MASTER_LS_ROUTE0: /* TODO */
+        val =3D lpc->opb_irq_route0;
+        break;
+    case OPB_MASTER_LS_ROUTE1: /* TODO */
+        val =3D lpc->opb_irq_route1;
+        break;
     case OPB_MASTER_LS_IRQ_STAT:
         val =3D lpc->opb_irq_stat;
         break;
@@ -547,6 +555,12 @@ static void opb_master_write(void *opaque, hwaddr ad=
dr,
     PnvLpcController *lpc =3D opaque;
=20
     switch (addr) {
+    case OPB_MASTER_LS_ROUTE0: /* TODO */
+        lpc->opb_irq_route0 =3D val;
+        break;
+    case OPB_MASTER_LS_ROUTE1: /* TODO */
+        lpc->opb_irq_route1 =3D val;
+        break;
     case OPB_MASTER_LS_IRQ_STAT:
         lpc->opb_irq_stat &=3D ~val;
         pnv_lpc_eval_irqs(lpc);
--=20
2.20.1
