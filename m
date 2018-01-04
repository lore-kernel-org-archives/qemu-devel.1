Received: from eggs.gnu.org ([2001:4830:134:3::10]:51802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX5NS-0006en-Ad
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX5NI-00009p-5j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX5NH-000078-L2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:15:59 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  4 Jan 2018 14:15:52 +0100
Message-Id: <1515071752-22961-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The option has been marked as deprecated since QEMU 2.10, and so far
nobody complained that it is urgently required anymore. So let's now
get rid of this legacy pile, to simplify the usb code quite a bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Keep a stub in vl.c that still prints out an error message
     with the hint to use -device instead.

 hw/usb/Makefile.objs          |   2 +-
 hw/usb/bus.c                  |  98 ----------------------------
 hw/usb/dev-audio.c            |   1 -
 hw/usb/dev-bluetooth.c        |  22 -------
 hw/usb/dev-hid.c              |   3 -
 hw/usb/dev-network.c          |  26 --------
 hw/usb/dev-serial.c           |  45 -------------
 hw/usb/dev-smartcard-reader.c |   1 -
 hw/usb/dev-storage.c          |  58 -----------------
 hw/usb/dev-wacom.c            |   1 -
 hw/usb/host-legacy.c          | 144 ------------------------------------------
 include/hw/usb.h              |   5 --
 qemu-doc.texi                 |   8 ---
 qemu-options.hx               |  47 +-------------
 vl.c                          |  57 +----------------
 15 files changed, 5 insertions(+), 513 deletions(-)
 delete mode 100644 hw/usb/host-legacy.c

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index bdfead6..fbcd498 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -43,7 +43,7 @@ redirect.o-libs = $(USB_REDIR_LIBS)
 
 # usb pass-through
 ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
-common-obj-y += host-libusb.o host-legacy.o
+common-obj-y += host-libusb.o
 else
 common-obj-y += host-stub.o
 endif
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 11f7720..0f1b16f 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -297,36 +297,6 @@ static void usb_qdev_unrealize(DeviceState *qdev, Error **errp)
     }
 }
 
-typedef struct LegacyUSBFactory
-{
-    const char *name;
-    const char *usbdevice_name;
-    USBDevice *(*usbdevice_init)(USBBus *bus, const char *params);
-} LegacyUSBFactory;
-
-static GSList *legacy_usb_factory;
-
-void usb_legacy_register(const char *typename, const char *usbdevice_name,
-                         USBDevice *(*usbdevice_init)(USBBus *bus,
-                                                      const char *params))
-{
-    if (usbdevice_name) {
-        LegacyUSBFactory *f = g_malloc0(sizeof(*f));
-        f->name = typename;
-        f->usbdevice_name = usbdevice_name;
-        f->usbdevice_init = usbdevice_init;
-        legacy_usb_factory = g_slist_append(legacy_usb_factory, f);
-    }
-}
-
-USBDevice *usb_create(USBBus *bus, const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(&bus->qbus, name);
-    return USB_DEVICE(dev);
-}
-
 static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
                                         Error **errp)
 {
@@ -654,74 +624,6 @@ void hmp_info_usb(Monitor *mon, const QDict *qdict)
     }
 }
 
-/* handle legacy -usbdevice cmd line option */
-USBDevice *usbdevice_create(const char *cmdline)
-{
-    USBBus *bus = usb_bus_find(-1 /* any */);
-    LegacyUSBFactory *f = NULL;
-    Error *err = NULL;
-    GSList *i;
-    char driver[32];
-    const char *params;
-    int len;
-    USBDevice *dev;
-
-    params = strchr(cmdline,':');
-    if (params) {
-        params++;
-        len = params - cmdline;
-        if (len > sizeof(driver))
-            len = sizeof(driver);
-        pstrcpy(driver, len, cmdline);
-    } else {
-        params = "";
-        pstrcpy(driver, sizeof(driver), cmdline);
-    }
-
-    for (i = legacy_usb_factory; i; i = i->next) {
-        f = i->data;
-        if (strcmp(f->usbdevice_name, driver) == 0) {
-            break;
-        }
-    }
-    if (i == NULL) {
-#if 0
-        /* no error because some drivers are not converted (yet) */
-        error_report("usbdevice %s not found", driver);
-#endif
-        return NULL;
-    }
-
-    if (!bus) {
-        error_report("Error: no usb bus to attach usbdevice %s, "
-                     "please try -machine usb=on and check that "
-                     "the machine model supports USB", driver);
-        return NULL;
-    }
-
-    if (f->usbdevice_init) {
-        dev = f->usbdevice_init(bus, params);
-    } else {
-        if (*params) {
-            error_report("usbdevice %s accepts no params", driver);
-            return NULL;
-        }
-        dev = usb_create(bus, f->name);
-    }
-    if (!dev) {
-        error_report("Failed to create USB device '%s'", f->name);
-        return NULL;
-    }
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err) {
-        error_reportf_err(err, "Failed to initialize USB device '%s': ",
-                          f->name);
-        object_unparent(OBJECT(dev));
-        return NULL;
-    }
-    return dev;
-}
-
 static bool usb_get_attached(Object *obj, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 3433452..ea4edd1 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -697,7 +697,6 @@ static const TypeInfo usb_audio_info = {
 static void usb_audio_register_types(void)
 {
     type_register_static(&usb_audio_info);
-    usb_legacy_register(TYPE_USB_AUDIO, "audio", NULL);
 }
 
 type_init(usb_audio_register_types)
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 443e3c3..2ed28c1 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -522,27 +522,6 @@ static void usb_bt_realize(USBDevice *dev, Error **errp)
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, USB_EVT_EP);
 }
 
