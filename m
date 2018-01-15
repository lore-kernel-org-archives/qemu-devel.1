Received: from eggs.gnu.org ([2001:4830:134:3::10]:53127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97U-00022F-OR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97T-0007Bn-Rq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:28 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:39371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97T-0007BN-KR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:27 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 681469FFCB
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:03 +0100
Message-Id: <20180115180406.28489-4-clg@kaod.org>
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] ppc/pnv: introduce pnv*_is_power9() helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

These are useful when instantiating device models which are shared
between the POWER8 and the POWER9 processor families.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_xscom.c   |  8 +++-----
 include/hw/ppc/pnv.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index e51d634f4062..99c40efecdf9 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -51,10 +51,9 @@ static void xscom_complete(CPUState *cs, uint64_t hmer=
_bits)
=20
 static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 {
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-
     addr &=3D (PNV_XSCOM_SIZE - 1);
-    if (pcc->chip_type =3D=3D PNV_CHIP_POWER9) {
+
+    if (pnv_chip_is_power9(chip)) {
         return addr >> 3;
     } else {
         return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
@@ -231,7 +230,6 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_o=
ffset)
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
=20
     name =3D g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset =3D fdt_add_subnode(fdt, root_offset, name);
@@ -242,7 +240,7 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_o=
ffset)
     _FDT((fdt_setprop_cell(fdt, xscom_offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, xscom_offset, "reg", reg, sizeof(reg))));
=20
-    if (pcc->chip_type =3D=3D PNV_CHIP_POWER9) {
+    if (pnv_chip_is_power9(chip)) {
         _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p9,
                           sizeof(compat_p9))));
     } else {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 61896f9fd767..f023f1ec99c0 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -138,6 +138,16 @@ typedef struct PnvMachineState {
     Notifier     powerdown_notifier;
 } PnvMachineState;
=20
+static inline bool pnv_chip_is_power9(const PnvChip *chip)
+{
+    return PNV_CHIP_GET_CLASS(chip)->chip_type =3D=3D PNV_CHIP_POWER9;
+}
+
+static inline bool pnv_is_power9(PnvMachineState *pnv)
+{
+    return pnv_chip_is_power9(pnv->chips[0]);
+}
+
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
--=20
2.13.6
