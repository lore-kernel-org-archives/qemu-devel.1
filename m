Received: from eggs.gnu.org ([2001:4830:134:3::10]:40196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6Zgn-00072r-6b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6Zgk-0002q4-1x
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d6Zgj-0002oe-P1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8086964C7
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 09:38:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 May 2017 11:38:07 +0200
Message-Id: <1493977087-26668-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

The preferred way of adding USB devices is via "-device" and
"device_add" nowadays, so let's start to get rid of "-usbdevice"
and "usb_add" in the documentation. While we're at it, also
add the new USB devices there which have been added to QEMU
during the last years.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Addressed review feedback from Markus
 - Added the new USB devices that are only available via "-device"
 - Update qdev-device-use.txt about "vendorid" and "productid"

 docs/qdev-device-use.txt |  5 +--
 qemu-doc.texi            | 92 +++++++++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index b059405..2c1331b 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -182,8 +182,9 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
 
   This lets you control I/O ports and IRQs.
 
-* -usbdevice serial:vendorid=VID,productid=PRID becomes
-  -device usb-serial,vendorid=VID,productid=PRID
+* -usbdevice serial:[vendorid=VID,productid=PRID]:chardev becomes
+  -device usb-serial,chardev=dev.  The possibility to set a vendor
+  and product ID has been removed since QEMU version 0.14.0.
 
 * -usbdevice braille doesn't support LEGACY-CHARDEV syntax.  It always
   uses "braille".  With -device, this useful default is gone, so you
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 794ab4a..b446ac4 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -182,7 +182,7 @@ Gravis Ultrasound GF1 sound card
 @item
 CS4231A compatible sound card
 @item
-PCI UHCI USB controller and a virtual USB hub.
+PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub.
 @end itemize
 
 SMP is supported with up to 255 CPUs.
@@ -1357,10 +1357,10 @@ monitor (@pxref{pcsys_keys}).
 @node pcsys_usb
 @section USB emulation
 
-QEMU emulates a PCI UHCI USB controller. You can virtually plug
-virtual USB devices or real host USB devices (experimental, works only
-on Linux hosts).  QEMU will automatically create and connect virtual USB hubs
-as necessary to connect multiple USB devices.
+QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can
+plug virtual USB devices or real host USB devices (only works with certain
+host operating systems). QEMU will automatically create and connect virtual
+USB hubs as necessary to connect multiple USB devices.
 
 @menu
 * usb_devices::
@@ -1369,53 +1369,65 @@ as necessary to connect multiple USB devices.
 @node usb_devices
 @subsection Connecting USB devices
 
-USB devices can be connected with the @option{-usbdevice} commandline option
-or the @code{usb_add} monitor command.  Available devices are:
+USB devices can be connected with the @option{-device usb-...} command line
+option or the @code{device_add} monitor command. Available devices are:
 
 @table @code
-@item mouse
+@item usb-mouse
 Virtual Mouse.  This will override the PS/2 mouse emulation when activated.
-@item tablet
+@item usb-tablet
 Pointer device that uses absolute coordinates (like a touchscreen).
 This means QEMU is able to report the mouse position without having
 to grab the mouse.  Also overrides the PS/2 mouse emulation when activated.
-@item disk:@var{file}
-Mass storage device based on @var{file} (@pxref{disk_images})
-@item host:@var{bus.addr}
-Pass through the host device identified by @var{bus.addr}
-(Linux only)
-@item host:@var{vendor_id:product_id}
-Pass through the host device identified by @var{vendor_id:product_id}
-(Linux only)
-@item wacom-tablet
+@item usb-storage,drive=@var{drive_id}
+Mass storage device (@pxref{disk_images})
+@item usb-uas
+USB attached SCSI device, see
+@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
+for details
+@item usb-bot
+Bulk-only transport storage device, see
+@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
+for details here, too
+@item usb-mtp,x-root=@var{dir}
+Media transfer protocol device
+@item usb-host,hostbus=@var{bus},hostaddr=@var{addr}
+Pass through the host device identified by @var{bus} and @var{addr}
+(this only works on Linux or other OS with support for libusb)
+@item usb-host,vendorid=@var{vendor},productid=@var{product}
+Pass through the host device identified by @var{vendor} and @var{product} ID
+(this only works on Linux or other OS with support for libusb)
+@item usb-wacom-tablet
 Virtual Wacom PenPartner tablet.  This device is similar to the @code{tablet}
 above but it can be used with the tslib library because in addition to touch
 coordinates it reports touch pressure.
-@item keyboard
+@item usb-kbd
 Standard USB keyboard.  Will override the PS/2 keyboard (if present).
-@item serial:[vendorid=@var{vendor_id}][,product_id=@var{product_id}]:@var{dev}
+@item usb-serial,chardev=@var{dev}
 Serial converter. This emulates an FTDI FT232BM chip connected to host character
-device @var{dev}. The available character devices are the same as for the
-@code{-serial} option. The @code{vendorid} and @code{productid} options can be
-used to override the default 0403:6001. For instance,
-@example
-usb_add serial:productid=FA00:tcp:192.168.0.2:4444
-@end example
-will connect to tcp port 4444 of ip 192.168.0.2, and plug that to the virtual
-serial converter, faking a Matrix Orbital LCD Display (USB ID 0403:FA00).
-@item braille
+device @var{dev}.
+@item usb-braille
 Braille device.  This will use BrlAPI to display the braille output on a real
 or fake device.
-@item net:@var{options}
-Network adapter that supports CDC ethernet and RNDIS protocols.  @var{options}
-specifies NIC options as with @code{-net nic,}@var{options} (see description).
+@item usb-net[,netdev=@var{id}]
+Network adapter that supports CDC ethernet and RNDIS protocols.  @var{id}
+specifies a netdev defined with @code{-netdev xxx,id=}@var{id}.
 For instance, user-mode networking can be used with
 @example
-qemu-system-i386 [...OPTIONS...] -net user,vlan=0 -usbdevice net:vlan=0
-@end example
-Currently this cannot be used in machines that support PCI NICs.
-@item bt[:@var{hci-type}]
-Bluetooth dongle whose type is specified in the same format as with
+qemu-system-i386 [...] -netdev user,id=net0 -device usb-net,netdev=net0
+@end example
+@item usb-ccid
+Smartcard reader device
+@item usb-audio
+USB audio device
+@item usb-bt-dongle
+Bluetooth dongle for the transport layer of HCI. It is connected to HCI
+scatternet 0 by default (corresponds to @code{-bt hci,vlan=0}).
+Note that the syntax for the @code{-device usb-bt-dongle} option is not as
+useful yet as it was with the legacy @code{-usbdevice} option. So to
+configure an USB bluetooth device, you might need to use
+"@code{-usbdevice bt}[:@var{hci-type}]" instead. This configures a
+bluetooth dongle whose type is specified in the same format as with
 the @option{-bt hci} option, @pxref{bt-hcis,,allowed HCI types}.  If
 no type is given, the HCI logic corresponds to @code{-bt hci,vlan=0}.
 This USB device implements the USB Transport Layer of HCI.  Example
@@ -1460,11 +1472,11 @@ hubs, it won't work).
 
 @item Add the device in QEMU by using:
 @example
-usb_add host:1234:5678
+device_add usb-host,vendorid=0x1234,productid=0x5678
 @end example
 
-Normally the guest OS should report that a new USB device is
-plugged. You can use the option @option{-usbdevice} to do the same.
+Normally the guest OS should report that a new USB device is plugged.
+You can use the option @option{-device usb-host,...} to do the same.
 
 @item Now you can try to use the host USB device in QEMU.
 
-- 
1.8.3.1
