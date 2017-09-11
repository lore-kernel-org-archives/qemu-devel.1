Received: from eggs.gnu.org ([2001:4830:134:3::10]:35545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSI7-0001eK-AN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSI2-0004eM-R1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:35 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSI2-0004di-KB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:30 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A79E4AB236
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:28 +0200
Message-Id: <20170911171235.29331-15-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 14/21] ppc/xive: add support for the
 SET_OS_PENDING command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Adjusting the Interrupt Pending Buffer for the O/S would allow a CPU
to process event queues of other priorities during one physical
interrupt cycle. This is not currently used by the XIVE support for
sPAPR in Linux but it is by the hypervisor.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ad3ff91b13ea..ad3f03e37401 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -162,7 +162,14 @@ static bool spapr_xive_tm_is_readonly(uint8_t index)
 static void spapr_xive_tm_write_special(ICPState *icp, hwaddr offset,
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
2.13.5
