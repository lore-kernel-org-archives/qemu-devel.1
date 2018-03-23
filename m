Received: from eggs.gnu.org ([2001:4830:134:3::10]:59297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezIBR-0001EC-Gm
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezIBM-0000AQ-HN
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:36:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ezIBM-00007v-DL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:36:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 23 Mar 2018 09:36:05 +0100
Message-Id: <1521794165-31678-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Most of the RISC-V boards currently crash when they are started with
"-nodefaults", e.g.:

$ gdb --args riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive_e
[...]
(gdb) r
Program received signal SIGSEGV, Segmentation fault.
qemu_chr_fe_init ([...], s=s@entry=0x0, [...])
    at chardev/char-fe.c:210
210	    } else if (s->be) {
(gdb) bt
 0  0x00005555558695f8 in qemu_chr_fe_init ([...], s=s@entry=0x0, [...])
    at chardev/char-fe.c:210
 1  0x00005555556fb425 in sifive_uart_create ([...], chr=0x0, [...])
    at hw/riscv/sifive_uart.c:169
 2  0x00005555556f8cc4 in riscv_sifive_e_init (machine=[...])
    at hw/riscv/sifive_e.c:164
    [...]

With "-nodefaults" there are no entries in serial_hds[], so qemu_chr_fe_init()
finally tries to dereference a NULL pointer. Let's fix this problem by
creating a "null" chardev in this case instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 For other boards / targets, see also:
 https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05073.html

 hw/riscv/riscv_htif.c  | 5 +++++
 hw/riscv/sifive_uart.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 3e17f30..d3d31ff 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -245,9 +245,14 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
     s->pending_read = 0;
     s->allow_tohost = 0;
     s->fromhost_inprogress = 0;
+
+    if (!chr) {
+        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_NULL, NULL, &error_abort);
+    }
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
+
     if (base) {
         memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
                             TYPE_HTIF_UART, size);
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index b0c3798..2bde8bb 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -166,9 +166,14 @@ SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
 {
     SiFiveUARTState *s = g_malloc0(sizeof(SiFiveUARTState));
     s->irq = irq;
+
+    if (!chr) {
+        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_NULL, NULL, &error_abort);
+    }
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
         uart_be_change, s, NULL, true);
+
     memory_region_init_io(&s->mmio, NULL, &uart_ops, s,
                           TYPE_SIFIVE_UART, SIFIVE_UART_MAX);
     memory_region_add_subregion(address_space, base, &s->mmio);
-- 
1.8.3.1
