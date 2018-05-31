Received: from eggs.gnu.org ([2001:4830:134:3::10]:34362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3r-0000kg-4a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3p-00045x-Ll
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:26 -0400
Message-Id: <20180531222835.16558-8-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/16] ahci: make port write traces more
 descriptive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: f4bug@amsat.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 8 +++++++-
 hw/ide/trace-events | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index efecf849a9..01463f0f51 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
@@ -284,8 +285,8 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
     AHCIPortRegs *pr = &s->dev[port].port_regs;
     enum AHCIPortReg regnum = offset / sizeof(uint32_t);
     assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
+    trace_ahci_port_write(s, port, AHCIPortReg_lookup[regnum], offset, val);
 
-    trace_ahci_port_write(s, port, offset, val);
     switch (regnum) {
     case AHCI_PORT_REG_LST_ADDR:
         pr->lst_addr = val;
@@ -355,6 +356,11 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         check_cmd(s, port);
         break;
     default:
+        trace_ahci_port_write_unimpl(s, port, AHCIPortReg_lookup[regnum],
+                                     offset, val);
+        qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented register: "
+                      "AHCI port %d register %s, offset 0x%x: 0x%"PRIu32,
+                      port, AHCIPortReg_lookup[regnum], offset, val);
         break;
     }
 }
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 0db18d8271..1efbbb8114 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -69,7 +69,8 @@ ahci_irq_raise(void *s) "ahci(%p): raise irq"
 ahci_irq_lower(void *s) "ahci(%p): lower irq"
 ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq 0x%08x --> 0x%08x"
 ahci_trigger_irq(void *s, int port, const char *name, uint32_t val, uint32_t old, uint32_t new, uint32_t effective) "ahci(%p)[%d]: trigger irq +%s (0x%08x); irqstat: 0x%08x --> 0x%08x; effective: 0x%08x"
-ahci_port_write(void *s, int port, int offset, uint32_t val) "ahci(%p)[%d]: port write @ 0x%x: 0x%08x"
+ahci_port_write(void *s, int port, const char *reg, int offset, uint32_t val) "ahci(%p)[%d]: port write [reg:%s] @ 0x%x: 0x%08x"
+ahci_port_write_unimpl(void *s, int port, const char *reg, int offset, uint32_t val) "ahci(%p)[%d]: unimplemented port write [reg:%s] @ 0x%x: 0x%08x"
 ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem read @ 0x%"PRIx64": 0x%08x"
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
-- 
2.14.3
