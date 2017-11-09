Received: from eggs.gnu.org ([2001:4830:134:3::10]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtu-0000BJ-8C
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtq-0005MS-4F
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:46 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:48615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmtp-0005Lw-TY
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:42 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 4DBE699C7C
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:29:40 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:33 +0100
Message-Id: <20171109101439.390-7-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 06/12] spapr: store a reference IRQ
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

To save some state when the guest is migrated, we capture the IRQ
bitmap after all devices have been reseted and store it as a reference
for the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 5 ++++-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70f6a96ec909..d4d0a36cc5bf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1437,6 +1437,9 @@ static void ppc_spapr_reset(void)
     qemu_devices_reset();
     spapr_clear_pending_events(spapr);
=20
+    spapr->irq_map_ref =3D bitmap_new(spapr->nr_irqs);
+    bitmap_copy(spapr->irq_map_ref, spapr->irq_map, spapr->nr_irqs);
+
     /*
      * We place the device tree and RTAS just below either the top of th=
e RMA,
      * or just below 2GB, whichever is lowere, so that it can be
@@ -1706,7 +1709,7 @@ static bool spapr_irq_map_needed(void *opaque)
         return false;
     }
=20
-    return true;
+    return !bitmap_equal(spapr->irq_map, spapr->irq_map_ref, spapr->nr_i=
rqs);
 }
=20
 static const VMStateDescription vmstate_spapr_irq_map =3D {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 71faeff17a40..090eda962ccb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -82,6 +82,7 @@ struct sPAPRMachineState {
     struct sPAPRNVRAM *nvram;
     int32_t nr_irqs;
     unsigned long *irq_map;
+    unsigned long *irq_map_ref;
     ICSState *ics;
     sPAPRRTCState rtc;
=20
--=20
2.13.6