-static USBDevice *usb_bt_init(USBBus *bus, const char *cmdline)
-{
-    USBDevice *dev;
-    struct USBBtState *s;
-    HCIInfo *hci;
-    const char *name = TYPE_USB_BT;
-
-    if (*cmdline) {
-        hci = hci_init(cmdline);
-    } else {
-        hci = bt_new_hci(qemu_find_bt_vlan(0));
-    }
-    if (!hci)
-        return NULL;
-
-    dev = usb_create(bus, name);
-    s = USB_BT(dev);
-    s->hci = hci;
-    return dev;
-}
-
 static const VMStateDescription vmstate_usb_bt = {
     .name = "usb-bt",
     .unmigratable = 1,
@@ -574,7 +553,6 @@ static const TypeInfo bt_info = {
 static void usb_bt_register_types(void)
 {
     type_register_static(&bt_info);
-    usb_legacy_register(TYPE_USB_BT, "bt", usb_bt_init);
 }
 
 type_init(usb_bt_register_types)
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index c40019d..5d74d5a 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -873,11 +873,8 @@ static void usb_hid_register_types(void)
 {
     type_register_static(&usb_hid_type_info);
     type_register_static(&usb_tablet_info);
-    usb_legacy_register("usb-tablet", "tablet", NULL);
     type_register_static(&usb_mouse_info);
-    usb_legacy_register("usb-mouse", "mouse", NULL);
     type_register_static(&usb_keyboard_info);
-    usb_legacy_register("usb-kbd", "keyboard", NULL);
 }
 
 type_init(usb_hid_register_types)
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 85fc81b..aea7edc 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1382,31 +1382,6 @@ static void usb_net_instance_init(Object *obj)
                                   &dev->qdev, NULL);
 }
 
-static USBDevice *usb_net_init(USBBus *bus, const char *cmdline)
-{
-    Error *local_err = NULL;
-    USBDevice *dev;
-    QemuOpts *opts;
-    int idx;
-
-    opts = qemu_opts_parse_noisily(qemu_find_opts("net"), cmdline, false);
-    if (!opts) {
-        return NULL;
-    }
-    qemu_opt_set(opts, "type", "nic", &error_abort);
-    qemu_opt_set(opts, "model", "usb", &error_abort);
-
-    idx = net_client_init(opts, false, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return NULL;
-    }
-
-    dev = usb_create(bus, "usb-net");
-    qdev_set_nic_properties(&dev->qdev, &nd_table[idx]);
-    return dev;
-}
-
 static const VMStateDescription vmstate_usb_net = {
     .name = "usb-net",
     .unmigratable = 1,
@@ -1446,7 +1421,6 @@ static const TypeInfo net_info = {
 static void usb_net_register_types(void)
 {
     type_register_static(&net_info);
-    usb_legacy_register(TYPE_USB_NET, "net", usb_net_init);
 }
 
 type_init(usb_net_register_types)
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 94b5c34..7a51154 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -509,49 +509,6 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
     }
 }
 
