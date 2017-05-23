Received: from eggs.gnu.org ([2001:4830:134:3::10]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dCx3C-0007Xc-Ay
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dCx39-0003Z5-51
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:47:46 -0400
Received: from nm14-vm5.bullet.mail.ir2.yahoo.com ([212.82.96.193]:52115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dCx38-0003Yk-PM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:47:43 -0400
Date: Tue, 23 May 2017 00:47:38 +0000
From: John Bradley <flypie@rocketmail.com>
Sender: John Bradley <flypie@rocketmail.com>
Message-ID: <56fa8a79-fa90-4adc-aa0e-0527c9d96698@ONE.local>
MIME-Version: 1.0
Content-Type: text/plain; 
Subject: [Qemu-devel] [PATCH] [PATCH V2] GDummyPanel Fix formatingissues.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, flypie@rocketmail.com

>From 468b7c74d36b1e9d56ca014531301f0485254866 Mon Sep 17 00:00:00 2001
From: John Bradley <flypie@rocketmail.com>
Date: Fri, 19 May 2017 00:01:07 +0100
Subject: [PATCH] [PATCH V2] GDummyPanel Fix formatingissues.

Add inital discussion of protocol version.

Add code to connect with https://github.com/flypie/GDummyPanel The code uses GNU Sockets & Windows
sockets as on MINGW GNU no available. This is inteded as a Demo for RFC.

Signed-off-by: John Bradley <flypie@rocketmail.com>
---
 hw/gpio/bcm2835_gpio.c         | 316 ++++++++++++++++++++++-----------------
 include/hw/gpio/bcm2835_gpio.h |   4 +
 include/qemu/PanelEmu.h        |  53 +++++++
 util/Makefile.objs             |   1 +
 util/PanelEmu.c                | 327 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 570 insertions(+), 131 deletions(-)
 create mode 100644 include/qemu/PanelEmu.h
 create mode 100644 util/PanelEmu.c

diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index acc2e3cf9e..2c9026c597 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -19,6 +19,8 @@
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2835_gpio.h"
 
+
+
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
 #define GPFSEL2   0x08
@@ -55,7 +57,7 @@ static uint32_t gpfsel_get(BCM2835GpioState *s, uint8_t reg)
     uint32_t value = 0;
     for (i = 0; i < 10; i++) {
         uint32_t index = 10 * reg + i;
-        if (index < sizeof(s->fsel)) {
+        if (index < sizeof (s->fsel)) {
             value |= (s->fsel[index] & 0x7) << (3 * i);
         }
     }
@@ -67,7 +69,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
     int i;
     for (i = 0; i < 10; i++) {
         uint32_t index = 10 * reg + i;
-        if (index < sizeof(s->fsel)) {
+        if (index < sizeof (s->fsel)) {
             int fsel = (value >> (3 * i)) & 0x7;
             s->fsel[index] = fsel;
         }
@@ -75,24 +77,24 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
 
     /* SD controller selection (48-53) */
     if (s->sd_fsel != 0
-            && (s->fsel[48] == 0) /* SD_CLK_R */
-            && (s->fsel[49] == 0) /* SD_CMD_R */
-            && (s->fsel[50] == 0) /* SD_DATA0_R */
-            && (s->fsel[51] == 0) /* SD_DATA1_R */
-            && (s->fsel[52] == 0) /* SD_DATA2_R */
-            && (s->fsel[53] == 0) /* SD_DATA3_R */
-            ) {
+        && (s->fsel[48] == 0) /* SD_CLK_R */
+        && (s->fsel[49] == 0) /* SD_CMD_R */
+        && (s->fsel[50] == 0) /* SD_DATA0_R */
+        && (s->fsel[51] == 0) /* SD_DATA1_R */
+        && (s->fsel[52] == 0) /* SD_DATA2_R */
+        && (s->fsel[53] == 0) /* SD_DATA3_R */
+        ) {
         /* SDHCI controller selected */
         sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
         s->sd_fsel = 0;
     } else if (s->sd_fsel != 4
-            && (s->fsel[48] == 4) /* SD_CLK_R */
-            && (s->fsel[49] == 4) /* SD_CMD_R */
-            && (s->fsel[50] == 4) /* SD_DATA0_R */
-            && (s->fsel[51] == 4) /* SD_DATA1_R */
-            && (s->fsel[52] == 4) /* SD_DATA2_R */
-            && (s->fsel[53] == 4) /* SD_DATA3_R */
-            ) {
+               && (s->fsel[48] == 4) /* SD_CLK_R */
+               && (s->fsel[49] == 4) /* SD_CMD_R */
+               && (s->fsel[50] == 4) /* SD_DATA0_R */
+               && (s->fsel[51] == 4) /* SD_DATA1_R */
+               && (s->fsel[52] == 4) /* SD_DATA2_R */
+               && (s->fsel[53] == 4) /* SD_DATA3_R */
+               ) {
         /* SDHost controller selected */
         sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
         s->sd_fsel = 4;
@@ -108,9 +110,9 @@ static int gpfsel_is_out(BCM2835GpioState *s, int index)
 }
 
 static void gpset(BCM2835GpioState *s,
-        uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
+                  uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
 {
-    uint32_t changes = val & ~*lev;
+    uint32_t changes = val & ~ *lev;
     uint32_t cur = 1;
 
     int i;
@@ -125,7 +127,7 @@ static void gpset(BCM2835GpioState *s,
 }
 
 static void gpclr(BCM2835GpioState *s,
-        uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
+                  uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
 {
     uint32_t changes = val & *lev;
     uint32_t cur = 1;
@@ -141,116 +143,153 @@ static void gpclr(BCM2835GpioState *s,
     *lev &= ~val;
 }
 
-static uint64_t bcm2835_gpio_read(void *opaque, hwaddr offset,
-        unsigned size)
+static uint64_t bcm2835_gpio_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835GpioState *s = (BCM2835GpioState *)opaque;
 
+    uint64_t Data;
+
     switch (offset) {
-    case GPFSEL0:
-    case GPFSEL1:
-    case GPFSEL2:
-    case GPFSEL3:
-    case GPFSEL4:
-    case GPFSEL5:
-        return gpfsel_get(s, offset / 4);
-    case GPSET0:
-    case GPSET1:
-        /* Write Only */
-        return 0;
-    case GPCLR0:
-    case GPCLR1:
-        /* Write Only */
-        return 0;
-    case GPLEV0:
-        return s->lev0;
-    case GPLEV1:
-        return s->lev1;
-    case GPEDS0:
-    case GPEDS1:
-    case GPREN0:
-    case GPREN1:
-    case GPFEN0:
-    case GPFEN1:
-    case GPHEN0:
-    case GPHEN1:
-    case GPLEN0:
-    case GPLEN1:
-    case GPAREN0:
-    case GPAREN1:
-    case GPAFEN0:
-    case GPAFEN1:
-    case GPPUD:
-    case GPPUDCLK0:
-    case GPPUDCLK1:
-        /* Not implemented */
-        return 0;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-                __func__, offset);
-        break;
+        case GPFSEL0:
+        case GPFSEL1:
+        case GPFSEL2:
+        case GPFSEL3:
+        case GPFSEL4:
+        case GPFSEL5:
+            return gpfsel_get(s, offset / 4);
+        case GPSET0:
+        case GPSET1:
+            /* Write Only */
+            return 0;
+        case GPCLR0:
+        case GPCLR1:
+            /* Write Only */
+            return 0;
+        case GPLEV0:
+            if (s->panel.socket != -1) {
+                if (panel_read(&s->panel, &Data)) {
+                    s->lev0 = (uint32_t)Data;
+                    s->lev1 = (uint32_t)(Data >> 32);
+                }
+            }
+            return s->lev0;
+        case GPLEV1:
+            if (s->panel.socket != -1) {
+                if (panel_read(&s->panel, &Data)) {
+                    s->lev0 = (uint32_t)Data;
+                    s->lev1 = (uint32_t)(Data >> 32);
+                }
+            }
+            return s->lev1;
+        case GPEDS0:
+        case GPEDS1:
+        case GPREN0:
+        case GPREN1:
+        case GPFEN0:
+        case GPFEN1:
+        case GPHEN0:
+        case GPHEN1:
+        case GPLEN0:
+        case GPLEN1:
+        case GPAREN0:
+        case GPAREN1:
+        case GPAFEN0:
+        case GPAFEN1:
+        case GPPUD:
+        case GPPUDCLK0:
+        case GPPUDCLK1:
+            /* Not implemented */
+            return 0;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+                          __func__, offset);
+            break;
     }
 
     return 0;
 }
 
 static void bcm2835_gpio_write(void *opaque, hwaddr offset,
-        uint64_t value, unsigned size)
+                               uint64_t value, unsigned size)
 {
     BCM2835GpioState *s = (BCM2835GpioState *)opaque;
+    uint64_t Data;
+
 
     switch (offset) {
-    case GPFSEL0:
-    case GPFSEL1:
-    case GPFSEL2:
-    case GPFSEL3:
-    case GPFSEL4:
-    case GPFSEL5:
-        gpfsel_set(s, offset / 4, value);
-        break;
-    case GPSET0:
-        gpset(s, value, 0, 32, &s->lev0);
-        break;
-    case GPSET1:
-        gpset(s, value, 32, 22, &s->lev1);
-        break;
-    case GPCLR0:
-        gpclr(s, value, 0, 32, &s->lev0);
-        break;
-    case GPCLR1:
-        gpclr(s, value, 32, 22, &s->lev1);
-        break;
-    case GPLEV0:
-    case GPLEV1:
-        /* Read Only */
-        break;
-    case GPEDS0:
-    case GPEDS1:
-    case GPREN0:
-    case GPREN1:
-    case GPFEN0:
-    case GPFEN1:
-    case GPHEN0:
-    case GPHEN1:
-    case GPLEN0:
-    case GPLEN1:
-    case GPAREN0:
-    case GPAREN1:
-    case GPAFEN0:
-    case GPAFEN1:
-    case GPPUD:
-    case GPPUDCLK0:
-    case GPPUDCLK1:
-        /* Not implemented */
-        break;
-    default:
-        goto err_out;
+        case GPFSEL0:
+        case GPFSEL1:
+        case GPFSEL2:
+        case GPFSEL3:
+        case GPFSEL4:
+        case GPFSEL5:
+            gpfsel_set(s, offset / 4, value);
+            break;
+        case GPSET0:
+            gpset(s, value, 0, 32, &s->lev0);
+            if (s->panel.socket != -1) {
+                Data = value;
+                /* John Bradley dummy GPIO Panel */
+                senddatatopanel(&s->panel, Data, true);
+            }
+            break;
+        case GPSET1:
+            gpset(s, value, 32, 22, &s->lev1);
+            if (s->panel.socket != -1) {
+                Data = value;
+                Data <<= 32;
+                /* John Bradley dummy GPIO Panel */
+                senddatatopanel(&s->panel, Data, true);
+            }
+            break;
+        case GPCLR0:
+            gpclr(s, value, 0, 32, &s->lev0);
+            if (s->panel.socket != -1) {
+                Data = value;
+                /* John Bradley dummy GPIO Panel */
+                senddatatopanel(&s->panel, Data, false);
+            }
+            break;
+        case GPCLR1:
+            gpclr(s, value, 32, 22, &s->lev1);
+            if (s->panel.socket != -1) {
+                Data = value;
+                Data <<= 32;
+                /* John Bradley dummy GPIO Panel */
+                senddatatopanel(&s->panel, Data, false);
+            }
+            break;
+        case GPLEV0:
+        case GPLEV1:
+            /* Read Only */
+            break;
+        case GPEDS0:
+        case GPEDS1:
+        case GPREN0:
+        case GPREN1:
+        case GPFEN0:
+        case GPFEN1:
+        case GPHEN0:
+        case GPHEN1:
+        case GPLEN0:
+        case GPLEN1:
+        case GPAREN0:
+        case GPAREN1:
+        case GPAFEN0:
+        case GPAFEN1:
+        case GPPUD:
+        case GPPUDCLK0:
+        case GPPUDCLK1:
+            /* Not implemented */
+            break;
+        default:
+            goto err_out;
     }
     return;
 
 err_out:
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-            __func__, offset);
+                  __func__, offset);
 }
 
 static void bcm2835_gpio_reset(DeviceState *dev)
@@ -272,21 +311,22 @@ static void bcm2835_gpio_reset(DeviceState *dev)
 }
 
 static const MemoryRegionOps bcm2835_gpio_ops = {
-    .read = bcm2835_gpio_read,
-    .write = bcm2835_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+                                                 .read = bcm2835_gpio_read,
+                                                 .write = bcm2835_gpio_write,
+                                                 .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_bcm2835_gpio = {
-    .name = "bcm2835_gpio",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(fsel, BCM2835GpioState, 54),
-        VMSTATE_UINT32(lev0, BCM2835GpioState),
-        VMSTATE_UINT32(lev1, BCM2835GpioState),
-        VMSTATE_UINT8(sd_fsel, BCM2835GpioState),
-        VMSTATE_END_OF_LIST()
+                                                        .name = "bcm2835_gpio",
+                                                        .version_id = 1,
+                                                        .minimum_version_id = 1,
+                                                        .fields = (VMStateField[])
+    {
+     VMSTATE_UINT8_ARRAY(fsel, BCM2835GpioState, 54),
+     VMSTATE_UINT32(lev0, BCM2835GpioState),
+     VMSTATE_UINT32(lev1, BCM2835GpioState),
+     VMSTATE_UINT8(sd_fsel, BCM2835GpioState),
+     VMSTATE_END_OF_LIST()
     }
 };
 
@@ -296,13 +336,27 @@ static void bcm2835_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
+    qbus_create_inplace(&s->sdbus, sizeof (s->sdbus),
                         TYPE_SD_BUS, DEVICE(s), "sd-bus");
 
     memory_region_init_io(&s->iomem, obj,
-            &bcm2835_gpio_ops, s, "bcm2835_gpio", 0x1000);
+                          &bcm2835_gpio_ops, s, "bcm2835_gpio", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     qdev_init_gpio_out(dev, s->out, 54);
+
+    /* Get access to the GPIO panel, program will quit on fail */
+    if (panel_open(&s->panel)) {
+        /* PI Has 54 Pins */
+        sendpincount(&s->panel, 54);
+        /* Pins 0 & 1 are I2C so disable */
+        sendenabledmap(&s->panel, 0x003FFFFFFFFFFFFC);
+        /* There are no dedicated input pins I know of */
+        sendinputmap(&s->panel, 0x0000000000000000);
+        /* Pin 53 is dedicated output LED */
+        sendoutputmap(&s->panel, 0x0000800000000000);
+    } else {
+        printf("Couldn't connect to a GPIO panel\n");
+    }
 }
 
 static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
@@ -314,7 +368,7 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
     obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &err);
     if (obj == NULL) {
         error_setg(errp, "%s: required sdhci link not found: %s",
-                __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(err));
         return;
     }
     s->sdbus_sdhci = SD_BUS(obj);
@@ -322,7 +376,7 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
     obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &err);
     if (obj == NULL) {
         error_setg(errp, "%s: required sdhost link not found: %s",
-                __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(err));
         return;
     }
     s->sdbus_sdhost = SD_BUS(obj);
