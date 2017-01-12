Received: from eggs.gnu.org ([2001:4830:134:3::10]:46516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-00032u-8i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006bU-7V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:51 +1100
Message-Id: <20170112020327.24882-32-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 31/67] hw/ppc/spapr: Fix boot path of usb-host
 storage devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

When passing through an USB storage device to a pseries guest, it
is currently not possible to automatically boot from the device
if the "bootindex" property has been specified, too (e.g. when using
"-device nec-usb-xhci -device usb-host,hostbus=1,hostaddr=2,bootindex=0"
at the command line). The problem is that QEMU builds a device tree path
like "/pci@800000020000000/usb@0/usb-host@1" and passes it to SLOF
in the /chosen/qemu,boot-list property. SLOF, however, probes the
USB device, recognizes that it is a storage device and thus changes
its name to "storage", and additionally adds a child node for the
SCSI LUN, so the correct boot path in SLOF is something like
"/pci@800000020000000/usb@0/storage@1/disk@101000000000000" instead.
So when we detect an USB mass storage device with SCSI interface,
we've got to adjust the firmware boot-device path properly that
SLOF can automatically boot from the device.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1354177
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 13 +++++++++++++
 hw/usb/host-libusb.c | 29 +++++++++++++++++++++++++++++
 hw/usb/host-stub.c   |  5 +++++
 include/hw/usb.h     |  1 +
 4 files changed, 48 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cfadc46..31210b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2198,6 +2198,19 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
         }
     }
 
+    /*
+     * SLOF probes the USB devices, and if it recognizes that the device is a
+     * storage device, it changes its name to "storage" instead of "usb-host",
+     * and additionally adds a child node for the SCSI LUN, so the correct
+     * boot path in SLOF is something like .../storage@1/disk@xxx" instead.
+     */
+    if (strcmp("usb-host", qdev_fw_name(dev)) == 0) {
+        USBDevice *usbdev = CAST(USBDevice, dev, TYPE_USB_DEVICE);
+        if (usb_host_dev_is_scsi_storage(usbdev)) {
+            return g_strdup_printf("storage@%s/disk", usbdev->port->path);
+        }
+    }
+
     if (phb) {
         /* Replace "pci" with "pci@800000020000000" */
         return g_strdup_printf("pci@%"PRIX64, phb->buid);
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index bd81d71..7791c6d 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1707,6 +1707,35 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
+/**
+ * Check whether USB host device has a USB mass storage SCSI interface
+ */
+bool usb_host_dev_is_scsi_storage(USBDevice *ud)
+{
+    USBHostDevice *uhd = USB_HOST_DEVICE(ud);
+    struct libusb_config_descriptor *conf;
+    const struct libusb_interface_descriptor *intf;
+    bool is_scsi_storage = false;
+    int i;
+
+    if (!uhd || libusb_get_active_config_descriptor(uhd->dev, &conf) != 0) {
+        return false;
+    }
+
+    for (i = 0; i < conf->bNumInterfaces; i++) {
+        intf = &conf->interface[i].altsetting[ud->altsetting[i]];
+        if (intf->bInterfaceClass == LIBUSB_CLASS_MASS_STORAGE &&
+            intf->bInterfaceSubClass == 6) {                 /* 6 means SCSI */
+            is_scsi_storage = true;
+            break;
+        }
+    }
+
+    libusb_free_config_descriptor(conf);
+
+    return is_scsi_storage;
+}
+
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
 {
     libusb_device **devs = NULL;
diff --git a/hw/usb/host-stub.c b/hw/usb/host-stub.c
index 6ba65a1..d0268ba 100644
--- a/hw/usb/host-stub.c
+++ b/hw/usb/host-stub.c
@@ -46,3 +46,8 @@ USBDevice *usb_host_device_open(USBBus *bus, const char *devname)
 {
     return NULL;
 }
+
+bool usb_host_dev_is_scsi_storage(USBDevice *ud)
+{
+    return false;
+}
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 847c9de..43838c9 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -471,6 +471,7 @@ void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 /* usb-linux.c */
 USBDevice *usb_host_device_open(USBBus *bus, const char *devname);
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
+bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
 
 /* usb ports of the VM */
 
-- 
2.9.3
