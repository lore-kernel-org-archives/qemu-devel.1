Received: from eggs.gnu.org ([209.51.188.92]:58515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09K-0006UM-Nq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09I-00078m-KC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:55 +1100
Message-Id: <20190108224600.23125-25-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/29] ppc: export the XICS and XIVE set_irq
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

To support the 'dual' interrupt mode, XICS and XIVE, we plan to move
the qemu_irq array of each interrupt controller under the machine and
do the allocation under the sPAPR IRQ init method.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 2 +-
 hw/intc/xics_kvm.c    | 2 +-
 hw/intc/xive.c        | 2 +-
 include/hw/ppc/xics.h | 2 ++
 include/hw/ppc/xive.h | 2 ++
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 406efee064..0d65549e3d 100644
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
index e8fa9a53ae..c469c85d53 100644
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
index 410c53278a..c759960895 100644
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
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 14afda198c..686db51149 100644
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
index b05fe88b5b..c279dc73b9 100644
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
--=20
2.20.1
