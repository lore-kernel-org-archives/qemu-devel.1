Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4u-0004kt-M4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4s-0003GY-RA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:55 -0300
Message-Id: <20180509034658.26455-12-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/14] sdcard: Add sd_frame48_init(),
 replace SDRequest by a raw buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

Using sd_frame48_init() we silent the Coverity warning:

  "Use of an uninitialized variable (CWE-457)"

and fixes the following issues (all "Uninitialized scalar variable"):

- CID1386072 (hw/sd/sdhci.c::sdhci_end_transfer)
- CID1386074 (hw/sd/bcm2835_sdhost.c::bcm2835_sdhost_send_command)
- CID1386076 (hw/sd/sdhci.c::sdhci_send_command)
- CID1390571 (hw/sd/ssi-sd.c::ssi_sd_transfer)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h        | 24 +++++++++++++++---------
 hw/sd/bcm2835_sdhost.c    |  8 ++++----
 hw/sd/core.c              |  7 ++++---
 hw/sd/milkymist-memcard.c | 12 +++---------
 hw/sd/omap_mmc.c          |  8 +++-----
 hw/sd/pl181.c             | 10 +++++-----
 hw/sd/pxa2xx_mmci.c       |  8 +++-----
 hw/sd/sd.c                | 13 +++++--------
 hw/sd/sdhci.c             | 20 ++++++++++----------
 hw/sd/sdmmc-internal.c    | 12 ++++++++++++
 hw/sd/ssi-sd.c            | 12 +++++++-----
 11 files changed, 71 insertions(+), 63 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 83399cd42d..85b66a27a3 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,12 +76,6 @@ typedef enum {
     sd_adtc,	/* addressed with data transfer */
 } sd_cmd_type_t;
 
-typedef struct {
-    uint8_t cmd;
-    uint32_t arg;
-    uint8_t crc;
-} SDRequest;
-
 typedef struct SDState SDState;
 typedef struct SDBus SDBus;
 
