Received: from eggs.gnu.org ([2001:4830:134:3::10]:48480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEf7-0003BU-O5
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEf2-0004m9-TI
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:42:05 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:46 +0300
Message-Id: <9e482d1a7ea967ffd465f530b3e5a6df32c20f69.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 28/31] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eduardo Otubo <otubo@redhat.com>

QEMU fails when used with the following command line:

  ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
  qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
  Aborted (core dumped)

The 40p machine type already creates the device i82374. If specified in the
command line, it will try to create it again, hence generating the error. The
function isa_bus_dma() isn't supposed to be called twice for the same bus. One
way to avoid this problem is to set user_creatable=false.

A possible fix in a near future would be making
isa_bus_dma()/DMA_init()/i82374_realize() return an error instead of asserting
as well.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/dma/i82374.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975df0..e76dea8dc7 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -139,6 +139,11 @@ static void i82374_class_init(ObjectClass *klass, void *data)
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     dc->props = i82374_properties;
+    dc->user_creatable = false;
+    /*
+     * Reason: i82374_realize() crashes (assertion failure inside isa_bus_dma()
+     *         if the device is instantiated twice.
+     */
 }
 
 static const TypeInfo i82374_info = {
-- 
2.11.0
