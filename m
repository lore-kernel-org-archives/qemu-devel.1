Received: from eggs.gnu.org ([2001:4830:134:3::10]:35619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Sq7-0002zN-OP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Sq0-0007sS-8P
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5Sq0-0007sC-2K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:07:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B8362C8300
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 08:07:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 May 2017 10:07:00 +0200
Message-Id: <1493712420-22480-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] Print a warning message if the user
 specified a legacy USB option
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

'-usb' and '-usbdevice' are considered as deprecated nowadays and
we might want to remove these options in a future version of QEMU.
So mark this options as deprecated in the documenation and print out
a warning if they are used to tell the user what to use instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Also update the documentation accordingly

 qemu-options.hx | 8 +++++---
 vl.c            | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f68829f..57bacc5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -946,12 +946,13 @@ STEXI
 ETEXI
 
 DEF("usb", 0, QEMU_OPTION_usb,
-    "-usb            enable the USB driver (will be the default soon)\n",
+    "-usb            enable the USB driver (if it is not used by default yet)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -usb
 @findex -usb
-Enable the USB driver (will be the default soon)
+Enable the USB driver (if it is not used by default yet). Note that this
+option is deprecated, please use @code{-M usb=on} instead.
 ETEXI
 
 DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
@@ -961,7 +962,8 @@ STEXI
 
 @item -usbdevice @var{devname}
 @findex -usbdevice
-Add the USB device @var{devname}. @xref{usb_devices}.
+Add the USB device @var{devname}. Note that this option is deperecated,
+please use @code{-device usb-...} instead. See also @xref{usb_devices}.
 
 @table @option
 
diff --git a/vl.c b/vl.c
index 42d4bce..0023298 100644
--- a/vl.c
+++ b/vl.c
@@ -3748,10 +3748,14 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_usb:
+                error_report("'-usb' is deprecated, please use "
+                             "'-M usb=on' instead");
                 olist = qemu_find_opts("machine");
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