@@ -97,7 +91,7 @@ typedef struct {
     DeviceClass parent_class;
     /*< public >*/
 
-    int (*do_command)(SDState *sd, SDRequest *req, uint8_t *response);
+    int (*do_command)(SDState *sd, const uint8_t *request, uint8_t *response);
     void (*write_data)(SDState *sd, uint8_t value);
     uint8_t (*read_data)(SDState *sd);
     bool (*data_ready)(SDState *sd);
@@ -130,6 +124,18 @@ typedef struct {
     void (*set_readonly)(DeviceState *dev, bool readonly);
 } SDBusClass;
 
+/**
+ * sd_frame48_init: Initialize a 48-bit SD frame
+ *
+ * @buf: the buffer to be filled
+ * @bufsize: the size of the @buffer
+ * @cmd: the SD command
+ * @arg: the SD command argument
+ * @is_response: whether the frame is a command request or response
+ */
+void sd_frame48_init(uint8_t *buf, size_t bufsize, uint8_t cmd, uint32_t arg,
+                     bool is_response);
+
 /**
  * sd_frame48_calc_checksum:
  * @content: pointer to the frame content
@@ -172,7 +178,7 @@ bool sd_frame136_verify_checksum(const void *content);
 
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
-int sd_do_command(SDState *sd, SDRequest *req,
+int sd_do_command(SDState *sd, const uint8_t *request,
                   uint8_t *response);
 void sd_write_data(SDState *sd, uint8_t value);
 uint8_t sd_read_data(SDState *sd);
@@ -193,7 +199,7 @@ void sd_enable(SDState *sd, bool enable);
 void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
 uint8_t sdbus_get_dat_lines(SDBus *sdbus);
 bool sdbus_get_cmd_line(SDBus *sdbus);
-int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
+int sdbus_do_command(SDBus *sd, const uint8_t *request, uint8_t *response);
 void sdbus_write_data(SDBus *sd, uint8_t value);
 uint8_t sdbus_read_data(SDBus *sd);
 bool sdbus_data_ready(SDBus *sd);
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4df4de7d67..b637a392b6 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -106,14 +106,14 @@ static void bcm2835_sdhost_update_irq(BCM2835SDHostState *s)
 
 static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
 {
-    SDRequest request;
+    uint8_t req[6];
     uint8_t rsp[16];
     int rlen;
 
-    request.cmd = s->cmd & SDCMD_CMD_MASK;
-    request.arg = s->cmdarg;
+    sd_frame48_init(req, sizeof(req), s->cmd & SDCMD_CMD_MASK,
+                    s->cmdarg, false);
 
-    rlen = sdbus_do_command(&s->sdbus, &request, rsp);
+    rlen = sdbus_do_command(&s->sdbus, req, rsp);
     if (rlen < 0) {
         goto error;
     }
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 820345f704..15cae5053c 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -87,15 +87,16 @@ void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
     }
 }
 
-int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
+int sdbus_do_command(SDBus *sdbus, const uint8_t *request, uint8_t *response)
 {
     SDState *card = get_card(sdbus);
 
-    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
+    trace_sdbus_command(sdbus_name(sdbus),
+                        request[0] & 0x3f, ldl_be_p(&request[1]), request[5]);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
-        return sc->do_command(card, req, response);
+        return sc->do_command(card, request, response);
     }
 
     return 0;
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index ff2b92dc64..94bb1ffc6f 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -97,14 +97,8 @@ static void update_pending_bits(MilkymistMemcardState *s)
 
 static void memcard_sd_command(MilkymistMemcardState *s)
 {
-    SDRequest req;
-
-    req.cmd = s->command[0] & 0x3f;
-    req.arg = ldl_be_p(s->command + 1);
-    req.crc = s->command[5];
-
-    s->response[0] = req.cmd;
-    s->response_len = sdbus_do_command(&s->sdbus, &req, s->response + 1);
+    s->response[0] = s->command[0];
+    s->response_len = sdbus_do_command(&s->sdbus, s->command, s->response + 1);
     s->response_read_ptr = 0;
 
     if (s->response_len == 16) {
@@ -117,7 +111,7 @@ static void memcard_sd_command(MilkymistMemcardState *s)
         s->response_len += 2;
     }
 
-    if (req.cmd == 0) {
+    if ((s->command[0] & 0x3f) == 0) {
         /* next write is a dummy byte to clock the initialization of the sd
          * card */
         s->ignore_next_cmd = 1;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 51c6c124b2..ca6a2ab2aa 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -113,7 +113,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
 {
     uint32_t rspstatus, mask;
     int rsplen, timeout;
-    SDRequest request;
+    uint8_t request[6];
     uint8_t response[16];
 
     if (init && cmd == 0) {
@@ -135,11 +135,9 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
     mask = 0;
     rspstatus = 0;
 
-    request.cmd = cmd;
-    request.arg = host->arg;
-    request.crc = 0; /* FIXME */
+    sd_frame48_init(request, sizeof(request), cmd, host->arg, false);
 
-    rsplen = sd_do_command(host->card, &request, response);
+    rsplen = sd_do_command(host->card, request, response);
 
     /* TODO: validate CRCs */
     switch (resptype) {
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index c9b1a6cb23..d8f6df8726 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -172,14 +172,14 @@ static uint32_t pl181_fifo_pop(PL181State *s)
 
 static void pl181_send_command(PL181State *s)
 {
-    SDRequest request;
+    uint8_t request[6];
     uint8_t response[16];
     int rlen;
 
-    request.cmd = s->cmd & PL181_CMD_INDEX;
-    request.arg = s->cmdarg;
-    DPRINTF("Command %d %08x\n", request.cmd, request.arg);
-    rlen = sd_do_command(s->card, &request, response);
+    sd_frame48_init(request, sizeof(request), s->cmd & PL181_CMD_INDEX,
+                    s->cmdarg, false);
+
+    rlen = sd_do_command(s->card, request, response);
     if (rlen < 0)
         goto error;
     if (s->cmd & PL181_CMD_RESPONSE) {
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82f8ec0d50..055d140f83 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -216,7 +216,7 @@ static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
 static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
 {
     int rsplen, i;
-    SDRequest request;
+    uint8_t request[6];
     uint8_t response[16];
 
     s->active = 1;
@@ -224,11 +224,9 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
     s->tx_len = 0;
     s->cmdreq = 0;
 
-    request.cmd = s->cmd;
-    request.arg = s->arg;
-    request.crc = 0;	/* FIXME */
+    sd_frame48_init(request, sizeof(request), s->cmd, s->arg, false);
 
-    rsplen = sdbus_do_command(&s->sdbus, &request, response);
+    rsplen = sdbus_do_command(&s->sdbus, request, response);
     s->intreq |= INT_END_CMD;
 
     memset(s->resp_fifo, 0, sizeof(s->resp_fifo));
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0dfcaf480c..aaf3a6806a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -467,11 +467,8 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
-static bool sd_req_crc_is_valid(SDRequest *req)
+static bool sd_req_crc_is_valid(const void *buffer)
 {
-    uint8_t buffer[5];
-    buffer[0] = 0x40 | req->cmd;
-    stl_be_p(&buffer[1], req->arg);
     return true;
     return sd_frame48_verify_checksum(buffer); /* TODO */
 }
@@ -1619,7 +1616,7 @@ static int cmd_valid_while_locked(SDState *sd, uint8_t cmd)
     return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
 
-int sd_do_command(SDState *sd, SDRequest *req,
+int sd_do_command(SDState *sd, const uint8_t *request,
                   uint8_t *response) {
     int last_state;
     sd_rsp_type_t rtype;
@@ -1631,10 +1628,10 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
-    cmd = req->cmd;
-    arg = req->arg;
+    cmd = request[0];
+    arg = ldl_be_p(&request[1]);
 
-    if (!sd_req_crc_is_valid(req)) {
+    if (!sd_req_crc_is_valid(request)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
         goto send_response;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f6fe93f033..554bb059ec 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -330,17 +330,18 @@ static void sdhci_data_transfer(void *opaque);
 
 static void sdhci_send_command(SDHCIState *s)
 {
-    SDRequest request;
+    uint8_t request[6];
     uint8_t response[16];
     int rlen;
 
     s->errintsts = 0;
     s->acmd12errsts = 0;
-    request.cmd = s->cmdreg >> 8;
-    request.arg = s->argument;
 
-    trace_sdhci_send_command(request.cmd, request.arg);
-    rlen = sdbus_do_command(&s->sdbus, &request, response);
+    trace_sdhci_send_command(s->cmdreg >> 8, s->argument);
+    sd_frame48_init(request, sizeof(request), s->cmdreg >> 8,
+                    s->argument, false);
+
+    rlen = sdbus_do_command(&s->sdbus, request, response);
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
         if (rlen == 4) {
@@ -386,13 +387,12 @@ static void sdhci_end_transfer(SDHCIState *s)
 {
     /* Automatically send CMD12 to stop transfer if AutoCMD12 enabled */
     if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
-        SDRequest request;
+        uint8_t request[6];
         uint8_t response[16];
 
-        request.cmd = 0x0C;
-        request.arg = 0;
-        trace_sdhci_end_transfer(request.cmd, request.arg);
-        sdbus_do_command(&s->sdbus, &request, response);
+        trace_sdhci_end_transfer(12, 0);
+        sd_frame48_init(request, sizeof(request), 12, 0, false);
+        sdbus_do_command(&s->sdbus, request, response);
         /* Auto CMD12 response goes to the upper Response register */
         s->rspreg[3] = ldl_be_p(response);
     }
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index f709211401..c8475a6e8e 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -92,7 +92,9 @@ static uint8_t sd_crc7(const void *message, size_t width)
 }
 
 enum {
+    CRC7_LENGTH         = 1,
     F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
+    F48_SIZE_MAX        = F48_CONTENT_LENGTH + CRC7_LENGTH,
     F136_CONTENT_LENGTH = 15,
 };
 
@@ -117,3 +119,13 @@ bool sd_frame136_verify_checksum(const void *content)
     return sd_frame136_calc_checksum(content)
            == ((const uint8_t *)content)[F136_CONTENT_LENGTH];
 }
+
+void sd_frame48_init(uint8_t *buf, size_t bufsize, uint8_t cmd, uint32_t arg,
+                     bool is_response)
+{
+    assert(bufsize >= F48_SIZE_MAX);
+    buf[0] = (!is_response << 6) | cmd;
+    stl_be_p(&buf[1], arg);
+    /* Zero-initialize the CRC byte to avoid leaking host memory to the guest */
+    buf[F48_CONTENT_LENGTH] = 0x00;
+}
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index dbcff4013d..77e446bb94 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -93,13 +93,15 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
         return 0xff;
     case SSI_SD_CMDARG:
         if (s->arglen == 4) {
-            SDRequest request;
+            uint8_t request[6];
             uint8_t longresp[16];
             /* FIXME: Check CRC.  */
-            request.cmd = s->cmd;
-            request.arg = ldl_be_p(s->cmdarg);
-            DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
-            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
+
+            DPRINTF("CMD%d arg 0x%08x\n", s->cmd, ldl_be_p(s->cmdarg));
+            sd_frame48_init(request, sizeof(request), s->cmd,
+                            ldl_be_p(s->cmdarg), false);
+
+            s->arglen = sdbus_do_command(&s->sdbus, request, longresp);
             if (s->arglen <= 0) {
                 s->arglen = 1;
                 s->response[0] = 4;
-- 
2.17.0
