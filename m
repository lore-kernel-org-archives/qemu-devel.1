Received: from eggs.gnu.org ([2001:4830:134:3::10]:52955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuO-0001Yr-Rk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuL-0008Q4-Fn
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:32 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuL-0008PF-Af
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:29 -0500
Received: by mail-qk0-x244.google.com with SMTP id g2so31115qkd.12
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:09:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:08:01 -0300
Message-Id: <20180213040809.26021-23-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 22/30] sdhci: implement CMD/DAT[] fields in
 the Present State register
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
 hw/sd/sdhci-internal.h |  2 ++
 include/hw/sd/sd.h     |  4 ++++
 hw/sd/core.c           | 34 ++++++++++++++++++++++++++++++++++
 hw/sd/sd.c             | 16 ++++++++++++++++
 hw/sd/sdhci.c          |  4 ++++
 hw/sd/trace-events     |  2 ++
 6 files changed, 62 insertions(+)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 5c69270988..0092627076 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -82,6 +82,8 @@
 #define SDHC_CARD_PRESENT              0x00010000
 #define SDHC_CARD_DETECT               0x00040000
 #define SDHC_WRITE_PROTECT             0x00080000
+FIELD(SDHC_PRNSTS, DAT_LVL,            20, 4);
+FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
 #define TRANSFERRING_DATA(x)           \
     ((x) & (SDHC_DOING_READ | SDHC_DOING_WRITE))
 
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index f086679493..bf1eb0713c 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -103,6 +103,8 @@ typedef struct {
     uint8_t (*read_data)(SDState *sd);
     bool (*data_ready)(SDState *sd);
     void (*set_voltage)(SDState *sd, uint16_t millivolts);
+    uint8_t (*get_dat_lines)(SDState *sd);
+    bool (*get_cmd_line)(SDState *sd);
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
@@ -150,6 +152,8 @@ void sd_enable(SDState *sd, bool enable);
  * an SDBus rather than directly with SDState)
  */
 void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
+uint8_t sdbus_get_dat_lines(SDBus *sdbus);
+bool sdbus_get_cmd_line(SDBus *sdbus);
 int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
 void sdbus_write_data(SDBus *sd, uint8_t value);
 uint8_t sdbus_read_data(SDBus *sd);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 6d198ea775..3c6eae6c88 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -41,6 +41,40 @@ static SDState *get_card(SDBus *sdbus)
     return SD_CARD(kid->child);
 }
 
+uint8_t sdbus_get_dat_lines(SDBus *sdbus)
+{
+    SDState *slave = get_card(sdbus);
+    uint8_t dat_lines = 0b1111; /* 4 bit bus width */
+
+    if (slave) {
+        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
+
+        if (sc->get_dat_lines) {
+            dat_lines = sc->get_dat_lines(slave);
+        }
+    }
+    trace_sdbus_get_dat_lines(sdbus_name(sdbus), dat_lines);
+
+    return dat_lines;
+}
+
+bool sdbus_get_cmd_line(SDBus *sdbus)
+{
+    SDState *slave = get_card(sdbus);
+    bool cmd_line = true;
+
+    if (slave) {
+        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
+
+        if (sc->get_cmd_line) {
+            cmd_line = sc->get_cmd_line(slave);
+        }
+    }
+    trace_sdbus_get_cmd_line(sdbus_name(sdbus), cmd_line);
+
+    return cmd_line;
+}
+
 void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
 {
     SDState *card = get_card(sdbus);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a8d7a522c0..9ac9b63ff8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -126,8 +126,20 @@ struct SDState {
     BlockBackend *blk;
 
     bool enable;
+    uint8_t dat_lines;
+    bool cmd_line;
 };
 
+static uint8_t sd_get_dat_lines(SDState *sd)
+{
+    return sd->enable ? sd->dat_lines : 0;
+}
+
+static bool sd_get_cmd_line(SDState *sd)
+{
+    return sd->enable ? sd->cmd_line : false;
+}
+
 static void sd_set_voltage(SDState *sd, uint16_t millivolts)
 {
     switch (millivolts) {
@@ -457,6 +469,8 @@ static void sd_reset(DeviceState *dev)
     sd->blk_len = 0x200;
     sd->pwd_len = 0;
     sd->expecting_acmd = false;
+    sd->dat_lines = 0xf;
+    sd->cmd_line = true;
     sd->multi_blk_cnt = 0;
 }
 
@@ -1939,6 +1953,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     dc->bus_type = TYPE_SD_BUS;
 
     sc->set_voltage = sd_set_voltage;
+    sc->get_dat_lines = sd_get_dat_lines;
+    sc->get_cmd_line = sd_get_cmd_line;
     sc->do_command = sd_do_command;
     sc->write_data = sd_write_data;
     sc->read_data = sd_read_data;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4e717117e1..0cd968fc6b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1003,6 +1003,10 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         break;
     case SDHC_PRNSTS:
         ret = s->prnsts;
+        ret = FIELD_DP32(ret, SDHC_PRNSTS, DAT_LVL,
+                         sdbus_get_dat_lines(&s->sdbus));
+        ret = FIELD_DP32(ret, SDHC_PRNSTS, CMD_LVL,
+                         sdbus_get_cmd_line(&s->sdbus));
         break;
     case SDHC_HOSTCTL:
         ret = s->hostctl1 | (s->pwrcon << 8) | (s->blkgap << 16) |
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 84d2f398b1..0f8536db32 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -5,6 +5,8 @@ sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s
 sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
 sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
 sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV)"
+sdbus_get_dat_lines(const char *bus_name, uint8_t dat_lines) "@%s dat_lines: %u"
+sdbus_get_cmd_line(const char *bus_name, bool cmd_line) "@%s cmd_line: %u"
 
 # hw/sd/sdhci.c
 sdhci_set_inserted(const char *level) "card state changed: %s"
-- 
2.16.1
