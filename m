Received: from eggs.gnu.org ([2001:4830:134:3::10]:46918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn2-0002pn-QZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn1-0007x1-1y
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:23 +0200
Message-Id: <20180612104430.25745-2-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] usb: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>

xhci is rock solid meanwhile.  So move it up in the docs and feature it
as prefered usb host adapter, instead of the old shy version saying "you
might want try ...".

While being at it rework the text on ehci and companion controllers too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20180605132915.3640-1-kraxel@redhat.com
---
 docs/usb2.txt | 99 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index 09df45b5b1..e2fa2cfde0 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -1,16 +1,42 @@
 
-USB 2.0 Quick Start
-===================
+USB Quick Start
+===============
 
-The QEMU EHCI Adapter can be used with and without companion
-controllers.  See below for the companion controller mode.
+XHCI controller support
+-----------------------
 
-When not running in companion controller mode there are two completely
-separate USB busses: One USB 1.1 bus driven by the UHCI controller and
-one USB 2.0 bus driven by the EHCI controller.  Devices must be
-attached to the correct controller manually.
+QEMU has XHCI host adapter support.  The XHCI hardware design is much
+more virtualization-friendly when compared to EHCI and UHCI, thus XHCI
+emulation uses less resources (especially cpu).  So if your guest
+supports XHCI (which should be the case for any operating system
+released around 2010 or later) we recommend using it:
 
-The '-usb' switch will make qemu create the UHCI controller as part of
+    qemu -device qemu-xhci
+
+XHCI supports USB 1.1, USB 2.0 and USB 3.0 devices, so this is the
+only controller you need.  With only a single USB controller (and
+therefore only a single USB bus) present in the system there is no
+need to use the bus= parameter when adding USB devices.
+
+
+EHCI controller support
+-----------------------
+
+The QEMU EHCI Adapter supports USB 2.0 devices.  It can be used either
+standalone or with companion controllers (UHCI, OHCI) for USB 1.1
+devices.  The companion controller setup is more convenient to use
+because it provides a single USB bus supporting both USB 2.0 and USB
+1.1 devices.  See next section for details.
+
+When running EHCI in standalone mode you can add UHCI or OHCI
+controllers for USB 1.1 devices too.  Each controller creates its own
+bus though, so there are two completely separate USB buses: One USB
+1.1 bus driven by the UHCI controller and one USB 2.0 bus driven by
+the EHCI controller.  Devices must be attached to the correct
+controller manually.
+
+The easiest way to add a UHCI controller to a 'pc' machine is the
+'-usb' switch.  QEMU will create the UHCI controller as function of
 the PIIX3 chipset.  The USB 1.1 bus will carry the name "usb-bus.0".
 
 You can use the standard -device switch to add a EHCI controller to
@@ -19,9 +45,8 @@ the controller so the USB 2.0 bus gets a individual name, for example
 '-device usb-ehci,id=ehci".  This will give you a USB 2.0 bus named
 "ehci.0".
 
-I strongly recommend to also use -device to attach usb devices because
-you can specify the bus they should be attached to this way.  Here is
-a complete example:
+When adding USB devices using the -device switch you can specify the
+bus they should be attached to.  Here is a complete example:
 
     qemu -M pc ${otheroptions}                           \
         -drive if=none,id=usbstick,file=/path/to/image   \
@@ -30,58 +55,44 @@ a complete example:
         -device usb-tablet,bus=usb-bus.0                 \
         -device usb-storage,bus=ehci.0,drive=usbstick
 
-This attaches a usb tablet to the UHCI adapter and a usb mass storage
+This attaches a USB tablet to the UHCI adapter and a USB mass storage
 device to the EHCI adapter.
 
 
 Companion controller support
 ----------------------------
 
-Companion controller support has been added recently.  The operational
-model described above with two completely separate busses still works
-fine.  Additionally the UHCI and OHCI controllers got the ability to
-attach to a usb bus created by EHCI as companion controllers.  This is
-done by specifying the masterbus and firstport properties.  masterbus
-specifies the bus name the controller should attach to.  firstport
-specifies the first port the controller should attach to, which is
-needed as usually one ehci controller with six ports has three uhci
-companion controllers with two ports each.
+The UHCI and OHCI controllers can attach to a USB bus created by EHCI
+as companion controllers.  This is done by specifying the masterbus
+and firstport properties.  masterbus specifies the bus name the
+controller should attach to.  firstport specifies the first port the
+controller should attach to, which is needed as usually one EHCI
+controller with six ports has three UHCI companion controllers with
+two ports each.
 
-There is a config file in docs which will do all this for you, just
-try ...
+There is a config file in docs which will do all this for
+you, just try ...
 
     qemu -readconfig docs/config/ich9-ehci-uhci.cfg
 
-... then use "bus=ehci.0" to assign your usb devices to that bus.
+... then use "bus=ehci.0" to assign your USB devices to that bus.
 
-
-xhci controller support
------------------------
-
-There is also xhci host controller support available.  It got a lot
-less testing than ehci and there are a bunch of known limitations, so
-ehci may work better for you.  On the other hand the xhci hardware
-design is much more virtualization-friendly, thus xhci emulation uses
-less resources (especially cpu).  If you want to give xhci a try
-use this to add the host controller ...
-
-    qemu -device nec-usb-xhci,id=xhci
-
-... then use "bus=xhci.0" when assigning usb devices.
+Using the '-usb' switch for 'q35' machines will create a similar
+USB controller configuration.
 
 
 More USB tips & tricks
 ======================
 
-Recently the usb pass through driver (also known as usb-host) and the
-qemu usb subsystem gained a few capabilities which are available only
+Recently the USB pass through driver (also known as usb-host) and the
+QEMU USB subsystem gained a few capabilities which are available only
 via qdev properties, i,e. when using '-device'.
 
 
 physical port addressing
 ------------------------
 
-First you can (for all usb devices) specify the physical port where
+First you can (for all USB devices) specify the physical port where
 the device will show up in the guest.  This can be done using the
 "port" property.  UHCI has two root ports (1,2).  EHCI has four root
 ports (1-4), the emulated (1.1) USB hub has eight ports.
@@ -94,7 +105,7 @@ Plugging a hub into UHCI port 2 works like this:
 
         -device usb-hub,bus=usb-bus.0,port=2
 
-Plugging a virtual usb stick into port 4 of the hub just plugged works
+Plugging a virtual USB stick into port 4 of the hub just plugged works
 this way:
 
         -device usb-storage,bus=usb-bus.0,port=2.4,drive=...
@@ -143,7 +154,7 @@ practice only a few combinations are useful:
 
 Note that USB 1.1 devices are handled by UHCI/OHCI and USB 2.0 by
 EHCI.  That means a device plugged into the very same physical port
-may show up on different busses depending on the speed.  The port I'm
+may show up on different buses depending on the speed.  The port I'm
 using for testing is bus 1 + port 1 for 2.0 devices and bus 3 + port 1
 for 1.1 devices.  Passing through any device plugged into that port
 and also assign them to the correct bus can be done this way:
-- 
2.9.3
