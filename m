Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3r-0000l7-AZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3p-000467-Rs
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:22 -0400
Message-Id: <20180531222835.16558-4-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/16] ahci: make port read traces more
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

A trace is added to let us watch unimplemented registers specifically,
as these are more likely to cause us trouble. Otherwise, the port read
traces now tell us what register is getting hit, which is nicer.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 5 +++--
 hw/ide/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5187bf34ad..5b5ab823f4 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,7 +46,6 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
 
-__attribute__((__unused__)) /* TODO */
 static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] = {
     [AHCI_PORT_REG_LST_ADDR]    = "PxCLB",
     [AHCI_PORT_REG_LST_ADDR_HI] = "PxCLBU",
@@ -149,10 +148,12 @@ static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
         val = pr->cmd_issue;
         break;
     default:
+        trace_ahci_port_read_default(s, port, AHCIPortReg_lookup[regnum],
+                                     offset);
         val = 0;
     }
 
-    trace_ahci_port_read(s, port, offset, val);
+    trace_ahci_port_read(s, port, AHCIPortReg_lookup[regnum], offset, val);
     return val;
 }
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 5c0e59ec42..0db18d8271 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -63,7 +63,8 @@ ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; aio read:
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
 
 # hw/ide/ahci.c
-ahci_port_read(void *s, int port, int offset, uint32_t ret) "ahci(%p)[%d]: port read @ 0x%x: 0x%08x"
+ahci_port_read(void *s, int port, const char *reg, int offset, uint32_t ret) "ahci(%p)[%d]: port read [reg:%s] @ 0x%x: 0x%08x"
+ahci_port_read_default(void *s, int port, const char *reg, int offset) "ahci(%p)[%d]: unimplemented port read [reg:%s] @ 0x%x"
 ahci_irq_raise(void *s) "ahci(%p): raise irq"
 ahci_irq_lower(void *s) "ahci(%p): lower irq"
 ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq 0x%08x --> 0x%08x"
-- 
2.14.3
