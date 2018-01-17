Received: from eggs.gnu.org ([2001:4830:134:3::10]:45725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQN-0007s0-8Z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQL-0001Mj-Dz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:59 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:21 +1100
Message-Id: <20180117022525.31767-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/22] ppc/pnv: introduce pnv*_is_power9()
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

These are useful when instantiating device models which are shared
between the POWER8 and the POWER9 processor families.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c   |  8 +++-----
 include/hw/ppc/pnv.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index e51d634f40..99c40efecd 100644
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
index 61896f9fd7..f023f1ec99 100644
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
2.14.3
