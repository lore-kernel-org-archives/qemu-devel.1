Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4O-0004Kx-5G
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4M-0002H2-Mv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:45 -0300
Message-Id: <20180509034658.26455-2-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/14] sdcard: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

The load/store API will ease further code movement.

Per the Physical Layer Simplified Spec. "3.6 Bus Protocol":

  "In the CMD line the Most Significant Bit (MSB) is transmitted
   first, the Least Significant Bit (LSB) is the last."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/bcm2835_sdhost.c    | 13 +++++--------
 hw/sd/milkymist-memcard.c |  3 +--
 hw/sd/omap_mmc.c          |  6 ++----
 hw/sd/pl181.c             | 11 ++++-------
 hw/sd/sdhci.c             | 15 +++++----------
 hw/sd/ssi-sd.c            |  6 ++----
 6 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index ebf3b926c2..4df4de7d67 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -118,8 +118,6 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
         goto error;
     }
     if (!(s->cmd & SDCMD_NO_RESPONSE)) {
-#define RWORD(n) (((uint32_t)rsp[n] << 24) | (rsp[n + 1] << 16) \
-                  | (rsp[n + 2] << 8) | rsp[n + 3])
         if (rlen == 0 || (rlen == 4 && (s->cmd & SDCMD_LONG_RESPONSE))) {
             goto error;
         }
@@ -127,15 +125,14 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
             goto error;
         }
         if (rlen == 4) {
-            s->rsp[0] = RWORD(0);
+            s->rsp[0] = ldl_be_p(&rsp[0]);
             s->rsp[1] = s->rsp[2] = s->rsp[3] = 0;
         } else {
-            s->rsp[0] = RWORD(12);
-            s->rsp[1] = RWORD(8);
-            s->rsp[2] = RWORD(4);
-            s->rsp[3] = RWORD(0);
+            s->rsp[0] = ldl_be_p(&rsp[12]);
+            s->rsp[1] = ldl_be_p(&rsp[8]);
+            s->rsp[2] = ldl_be_p(&rsp[4]);
+            s->rsp[3] = ldl_be_p(&rsp[0]);
         }
-#undef RWORD
     }
     /* We never really delay commands, so if this was a 'busywait' command
      * then we've completed it now and can raise the interrupt.
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e9a0..ff2b92dc64 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -100,8 +100,7 @@ static void memcard_sd_command(MilkymistMemcardState *s)
     SDRequest req;
 
     req.cmd = s->command[0] & 0x3f;
-    req.arg = (s->command[1] << 24) | (s->command[2] << 16)
-              | (s->command[3] << 8) | s->command[4];
+    req.arg = ldl_be_p(s->command + 1);
     req.crc = s->command[5];
 
     s->response[0] = req.cmd;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 5b47cadf11..51c6c124b2 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -162,8 +162,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
                 CID_CSD_OVERWRITE;
         if (host->sdio & (1 << 13))
             mask |= AKE_SEQ_ERROR;
-        rspstatus = (response[0] << 24) | (response[1] << 16) |
-                (response[2] << 8) | (response[3] << 0);
+        rspstatus = ldl_be_p(response);
         break;
 
     case sd_r2:
@@ -181,8 +180,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
         }
         rsplen = 4;
 
-        rspstatus = (response[0] << 24) | (response[1] << 16) |
-                (response[2] << 8) | (response[3] << 0);
+        rspstatus = ldl_be_p(response);
         if (rspstatus & 0x80000000)
             host->status &= 0xe000;
         else
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 3ba1f7dd23..c9b1a6cb23 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -183,23 +183,20 @@ static void pl181_send_command(PL181State *s)
     if (rlen < 0)
         goto error;
     if (s->cmd & PL181_CMD_RESPONSE) {
-#define RWORD(n) (((uint32_t)response[n] << 24) | (response[n + 1] << 16) \
-                  | (response[n + 2] << 8) | response[n + 3])
         if (rlen == 0 || (rlen == 4 && (s->cmd & PL181_CMD_LONGRESP)))
             goto error;
         if (rlen != 4 && rlen != 16)
             goto error;
-        s->response[0] = RWORD(0);
+        s->response[0] = ldl_be_p(&response[0]);
         if (rlen == 4) {
             s->response[1] = s->response[2] = s->response[3] = 0;
         } else {
-            s->response[1] = RWORD(4);
-            s->response[2] = RWORD(8);
-            s->response[3] = RWORD(12) & ~1;
+            s->response[1] = ldl_be_p(&response[4]);
+            s->response[2] = ldl_be_p(&response[8]);
+            s->response[3] = ldl_be_p(&response[12]) & ~1;
         }
         DPRINTF("Response received\n");
         s->status |= PL181_STATUS_CMDRESPEND;
-#undef RWORD
     } else {
         DPRINTF("Command sent\n");
         s->status |= PL181_STATUS_CMDSENT;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 63c44a4ee8..f6fe93f033 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -344,17 +344,13 @@ static void sdhci_send_command(SDHCIState *s)
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
         if (rlen == 4) {
-            s->rspreg[0] = (response[0] << 24) | (response[1] << 16) |
-                           (response[2] << 8)  |  response[3];
+            s->rspreg[0] = ldl_be_p(response);
             s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
             trace_sdhci_response4(s->rspreg[0]);
         } else if (rlen == 16) {
-            s->rspreg[0] = (response[11] << 24) | (response[12] << 16) |
-                           (response[13] << 8) |  response[14];
-            s->rspreg[1] = (response[7] << 24) | (response[8] << 16) |
-                           (response[9] << 8)  |  response[10];
-            s->rspreg[2] = (response[3] << 24) | (response[4] << 16) |
-                           (response[5] << 8)  |  response[6];
+            s->rspreg[0] = ldl_be_p(&response[11]);
+            s->rspreg[1] = ldl_be_p(&response[7]);
+            s->rspreg[2] = ldl_be_p(&response[3]);
             s->rspreg[3] = (response[0] << 16) | (response[1] << 8) |
                             response[2];
             trace_sdhci_response16(s->rspreg[3], s->rspreg[2],
@@ -398,8 +394,7 @@ static void sdhci_end_transfer(SDHCIState *s)
         trace_sdhci_end_transfer(request.cmd, request.arg);
         sdbus_do_command(&s->sdbus, &request, response);
         /* Auto CMD12 response goes to the upper Response register */
-        s->rspreg[3] = (response[0] << 24) | (response[1] << 16) |
-                (response[2] << 8) | response[3];
+        s->rspreg[3] = ldl_be_p(response);
     }
 
     s->prnsts &= ~(SDHC_DOING_READ | SDHC_DOING_WRITE |
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index ae04b6641b..dbcff4013d 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -97,8 +97,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             uint8_t longresp[16];
             /* FIXME: Check CRC.  */
             request.cmd = s->cmd;
-            request.arg = (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
-                           | (s->cmdarg[2] << 8) | s->cmdarg[3];
+            request.arg = ldl_be_p(s->cmdarg);
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
             s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
             if (s->arglen <= 0) {
@@ -123,8 +122,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
                 /* CMD13 returns a 2-byte statuse work. Other commands
                    only return the first byte.  */
                 s->arglen = (s->cmd == 13) ? 2 : 1;
-                cardstatus = (longresp[0] << 24) | (longresp[1] << 16)
-                             | (longresp[2] << 8) | longresp[3];
+                cardstatus = ldl_be_p(longresp);
                 status = 0;
                 if (((cardstatus >> 9) & 0xf) < 4)
                     status |= SSI_SDR_IDLE;
-- 
2.17.0
