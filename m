Received: from eggs.gnu.org ([2001:4830:134:3::10]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYP-0006Rd-8W
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYO-00088E-0p
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:09 -0400
Message-Id: <20180525235509.11282-17-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 16/16] ahci: make ahci_mem_write traces more
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
 hw/ide/ahci.c       | 7 ++++++-
 hw/ide/trace-events | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index cd834c563e..b74a871a83 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -490,13 +490,18 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
             /* FIXME report write? */
             break;
         default:
-            trace_ahci_mem_write_unknown(s, size, addr, val);
+            trace_ahci_mem_write_host_unimpl(s, size, AHCIHostReg_lookup[regnum],
+                                             addr);
         }
+        trace_ahci_mem_write_host(s, size, AHCIHostReg_lookup[regnum],
+                                     addr, val);
     } else if ((addr >= AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
                         (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         ahci_port_write(s, (addr - AHCI_PORT_REGS_START_ADDR) >> 7,
                         addr & AHCI_PORT_ADDR_OFFSET_MASK, val);
+    } else {
+        trace_ahci_mem_write_unimpl(s, size, addr, val);
     }
 }
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 5bd8b2b1df..ad7195253f 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -77,7 +77,9 @@ ahci_mem_read_32_host(void *s, const char *reg, uint64_t addr, uint32_t val) "ah
 ahci_mem_read_32_host_unimpl(void *s, const char *reg, uint64_t addr) "ahci(%p): unimplemented mem read [reg:%s] @ 0x%"PRIx64
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
-ahci_mem_write_unknown(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write_host_unimpl(void *s, unsigned size, const char *reg, uint64_t addr) "ahci(%p) unimplemented write%u [reg:%s] @ 0x%"PRIx64
+ahci_mem_write_host(void *s, unsigned size, const char *reg, uint64_t addr, uint64_t val) "ahci(%p) write%u [reg:%s] @ 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write_unimpl(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
 ahci_set_signature(void *s, int port, uint8_t nsector, uint8_t sector, uint8_t lcyl, uint8_t hcyl, uint32_t sig) "ahci(%p)[%d]: set signature sector:0x%02x nsector:0x%02x lcyl:0x%02x hcyl:0x%02x (cumulatively: 0x%08x)"
 ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
 ahci_unmap_fis_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to unmap NULL FIS address"
-- 
2.14.3
