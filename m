Received: from eggs.gnu.org ([2001:4830:134:3::10]:37521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO5-0008NS-BP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNz-0002uS-C0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNz-0002sv-4Q
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNx-0002yW-Uc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:16 +0000
Message-Id: <1516109659-1557-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/24] sdhci: fix CAPAB/MAXCURR registers,
 both are 64bit and read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

running qtests:

  $ make check-qtest-arm
    GTESTER check-qtest-arm
  SDHC rd_4b @0x44 not implemented
  SDHC wr_4b @0x40 <- 0x89abcdef not implemented
  SDHC wr_4b @0x44 <- 0x01234567 not implemented

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180115182436.2066-12-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h |  4 ++--
 hw/sd/sdhci.c         | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 8041c96..442e30a 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -72,8 +72,8 @@ typedef struct SDHCIState {
     uint64_t admasysaddr;  /* ADMA System Address Register */
 
     /* Read-only registers */
-    uint32_t capareg;      /* Capabilities Register */
-    uint32_t maxcurr;      /* Maximum Current Capabilities Register */
+    uint64_t capareg;      /* Capabilities Register */
+    uint64_t maxcurr;      /* Maximum Current Capabilities Register */
 
     uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
     uint32_t buf_maxsz;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c4e486e..d4fcebc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -899,10 +899,16 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = s->acmd12errsts;
         break;
     case SDHC_CAPAB:
-        ret = s->capareg;
+        ret = (uint32_t)s->capareg;
+        break;
+    case SDHC_CAPAB + 4:
+        ret = (uint32_t)(s->capareg >> 32);
         break;
     case SDHC_MAXCURR:
-        ret = s->maxcurr;
+        ret = (uint32_t)s->maxcurr;
+        break;
+    case SDHC_MAXCURR + 4:
+        ret = (uint32_t)(s->maxcurr >> 32);
         break;
     case SDHC_ADMAERR:
         ret =  s->admaerr;
@@ -1123,6 +1129,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
+
+    case SDHC_CAPAB:
+    case SDHC_CAPAB + 4:
+    case SDHC_MAXCURR:
+    case SDHC_MAXCURR + 4:
+        qemu_log_mask(LOG_GUEST_ERROR, "SDHC wr_%ub @0x%02" HWADDR_PRIx
+                      " <- 0x%08x read-only\n", size, offset, value >> shift);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0x%08x "
                       "not implemented\n", size, offset, value >> shift);
@@ -1163,8 +1178,8 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
     /* Capabilities registers provide information on supported features
      * of this specific host controller implementation */ \
-    DEFINE_PROP_UINT32("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
-    DEFINE_PROP_UINT32("maxcurr", _state, maxcurr, 0)
+    DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
+    DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
 
 static void sdhci_initfn(SDHCIState *s)
 {
-- 
2.7.4
