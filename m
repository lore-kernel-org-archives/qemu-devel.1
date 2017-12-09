Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakn-0001NO-5A
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakf-0007BE-3B
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:57 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:39640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNake-0007AT-Tu
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:53 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C4E921276E5
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:28 +0100
Message-Id: <20171209084338.29395-10-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/19] spapr: add support for the
 SET_OS_PENDING command (XIVE)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This command offers the possibility for the O/S to adjust the IPB to
allow a CPU to process event queues of other priorities during one
physical interrupt cycle. This is not currently used by the XIVE
support for sPAPR in Linux but it is by the hypervisor.

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
 hw/intc/spapr_xive.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a8acfee740d9..38e1f569ea82 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -166,9 +166,23 @@ static bool spapr_xive_tm_is_readonly(uint8_t offset=
)
 static void spapr_xive_tm_write_special(sPAPRXiveNVT *nvt, hwaddr offset=
,
                                         uint64_t value, unsigned size)
 {
-    /* TODO: support TM_SPC_SET_OS_PENDING */
+    switch (offset) {
+    case TM_SPC_SET_OS_PENDING:
+        if (size =3D=3D 1) {
+            nvt->ring_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
+            nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+            spapr_xive_nvt_notify(nvt);
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
 static void spapr_xive_tm_os_write(void *opaque, hwaddr offset,
--=20
2.13.6
