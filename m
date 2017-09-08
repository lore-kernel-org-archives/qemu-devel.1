Received: from eggs.gnu.org ([2001:4830:134:3::10]:42833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqE0x-0003Du-5v
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqE0s-000121-OA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqE0s-0000zP-Iu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:47:42 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Sep 2017 09:47:32 +0200
Message-Id: <1504856852-12425-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/usb: Disable 'usb-host' device when no USB
 is available in the target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

The 'usb-host' device currently also shows up in the "-device help"
list of all targets that do not support USB. That's ugly and kind of
confusing for the users. We should only provide this device if both,
the host and the target support USB.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/Makefile.objs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 97f1c456..323d448 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,7 +38,9 @@ endif
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 
 # usb pass-through
-common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
+common-obj-$(CONFIG_USB) += $(patsubst %,host-%.o,$(HOST_USB))
+common-obj-$(call lnot,$(CONFIG_USB)) += host-stub.o
+common-obj-$(CONFIG_ALL) += host-stub.o
 
 ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-$(CONFIG_XEN) += xen-usb.o
-- 
1.8.3.1