-static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
-{
-    USBDevice *dev;
-    Chardev *cdrv;
-    char label[32];
-    static int index;
-
-    if (*filename == ':') {
-        filename++;
-    } else if (*filename) {
-        error_report("unrecognized serial USB option %s", filename);
-        return NULL;
-    }
-    if (!*filename) {
-        error_report("character device specification needed");
-        return NULL;
-    }
-
-    snprintf(label, sizeof(label), "usbserial%d", index++);
-    cdrv = qemu_chr_new(label, filename);
-    if (!cdrv)
-        return NULL;
-
-    dev = usb_create(bus, "usb-serial");
-    qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
-
-    return dev;
-}
-
-static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
-{
-    USBDevice *dev;
-    Chardev *cdrv;
-
-    cdrv = qemu_chr_new("braille", "braille");
-    if (!cdrv)
-        return NULL;
-
-    dev = usb_create(bus, "usb-braille");
-    qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
-    return dev;
-}
-
 static const VMStateDescription vmstate_usb_serial = {
     .name = "usb-serial",
     .unmigratable = 1,
@@ -624,9 +581,7 @@ static void usb_serial_register_types(void)
 {
     type_register_static(&usb_serial_dev_type_info);
     type_register_static(&serial_info);
-    usb_legacy_register("usb-serial", "serial", usb_serial_init);
     type_register_static(&braille_info);
-    usb_legacy_register("usb-braille", "braille", usb_braille_init);
 }
 
 type_init(usb_serial_register_types)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e334d3b..aeadc86 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1496,7 +1496,6 @@ static void ccid_register_types(void)
     type_register_static(&ccid_bus_info);
     type_register_static(&ccid_card_type_info);
     type_register_static(&ccid_info);
-    usb_legacy_register(CCID_DEV_NAME, "ccid", NULL);
 }
 
 type_init(ccid_register_types)
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 9722ac8..e44a5c7 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -666,63 +666,6 @@ static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
     usb_msd_handle_reset(dev);
 }
 
