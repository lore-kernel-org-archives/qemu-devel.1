Received: from eggs.gnu.org ([2001:4830:134:3::10]:56410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TID-0001YM-4j
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIC-0003Rf-68
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:05 +1000
Message-Id: <20170424015927.8933-26-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/47] ppc/pnv: add a helper to calculate MMIO
 addresses registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Some controllers (ICP, PSI) have a base register address which is
calculated using the chip id.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index df98a72..5693ba1 100644
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
2.9.3