@@ -338,11 +392,11 @@ static void bcm2835_gpio_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo bcm2835_gpio_info = {
-    .name          = TYPE_BCM2835_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(BCM2835GpioState),
-    .instance_init = bcm2835_gpio_init,
-    .class_init    = bcm2835_gpio_class_init,
+                                           .name = TYPE_BCM2835_GPIO,
+                                           .parent = TYPE_SYS_BUS_DEVICE,
+                                           .instance_size = sizeof (BCM2835GpioState),
+                                           .instance_init = bcm2835_gpio_init,
+                                           .class_init = bcm2835_gpio_class_init,
 };
 
 static void bcm2835_gpio_register_types(void)
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpio.h
index 9f8e0c720c..f7d7c79aa2 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -15,6 +15,7 @@
 #define BCM2835_GPIO_H
 
 #include "hw/sd/sd.h"
+#include "qemu/PanelEmu.h"
 
 typedef struct BCM2835GpioState {
     SysBusDevice parent_obj;
@@ -30,6 +31,9 @@ typedef struct BCM2835GpioState {
     uint32_t lev0, lev1;
     uint8_t sd_fsel;
     qemu_irq out[54];
+
+    panel_connection_t panel;
+
 } BCM2835GpioState;
 
 #define TYPE_BCM2835_GPIO "bcm2835_gpio"
diff --git a/include/qemu/PanelEmu.h b/include/qemu/PanelEmu.h
new file mode 100644
index 0000000000..35a0b2c3af
--- /dev/null
+++ b/include/qemu/PanelEmu.h
@@ -0,0 +1,53 @@
+/*
+ * To change this license header, choose License Headers in Project Properties.
+ * To change this template file, choose Tools | Templates
+ * and open the template in the editor.
+ */
+
+/*
+ * File:   PanelEmu.h
+ * Author: John Bradley
+ *
+ * Created on 22 April 2017, 22:26
+ */
+
+#ifndef PANELEMU_H
+#define PANELEMU_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+
+#define DRIVER_NAME "RDC-GPIO: "
+#define PANEL_NAME "GPIO panel: "
+
+
+#define DEFAULT_PORT 0xb1ff       /*45567*/
+
+#define PANEL_PINS 54
+
+    typedef struct panel_connection {
+        int socket; /* socket we'll connect to the panel with */
+        fd_set fds; /* list of descriptors (only the above socket */
+        char last[PANEL_PINS / 8]; /* we don't want to send updates to the panel
+	                       unless something changed */
+        int ProtocolInUse; /*What version of the protocol are we using. */
+    } panel_connection_t;
+
+    bool panel_open(panel_connection_t *h);
+
+    bool panel_read(panel_connection_t *h, uint64_t *pinS);
+    void senddatatopanel(panel_connection_t *h, uint64_t pinS, bool Value);
+    void panel_send_read_command(panel_connection_t *h);
+    void sendpincount(panel_connection_t *h, int Num);
+    void sendenabledmap(panel_connection_t *h, uint64_t pins);
+    void sendinputmap(panel_connection_t *h, uint64_t pins);
+    void sendoutputmap(panel_connection_t *h, uint64_t pins);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* PANELEMU_H */
+
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205ebf86..8316ed79ba 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -43,3 +43,4 @@ util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += systemd.o
+util-obj-y += PanelEmu.o
\ No newline at end of file
diff --git a/util/PanelEmu.c b/util/PanelEmu.c
new file mode 100644
index 0000000000..4700f951ec
--- /dev/null
+++ b/util/PanelEmu.c
@@ -0,0 +1,327 @@
+/*
+ * Emulation for Rasp PI GPIO via Server connected to via Socket
+ *
+ */
+#include "qemu/osdep.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <memory.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#endif
+
+#include "qemu/PanelEmu.h"
+
+typedef enum
+{
+    PROTOCOLDESCFROMQEMU = 0,
+    PROTOCOLDESCFROMPANEL = 1,
+    PINSTOPANEL = 2,
+    READREQ = 3,
+    PINCOUNT = 4,
+    ENABLEMAP = 5,
+    INPUTMAP = 6,
+    OUTPUTMAP = 7,
+    PINSTOQEMU = 8
+} PacketType;
+
+#define MINPROTOCOL 0
+#define MAXPROTOCOL 0
+
+#define MAXPACKET   255
+
+#define PACKETLEN   0  /* Includes Packet Length */
+#define PACKETTYPE  1
+
+typedef struct
+{
+    unsigned short int Data[MAXPACKET];
+} CommandPacket;
+
+static void panel_command(panel_connection_t *h, CommandPacket *Pkt);
+
+static void panel_send_protocol_command(panel_connection_t *h)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = 8;
+    Pkt.Data[PACKETTYPE] = PROTOCOLDESCFROMQEMU;
+    Pkt.Data[2] = MINPROTOCOL;
+    Pkt.Data[3] = MAXPROTOCOL;
+
+    panel_command(h, &Pkt);
+}
+
+void panel_send_read_command(panel_connection_t *h)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = 4;
+    Pkt.Data[PACKETTYPE] = READREQ;
+
+    panel_command(h, &Pkt);
+}
+
+/* Set a pin to a specified value */
+void senddatatopanel(panel_connection_t *h, uint64_t pin, bool val)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *)&Pkt.Data[6 + 1] - (char *)&Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = PINSTOPANEL;
+    Pkt.Data[2] = (unsigned short int)(pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int)((pin >> 16) & 0xFFFF);
+    Pkt.Data[4] = (unsigned short int)(pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int)((pin >> 48) & 0xFFFF);
+    Pkt.Data[6] = val;
+
+    panel_command(h, &Pkt);
+}
+
+void sendpincount(panel_connection_t *h, int val)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *)&Pkt.Data[2 + 1] - (char *)&Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = PINCOUNT;
+    Pkt.Data[2] = val;
+
+    panel_command(h, &Pkt);
+}
+
+void sendenabledmap(panel_connection_t *h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *)&Pkt.Data[5 + 1] - (char *)&Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = ENABLEMAP;
+    Pkt.Data[2] = (unsigned short int)(pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int)((pin >> 16) & 0xFFFF);
+    Pkt.Data[4] = (unsigned short int)(pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int)((pin >> 48) & 0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
+void sendinputmap(panel_connection_t *h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *)&Pkt.Data[5 + 1] - (char *)&Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = INPUTMAP;
+    Pkt.Data[2] = (unsigned short int)(pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int)((pin >> 16) & 0xFFFF);
+    Pkt.Data[4] = (unsigned short int)(pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int)((pin >> 48) & 0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
+void sendoutputmap(panel_connection_t *h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *)&Pkt.Data[5 + 1] - (char *)&Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = OUTPUTMAP;
+    Pkt.Data[2] = (unsigned short int)(pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int)((pin >> 16) & 0xFFFF);
+    Pkt.Data[4] = (unsigned short int)(pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int)((pin >> 48) & 0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
+static void panel_command(panel_connection_t *h, CommandPacket *Pkt)
+{
+    if (send(h->socket, (char *)Pkt, Pkt->Data[PACKETLEN], 0) == -1) {
+        perror(PANEL_NAME "send");
+#ifdef __MINGW32__
+        closesocket(h->socket);
+#else
+        close(h->socket);
+#endif
+        h->socket = -1; /* act like we never connected */
+    }
+}
+
+/* Wait for values to be read back from panel */
+bool panel_read(panel_connection_t *h, uint64_t* Data)
+{
+    fd_set rfds, efds;
+    int LengthInBuffer;
+    int select_res = 0;
+
+    CommandPacket *PktPtr = (CommandPacket *)malloc(sizeof(CommandPacket));
+    CommandPacket *Pkt;
+    bool NoError = true;
+    bool NewData = false;
+    bool NoData = false;
+    struct timeval timeout;
+
+    int ReadStart = 0;
+
+    timeout.tv_sec = 0;
+    timeout.tv_usec = 0;
+
+    if (h->socket != -1) {
+        rfds = h->fds;
+        efds = h->fds;
+
+        Pkt = PktPtr;
+        while (NoError&&! NoData) {
+            select_res = select(h->socket + 1, &rfds, NULL, &efds, &timeout);
+            if (select_res > 0) {
+                if (FD_ISSET(h->socket, &rfds)) {
+                    /* receive more data */
+                    LengthInBuffer = recv(h->socket, (char *)&Pkt[ReadStart],
+                                    sizeof(*Pkt) - ReadStart, 0);
+                    if (LengthInBuffer > 0) {
+                        LengthInBuffer += ReadStart;
+                        for (int i = 0; LengthInBuffer > 0; i ++) {
+                            if (LengthInBuffer >= Pkt->Data[i + PACKETLEN]) {
+                                switch (Pkt->Data[i + PACKETTYPE]) {
+                                case PINSTOQEMU:
+                                    *Data = (uint64_t)Pkt->Data[i + 2];
+                                    *Data |= ((uint64_t)Pkt->Data[i + 3]) << 16;
+                                    *Data |= ((uint64_t)Pkt->Data[i + 4]) << 32;
+                                    *Data |= ((uint64_t)Pkt->Data[i + 5]) << 48;
+
+                                    NewData = true;
+                                    break;
+
+                                case PROTOCOLDESCFROMPANEL:
+                                    h->ProtocolInUse = (int)Pkt->Data[i + 2];
+                                    if (h->ProtocolInUse != -1) {
+                                        printf(PANEL_NAME "Protocol %d\n",
+                                               h->ProtocolInUse);
+                                    } else {
+                                        printf(PANEL_NAME "No Common Pcol\n");
+                                    }
+                                    break;
+
+                                default:
+                                    printf(PANEL_NAME "Invalid data receive\n");
+                                    break;
+                                }
+                                LengthInBuffer -= Pkt->Data[PACKETLEN];
+                                i += Pkt->Data[PACKETLEN];
+                            } else {
+                                ReadStart = LengthInBuffer;
+                                for (int j = 0; j < LengthInBuffer; j ++) {
+                                    Pkt->Data[j] = Pkt->Data[i + j];
+                                }
+                                printf(PANEL_NAME "Partial Packet Read");
+                            }
+                        }
+                    } else {
+                        if (LengthInBuffer < 0) {
+                            if (errno != EINTR) {
+                                printf(PANEL_NAME "recv");
+                                NoError = FALSE;
+                            }
+                        } else {
+                            printf(PANEL_NAME "closed connection\n");
+                            NoError = FALSE;
+                        }
+                    }
+                }
+            } else if (select_res == 0) {
+                NoData = true;
+            } else if (errno != EINTR) {
+#ifdef __MINGW32__
+                closesocket(h->socket);
+#else
+                close(h->socket);
+#endif
+                h->socket = -1; /* act like we never connected */
+                perror(PANEL_NAME "select error");
+                NoError = FALSE;
+            }
+        }
+    }
+
+    free(PktPtr);
+
+    return NewData;
+}
+
+bool panel_open(panel_connection_t *h)
+{
+    int rv;
+#ifdef __MINGW32__
+    struct sockaddr_in remote;
+#else
+    struct sockaddr_in remote;
+#endif
+
+    bool returnval = false;
+
+#ifdef __MINGW32__
+    printf("__MINGW32__\n");
+#else
+    printf("NOT __MINGW32__\n");
+#endif
+
+    h->socket = -1;
+    h->ProtocolInUse = -1;
+
+#ifdef __MINGW32__
+    WSADATA wsadata;
+    if (WSAStartup(MAKEWORD(1, 1), &wsadata) == SOCKET_ERROR) {
+        printf("Error creating socket.\n");
+    } else {
+#endif
+        h->socket = socket(AF_INET, SOCK_STREAM, 0);
+        if (h->socket != -1) {
+#ifdef __MINGW32__
+            memset((char *)&remote, 0, sizeof(remote));
+            remote.sin_family = AF_INET;
+            remote.sin_port = htons(DEFAULT_PORT);
+            remote.sin_addr.s_addr = inet_addr("127.0.0.1");
+#else
+            memset((char *)&remote, 0, sizeof(remote));
+            remote.sin_family = AF_INET;
+            remote.sin_port = htons(DEFAULT_PORT);
+            remote.sin_addr.s_addr = inet_addr("127.0.0.1");
+#endif
+            rv = connect(h->socket,
+                            (struct sockaddr *)&remote, sizeof(remote));
+            if (rv != -1) {
+#ifdef __MINGW32__
+                char value = 1;
+                setsockopt(h->socket, IPPROTO_TCP, TCP_NODELAY,
+                           &value, sizeof(value));
+#endif
+                FD_ZERO(&h->fds);
+
+                /* Set our connected socket */
+                FD_SET(h->socket, &h->fds);
+
+                printf(PANEL_NAME "Connected OK %d\n", rv);
+
+                panel_send_protocol_command(h);
+
+                returnval = true;
+            } else {
+                printf(PANEL_NAME "connection Fails %d\n", rv);
+#ifdef __MINGW32__
+                closesocket(h->socket);
+#else
+                close(h->socket);
+#endif
+                h->socket = -1;
+            }
+        }
+#ifdef __MINGW32__
+    }
+#endif
+    return returnval;
+}
-- 
2.13.0.windows.1
