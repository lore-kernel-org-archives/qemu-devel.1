Received: from eggs.gnu.org ([2001:4830:134:3::10]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87864c7eb=Alistair.Francis@wdc.com>)
	id 1gXVpe-0000Qm-3C
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87864c7eb=Alistair.Francis@wdc.com>)
	id 1gXVpZ-0003WA-S9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:35:33 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 13 Dec 2018 18:34:52 +0000
Message-ID: <17339beb25e8db709cd55882df726200de31b2b0.1544726044.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] sifive_u: Add clock DT node for GEM
 ethernet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, Anup Patel <Anup.Patel@wdc.com>

From: Anup Patel <anup@brainfault.org>

The GEM ethernet on SiFive unleashed has fixed input clock
of 125MHz as-per SiFive FU540 manual. This patch updates FDT
generation for QEMU sifive_u machine to provide fixed-rate
clock for GEM ethernet.

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 18 +++++++++++++++++-
 include/hw/riscv/sifive_u.h |  3 ++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df2442..5c41ee5017 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -85,7 +85,8 @@ static void create_fdt(SiFiveUState *s, const struct Memm=
apEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    uint32_t plic_phandle;
+    char ethclk_names[] =3D "pclk\0hclk\0tx_clk";
+    uint32_t plic_phandle, ethclk_phandle;
=20
     fdt =3D s->fdt =3D create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -197,6 +198,17 @@ static void create_fdt(SiFiveUState *s, const struct M=
emmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
=20
+    nodename =3D g_strdup_printf("/soc/ethclk");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+        SIFIVE_U_GEM_CLOCK_FREQ);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", 3);
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", 3);
+    ethclk_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
+    g_free(nodename);
+
     nodename =3D g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -208,6 +220,10 @@ static void create_fdt(SiFiveUState *s, const struct M=
emmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle=
);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        ethclk_phandle, ethclk_phandle, ethclk_phandle);
+    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
+        sizeof(ethclk_names));
     qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
     g_free(nodename);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e8b4d9ffa3..be13cc1304 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -63,7 +63,8 @@ enum {
 };
=20
 enum {
-    SIFIVE_U_CLOCK_FREQ =3D 1000000000
+    SIFIVE_U_CLOCK_FREQ =3D 1000000000,
+    SIFIVE_U_GEM_CLOCK_FREQ =3D 125000000
 };
=20
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
--=20
2.19.1
