Received: from eggs.gnu.org ([209.51.188.92]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1gsvbC-0004GM-C2
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 15:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukas.auer@aisec.fraunhofer.de>) id 1gsvYm-00077g-Lm
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 15:18:42 -0500
From: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Date: Sun, 10 Feb 2019 21:17:26 +0100
Message-ID: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>, Alistair Francis <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

Re-add the previous compatible string "riscv-virtio-soc" to the soc
device tree node to allow U-Boot and Linux to bind machine-specific
drivers to it. The current compatible string "simple-bus" is retained.

This is required by U-Boot to bind devices early, as part of the
pre-relocation driver model.

Fixes: 53f54508dae6("hw/riscv/virtio: Set the soc device tree node as a
simple-bus")
Signed-off-by: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
---

 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3e8b19c668..c53bb905ff 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -157,6 +157,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     char *nodename;
     uint32_t plic_phandle, phandle = 1;
     int i;
+    const char soc_compat[] = "riscv-virtio-soc\0simple-bus";
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -171,7 +172,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/soc");
     qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
+    qemu_fdt_setprop(fdt, "/soc", "compatible", soc_compat, sizeof(soc_compat));
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-- 
2.20.1
