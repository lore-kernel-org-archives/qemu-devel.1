Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D8-0007K1-Bt
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D6-00077Q-Ul
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D6-000774-PE
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:40 +0100
Message-Id: <20161222152300.32395-6-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/25] watchdog: 6300esb: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

When the Intel 6300ESB watchdog is hot unplug. The timer allocated
in realize isn't freed thus leaking memory leak. This patch avoid
this through adding the exit function.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-Id: <583cde9c.3223ed0a.7f0c2.886e@mx.google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/watchdog/wdt_i6300esb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index a83d951..49b3cd1 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -428,6 +428,14 @@ static void i6300esb_realize(PCIDevice *dev, Error **errp)
     /* qemu_register_coalesced_mmio (addr, 0x10); ? */
 }
 
+static void i6300esb_exit(PCIDevice *dev)
+{
+    I6300State *d = WATCHDOG_I6300ESB_DEVICE(dev);
+
+    timer_del(d->timer);
+    timer_free(d->timer);
+}
+
 static WatchdogTimerModel model = {
     .wdt_name = "i6300esb",
     .wdt_description = "Intel 6300ESB",
@@ -441,6 +449,7 @@ static void i6300esb_class_init(ObjectClass *klass, void *data)
     k->config_read = i6300esb_config_read;
     k->config_write = i6300esb_config_write;
     k->realize = i6300esb_realize;
+    k->exit = i6300esb_exit;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_ESB_9;
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
-- 
2.9.3
