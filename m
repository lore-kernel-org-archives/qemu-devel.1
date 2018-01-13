Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE39-0000o5-Fa
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE38-0004QO-8j
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:11 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE38-0004Pz-4Z
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:10 -0500
Received: by mail-qt0-x243.google.com with SMTP id c2so8545829qtn.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:08:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:14 -0300
Message-Id: <20180113050717.22969-12-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 11/14] sdhci: fix CAPAB/MAXCURR registers,
 both are 64bit and read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>

running qtests:

  $ make check-qtest-arm
    GTESTER check-qtest-arm
  SDHC rd_4b @0x44 not implemented
  SDHC wr_4b @0x40 <- 0x89abcdef not implemented
  SDHC wr_4b @0x44 <- 0x01234567 not implemented

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/sd/sdhci.h |  4 ++--
 hw/sd/sdhci.c         | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 8041c9629e..442e30aff2 100644
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
index 3df33f5e93..983569ba8b 100644
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
@@ -1163,10 +1178,10 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
 static Property sdhci_capareg_property =
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, SDHC_CAPAB_REG_DEFAULT);
+    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, SDHC_CAPAB_REG_DEFAULT);
 
 static Property sdhci_maxcurr_property =
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0);
+    DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0);
 
 static void sdhci_initfn(SDHCIState *s)
 {
-- 
2.15.1
