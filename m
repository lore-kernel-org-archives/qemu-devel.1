Received: from eggs.gnu.org ([2001:4830:134:3::10]:55625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cc7UL-0001kp-LN
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cc7UI-0007HH-4K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:27:33 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 10 Feb 2017 10:27:22 +0100
Message-Id: <20170210092724.6470-2-lvivier@redhat.com>
In-Reply-To: <20170210092724.6470-1-lvivier@redhat.com>
References: <20170210092724.6470-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] mac99: replace debug printf with trace
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
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/mac_newworld.c | 15 +++------------
 hw/ppc/trace-events   |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2bfdb64..3702dd1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -72,6 +72,7 @@
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
@@ -79,21 +80,11 @@
 #define CLOCKFREQ (266UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
 
-/* debug UniNorth */
-//#define DEBUG_UNIN
-
-#ifdef DEBUG_UNIN
-#define UNIN_DPRINTF(fmt, ...)                                  \
-    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define UNIN_DPRINTF(fmt, ...)
-#endif
-
 /* UniN device */
 static void unin_write(void *opaque, hwaddr addr, uint64_t value,
                        unsigned size)
 {
-    UNIN_DPRINTF("write addr " TARGET_FMT_plx " val %"PRIx64"\n", addr, value);
+    trace_mac99_uninorth_write(addr, value);
     if (addr == 0x0) {
         *(int*)opaque = value;
     }
@@ -109,7 +100,7 @@ static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
         value = *(int*)opaque;
     }
 
-    UNIN_DPRINTF("readl addr " TARGET_FMT_plx " val %x\n", addr, value);
+    trace_mac99_uninorth_read(addr, value);
 
     return value;
 }
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f46995c..6122a12 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -85,3 +85,7 @@ rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
 rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
+
+# hw/ppc/mac_newworld.c
+mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
+mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
-- 
2.9.3
