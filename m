Received: from eggs.gnu.org ([2001:4830:134:3::10]:45260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0h-00017Z-Qt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0e-0007vt-NI
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:42:07 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0e-0007vg-HW
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:42:04 -0500
Received: by mail-qt0-x243.google.com with SMTP id s3so33590238qtb.10
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:42:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:57 -0300
Message-Id: <20180118204058.5768-14-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 13/14] sdhci: implement UHS-I voltage switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h    | 16 ++++++++++++++++
 include/hw/sd/sdhci.h |  1 +
 hw/sd/core.c          | 13 +++++++++++++
 hw/sd/sd.c            | 13 +++++++++++++
 hw/sd/sdhci.c         | 12 +++++++++++-
 hw/sd/trace-events    |  1 +
 6 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 96caefe373..f086679493 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -55,6 +55,20 @@
 #define AKE_SEQ_ERROR		(1 << 3)
 #define OCR_CCS_BITN        30
 
+typedef enum {
+    SD_VOLTAGE_0_4V     = 400,  /* currently not supported */
+    SD_VOLTAGE_1_8V     = 1800,
+    SD_VOLTAGE_3_0V     = 3000,
+    SD_VOLTAGE_3_3V     = 3300,
+} sd_voltage_mv_t;
+
+typedef enum  {
+    UHS_NOT_SUPPORTED   = 0,
+    UHS_I               = 1,
+    UHS_II              = 2,    /* currently not supported */
+    UHS_III             = 3,    /* currently not supported */
+} sd_uhs_mode_t;
+
 typedef enum {
     sd_none = -1,
     sd_bc = 0,	/* broadcast -- no response */
@@ -88,6 +102,7 @@ typedef struct {
     void (*write_data)(SDState *sd, uint8_t value);
     uint8_t (*read_data)(SDState *sd);
     bool (*data_ready)(SDState *sd);
+    void (*set_voltage)(SDState *sd, uint16_t millivolts);
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
@@ -134,6 +149,7 @@ void sd_enable(SDState *sd, bool enable);
 /* Functions to be used by qdevified callers (working via
  * an SDBus rather than directly with SDState)
  */
+void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
 int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
 void sdbus_write_data(SDBus *sd, uint8_t value);
 uint8_t sdbus_read_data(SDBus *sd);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 9d3f656441..5951b3fb2d 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -121,6 +121,7 @@ typedef struct SDHCIState {
          * Spec v3
          ***********/
         uint8_t slot_type, sdr, strength;
+        uint8_t uhs_mode;
     } cap;
 } SDHCIState;
 
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 498284f109..6d198ea775 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -41,6 +41,19 @@ static SDState *get_card(SDBus *sdbus)
     return SD_CARD(kid->child);
 }
 
+void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
+{
+    SDState *card = get_card(sdbus);
+
+    trace_sdbus_set_voltage(sdbus_name(sdbus), millivolts);
+    if (card) {
+        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+
+        assert(sc->set_voltage);
+        sc->set_voltage(card, millivolts);
+    }
+}
+
 int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 {
     SDState *card = get_card(sdbus);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 35347a5bbc..609b2da14f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -128,6 +128,18 @@ struct SDState {
     bool enable;
 };
 
+static void sd_set_voltage(SDState *sd, uint16_t millivolts)
+{
+    switch (millivolts) {
+    case 3001 ... 3600: /* SD_VOLTAGE_3_3V */
+    case 2001 ... 3000: /* SD_VOLTAGE_3_0V */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "SD card voltage not supported: %.3fV",
+                      millivolts / 1000.f);
+    }
+}
+
 static void sd_set_mode(SDState *sd)
 {
     switch (sd->state) {
@@ -1925,6 +1937,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
 
+    sc->set_voltage = sd_set_voltage;
     sc->do_command = sd_do_command;
     sc->write_data = sd_write_data;
     sc->read_data = sd_read_data;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 37b3b265ef..3846182371 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1162,7 +1162,16 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_update_irq(s);
         break;
     case SDHC_ACMD12ERRSTS:
-        MASKED_WRITE(s->acmd12errsts, mask, value);
+        MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
+        if (s->cap.uhs_mode >= UHS_I) {
+            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
+
+            if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
+                sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
+            } else {
+                sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
+            }
+        }
         break;
 
     case SDHC_CAPAB:
@@ -1244,6 +1253,7 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     DEFINE_PROP_UINT8("slot-type", _state, cap.slot_type, 0), \
     DEFINE_PROP_UINT8("bus-speed", _state, cap.sdr, 0), \
     DEFINE_PROP_UINT8("driver-strength", _state, cap.strength, 0), \
+    DEFINE_PROP_UINT8("uhs", _state, cap.uhs_mode, UHS_NOT_SUPPORTED), \
     \
     DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
 
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index c0f51f11d4..f874489980 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -4,6 +4,7 @@
 sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
 sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
 sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV)"
 
 # hw/sd/sdhci.c
 sdhci_set_inserted(const char *level) "card state changed: %s"
-- 
2.15.1
