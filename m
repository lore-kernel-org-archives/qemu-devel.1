Received: from eggs.gnu.org ([2001:4830:134:3::10]:54951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7b-0002bG-NQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7W-0001Uu-T8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:03 -0300
Message-Id: <20180504155918.21287-6-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/20] sdcard: Use the sd_prepare_request*()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>

This guaranties all SDRequest members are initialized.

This silent the Coverity warning:

  "Use of an uninitialized variable (CWE-457)"

and fixes the following issues (all "Uninitialized scalar variable"):

- CID1386072 (hw/sd/sdhci.c::sdhci_end_transfer)
- CID1386074 (hw/sd/bcm2835_sdhost.c::bcm2835_sdhost_send_command)
- CID1386076 (hw/sd/sdhci.c::sdhci_send_command)
- CID1390571 (hw/sd/ssi-sd.c::ssi_sd_transfer)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/bcm2835_sdhost.c    | 3 +--
 hw/sd/milkymist-memcard.c | 7 +++----
 hw/sd/omap_mmc.c          | 4 +---
 hw/sd/pxa2xx_mmci.c       | 4 +---
 hw/sd/sdhci.c             | 6 ++----
 hw/sd/ssi-sd.c            | 5 ++---
 6 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index ebf3b926c2..5134d7b5c7 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -110,8 +110,7 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
     uint8_t rsp[16];
     int rlen;
 
-    request.cmd = s->cmd & SDCMD_CMD_MASK;
-    request.arg = s->cmdarg;
+    sd_prepare_request(&request, s->cmd & SDCMD_CMD_MASK, s->cmdarg, false);
 
     rlen = sdbus_do_command(&s->sdbus, &request, rsp);
     if (rlen < 0) {
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index ff2b92dc64..d8cbb7b681 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -99,10 +99,9 @@ static void memcard_sd_command(MilkymistMemcardState *s)
 {
     SDRequest req;
 
-    req.cmd = s->command[0] & 0x3f;
-    req.arg = ldl_be_p(s->command + 1);
-    req.crc = s->command[5];
-
+    sd_prepare_request_with_crc(&req, s->command[0] & 0x3f,
+                                ldl_be_p(s->command + 1),
+                                s->command[5]);
     s->response[0] = req.cmd;
     s->response_len = sdbus_do_command(&s->sdbus, &req, s->response + 1);
     s->response_read_ptr = 0;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 5b47cadf11..7b71984115 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -135,9 +135,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
     mask = 0;
     rspstatus = 0;
 
-    request.cmd = cmd;
-    request.arg = host->arg;
-    request.crc = 0; /* FIXME */
+    sd_prepare_request(&request, cmd, host->arg, false /* FIXME */);
 
     rsplen = sd_do_command(host->card, &request, response);
 
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82f8ec0d50..fd5c1e7686 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -224,9 +224,7 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
     s->tx_len = 0;
     s->cmdreq = 0;
 
-    request.cmd = s->cmd;
-    request.arg = s->arg;
-    request.crc = 0;	/* FIXME */
+    sd_prepare_request(&request, s->cmd, s->arg, false /* FIXME */);
 
     rsplen = sdbus_do_command(&s->sdbus, &request, response);
     s->intreq |= INT_END_CMD;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 63c44a4ee8..9260f59e80 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -336,8 +336,7 @@ static void sdhci_send_command(SDHCIState *s)
 
     s->errintsts = 0;
     s->acmd12errsts = 0;
-    request.cmd = s->cmdreg >> 8;
-    request.arg = s->argument;
+    sd_prepare_request(&request, s->cmdreg >> 8, s->argument, false);
 
     trace_sdhci_send_command(request.cmd, request.arg);
     rlen = sdbus_do_command(&s->sdbus, &request, response);
@@ -393,8 +392,7 @@ static void sdhci_end_transfer(SDHCIState *s)
         SDRequest request;
         uint8_t response[16];
 
-        request.cmd = 0x0C;
-        request.arg = 0;
+        sd_prepare_request(&request, 12, 0, false);
         trace_sdhci_end_transfer(request.cmd, request.arg);
         sdbus_do_command(&s->sdbus, &request, response);
         /* Auto CMD12 response goes to the upper Response register */
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 0bb26e596d..c22967170c 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -95,9 +95,8 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
         if (s->arglen == 4) {
             SDRequest request;
             uint8_t longresp[16];
-            /* FIXME: Check CRC.  */
-            request.cmd = s->cmd;
-            request.arg = ldl_be_p(s->cmdarg);
+            sd_prepare_request(&request, s->cmd,
+                               ldl_be_p(s->cmdarg), false /* FIXME */);
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
             s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
             if (s->arglen <= 0) {
-- 
2.17.0
