Received: from eggs.gnu.org ([2001:4830:134:3::10]:36528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1g-0006YU-L7
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1d-00049m-Iq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ewm1d-000499-E5
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 10:51:30 +0100
Message-Id: <1521193892-15552-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1521193892-15552-1-git-send-email-thuth@redhat.com>
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Eduardo Habkost <ehabkost@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

A "powernv" machine type defines an ISA bus but it does not add any DMA
controller to it so it is possible to hit assert(fdctrl->dma) by
adding "-machine powernv -device isa-fdc".

This replaces assert() with an error message.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[thuth: Slightly adjusted error message and updated scripts/device-crash-test]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/fdc.c            | 5 ++++-
 scripts/device-crash-test | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 7b7dd41..cd29e27 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2695,7 +2695,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     fdctrl->dma_chann = isa->dma;
     if (fdctrl->dma_chann != -1) {
         fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
-        assert(fdctrl->dma);
+        if (!fdctrl->dma) {
+            error_setg(errp, "ISA controller does not support DMA");
+            return;
+        }
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7ff351d..99d20cb 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -217,7 +217,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
-- 
1.8.3.1
