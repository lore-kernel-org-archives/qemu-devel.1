Received: from eggs.gnu.org ([2001:4830:134:3::10]:47888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqRh-0003ca-EC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqRe-0006yD-Ag
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1duqRe-0006xP-5I
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:38:26 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Sep 2017 21:38:21 -0400
Message-Id: <20170921013821.1673-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ide: fix enum comparison for gcc 4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, John Snow <jsnow@redhat.com>

Apparently GCC gets bent over comparing enum values against zero.
Replace the conditional with something less readable.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: John Snow <jsnow@redhat.com>

---

v2: Second verse, same as the first.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c             | 2 +-
 hw/ide/core.c             | 2 +-
 include/hw/ide/internal.h | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 24c65df..32d1296 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -184,7 +184,7 @@ static void ahci_check_irq(AHCIState *s)
 static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
                              enum AHCIPortIRQ irqbit)
 {
-    g_assert(irqbit >= 0 && irqbit < 32);
+    g_assert((unsigned)irqbit < 32);
     uint32_t irq = 1U << irqbit;
     uint32_t irqstat = d->port_regs.irq_stat | irq;
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index a19bd90..d63eb4a 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -68,7 +68,7 @@ const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT] = {
 
 static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
 {
-    if (enval >= IDE_DMA__BEGIN && enval < IDE_DMA__COUNT) {
+    if ((unsigned)enval < IDE_DMA__COUNT) {
         return IDE_DMA_CMD_lookup[enval];
     }
     return "DMA UNKNOWN CMD";
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 180e00e..e641012 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -333,8 +333,7 @@ struct unreported_events {
 };
 
 enum ide_dma_cmd {
-    IDE_DMA__BEGIN = 0,
-    IDE_DMA_READ = IDE_DMA__BEGIN,
+    IDE_DMA_READ = 0,
     IDE_DMA_WRITE,
     IDE_DMA_TRIM,
     IDE_DMA_ATAPI,
-- 
2.9.5
