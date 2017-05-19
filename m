Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBbVY-0004k0-5a
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBbVT-0001oq-86
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:35:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBbVT-0001oc-2S
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:35:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CACAB37EEB
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:35:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 May 2017 08:35:16 +0200
Message-Id: <1495175716-12735-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: Deprecate the legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

The '-usbdevice' option is considered as deprecated nowadays and
we might want to remove these options in a future version of QEMU.
So mark this options as deprecated in the documenation and print out
a warning if it is used to tell the user what to use instead.
While we're at it, improve also some other minor USB-related spots
in qemu-options.hx that were not up to date anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 9 +++++----
 vl.c            | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fd31428..f688123 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -983,12 +983,12 @@ STEXI
 ETEXI
 
 DEF("usb", 0, QEMU_OPTION_usb,
-    "-usb            enable the USB driver (will be the default soon)\n",
+    "-usb            enable the USB driver (if it is not used by default yet)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -usb
 @findex -usb
-Enable the USB driver (will be the default soon)
+Enable the USB driver (if it is not used by default yet).
 ETEXI
 
 DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
@@ -998,7 +998,8 @@ STEXI
 
 @item -usbdevice @var{devname}
 @findex -usbdevice
-Add the USB device @var{devname}. @xref{usb_devices}.
+Add the USB device @var{devname}. Note that this option is deprecated,
+please use @code{-device usb-...} instead. @xref{usb_devices}.
 
 @table @option
 
@@ -1376,7 +1377,7 @@ output such as guest graphics, guest console, and the QEMU monitor in a
 window. With this option, you can have QEMU listen on VNC display
 @var{display} and redirect the VGA display over the VNC session. It is
 very useful to enable the usb tablet device when using this option
-(option @option{-usbdevice tablet}). When using the VNC display, you
+(option @option{-device usb-tablet}). When using the VNC display, you
 must use the @option{-k} parameter to set the keyboard layout if you are
 not using en-us. Valid syntax for the @var{display} is
 
diff --git a/vl.c b/vl.c
index abecaf8..3ca6bd3 100644
--- a/vl.c
+++ b/vl.c
@@ -3748,6 +3748,8 @@ int main(int argc, char **argv, char **envp)
                 qemu_opts_parse_noisily(olist, "usb=on", false);
                 break;
             case QEMU_OPTION_usbdevice:
+                error_report("'-usbdevice' is deprecated, please use "
+                             "'-device usb-...' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
                 add_device_config(DEV_USB, optarg);
-- 
1.8.3.1
