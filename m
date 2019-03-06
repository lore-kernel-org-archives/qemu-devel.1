Received: from eggs.gnu.org ([209.51.188.92]:54918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGc-00062Z-Vh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGR-0001P0-Kz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGQ-0001E2-MR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mUop124230
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:51 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2a8ejvbr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:50 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:48 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:09 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-5-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/27] ppc/pnv: export the xive_router_notify()
 routine
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

The PowerNV machine with need to encode the block id in the source
interrupt number before forwarding the source event notification to
the Router.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 1 +
 hw/intc/xive.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7dd80e0f46ef..c4f27742ca09 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -364,6 +364,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
 XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
+void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
 /*
  * XIVE END ESBs
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3d7de864e93f..7d7992c0ce3f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1404,7 +1404,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
     /* TODO: Auto EOI. */
 }
=20
-static void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
+void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xn);
     uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
--=20
2.20.1
