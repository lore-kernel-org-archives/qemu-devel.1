Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYP-0006R6-0j
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-00082z-Nl
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:05 -0400
Message-Id: <20180525235509.11282-13-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 12/16] ahci: make mem_read_32 traces more
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
Cc: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 7 +++++--
 hw/ide/trace-events | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4bcb613bf9..ea68950952 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,7 +46,6 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
 
-__attribute__((__unused__)) /* TODO */
 static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] = {
     [AHCI_HOST_REG_CAP]        = "CAP",
     [AHCI_HOST_REG_CTL]        = "GHC",
@@ -402,13 +401,17 @@ static uint64_t ahci_mem_read_32(void *opaque, hwaddr addr)
             val = s->control_regs.version;
             break;
         default:
-            break;
+            trace_ahci_mem_read_32_host_unimpl(s, AHCIHostReg_lookup[regnum],
+                                               addr);
         }
+        trace_ahci_mem_read_32_host(s, AHCIHostReg_lookup[regnum], addr, val);
     } else if ((addr >= AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
                 (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         val = ahci_port_read(s, (addr - AHCI_PORT_REGS_START_ADDR) >> 7,
                              addr & AHCI_PORT_ADDR_OFFSET_MASK);
+    } else {
+        trace_ahci_mem_read_32_default(s, addr, val);
     }
 
     trace_ahci_mem_read_32(s, addr, val);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 458e4a3e80..5bd8b2b1df 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -72,6 +72,9 @@ ahci_trigger_irq(void *s, int port, const char *name, uint32_t val, uint32_t old
 ahci_port_write(void *s, int port, const char *reg, int offset, uint32_t val) "ahci(%p)[%d]: port write [reg:%s] @ 0x%x: 0x%08x"
 ahci_port_write_unimpl(void *s, int port, const char *reg, int offset, uint32_t val) "ahci(%p)[%d]: unimplemented port write [reg:%s] @ 0x%x: 0x%08x"
 ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem read @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_default(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem read @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_host(void *s, const char *reg, uint64_t addr, uint32_t val) "ahci(%p): mem read [reg:%s] @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_host_unimpl(void *s, const char *reg, uint64_t addr) "ahci(%p): unimplemented mem read [reg:%s] @ 0x%"PRIx64
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write_unknown(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
-- 
2.14.3
