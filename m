Received: from eggs.gnu.org ([2001:4830:134:3::10]:52430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-0006MC-Ap
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYJ-0007ya-G7
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:00 -0400
Message-Id: <20180525235509.11282-8-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 07/16] ahci: make port write traces more
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
 hw/ide/ahci.c       | 4 +++-
 hw/ide/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1d93cd6806..61ac8e46c8 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -284,8 +284,8 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
     AHCIPortRegs *pr = &s->dev[port].port_regs;
     enum AHCIPortReg regnum = offset / sizeof(uint32_t);
     assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
+    trace_ahci_port_write(s, port, AHCIPortReg_lookup[regnum], offset, val);
 
-    trace_ahci_port_write(s, port, offset, val);
     switch (regnum) {
     case AHCI_PORT_REG_LST_ADDR:
         pr->lst_addr = val;
@@ -355,6 +355,8 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         check_cmd(s, port);
         break;
     default:
+        trace_ahci_port_write_unimpl(s, port, AHCIPortReg_lookup[regnum],
+                                     offset, val);
         break;
     }
 }
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index ffde28615f..458e4a3e80 100644
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
