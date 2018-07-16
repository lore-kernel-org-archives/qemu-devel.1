Received: from eggs.gnu.org ([2001:4830:134:3::10]:36769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffBuW-0003OA-OU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffBuT-0006AC-Jg
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:24:04 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ffBuT-00069s-EM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:24:01 -0400
Received: by mail-pf0-x241.google.com with SMTP id i26-v6so15557137pfo.12
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:24:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jul 2018 15:23:57 -0700
Message-Id: <1531779837-20557-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] hw/sd/bcm2835_sdhost: Fix PIO mode writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

Writes in PIO mode have two requirements:

- A data interrupt must be generated after a write command has been
  issued to indicate that the chip is ready to receive data.
- A block interrupt must be generated after each block to indicate
  that the chip is ready to receive the next data block.

Rearrange the code to make this happen. Tested on raspi3 (in PIO mode)
and raspi2 (in DMA mode).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sd/bcm2835_sdhost.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4df4de7..1b760b2 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -179,9 +179,11 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
     uint32_t value = 0;
     int n;
     int is_read;
+    int is_write;
 
     is_read = (s->cmd & SDCMD_READ_CMD) != 0;
-    if (s->datacnt != 0 && (!is_read || sdbus_data_ready(&s->sdbus))) {
+    is_write = (s->cmd & SDCMD_WRITE_CMD) != 0;
+    if (s->datacnt != 0 && (is_write || sdbus_data_ready(&s->sdbus))) {
         if (is_read) {
             n = 0;
             while (s->datacnt && s->fifo_len < BCM2835_SDHOST_FIFO_LEN) {
@@ -201,8 +203,11 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
             if (n != 0) {
                 bcm2835_sdhost_fifo_push(s, value);
                 s->status |= SDHSTS_DATA_FLAG;
+                if (s->config & SDHCFG_DATA_IRPT_EN) {
+                    s->status |= SDHSTS_SDIO_IRPT;
+                }
             }
-        } else { /* write */
+        } else if (is_write) { /* write */
             n = 0;
             while (s->datacnt > 0 && (s->fifo_len > 0 || n > 0)) {
                 if (n == 0) {
@@ -223,11 +228,18 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
             s->edm &= ~SDEDM_FSM_MASK;
             s->edm |= SDEDM_FSM_DATAMODE;
             trace_bcm2835_sdhost_edm_change("datacnt 0", s->edm);
-
-            if ((s->cmd & SDCMD_WRITE_CMD) &&
+        }
+        if (is_write) {
+            /* set block interrupt at end of each block transfer */
+            if (s->hbct && s->datacnt % s->hbct == 0 &&
                 (s->config & SDHCFG_BLOCK_IRPT_EN)) {
                 s->status |= SDHSTS_BLOCK_IRPT;
             }
+            /* set data interrupt after each transfer */
+            s->status |= SDHSTS_DATA_FLAG;
+            if (s->config & SDHCFG_DATA_IRPT_EN) {
+                s->status |= SDHSTS_SDIO_IRPT;
+            }
         }
     }
 
-- 
2.7.4
