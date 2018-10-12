Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwif-0006uR-BJ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwiY-0007bc-Iu
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAwiY-0007Zu-5Z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:38:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 14:38:50 +0200
Message-Id: <20181012123851.30856-5-kraxel@redhat.com>
In-Reply-To: <20181012123851.30856-1-kraxel@redhat.com>
References: <20181012123851.30856-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] i2c: switch ddc to use the new edid
 generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>

This also makes the default display resolution configurable,
via xres and yres properties.  The default is 1024x768.

The old code had a hard-coded resolution of 1600x1200.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181005110837.28209-1-kraxel@redhat.com
---
 include/hw/i2c/i2c-ddc.h |   4 +-
 hw/i2c/i2c-ddc.c         | 200 ++---------------------------------------------
 2 files changed, 11 insertions(+), 193 deletions(-)

diff --git a/include/hw/i2c/i2c-ddc.h b/include/hw/i2c/i2c-ddc.h
index d9b5f33f58..c29443c5af 100644
--- a/include/hw/i2c/i2c-ddc.h
+++ b/include/hw/i2c/i2c-ddc.h
@@ -19,14 +19,16 @@
 #ifndef I2C_DDC_H
 #define I2C_DDC_H
 
+#include "hw/display/edid.h"
+
 /* A simple I2C slave which just returns the contents of its EDID blob. */
-
 struct I2CDDCState {
     /*< private >*/
     I2CSlave i2c;
     /*< public >*/
     bool firstbyte;
     uint8_t reg;
+    qemu_edid_info edid_info;
     uint8_t edid_blob[128];
 };
 
diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index bec0c91e2d..be34fe072c 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -32,197 +32,6 @@
     }                                                                          \
 } while (0)
 
