Received: from eggs.gnu.org ([2001:4830:134:3::10]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3y-0000qD-8i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3v-0004Cg-9v
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:54 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:30 -0400
Message-Id: <20180531222835.16558-12-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/16] ahci: modify ahci_mem_read_32 to work
 on register numbers
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
 hw/ide/ahci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f2e8bce797..7edbb30f60 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -386,22 +386,27 @@ static uint64_t ahci_mem_read_32(void *opaque, hwaddr addr)
     uint32_t val = 0;
 
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
-        switch (addr) {
-        case HOST_CAP:
+        enum AHCIHostReg regnum = addr / 4;
+        assert(regnum < AHCI_HOST_REG__COUNT);
+
+        switch (regnum) {
+        case AHCI_HOST_REG_CAP:
             val = s->control_regs.cap;
             break;
-        case HOST_CTL:
+        case AHCI_HOST_REG_CTL:
             val = s->control_regs.ghc;
             break;
-        case HOST_IRQ_STAT:
+        case AHCI_HOST_REG_IRQ_STAT:
             val = s->control_regs.irqstatus;
             break;
-        case HOST_PORTS_IMPL:
+        case AHCI_HOST_REG_PORTS_IMPL:
             val = s->control_regs.impl;
             break;
-        case HOST_VERSION:
+        case AHCI_HOST_REG_VERSION:
             val = s->control_regs.version;
             break;
+        default:
+            break;
         }
     } else if ((addr >= AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
-- 
2.14.3
