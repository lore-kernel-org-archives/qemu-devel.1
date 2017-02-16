Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQi-0001qq-Tu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQf-0005JT-2W
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:04 -0500
Received: from mo173.mail-out.ovh.net ([178.32.228.173]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQe-0005IO-Sk
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:01 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B760823A73
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:48:59 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:31 +0100
Message-Id: <1487252865-12064-9-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/22] ppc/xics: use the QOM interface to
 resend irqs
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 0ffdf09c5304..2decb921e4e3 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -229,16 +229,15 @@ static void icp_check_ipi(ICPState *ss)
     qemu_irq_raise(ss->output);
 }
=20
-static void icp_resend(ICPState *ss)
+static void icp_resend(XICSInterface *xi, ICPState *ss)
 {
-    ICSState *ics;
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
=20
     if (ss->mfrr < CPPR(ss)) {
         icp_check_ipi(ss);
     }
-    QLIST_FOREACH(ics, &ss->xics->ics, list) {
-        ics_resend(ics);
-    }
+
+    xic->ics_resend(xi);
 }
=20
 void icp_set_cppr(ICPState *ss, uint8_t cppr)
@@ -262,7 +261,7 @@ void icp_set_cppr(ICPState *ss, uint8_t cppr)
         }
     } else {
         if (!XISR(ss)) {
-            icp_resend(ss);
+            icp_resend(XICS_INTERFACE(qdev_get_machine()), ss);
         }
     }
 }
@@ -299,6 +298,8 @@ uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
=20
 void icp_eoi(ICPState *ss, uint32_t xirr)
 {
+    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
     ICSState *ics;
     uint32_t irq;
=20
@@ -306,13 +307,13 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
     ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
     trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
     irq =3D xirr & XISR_MASK;
-    QLIST_FOREACH(ics, &ss->xics->ics, list) {
-        if (ics_valid_irq(ics, irq)) {
-            ics_eoi(ics, irq);
-        }
+
+    ics =3D xic->ics_get(xi, irq);
+    if (ics) {
+        ics_eoi(ics, irq);
     }
     if (!XISR(ss)) {
-        icp_resend(ss);
+        icp_resend(xi, ss);
     }
 }
=20
@@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
=20
 static int ics_simple_post_load(ICSState *ics, int version_id)
 {
+    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
     int i;
=20
     for (i =3D 0; i < ics->xics->nr_servers; i++) {
-        icp_resend(&ics->xics->ss[i]);
+        icp_resend(xi, &ics->xics->ss[i]);
     }
=20
     return 0;
--=20
2.7.4
