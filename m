Received: from eggs.gnu.org ([2001:4830:134:3::10]:37603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9W-0000VT-CZ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9S-0003sn-Dq
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:26 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:40909
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f8k9S-0003s2-63
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:22 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed, 18 Apr 2018 12:16:47 +0200
Message-Id: <1524046608-12906-2-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
References: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 1/2] riscv: spike: allow base == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: frederic.konrad@adacore.com, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

The sanity check on base doesn't allow htif to be mapped @0. Check if the
symbol exists instead so we can map it where we want.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/riscv/riscv_htif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 3e17f30..6e687f2 100644
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
+        address_symbol_set = 1;
         fromhost_addr = st_value;
         if (st_size != 8) {
             error_report("HTIF fromhost must be 8 bytes");
             exit(1);
         }
     } else if (strcmp("tohost", st_name) == 0) {
+        address_symbol_set = 1;
         tohost_addr = st_value;
         if (st_size != 8) {
             error_report("HTIF tohost must be 8 bytes");
@@ -248,7 +251,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
-    if (base) {
+    if (address_symbol_set) {
         memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
                             TYPE_HTIF_UART, size);
         memory_region_add_subregion(address_space, base, &s->mmio);
-- 
1.8.3.1
