Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApN-0000qd-08
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeV-0004QZ-Hn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59522
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeU-00048M-T5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:07 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDCTJj133785
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtf438ca7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:48 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:40 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:22 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-14-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/13] spapr/xive: fix device hotplug when
 VM is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Instead of switching off the sources, set their state to PENDING to
possibly catch a hotplug event occuring while the VM is stopped. At
resume, check the previous state and if an interrupt was queued,
generate a trigger.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 99a829fb3f60..64d160babb26 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -500,8 +500,16 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
     if (running) {
         for (i =3D 0; i < xsrc->nr_irqs; i++) {
             uint8_t pq =3D xive_source_esb_get(xsrc, i);
-            if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)) !=
=3D 0x1) {
-                error_report("XIVE: IRQ %d has an invalid state", i);
+            uint8_t old_pq;
+
+            old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
+
+            /*
+             * If an interrupt was queued (hotplug event) while VM was
+             * stopped, generate a trigger.
+             */
+            if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QUEUE=
D) {
+                xive_esb_trigger(xsrc, i);
             }
         }
=20
@@ -515,7 +523,15 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
      * migration is in progress.
      */
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
-        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
+        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+
+        /*
+         * PQ is set to PENDING to possibly catch a hotplug event
+         * occuring while the VM is stopped.
+         */
+        if (pq !=3D XIVE_ESB_OFF) {
+            pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
+        }
         xive_source_esb_set(xsrc, i, pq);
     }
=20
--=20
2.20.1
