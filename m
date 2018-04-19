Received: from eggs.gnu.org ([2001:4830:134:3::10]:57026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vf-0008Eq-LQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vb-0008IU-P2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:47 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vb-0008Hc-HS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:43 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.104])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6F582AE876
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:06 +0200
Message-Id: <20180419124331.3915-11-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/35] spapr: add support for the
 SET_OS_PENDING command (XIVE)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This command offers the possibility for the O/S to adjust the IPB to
allow a CPU to process event queues of other priorities during one
physical interrupt cycle. This is not currently used by the XIVE
native exploitation driver for sPAPR in Linux but it is by the
hypervisor.

More from Ben :

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
 hw/intc/xive.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8d0e77cac12a..20e216f03c5b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -214,9 +214,22 @@ static bool xive_tm_is_readonly(uint8_t offset)
 static void xive_tm_write_special(XiveNVT *nvt, hwaddr offset,
                                         uint64_t value, unsigned size)
 {
-    /* TODO: support TM_SPC_SET_OS_PENDING */
+    switch (offset) {
+    case TM_SPC_SET_OS_PENDING:
+        if (size =3D=3D 1) {
+            xive_nvt_ipb_update(nvt, value & 0xff);
+            xive_nvt_notify(nvt);
+        }
+        break;
+    case TM_SPC_ACK_OS_EL:  /* TODO */
+        qemu_log_mask(LOG_UNIMP, "XIVE: no command to acknowledge O/S "
+                      "Interrupt to even O/S reporting line\n");
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
=20
-    /* TODO: support TM_SPC_ACK_OS_EL */
 }
=20
 static void xive_tm_os_write(void *opaque, hwaddr offset,
--=20
2.13.6
