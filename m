Received: from eggs.gnu.org ([2001:4830:134:3::10]:43290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fE7kR-0005it-Jy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fE7kN-0006iD-MR
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:29:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fE7kN-0006hV-Hr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:29:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE5E7406C78A
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 06:29:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  3 May 2018 08:29:32 +0200
Message-Id: <20180503062932.17233-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb-host: skip open on pending postload bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

usb-host emulates a device unplug after live migration, because the
device state is unknown and unplug/replug makes sure the guest
re-initializes the device into a working state.  This can't be done in
post-load though, so post-load just schedules a bottom half which
executes after vmload is complete.

It can happen that the device autoscan timer hits the race window
between scheduling and running the bottom half, which in turn can
triggers an assert().

Fix that issue by just ignoring the usb_host_open() call in case the
bottom half didn't execute yet.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1572851
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 1b0be071cc..0290fb8bbc 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -102,6 +102,7 @@ struct USBHostDevice {
     /* callbacks & friends */
     QEMUBH                           *bh_nodev;
     QEMUBH                           *bh_postld;
+    bool                             bh_postld_pending;
     Notifier                         exit;
 
     /* request queues */
@@ -866,6 +867,10 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev)
     int rc;
     Error *local_err = NULL;
 
+    if (s->bh_postld_pending) {
+        return -1;
+    }
+
     trace_usb_host_open_started(bus_num, addr);
 
     if (s->dh != NULL) {
@@ -1524,6 +1529,7 @@ static void usb_host_post_load_bh(void *opaque)
     if (udev->attached) {
         usb_device_detach(udev);
     }
+    dev->bh_postld_pending = false;
     usb_host_auto_check(NULL);
 }
 
@@ -1535,6 +1541,7 @@ static int usb_host_post_load(void *opaque, int version_id)
         dev->bh_postld = qemu_bh_new(usb_host_post_load_bh, dev);
     }
     qemu_bh_schedule(dev->bh_postld);
+    dev->bh_postld_pending = true;
     return 0;
 }
 
-- 
2.9.3
