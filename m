Received: from eggs.gnu.org ([2001:4830:134:3::10]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuE-0001O7-3h
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuC-00086O-7y
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:22 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuC-00085i-3C
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:20 -0500
Received: by mail-qk0-x241.google.com with SMTP id s198so4950823qke.5
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:09:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:58 -0300
Message-Id: <20180213040809.26021-20-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 19/30] sdhci: implement the Host Control 2
 register (tuning sequence)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

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
index bfb39d614b..5c69270988 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -189,6 +189,16 @@ FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
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
index 54594845ce..fd606e9928 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -73,6 +73,7 @@ typedef struct SDHCIState {
     uint16_t norintsigen;  /* Normal Interrupt Signal Enable Register */
     uint16_t errintsigen;  /* Error Interrupt Signal Enable Register */
     uint16_t acmd12errsts; /* Auto CMD12 error status register */
+    uint16_t hostctl2;     /* Host Control 2 */
     uint64_t admasysaddr;  /* ADMA System Address Register */
 
     /* Read-only registers */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9a8cdd551c..1dbcb99f52 100644
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
