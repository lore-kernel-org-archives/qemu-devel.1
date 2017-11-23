Received: from eggs.gnu.org ([2001:4830:134:3::10]:39381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrc9-0001yr-SW
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrc6-0002gc-1g
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:25 -0500
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:40325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrc5-0002fi-R6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:21 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id CDA5F175B04
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:46 +0100
Message-Id: <20171123132955.1261-17-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/25] spapr: add support for the
 SET_OS_PENDING command (XIVE)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Adjusting the Interrupt Pending Buffer for the O/S would allow a CPU
to process event queues of other priorities during one physical
interrupt cycle. This is not currently used by the XIVE support for
sPAPR in Linux but it is by the hypervisor.

>From Ben :

  It's a way to avoid the SW replay on EOI.

  IE, assume you have 2 interrupts in the queue. You take the exception,
  ack the first one, process it etc... Then you EOI, the HW won't send
  a second notification. You need to look at the queue and continue
  consuming until it's empty.

  Today Linux checks the queue on EOI and use a SW mechanism to
  synthesize a new pseudo-external interrupt.

  This MMIO command would allow the OS to instead set back the
  corresponding priority bit to 1 in the IPB and cause the HW to
  re-emit the interrupt instead of SW.

  Linux doesn't use this today because DD1 didn't support it for the
  HV level, but other OSes might and we also might use it when we do
  groups, thus allowing redistribution.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index fead9c7031f3..b732aaf4f8ba 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -181,7 +181,14 @@ static bool spapr_xive_tm_is_readonly(uint8_t offset=
)
 static void spapr_xive_tm_write_special(sPAPRXiveICP *icp, hwaddr offset=
,
                                   uint64_t value, unsigned size)
 {
-    /* TODO: support TM_SPC_SET_OS_PENDING */
+    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
+        icp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
+        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
+        spapr_xive_icp_notify(icp);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
=20
     /* TODO: support TM_SPC_ACK_OS_EL */
 }
--=20
2.13.6
