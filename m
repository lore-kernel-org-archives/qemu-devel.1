Received: from eggs.gnu.org ([2001:4830:134:3::10]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utr-0007x0-Q4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utq-0007lS-Jc
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:43 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utq-0007jr-CF
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:42 -0400
Received: by mail-wr0-x234.google.com with SMTP id m13so2405575wrj.5
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:13 +0200
Message-Id: <1523034681-33787-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/20] hw/dma/i82374: Avoid double creation of
 the 82374 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

QEMU fails when used with the following command line:

    ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p -device i82374
    qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.

The 40p machine type already creates the device i82374. If specified in the
command line, it will try to create it again, hence generating the error. The
function isa_bus_dma() isn't supposed to be called twice for the same bus.
Check the bus doesn't already have a DMA controller registered before creating
the device.

Fixes: https://bugs.launchpad.net/qemu/+bug/1721224
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180326153441.32641-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/dma/i82374.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 83c87d9..892f655 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/isa/isa.h"
 #include "hw/dma/i8257.h"
 
@@ -118,13 +119,19 @@ static const MemoryRegionPortio i82374_portio_list[] = {
 static void i82374_realize(DeviceState *dev, Error **errp)
 {
     I82374State *s = I82374(dev);
+    ISABus *isa_bus = isa_bus_from_device(ISA_DEVICE(dev));
+
+    if (isa_get_dma(isa_bus, 0)) {
+        error_setg(errp, "DMA already initialized on ISA bus");
+        return;
+    }
+    i8257_dma_init(isa_bus, true);
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
     portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj),
                     s->iobase);
 
-    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
     memset(s->commands, 0, sizeof(s->commands));
 }
 
-- 
1.8.3.1