-static USBDevice *usb_msd_init(USBBus *bus, const char *filename)
-{
-    static int nr=0;
-    Error *err = NULL;
-    char id[8];
-    QemuOpts *opts;
-    DriveInfo *dinfo;
-    USBDevice *dev;
-    const char *p1;
-    char fmt[32];
-
-    /* parse -usbdevice disk: syntax into drive opts */
-    do {
-        snprintf(id, sizeof(id), "usb%d", nr++);
-        opts = qemu_opts_create(qemu_find_opts("drive"), id, 1, NULL);
-    } while (!opts);
-
-    p1 = strchr(filename, ':');
-    if (p1++) {
-        const char *p2;
-
-        if (strstart(filename, "format=", &p2)) {
-            int len = MIN(p1 - p2, sizeof(fmt));
-            pstrcpy(fmt, len, p2);
-            qemu_opt_set(opts, "format", fmt, &error_abort);
-        } else if (*filename != ':') {
-            error_report("unrecognized USB mass-storage option %s", filename);
-            return NULL;
-        }
-        filename = p1;
-    }
-    if (!*filename) {
-        error_report("block device specification needed");
-        return NULL;
-    }
-    qemu_opt_set(opts, "file", filename, &error_abort);
-    qemu_opt_set(opts, "if", "none", &error_abort);
-
-    /* create host drive */
-    dinfo = drive_new(opts, 0);
-    if (!dinfo) {
-        qemu_opts_del(opts);
-        return NULL;
-    }
-
-    /* create guest device */
-    dev = usb_create(bus, "usb-storage");
-    qdev_prop_set_drive(&dev->qdev, "drive", blk_by_legacy_dinfo(dinfo),
-                        &err);
-    if (err) {
-        error_report_err(err);
-        object_unparent(OBJECT(dev));
-        return NULL;
-    }
-    return dev;
-}
-
 static const VMStateDescription vmstate_usb_msd = {
     .name = "usb-storage",
     .version_id = 1,
@@ -855,7 +798,6 @@ static void usb_msd_register_types(void)
     type_register_static(&usb_storage_dev_type_info);
     type_register_static(&msd_info);
     type_register_static(&bot_info);
-    usb_legacy_register("usb-storage", "disk", usb_msd_init);
 }
 
 type_init(usb_msd_register_types)
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index bf70013..6371a24 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -380,7 +380,6 @@ static const TypeInfo wacom_info = {
 static void usb_wacom_register_types(void)
 {
     type_register_static(&wacom_info);
-    usb_legacy_register(TYPE_USB_WACOM, "wacom-tablet", NULL);
 }
 
 type_init(usb_wacom_register_types)
diff --git a/hw/usb/host-legacy.c b/hw/usb/host-legacy.c
deleted file mode 100644
index 3b57e21..0000000
--- a/hw/usb/host-legacy.c
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Linux host USB redirector
- *
- * Copyright (c) 2005 Fabrice Bellard
- *
- * Copyright (c) 2008 Max Krasnyansky
- *      Support for host device auto connect & disconnect
- *      Major rewrite to support fully async operation
- *
- * Copyright 2008 TJ <linux@tjworld.net>
- *      Added flexible support for /dev/bus/usb /sys/bus/usb/devices in addition
- *      to the legacy /proc/bus/usb USB device discovery and handling
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "hw/usb.h"
-#include "hw/usb/host.h"
-
-/*
- * Autoconnect filter
- * Format:
- *    auto:bus:dev[:vid:pid]
- *    auto:bus.dev[:vid:pid]
- *
- *    bus  - bus number    (dec, * means any)
- *    dev  - device number (dec, * means any)
- *    vid  - vendor id     (hex, * means any)
- *    pid  - product id    (hex, * means any)
- *
- *    See 'lsusb' output.
- */
-static int parse_filter(const char *spec, struct USBAutoFilter *f)
-{
-    enum { BUS, DEV, VID, PID, DONE };
-    const char *p = spec;
-    int i;
-
-    f->bus_num    = 0;
-    f->addr       = 0;
-    f->vendor_id  = 0;
-    f->product_id = 0;
-
-    for (i = BUS; i < DONE; i++) {
-        p = strpbrk(p, ":.");
-        if (!p) {
-            break;
-        }
-        p++;
-
-        if (*p == '*') {
-            continue;
-        }
-        switch (i) {
-        case BUS:
-            f->bus_num = strtol(p, NULL, 10);
-            break;
-        case DEV:
-            f->addr    = strtol(p, NULL, 10);
-            break;
-        case VID:
-            f->vendor_id  = strtol(p, NULL, 16);
-            break;
-        case PID:
-            f->product_id = strtol(p, NULL, 16);
-            break;
-        }
-    }
-
-    if (i < DEV) {
-        fprintf(stderr, "husb: invalid auto filter spec %s\n", spec);
-        return -1;
-    }
-
-    return 0;
-}
-
-USBDevice *usb_host_device_open(USBBus *bus, const char *devname)
-{
-    struct USBAutoFilter filter;
-    USBDevice *dev;
-    char *p;
-
-    dev = usb_create(bus, "usb-host");
-
-    if (strstr(devname, "auto:")) {
-        if (parse_filter(devname, &filter) < 0) {
-            goto fail;
-        }
-    } else {
-        p = strchr(devname, '.');
-        if (p) {
-            filter.bus_num    = strtoul(devname, NULL, 0);
-            filter.addr       = strtoul(p + 1, NULL, 0);
-            filter.vendor_id  = 0;
-            filter.product_id = 0;
-        } else {
-            p = strchr(devname, ':');
-            if (p) {
-                filter.bus_num    = 0;
-                filter.addr       = 0;
-                filter.vendor_id  = strtoul(devname, NULL, 16);
-                filter.product_id = strtoul(p + 1, NULL, 16);
-            } else {
-                goto fail;
-            }
-        }
-    }
-
-    qdev_prop_set_uint32(&dev->qdev, "hostbus",   filter.bus_num);
-    qdev_prop_set_uint32(&dev->qdev, "hostaddr",  filter.addr);
-    qdev_prop_set_uint32(&dev->qdev, "vendorid",  filter.vendor_id);
-    qdev_prop_set_uint32(&dev->qdev, "productid", filter.product_id);
-    return dev;
-
-fail:
-    object_unparent(OBJECT(dev));
-    return NULL;
-}
-
-static void usb_host_register_types(void)
-{
-    usb_legacy_register("usb-host", "host", usb_host_device_open);
-}
-
-type_init(usb_host_register_types)
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 9dd9c6f..92318b2 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -531,12 +531,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,
                  USBBusOps *ops, DeviceState *host);
 void usb_bus_release(USBBus *bus);
 USBBus *usb_bus_find(int busnr);
-void usb_legacy_register(const char *typename, const char *usbdevice_name,
-                         USBDevice *(*usbdevice_init)(USBBus *bus,
-                                                      const char *params));
-USBDevice *usb_create(USBBus *bus, const char *name);
 USBDevice *usb_create_simple(USBBus *bus, const char *name);
