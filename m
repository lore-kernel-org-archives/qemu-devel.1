Received: from eggs.gnu.org ([208.118.235.92]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYC-0003CP-BO
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZY9-0006E6-6D
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:44 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:41420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1geZY8-0006Cq-Uq
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:41 -0500
Received: from player773.ha.ovh.net (unknown [10.109.146.143])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 85587382AD
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 06:58:39 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  2 Jan 2019 06:57:38 +0100
Message-Id: <20190102055743.5052-6-clg@kaod.org>
In-Reply-To: <20190102055743.5052-1-clg@kaod.org>
References: <20190102055743.5052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/10] ppc: export the XICS and XIVE set_irq
 handlers
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

To support the 'dual' interrupt mode, XICS and XIVE, we plan to move
the qemu_irq array of each interrupt controller under the machine and
do the allocation under the sPAPR IRQ init method.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h | 2 ++
 include/hw/ppc/xive.h | 2 ++
 hw/intc/xics.c        | 2 +-
 hw/intc/xics_kvm.c    | 2 +-
 hw/intc/xive.c        | 2 +-
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 14afda198cdb..686db51149f3 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -192,6 +192,8 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
=20
 void ics_simple_write_xive(ICSState *ics, int nr, int server,
                            uint8_t priority, uint8_t saved_priority);
+void ics_simple_set_irq(void *opaque, int srcno, int val);
+void ics_kvm_set_irq(void *opaque, int srcno, int val);
=20
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index b05fe88b5b82..c279dc73b9f6 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -293,6 +293,8 @@ static inline void xive_source_irq_set(XiveSource *xs=
rc, uint32_t srcno,
     }
 }
=20
+void xive_source_set_irq(void *opaque, int srcno, int val);
+
 /*
  * XIVE Router
  */
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 406efee06448..0d65549e3d2e 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -461,7 +461,7 @@ static void ics_simple_set_irq_lsi(ICSState *ics, int=
 srcno, int val)
     ics_simple_resend_lsi(ics, srcno);
 }
=20
-static void ics_simple_set_irq(void *opaque, int srcno, int val)
+void ics_simple_set_irq(void *opaque, int srcno, int val)
 {
     ICSState *ics =3D (ICSState *)opaque;
=20
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index e8fa9a53aeba..c469c85d53dc 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -298,7 +298,7 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
     return 0;
 }
=20
-static void ics_kvm_set_irq(void *opaque, int srcno, int val)
+void ics_kvm_set_irq(void *opaque, int srcno, int val)
 {
     ICSState *ics =3D opaque;
     struct kvm_irq_level args;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 410c53278a11..c7599608959c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -845,7 +845,7 @@ static const MemoryRegionOps xive_source_esb_ops =3D =
{
     },
 };
=20
-static void xive_source_set_irq(void *opaque, int srcno, int val)
+void xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(opaque);
     bool notify =3D false;
--=20
2.20.1
