Received: from eggs.gnu.org ([2001:4830:134:3::10]:42164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpO7-0008O6-Fu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpO4-0004Go-A9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:31 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpO4-0004Gi-4a
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:28 -0500
Received: by mail-qt0-x244.google.com with SMTP id f18so6807358qth.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:49:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 13:48:07 -0300
Message-Id: <20180208164818.7961-20-f4bug@amsat.org>
In-Reply-To: <20180208164818.7961-1-f4bug@amsat.org>
References: <20180208164818.7961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 19/30] sdhci: implement the Host Control 2
 register (tuning sequence)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 10 ++++++++++
 include/hw/sd/sdhci.h  |  1 +
 hw/sd/sdhci.c          | 22 +++++++++++++++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9111f6856a..e7cbea297f 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -184,6 +184,16 @@ FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
 FIELD(SDHC_ACMD12ERRSTS, CRC_ERR,      2, 1);
 FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
 
+/* Host Control Register 2 (since v3) */
+#define SDHC_HOSTCTL2                  0x3E
+FIELD(SDHC_HOSTCTL2, UHS_MODE_SEL,     0, 3);
+FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
+FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
+
 /* HWInit Capabilities Register 0x05E80080 */
 #define SDHC_CAPAB                     0x40
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index e1974306f9..05ac0e763f 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -72,6 +72,7 @@ typedef struct SDHCIState {
     uint16_t norintsigen;  /* Normal Interrupt Signal Enable Register */
     uint16_t errintsigen;  /* Error Interrupt Signal Enable Register */
     uint16_t acmd12errsts; /* Auto CMD12 error status register */
+    uint16_t hostctl2;     /* Host Control 2 */
     uint64_t admasysaddr;  /* ADMA System Address Register */
 
     /* Read-only registers */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bcdf8529cc..9f56eb55e2 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -408,14 +408,29 @@ static void sdhci_end_transfer(SDHCIState *s)
 static void sdhci_read_block_from_card(SDHCIState *s)
 {
     int index = 0;
+    uint8_t data;
+    const uint16_t blk_size = s->blksize & BLOCK_SIZE_MASK;
 
     if ((s->trnmod & SDHC_TRNS_MULTI) &&
             (s->trnmod & SDHC_TRNS_BLK_CNT_EN) && (s->blkcnt == 0)) {
         return;
     }
 
-    for (index = 0; index < (s->blksize & BLOCK_SIZE_MASK); index++) {
-        s->fifo_buffer[index] = sdbus_read_data(&s->sdbus);
+    for (index = 0; index < blk_size; index++) {
+        data = sdbus_read_data(&s->sdbus);
+        if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
+            /* Device is not in tunning */
+            s->fifo_buffer[index] = data;
+        }
+    }
+
+    if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
+        /* Device is in tunning */
+        s->hostctl2 &= ~R_SDHC_HOSTCTL2_EXECUTE_TUNING_MASK;
+        s->hostctl2 |= R_SDHC_HOSTCTL2_SAMPLING_CLKSEL_MASK;
+        s->prnsts &= ~(SDHC_DAT_LINE_ACTIVE | SDHC_DOING_READ |
+                       SDHC_DATA_INHIBIT);
+        goto read_done;
     }
 
     /* New data now available for READ through Buffer Port Register */
@@ -440,6 +455,7 @@ static void sdhci_read_block_from_card(SDHCIState *s)
         }
     }
 
+read_done:
     sdhci_update_irq(s);
 }
 
@@ -1005,7 +1021,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = s->norintsigen | (s->errintsigen << 16);
         break;
     case SDHC_ACMD12ERRSTS:
-        ret = s->acmd12errsts;
+        ret = s->acmd12errsts | (s->hostctl2 << 16);
         break;
     case SDHC_CAPAB:
         ret = (uint32_t)s->capareg;
-- 
2.16.1
