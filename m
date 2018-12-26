Received: from eggs.gnu.org ([208.118.235.92]:47887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrD-00043s-LQ
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrC-0007pD-5e
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:35 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrB-0007jW-P5
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:33 -0500
Received: by mail-qk1-x744.google.com with SMTP id n12so9610966qkh.11
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:23 -0800 (PST)
Date: Wed, 26 Dec 2018 09:19:56 -0800
Message-Id: <20181226172005.26990-6-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 05/14] sifive_u: Add clock DT node for GEM
 ethernet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Anup Patel <anup@brainfault.org>

The GEM ethernet on SiFive unleashed has fixed input clock
of 125MHz as-per SiFive FU540 manual. This patch updates FDT
generation for QEMU sifive_u machine to provide fixed-rate
clock for GEM ethernet.

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 18 +++++++++++++++++-
 include/hw/riscv/sifive_u.h |  3 ++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df244241..5c41ee5017e4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -85,7 +85,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    uint32_t plic_phandle;
+    char ethclk_names[] = "pclk\0hclk\0tx_clk";
+    uint32_t plic_phandle, ethclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -197,6 +198,17 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/ethclk");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+        SIFIVE_U_GEM_CLOCK_FREQ);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", 3);
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", 3);
+    ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -208,6 +220,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        ethclk_phandle, ethclk_phandle, ethclk_phandle);
+    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
+        sizeof(ethclk_names));
     qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
     g_free(nodename);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e8b4d9ffa3fb..be13cc1304cc 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -63,7 +63,8 @@ enum {
 };
 
 enum {
-    SIFIVE_U_CLOCK_FREQ = 1000000000
+    SIFIVE_U_CLOCK_FREQ = 1000000000,
+    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
-- 
2.18.1
