Received: from eggs.gnu.org ([2001:4830:134:3::10]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekd6-0006c9-Dp
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekd3-0000wn-BH
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eekd3-0000wP-2w
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:43:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 17:43:49 +0100
Message-Id: <20180125164351.17154-2-kraxel@redhat.com>
In-Reply-To: <20180125164351.17154-1-kraxel@redhat.com>
References: <20180125164351.17154-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] usb: Remove legacy -usbdevice options (host, serial,
 disk and net)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The option have been marked as deprecated since QEMU 2.10, and so far
nobody complained that the host, serial, disk and net options are urgently
required anymore. So let's now get rid at least of this legacy pile, to
simplify the usb code quite a bit.

This patch removes the usbdevices host, serial, disk and net. These devices
use their own complicated parameter parsing mechanisms, so they are just
ugly to maintain, without real benefit for the users (the users can use the
corresponding "-device" parameters instead which have the same complexity
as the "-usbdevice" devices here).

Note that the other rather simple -usbdevice options (mouse, tablet, etc.)
are not removed yet (the code is really simple here, so it does not hurt
much to keep it), as well as the two devices "braille" and "bt" which are
easier to use with -usbdevice than with -device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1515519171-20315-1-git-send-email-thuth@redhat.com

[kraxel] delete some usb_host_device_open() leftovers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/usb.h     |   1 -
 hw/usb/dev-network.c |  26 ----------
 hw/usb/dev-serial.c  |  30 -----------
 hw/usb/dev-storage.c |  58 ---------------------
 hw/usb/host-legacy.c | 144 ---------------------------------------------------
 hw/usb/host-stub.c   |   6 ---
 vl.c                 |  15 ------
 hw/usb/Makefile.objs |   2 +-
 qemu-options.hx      |  19 -------
 9 files changed, 1 insertion(+), 300 deletions(-)
 delete mode 100644 hw/usb/host-legacy.c

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 9dd9c6f0d9..a5080adecc 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -466,7 +466,6 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream);
 void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 
 /* usb-linux.c */
-USBDevice *usb_host_device_open(USBBus *bus, const char *devname);
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
 bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
 
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 85fc81bf43..aea7edcf31 100644
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
index 94b5c34afe..2829dda391 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -509,35 +509,6 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
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
 static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
 {
     USBDevice *dev;
@@ -624,7 +595,6 @@ static void usb_serial_register_types(void)
 {
     type_register_static(&usb_serial_dev_type_info);
     type_register_static(&serial_info);
-    usb_legacy_register("usb-serial", "serial", usb_serial_init);
     type_register_static(&braille_info);
     usb_legacy_register("usb-braille", "braille", usb_braille_init);
 }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 9722ac854c..e44a5c72cf 100644
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
diff --git a/hw/usb/host-legacy.c b/hw/usb/host-legacy.c
deleted file mode 100644
index 3b57e21b52..0000000000
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
diff --git a/hw/usb/host-stub.c b/hw/usb/host-stub.c
index d0268baaa0..41d93ec8a0 100644
--- a/hw/usb/host-stub.c
+++ b/hw/usb/host-stub.c
@@ -41,12 +41,6 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "USB host devices not supported\n");
 }
 
-/* XXX: modify configure to compile the right host driver */
-USBDevice *usb_host_device_open(USBBus *bus, const char *devname)
-{
-    return NULL;
-}
-
 bool usb_host_dev_is_scsi_storage(USBDevice *ud)
 {
     return false;
diff --git a/vl.c b/vl.c
index e725ecbc08..2323111321 100644
--- a/vl.c
+++ b/vl.c
@@ -1451,30 +1451,15 @@ static void igd_gfx_passthru(void)
 static int usb_device_add(const char *devname)
 {
     USBDevice *dev = NULL;
-#ifndef CONFIG_LINUX
-    const char *p;
-#endif
 
     if (!machine_usb(current_machine)) {
         return -1;
     }
 
-    /* drivers with .usbdevice_name entry in USBDeviceInfo */
     dev = usbdevice_create(devname);
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
     if (!dev)
         return -1;
 
-done:
     return 0;
 }
 
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index bdfead6701..fbcd498c59 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 5ff741a4af..1d73fb151d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1221,29 +1221,10 @@ Pointer device that uses absolute coordinates (like a touchscreen). This
 means QEMU is able to report the mouse position without having to grab the
 mouse. Also overrides the PS/2 mouse emulation when activated.
 
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
 @item braille
 Braille device.  This will use BrlAPI to display the braille output on a real
 or fake device.
 
-@item net:@var{options}
-Network adapter that supports CDC ethernet and RNDIS protocols.
-
 @end table
 ETEXI
 
-- 
2.9.3
