Received: from eggs.gnu.org ([2001:4830:134:3::10]:46810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNfB-0003eT-RR
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNf6-0007gg-Mu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:45 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cjNf6-0007gW-Hp
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:40 -0500
Received: by mail-pf0-x241.google.com with SMTP id 67so1971809pfg.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:08:40 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  2 Mar 2017 02:08:12 -0800
Message-Id: <1488449293-80280-3-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
References: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 2/3] ide: core: add cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

As the pci ahci can be hotplug and unplug, in the ahci unrealize
function it should free all the resource once allocated in the
realized function. This patch add ide_exit to free the resource.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/ide/core.c             | 8 ++++++++
 include/hw/ide/internal.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index cfa5de6..e971a94 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2603,6 +2603,14 @@ void ide_init2(IDEBus *bus, qemu_irq irq)
     bus->dma = &ide_dma_nop;
 }
 
+void ide_exit(IDEState *s)
+{
+    timer_del(s->sector_write_timer);
+    timer_free(s->sector_write_timer);
+    qemu_vfree(s->smart_selftest_data);
+    qemu_vfree(s->io_buffer);
+}
+
 static const MemoryRegionPortio ide_portio_list[] = {
     { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
     { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 88dc118..482a951 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -607,6 +607,7 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
                    uint32_t cylinders, uint32_t heads, uint32_t secs,
                    int chs_trans);
 void ide_init2(IDEBus *bus, qemu_irq irq);
+void ide_exit(IDEState *s);
 void ide_init_ioport(IDEBus *bus, ISADevice *isa, int iobase, int iobase2);
 void ide_register_restart_cb(IDEBus *bus);
 
-- 
1.8.3.1
