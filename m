Received: from eggs.gnu.org ([2001:4830:134:3::10]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbSey-0005tn-TJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbSev-0001za-S1
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cbSev-0001z3-Mu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21ECE804E5
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 13:51:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  8 Feb 2017 14:51:33 +0100
Message-Id: <1486561893-26470-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486561893-26470-1-git-send-email-kraxel@redhat.com>
References: <1486561893-26470-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] cirrus: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 11 +++++------
 hw/display/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 16f27e8..b272a70 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -28,6 +28,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "ui/console.h"
@@ -1852,12 +1853,14 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState * s, unsigned address)
 	break;
     }
 
+    trace_vga_cirrus_write_blt(address, value);
     return (uint8_t) value;
 }
 
 static void cirrus_mmio_blt_write(CirrusVGAState * s, unsigned address,
 				  uint8_t value)
 {
+    trace_vga_cirrus_write_blt(address, value);
     switch (address) {
     case (CIRRUS_MMIO_BLTBGCOLOR + 0):
 	cirrus_vga_write_gr(s, 0x00, value);
@@ -2607,9 +2610,7 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
 	    break;
 	}
     }
-#if defined(DEBUG_VGA)
-    printf("VGA: read addr=0x%04x data=0x%02x\n", addr, val);
-#endif
+    trace_vga_cirrus_read_io(addr, val);
     return val;
 }
 
@@ -2626,9 +2627,7 @@ static void cirrus_vga_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     if (vga_ioport_invalid(s, addr)) {
 	return;
     }
-#ifdef DEBUG_VGA
-    printf("VGA: write addr=0x%04x data=0x%02x\n", addr, val);
-#endif
+    trace_vga_cirrus_write_io(addr, val);
 
     switch (addr) {
     case 0x3c0:
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 26910e2..3e896d2 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -125,3 +125,9 @@ vga_std_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_std_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
 vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+
+# hw/display/cirrus_vga.c
+vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
+vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
+vga_cirrus_read_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
+vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
-- 
1.8.3.1
