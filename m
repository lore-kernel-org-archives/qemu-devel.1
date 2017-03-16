Received: from eggs.gnu.org ([2001:4830:134:3::10]:48493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf8-00067k-PN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf7-0006nB-Sw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1coJf7-0006mx-Mi
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:52:58 -0400
Message-Id: <20170316005259.21970-3-jsnow@redhat.com>
In-Reply-To: <20170316005259.21970-1-jsnow@redhat.com>
References: <20170316005259.21970-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL for-rc1 2/3] ide: core: add cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liq3ea@gmail.com>

As the pci ahci can be hotplug and unplug, in the ahci unrealize
function it should free all the resource once allocated in the
realized function. This patch add ide_exit to free the resource.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 1488449293-80280-3-git-send-email-liqiang6-s@360.cn
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c             | 8 ++++++++
 include/hw/ide/internal.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index db509b3..0b48b64 100644
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
2.9.3