-USBDevice *usbdevice_create(const char *cmdline);
 void usb_register_port(USBBus *bus, USBPort *port, void *opaque, int index,
                        USBPortOps *ops, int speedmask);
 void usb_register_companion(const char *masterbus, USBPort *ports[],
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 90bea73..e92fbc9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2700,14 +2700,6 @@ on the ``ide-hd'' device using the ``-device'' argument.
 The new syntax allows different settings to be provided
 per disk.
 
-@subsection -usbdevice (since 2.10.0)
-
-The ``-usbdevice DEV'' argument is now a synonym for setting
-the ``-device usb-DEV'' argument instead. The deprecated syntax
-would automatically enable USB support on the machine type.
-If using the new syntax, USB support must be explicitly
-enabled via the ``-machine usb=on'' argument.
-
 @subsection -nodefconfig (since 2.11.0)
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e2..b4c42b2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1214,51 +1214,8 @@ STEXI
 Enable the USB driver (if it is not used by default yet).
 ETEXI
 
-DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
-    "-usbdevice name add the host or guest USB device 'name'\n",
-    QEMU_ARCH_ALL)
-STEXI
-
-@item -usbdevice @var{devname}
-@findex -usbdevice
-Add the USB device @var{devname}. Note that this option is deprecated,
-please use @code{-device usb-...} instead. @xref{usb_devices}.
-
-@table @option
-
-@item mouse
-Virtual Mouse. This will override the PS/2 mouse emulation when activated.
-
-@item tablet
-Pointer device that uses absolute coordinates (like a touchscreen). This
-means QEMU is able to report the mouse position without having to grab the
-mouse. Also overrides the PS/2 mouse emulation when activated.
-
-@item disk:[format=@var{format}]:@var{file}
-Mass storage device based on file. The optional @var{format} argument
-will be used rather than detecting the format. Can be used to specify
-@code{format=raw} to avoid interpreting an untrusted format header.
-
-@item host:@var{bus}.@var{addr}
-Pass through the host device identified by @var{bus}.@var{addr} (Linux only).
-
-@item host:@var{vendor_id}:@var{product_id}
-Pass through the host device identified by @var{vendor_id}:@var{product_id}
-(Linux only).
-
-@item serial:[vendorid=@var{vendor_id}][,productid=@var{product_id}]:@var{dev}
-Serial converter to host character device @var{dev}, see @code{-serial} for the
-available devices.
-
-@item braille
-Braille device.  This will use BrlAPI to display the braille output on a real
-or fake device.
-
-@item net:@var{options}
-Network adapter that supports CDC ethernet and RNDIS protocols.
-
-@end table
-ETEXI
+HXCOMM Replaced by -device usb-...
+DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice, "", QEMU_ARCH_ALL)
 
 STEXI
 @end table
diff --git a/vl.c b/vl.c
index d3a5c5d..f372905 100644
--- a/vl.c
+++ b/vl.c
@@ -1446,49 +1446,6 @@ static void igd_gfx_passthru(void)
 }
 
 /***********************************************************/
-/* USB devices */
-
-static int usb_device_add(const char *devname)
-{
-    USBDevice *dev = NULL;
-#ifndef CONFIG_LINUX
-    const char *p;
-#endif
-
-    if (!machine_usb(current_machine)) {
-        return -1;
-    }
-
-    /* drivers with .usbdevice_name entry in USBDeviceInfo */
-    dev = usbdevice_create(devname);
-    if (dev)
-        goto done;
-
-    /* the other ones */
-#ifndef CONFIG_LINUX
-    /* only the linux version is qdev-ified, usb-bsd still needs this */
-    if (strstart(devname, "host:", &p)) {
-        dev = usb_host_device_open(usb_bus_find(-1), p);
-    }
-#endif
-    if (!dev)
-        return -1;
-
-done:
-    return 0;
-}
-
-static int usb_parse(const char *cmdline)
-{
-    int r;
-    r = usb_device_add(cmdline);
-    if (r < 0) {
-        error_report("could not add USB device '%s'", cmdline);
-    }
-    return r;
-}
-
-/***********************************************************/
 /* machine registration */
 
 MachineState *current_machine;
@@ -2480,7 +2437,6 @@ static void monitor_parse(const char *optarg, const char *mode, bool pretty)
 
 struct device_config {
     enum {
-        DEV_USB,       /* -usbdevice     */
         DEV_BT,        /* -bt            */
         DEV_SERIAL,    /* -serial        */
         DEV_PARALLEL,  /* -parallel      */
@@ -3846,12 +3802,9 @@ int main(int argc, char **argv, char **envp)
                 qemu_opts_parse_noisily(olist, "usb=on", false);
                 break;
             case QEMU_OPTION_usbdevice:
-                error_report("'-usbdevice' is deprecated, please use "
+                error_report("'-usbdevice' has been removed, please use "
                              "'-device usb-...' instead");
-                olist = qemu_find_opts("machine");
-                qemu_opts_parse_noisily(olist, "usb=on", false);
-                add_device_config(DEV_USB, optarg);
-                break;
+                exit(1);
             case QEMU_OPTION_device:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("device"),
                                              optarg, true)) {
@@ -4716,12 +4669,6 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    /* init USB devices */
-    if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
-    }
-
     /* Check if IGD GFX passthrough. */
     igd_gfx_passthru();
 
-- 
1.8.3.1
