Received: from eggs.gnu.org ([209.51.188.92]:37129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1go7T2-0002J3-Pb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1go7T1-0007E7-BT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1go7T0-0007DE-Bg
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:00:50 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 28 Jan 2019 15:00:27 +0100
Message-Id: <20190128140027.9448-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] Introduce new "no_guest_reset" parameter for
 usb-host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agk@godking.net, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Kappner <agk@godking.net>

With certain USB devices passed through via usb-host, a guest attempting to
reset a usb-host device can trigger a reset loop that renders the USB device
unusable. In my use case, the device was an iPhone XR that was passed through to
a Mac OS X Mojave guest. Upon connecting the device, the following happens:

1) Guest recognizes new device, sends reset to emulated USB host
2) QEMU's USB host sends reset to host kernel
3) Host kernel resets device
4) After reset, host kernel determines that some part of the device descriptor
has changed ("device firmware changed" in dmesg), so host kernel decides to
re-enumerate the device.
5) Re-enumeration causes QEMU to disconnect and reconnect the device in the
guest.
6) goto 1)

Here's from the host kernel (note the "device firmware changed" lines")

[3677704.473050] usb 1-1.3: new high-speed USB device number 53 using ehci-pci
[3677704.555594] usb 1-1.3: New USB device found, idVendor=05ac, idProduct=12a8, bcdDevice=11.08
[3677704.555599] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[3677704.555602] usb 1-1.3: Product: iPhone
[3677704.555605] usb 1-1.3: Manufacturer: Apple Inc.
[3677704.555607] usb 1-1.3: SerialNumber: [[removed]]
[3677709.401040] usb 1-1.3: reset high-speed USB device number 53 using ehci-pci
[3677709.479486] usb 1-1.3: device firmware changed
[3677709.479842] usb 1-1.3: USB disconnect, device number 53
[3677709.546039] usb 1-1.3: new high-speed USB device number 54 using ehci-pci
[3677709.627471] usb 1-1.3: New USB device found, idVendor=05ac, idProduct=12a8, bcdDevice=11.08
[3677709.627476] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[3677709.627479] usb 1-1.3: Product: iPhone
[3677709.627481] usb 1-1.3: Manufacturer: Apple Inc.
[3677709.627483] usb 1-1.3: SerialNumber: [[removed]]
[3677762.320044] usb 1-1.3: reset high-speed USB device number 54 using ehci-pci
[3677762.615630] usb 1-1.3: USB disconnect, device number 54
[3677762.787043] usb 1-1.3: new high-speed USB device number 55 using ehci-pci
[3677762.869016] usb 1-1.3: New USB device found, idVendor=05ac, idProduct=12a8, bcdDevice=11.08
[3677762.869024] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[3677762.869028] usb 1-1.3: Product: iPhone
[3677762.869032] usb 1-1.3: Manufacturer: Apple Inc.
[3677762.869035] usb 1-1.3: SerialNumber: [[removed]]
[3677815.662036] usb 1-1.3: reset high-speed USB device number 55 using ehci-pci

Here's from QEMU:

libusb: error [_get_usbfs_fd] libusb couldn't open USB device /dev/bus/usb/005/022: No such file or directory
libusb: error [udev_hotplug_event] ignoring udev action bind
libusb: error [udev_hotplug_event] ignoring udev action bind
libusb: error [_open_sysfs_attr] open /sys/bus/usb/devices/5-1/bConfigurationValue failed ret=-1 errno=2
libusb: error [_get_usbfs_fd] File doesn't exist, wait 10 ms and try again

libusb: error [_get_usbfs_fd] libusb couldn't open USB device /dev/bus/usb/005/024: No such file or directory
libusb: error [udev_hotplug_event] ignoring udev action bind
libusb: error [udev_hotplug_event] ignoring udev action bind
libusb: error [_open_sysfs_attr] open /sys/bus/usb/devices/5-1/bConfigurationValue failed ret=-1 errno=2
libusb: error [_get_usbfs_fd] File doesn't exist, wait 10 ms and try again

libusb: error [_get_usbfs_fd] libusb couldn't open USB device /dev/bus/usb/005/026: No such file or directory

The result of this is that the device remains permanently unusable in the guest.
The same problem has been previously reported for an iPad:
https://stackoverflow.com/questions/52617634/how-do-i-get-qemu-usb-passthrough-to-work-for-ipad-iphone

This problem can be elegantly solved by interrupting step 2) above. Instead of
passing through the reset, QEMU simply ignores it. To allow this to be
configured on a per-device level,  a new parameter "no_guest_reset" is
introduced for the usb-host device. I can confirm that the configuration
described above (iPhone XS + Mojave guest) works flawlessly with
no_guest_reset=True specified.

Working command line for my scenario:
device_add usb-host,vendorid=0x05ac,productid=0x12a8,no_guest_reset=True,id=iphone

Best regards
Alexander

Signed-off-by: Alexander Kappner <agk@godking.net>

[ kraxel: rename parameter to "guest-reset" ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 833250a886..67b7465915 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -82,7 +82,7 @@ struct USBHostDevice {
     uint32_t                         options;
     uint32_t                         loglevel;
     bool                             needs_autoscan;
-
+    bool                             allow_guest_reset;
     /* state */
     QTAILQ_ENTRY(USBHostDevice)      next;
     int                              seen, errcount;
@@ -1456,6 +1456,10 @@ static void usb_host_handle_reset(USBDevice *udev)
     USBHostDevice *s = USB_HOST_DEVICE(udev);
     int rc;
 
+    if (!s->allow_guest_reset) {
+        return;
+    }
+
     trace_usb_host_reset(s->bus_num, s->addr);
 
     rc = libusb_reset_device(s->dh);
@@ -1573,6 +1577,7 @@ static Property usb_host_dev_properties[] = {
     DEFINE_PROP_UINT32("productid", USBHostDevice, match.product_id, 0),
     DEFINE_PROP_UINT32("isobufs",  USBHostDevice, iso_urb_count,    4),
     DEFINE_PROP_UINT32("isobsize", USBHostDevice, iso_urb_frames,   32),
+    DEFINE_PROP_BOOL("guest-reset", USBHostDevice, allow_guest_reset, true),
     DEFINE_PROP_UINT32("loglevel",  USBHostDevice, loglevel,
                        LIBUSB_LOG_LEVEL_WARNING),
     DEFINE_PROP_BIT("pipeline",    USBHostDevice, options,
-- 
2.9.3
