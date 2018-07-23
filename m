Received: from eggs.gnu.org ([2001:4830:134:3::10]:42459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJy-0003F9-SZ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJx-0004uA-UJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:42 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:09 -0500
Message-Id: <20180723201748.25573-61-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 60/99] riscv: spike: allow base == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>, Michael Clark <mjc@sifive.com>

From: KONRAD Frederic <frederic.konrad@adacore.com>

The sanity check on base doesn't allow htif to be mapped @0. Check if the
symbol exists instead so we can map it where we want.

Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Michael Clark <mjc@sifive.com>

Message-Id: <1525360636-18229-2-git-send-email-frederic.konrad@adacore.com>
(cherry picked from commit 17b9751e85b9989cc841ed387794d7f1e8aa5e46)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/riscv/riscv_htif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 3e17f30251..be252ec8cc 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -41,17 +41,20 @@
     } while (0)
 
 static uint64_t fromhost_addr, tohost_addr;
+static int address_symbol_set;
 
 void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
-    uint64_t st_size)
+                          uint64_t st_size)
 {
     if (strcmp("fromhost", st_name) == 0) {
+        address_symbol_set |= 1;
         fromhost_addr = st_value;
         if (st_size != 8) {
             error_report("HTIF fromhost must be 8 bytes");
             exit(1);
         }
     } else if (strcmp("tohost", st_name) == 0) {
+        address_symbol_set |= 2;
         tohost_addr = st_value;
         if (st_size != 8) {
             error_report("HTIF tohost must be 8 bytes");
@@ -248,7 +251,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
-    if (base) {
+    if (address_symbol_set == 3) {
         memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
                             TYPE_HTIF_UART, size);
         memory_region_add_subregion(address_space, base, &s->mmio);
-- 
2.17.1
