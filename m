Received: from eggs.gnu.org ([209.51.188.92]:34616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7x-0007dH-Kl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7w-0006Yp-It
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBM7w-0006YU-Af
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 18:18:58 +0200
Message-Id: <20190402161900.7374-2-armbru@redhat.com>
In-Reply-To: <20190402161900.7374-1-armbru@redhat.com>
References: <20190402161900.7374-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] acpi/piix4: Convert debug printf()s to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/piix4.c      | 14 +++-----------
 hw/acpi/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9c079d6834..546ba036ed 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -39,14 +39,7 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
 #include "qom/cpu.h"
-
-//#define DEBUG
-
-#ifdef DEBUG
-# define PIIX4_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define PIIX4_DPRINTF(format, ...)     do { } while (0)
-#endif
+#include "trace.h"
 
 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
@@ -596,7 +589,7 @@ static uint64_t gpe_readb(void *opaque, hwaddr addr, unsigned width)
     PIIX4PMState *s = opaque;
     uint32_t val = acpi_gpe_ioport_readb(&s->ar, addr);
 
-    PIIX4_DPRINTF("gpe read %" HWADDR_PRIx " == %" PRIu32 "\n", addr, val);
+    trace_piix4_gpe_readb(addr, width, val);
     return val;
 }
 
@@ -605,10 +598,9 @@ static void gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
 {
     PIIX4PMState *s = opaque;
 
+    trace_piix4_gpe_writeb(addr, width, val);
     acpi_gpe_ioport_writeb(&s->ar, addr, val);
     acpi_update_sci(&s->ar, s->irq);
-
-    PIIX4_DPRINTF("gpe write %" HWADDR_PRIx " <== %" PRIu64 "\n", addr, val);
 }
 
 static const MemoryRegionOps piix4_gpe_ops = {
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 6272d8a9e7..825b25cbb0 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -31,6 +31,10 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
+# piix4.c
+piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
+piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
+
 # tco.c
 tco_timer_reload(int ticks, int msec) "ticks=%d (%d ms)"
 tco_timer_expired(int timeouts_no, bool strap, bool no_reboot) "timeouts_no=%d no_reboot=%d/%d"
-- 
2.17.2
