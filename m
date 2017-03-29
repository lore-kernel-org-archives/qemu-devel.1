Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3L-0006ht-2k
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3H-0001Js-Tu
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:23 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:37495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ctE3H-0001It-NP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:19 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 00D0069030
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 15:54:15 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 29 Mar 2017 15:53:28 +0200
Message-Id: <1490795611-4762-7-git-send-email-clg@kaod.org>
In-Reply-To: <1490795611-4762-1-git-send-email-clg@kaod.org>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 6/9] ppc/pnv: add a helper to calculate MMIO
 addresses registers
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

Some controllers (ICP, PSI) have a base register address which is
calculated using the chip id.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index df98a72006e4..5693ba181d24 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -91,14 +91,24 @@ typedef struct PnvChipClass {
     OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)
=20
 /*
- * This generates a HW chip id depending on an index:
+ * This generates a HW chip id depending on an index, as found on a
+ * two socket system with dual chip modules :
  *
  *    0x0, 0x1, 0x10, 0x11
  *
  * 4 chips should be the maximum
+ *
+ * TODO: use a machine property to define the chip ids
  */
 #define PNV_CHIP_HWID(i) ((((i) & 0x3e) << 3) | ((i) & 0x1))
=20
+/*
+ * Converts back a HW chip id to an index. This is useful to calculate
+ * the MMIO addresses of some controllers which depend on the chip id.
+ */
+#define PNV_CHIP_INDEX(chip)                                    \
+    (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
+
 #define TYPE_POWERNV_MACHINE       MACHINE_TYPE_NAME("powernv")
 #define POWERNV_MACHINE(obj) \
     OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
--=20
2.7.4
