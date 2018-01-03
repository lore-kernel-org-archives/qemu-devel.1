Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgoK-0003Lr-27
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgoJ-00064o-6c
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:02:16 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgoJ-00064f-1B
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:02:15 -0500
Received: by mail-qk0-x241.google.com with SMTP id x7so1056571qkb.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 03:02:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 08:01:23 -0300
Message-Id: <20180103110126.29209-15-f4bug@amsat.org>
In-Reply-To: <20180103110126.29209-1-f4bug@amsat.org>
References: <20180103110126.29209-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/17] sdhci: fix CAPAB/MAXCURR registers,
 both are 64bit and read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

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
index da943a6562..9436375b1e 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -86,9 +86,9 @@ typedef struct SDHCIState {
 
     /* Read-only registers */
     /* 0x40 */
-    uint32_t capareg;      /* Capabilities Register */
+    uint64_t capareg;      /* Capabilities Register */
     /* 0x48 */
-    uint32_t maxcurr;      /* Maximum Current Capabilities Register */
+    uint64_t maxcurr;      /* Maximum Current Capabilities Register */
 
     uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
     uint32_t buf_maxsz;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6989bb09a6..ea7d27087e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -905,10 +905,16 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
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
@@ -1130,6 +1136,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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
@@ -1267,9 +1282,9 @@ const VMStateDescription sdhci_vmstate = {
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
 static Property sdhci_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
+    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg,
             SDHC_CAPAB_REG_DEFAULT),
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
+    DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.15.1