-/* Structure defining a monitor's characteristics in a
- * readable format: this should be passed to build_edid_blob()
- * to convert it into the 128 byte binary EDID blob.
- * Not all bits of the EDID are customisable here.
- */
-struct EDIDData {
-    char manuf_id[3]; /* three upper case letters */
-    uint16_t product_id;
-    uint32_t serial_no;
-    uint8_t manuf_week;
-    int manuf_year;
-    uint8_t h_cm;
-    uint8_t v_cm;
-    uint8_t gamma;
-    char monitor_name[14];
-    char serial_no_string[14];
-    /* Range limits */
-    uint8_t vmin; /* Hz */
-    uint8_t vmax; /* Hz */
-    uint8_t hmin; /* kHz */
-    uint8_t hmax; /* kHz */
-    uint8_t pixclock; /* MHz / 10 */
-    uint8_t timing_data[18];
-};
-
-typedef struct EDIDData EDIDData;
-
-/* EDID data for a simple LCD monitor */
-static const EDIDData lcd_edid = {
-    /* The manuf_id ought really to be an assigned EISA ID */
-    .manuf_id = "QMU",
-    .product_id = 0,
-    .serial_no = 1,
-    .manuf_week = 1,
-    .manuf_year = 2011,
-    .h_cm = 40,
-    .v_cm = 30,
-    .gamma = 0x78,
-    .monitor_name = "QEMU monitor",
-    .serial_no_string = "1",
-    .vmin = 40,
-    .vmax = 120,
-    .hmin = 30,
-    .hmax = 100,
-    .pixclock = 18,
-    .timing_data = {
-        /* Borrowed from a 21" LCD */
-        0x48, 0x3f, 0x40, 0x30, 0x62, 0xb0, 0x32, 0x40, 0x40,
-        0xc0, 0x13, 0x00, 0x98, 0x32, 0x11, 0x00, 0x00, 0x1e
-    }
-};
-
-static uint8_t manuf_char_to_int(char c)
-{
-    return (c - 'A') & 0x1f;
-}
-
-static void write_ascii_descriptor_block(uint8_t *descblob, uint8_t blocktype,
-                                         const char *string)
-{
-    /* Write an EDID Descriptor Block of the "ascii string" type */
-    int i;
-    descblob[0] = descblob[1] = descblob[2] = descblob[4] = 0;
-    descblob[3] = blocktype;
-    /* The rest is 13 bytes of ASCII; if less then the rest must
-     * be filled with newline then spaces
-     */
-    for (i = 5; i < 19; i++) {
-        descblob[i] = string[i - 5];
-        if (!descblob[i]) {
-            break;
-        }
-    }
-    if (i < 19) {
-        descblob[i++] = '\n';
-    }
-    for ( ; i < 19; i++) {
-        descblob[i] = ' ';
-    }
-}
-
-static void write_range_limits_descriptor(const EDIDData *edid,
-                                          uint8_t *descblob)
-{
-    int i;
-    descblob[0] = descblob[1] = descblob[2] = descblob[4] = 0;
-    descblob[3] = 0xfd;
-    descblob[5] = edid->vmin;
-    descblob[6] = edid->vmax;
-    descblob[7] = edid->hmin;
-    descblob[8] = edid->hmax;
-    descblob[9] = edid->pixclock;
-    descblob[10] = 0;
-    descblob[11] = 0xa;
-    for (i = 12; i < 19; i++) {
-        descblob[i] = 0x20;
-    }
-}
-
-static void build_edid_blob(const EDIDData *edid, uint8_t *blob)
-{
-    /* Write an EDID 1.3 format blob (128 bytes) based
-     * on the EDIDData structure.
-     */
-    int i;
-    uint8_t cksum;
-
-    /* 00-07 : header */
-    blob[0] = blob[7] = 0;
-    for (i = 1 ; i < 7; i++) {
-        blob[i] = 0xff;
-    }
-    /* 08-09 : manufacturer ID */
-    blob[8] = (manuf_char_to_int(edid->manuf_id[0]) << 2)
-        | (manuf_char_to_int(edid->manuf_id[1]) >> 3);
-    blob[9] = (manuf_char_to_int(edid->manuf_id[1]) << 5)
-        | manuf_char_to_int(edid->manuf_id[2]);
-    /* 10-11 : product ID code */
-    blob[10] = edid->product_id;
-    blob[11] = edid->product_id >> 8;
-    blob[12] = edid->serial_no;
-    blob[13] = edid->serial_no >> 8;
-    blob[14] = edid->serial_no >> 16;
-    blob[15] = edid->serial_no >> 24;
-    /* 16 : week of manufacture */
-    blob[16] = edid->manuf_week;
-    /* 17 : year of manufacture - 1990 */
-    blob[17] = edid->manuf_year - 1990;
-    /* 18, 19 : EDID version and revision */
-    blob[18] = 1;
-    blob[19] = 3;
-    /* 20 - 24 : basic display parameters */
-    /* We are always a digital display */
-    blob[20] = 0x80;
-    /* 21, 22 : max h/v size in cm */
-    blob[21] = edid->h_cm;
-    blob[22] = edid->v_cm;
-    /* 23 : gamma (divide by 100 then add 1 for actual value) */
-    blob[23] = edid->gamma;
-    /* 24 feature support: no power management, RGB, preferred timing mode,
-     * standard colour space
-     */
-    blob[24] = 0x0e;
-    /* 25 - 34 : chromaticity coordinates. These are the
-     * standard sRGB chromaticity values
-     */
-    blob[25] = 0xee;
-    blob[26] = 0x91;
-    blob[27] = 0xa3;
-    blob[28] = 0x54;
-    blob[29] = 0x4c;
-    blob[30] = 0x99;
-    blob[31] = 0x26;
-    blob[32] = 0x0f;
-    blob[33] = 0x50;
-    blob[34] = 0x54;
-    /* 35, 36 : Established timings: claim to support everything */
-    blob[35] = blob[36] = 0xff;
-    /* 37 : manufacturer's reserved timing: none */
-    blob[37] = 0;
-    /* 38 - 53 : standard timing identification
-     * don't claim anything beyond what the 'established timings'
-     * already provide. Unused slots must be (0x1, 0x1)
-     */
-    for (i = 38; i < 54; i++) {
-        blob[i] = 0x1;
-    }
-    /* 54 - 71 : descriptor block 1 : must be preferred timing data */
-    memcpy(blob + 54, edid->timing_data, 18);
-    /* 72 - 89, 90 - 107, 108 - 125 : descriptor block 2, 3, 4
-     * Order not important, but we must have a monitor name and a
-     * range limits descriptor.
-     */
-    write_range_limits_descriptor(edid, blob + 72);
-    write_ascii_descriptor_block(blob + 90, 0xfc, edid->monitor_name);
-    write_ascii_descriptor_block(blob + 108, 0xff, edid->serial_no_string);
-
-    /* 126 : extension flag */
-    blob[126] = 0;
-
-    cksum = 0;
-    for (i = 0; i < 127; i++) {
-        cksum += blob[i];
-    }
-    /* 127 : checksum */
-    blob[127] = -cksum;
-    if (DEBUG_I2CDDC) {
-        qemu_hexdump((char *)blob, stdout, "", 128);
-    }
-}
-
 static void i2c_ddc_reset(DeviceState *ds)
 {
     I2CDDCState *s = I2CDDC(ds);
@@ -270,7 +79,8 @@ static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)
 static void i2c_ddc_init(Object *obj)
 {
     I2CDDCState *s = I2CDDC(obj);
-    build_edid_blob(&lcd_edid, s->edid_blob);
+
+    qemu_edid_generate(s->edid_blob, sizeof(s->edid_blob), &s->edid_info);
 }
 
 static const VMStateDescription vmstate_i2c_ddc = {
@@ -283,6 +93,11 @@ static const VMStateDescription vmstate_i2c_ddc = {
     }
 };
 
+static Property i2c_ddc_properties[] = {
+    DEFINE_EDID_PROPERTIES(I2CDDCState, edid_info),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void i2c_ddc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -290,6 +105,7 @@ static void i2c_ddc_class_init(ObjectClass *oc, void *data)
 
     dc->reset = i2c_ddc_reset;
     dc->vmsd = &vmstate_i2c_ddc;
+    dc->props = i2c_ddc_properties;
     isc->event = i2c_ddc_event;
     isc->recv = i2c_ddc_rx;
     isc->send = i2c_ddc_tx;
-- 
2.9.3
