Received: from eggs.gnu.org ([2001:4830:134:3::10]:52973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYR-0003RU-P8
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYN-0000WE-HE
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:31 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYN-0000Vt-BD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:27 -0500
Received: by mail-qt0-x242.google.com with SMTP id i40so3793807qti.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:34 -0300
Message-Id: <20180103212436.15762-24-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 23/25] sdcard: store the bus protocol in
 an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

One and only one protocol can be used at a time.
We use a bitmask 'bus_protocol' simplify to check with one variable which
protocols are supported (this will help when we start using the MMC mode).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h            |   5 ++
 include/hw/sd/sdcard_legacy.h |   2 +-
 hw/sd/sd.c                    | 141 ++++++++++++++++++++++++++++--------------
 3 files changed, 100 insertions(+), 48 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index a342e7bc3e..6874696ff7 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -55,6 +55,11 @@
 #define AKE_SEQ_ERROR		(1 << 3)
 #define OCR_CCS_BITN        30
 
+typedef enum {
+    PROTO_SD =  0,
+    PROTO_SPI = 1 << 1,
+} sd_bus_protocol_t;
+
 typedef enum {
     sd_none = -1,
     sd_bc = 0,	/* broadcast -- no response */
diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
index 882e13a8f1..08674797b5 100644
--- a/include/hw/sd/sdcard_legacy.h
+++ b/include/hw/sd/sdcard_legacy.h
@@ -32,7 +32,7 @@
 #include "hw/sd/sd.h"
 
 /* Legacy functions to be used only by non-qdevified callers */
-SDState *sd_init(BlockBackend *blk, bool is_spi);
+SDState *sd_init(BlockBackend *blk, bool is_spi); /* deprecated */
 int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
 void sd_write_data(SDState *card, uint8_t value);
 uint8_t sd_read_data(SDState *card);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 16199cd886..d626445282 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -127,7 +127,7 @@ struct SDState {
     uint8_t function_group[6];
 
     int spec_version;
-    bool spi;
+    uint32_t bus_protocol;
     sd_card_capacity_t capacity;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -150,6 +150,18 @@ struct SDState {
     const char *proto_name;
 };
 
+static const char *sd_protocol_name(sd_bus_protocol_t protocol)
+{
+    switch (protocol) {
+    case PROTO_SD:
+        return "SD";
+    case PROTO_SPI:
+        return "SPI";
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const char *sd_state_name(enum SDCardStates state)
 {
     static const char *state_name[] = {
@@ -365,7 +377,16 @@ static bool cmd_version_supported(SDState *sd, uint8_t cmd, bool is_acmd)
     const sd_cmd_supported_t *cmdset = is_acmd ? acmd_supported : cmd_supported;
     uint16_t cmd_version;
 
-    cmd_version = sd->spi ? cmdset[cmd].spi.version : cmdset[cmd].sd.version;
+    switch (sd->bus_protocol) {
+    case PROTO_SD:
+        cmd_version = cmdset[cmd].sd.version;
+        break;
+    case PROTO_SPI:
+        cmd_version = cmdset[cmd].spi.version;
+        break;
+    default:
+        g_assert_not_reached();
+    }
     if (cmd_version) {
         return true;
     }
@@ -381,9 +402,17 @@ static bool cmd_class_supported(SDState *sd, uint8_t cmd, uint8_t class,
     const sd_cmd_supported_t *cmdset = is_acmd ? acmd_supported : cmd_supported;
     uint32_t cmd_ccc_mask;
 
-    cmd_ccc_mask = sd->spi ? cmdset[cmd].spi.ccc_mask : cmdset[cmd].sd.ccc_mask;
-
-    /* class 1, 3 and 9 are not supported in SPI mode */
+    switch (sd->bus_protocol) {
+    case PROTO_SD:
+        cmd_ccc_mask = cmdset[cmd].sd.ccc_mask;
+        break;
+    case PROTO_SPI:
+        /* class 1, 3 and 9 are not supported in SPI mode */
+        cmd_ccc_mask = cmdset[cmd].spi.ccc_mask;
+        break;
+    default:
+        g_assert_not_reached();
+    }
     if (cmd_ccc_mask & BIT(class)) {
         return true;
     }
@@ -603,7 +632,7 @@ static size_t sd_response_r1_make(SDState *sd, uint8_t *response)
     /* Clear the "clear on read" status bits */
     sd->card_status &= ~CARD_STATUS_C;
 
-    if (sd->spi) {
+    if (sd->bus_protocol == PROTO_SPI) {
         response[0] = 0xff; /* XXX */
         return 1;
     } else {
@@ -619,7 +648,7 @@ static size_t sd_response_r1b_make(SDState *sd, uint8_t *response)
 {
     /* This response token is identical to the R1 format with the
      * optional addition of the busy signal. */
-    if (sd->spi) {
+    if (sd->bus_protocol == PROTO_SPI) {
         /* The busy signal token can be any number of bytes. A zero value
          * indicates card is busy. A non-zero value indicates the card is
          * ready for the next command. */
@@ -634,7 +663,7 @@ static size_t sd_response_r1b_make(SDState *sd, uint8_t *response)
 
 static size_t sd_response_r2s_make(SDState *sd, uint8_t *response)
 {
-    if (sd->spi) {
+    if (sd->bus_protocol == PROTO_SPI) {
         /* TODO */
         return 2;
     } else {
@@ -647,7 +676,7 @@ static size_t sd_response_r3_make(SDState *sd, uint8_t *response)
 {
     int ofs = 0;
 
-    if (sd->spi) {
+    if (sd->bus_protocol == PROTO_SPI) {
         ofs += sd_response_r1_make(sd, response);
     }
     response[ofs++] = (sd->ocr >> 24) & 0xff;
@@ -663,6 +692,7 @@ static void sd_response_r6_make(SDState *sd, uint8_t *response)
     uint16_t arg;
     uint16_t status;
 
+    assert(sd->bus_protocol != PROTO_SPI);
     arg = sd->rca;
     status = ((sd->card_status >> 8) & 0xc000) |
              ((sd->card_status >> 6) & 0x2000) |
@@ -677,6 +707,7 @@ static void sd_response_r6_make(SDState *sd, uint8_t *response)
 
 static void sd_response_r7_make(SDState *sd, uint8_t *response)
 {
+    assert(sd->bus_protocol != PROTO_SPI);
     response[0] = (sd->vhs >> 24) & 0xff;
     response[1] = (sd->vhs >> 16) & 0xff;
     response[2] = (sd->vhs >>  8) & 0xff;
@@ -844,7 +875,7 @@ static const VMStateDescription sd_vmstate = {
 };
 
 /* Legacy initialization function for use by non-qdevified callers */
-SDState *sd_init(BlockBackend *blk, bool is_spi)
+static SDState *sdcard_init(BlockBackend *blk, sd_bus_protocol_t bus_protocol)
 {
     Object *obj;
     DeviceState *dev;
@@ -857,7 +888,13 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
         error_report("sd_init failed: %s", error_get_pretty(err));
         return NULL;
     }
-    qdev_prop_set_bit(dev, "spi", is_spi);
+    switch (bus_protocol) {
+    case PROTO_SPI:
+        qdev_prop_set_bit(dev, "spi", true);
+        break;
+    default:
+        break;
+    }
     object_property_set_bool(obj, true, "realized", &err);
     if (err) {
         error_report("sd_init failed: %s", error_get_pretty(err));
@@ -867,6 +904,11 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     return SD_CARD(dev);
 }
 
+SDState *sd_init(BlockBackend *blk, bool is_spi)
+{
+    return sdcard_init(blk, is_spi ? PROTO_SPI : PROTO_SD);
+}
+
 void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
 {
     sd->readonly_cb = readonly;
@@ -1062,13 +1104,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->state = sd_idle_state;
             sd_reset(DEVICE(sd));
         }
-        return sd->spi ? sd_r1 : sd_r0;
+        return sd->bus_protocol == PROTO_SPI ? sd_r1 : sd_r0;
 
     case 1:	/* CMD1:   SEND_OP_CMD */
-        if (!sd->spi)
-            goto bad_cmd;
-        sd->state = sd_transfer_state;
-        return sd_r1;
+        if (sd->bus_protocol == PROTO_SPI) {
+            sd->state = sd_transfer_state;
+            return sd_r1;
+        }
+        goto bad_cmd;
 
     case 2:	/* CMD2:   ALL_SEND_CID */
         if (sd->state == sd_ready_state) {
@@ -1157,7 +1200,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
             /* No response if not exactly one VHS bit is set.  */
             if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-                return sd->spi ? sd_r7 : sd_r0;
+                return sd->bus_protocol == PROTO_SPI ? sd_r7 : sd_r0; /* XXX */
             }
 
             /* Accept.  */
@@ -1178,13 +1221,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             return sd_r2_s;
 
         case sd_transfer_state:
-            if (!sd->spi)
-                break;
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->csd, 16);
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            if (sd->bus_protocol == PROTO_SPI) {
+                sd->state = sd_sendingdata_state;
+                memcpy(sd->data, sd->csd, 16);
+                sd->data_start = addr;
+                sd->data_offset = 0;
+                return sd_r1;
+            }
 
         default:
             break;
@@ -1200,13 +1243,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             return sd_r2_i;
 
         case sd_transfer_state:
-            if (!sd->spi)
-                break;
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->cid, 16);
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            if (sd->bus_protocol == PROTO_SPI) {
+                sd->state = sd_sendingdata_state;
+                memcpy(sd->data, sd->cid, 16);
+                sd->data_start = addr;
+                sd->data_offset = 0;
+                return sd_r1;
+            }
 
         default:
             break;
@@ -1306,8 +1349,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd->spi)
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
@@ -1325,8 +1369,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 25:	/* CMD25:  WRITE_MULTIPLE_BLOCK */
-        if (sd->spi)
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
@@ -1353,8 +1398,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 27:	/* CMD27:  PROGRAM_CSD */
-        if (sd->spi)
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
@@ -1400,7 +1446,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
             sd->data_start = addr;
             sd->data_offset = 0;
-            return sd->spi ? sd_r1 : sd_r1b;
+            return sd->bus_protocol == PROTO_SPI ? sd_r1 : sd_r1b;
         }
         break;
 
@@ -1436,8 +1482,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:	/* CMD42:  LOCK_UNLOCK */
-        if (sd->spi)
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
@@ -1457,7 +1504,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:	/* CMD55:  APP_CMD */
-        if (!sd->spi) {
+        if (sd->bus_protocol != PROTO_SPI) {
             if (sd->rca != rca) {
                 return sd_r0;
             }
@@ -1478,13 +1525,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 58:    /* CMD58:   READ_OCR (SPI) */
-        if (!sd->spi) {
+        if (sd->bus_protocol != PROTO_SPI) {
             goto bad_cmd;
         }
         return sd_r3;
 
     case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
-        if (!sd->spi) {
+        if (sd->bus_protocol != PROTO_SPI) {
             goto bad_cmd;
         }
         goto unimplemented_cmd;
@@ -1524,12 +1571,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
-            return sd->spi ? sd_r2_s : sd_r1;
+            return sd->bus_protocol == PROTO_SPI ? sd_r2_s : sd_r1;
         }
         break;
 
     case 18:
-        if (sd->spi) {
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
         }
         break;
@@ -1553,19 +1600,19 @@ static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
 
     case 25:
     case 26:
-        if (sd->spi) {
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
         }
         break;
 
     case 38:
-        if (sd->spi) {
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
         }
         break;
 
     case 41:	/* ACMD41: SD_APP_OP_COND */
-        if (sd->spi) {
+        if (sd->bus_protocol == PROTO_SPI) {
             /* SEND_OP_CMD */
             sd->state = sd_transfer_state;
             return sd_r1;
@@ -1611,7 +1658,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
         break;
 
     case 43 ... 49:
-        if (sd->spi) {
+        if (sd->bus_protocol == PROTO_SPI) {
             goto unimplemented_cmd;
         }
         break;
@@ -2100,7 +2147,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     SDState *sd = SD_CARD(dev);
     int ret;
 
-    sd->proto_name = sd->spi ? "SPI" : "SD";
+    sd->proto_name = sd_protocol_name(sd->bus_protocol);
     sd->spec_version = SD_PHY_SPEC_VER_2_00;
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
@@ -2146,7 +2193,7 @@ static Property sd_properties[] = {
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
-    DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_BIT("spi", SDState, bus_protocol, 1, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.15.1
