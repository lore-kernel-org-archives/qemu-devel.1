Received: from eggs.gnu.org ([2001:4830:134:3::10]:35699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBgeA-0006sA-LD
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBge6-0007Gp-Jo
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBge6-0007Gd-EJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 649293B73F
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 12:04:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 14:04:28 +0200
Message-Id: <20170519120428.25981-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ehci: fix frame timer invocation.
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

ehci registers ehci_frame_timer as both timer and bottom half, which
turned out to be a bad idea as it can be called as bottom half then
while it is running as timer, and it isn't prepared to handle recursive
calls.

Change the timer func to just schedule the bottom half to avoid this.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1449609
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 50ef817f93..3703a8dddc 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2232,7 +2232,7 @@ static void ehci_update_frindex(EHCIState *ehci, int uframes)
     ehci->frindex = (ehci->frindex + uframes) % 0x4000;
 }
 
-static void ehci_frame_timer(void *opaque)
+static void ehci_work_bh(void *opaque)
 {
     EHCIState *ehci = opaque;
     int need_timer = 0;
@@ -2324,6 +2324,13 @@ static void ehci_frame_timer(void *opaque)
     }
 }
 
+static void ehci_work_timer(void *opaque)
+{
+    EHCIState *ehci = opaque;
+
+    qemu_bh_schedule(ehci->async_bh);
+}
+
 static const MemoryRegionOps ehci_mmio_caps_ops = {
     .read = ehci_caps_read,
     .write = ehci_caps_write,
@@ -2478,8 +2485,8 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
         s->ports[i].dev = 0;
     }
 
-    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ehci_frame_timer, s);
-    s->async_bh = qemu_bh_new(ehci_frame_timer, s);
+    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ehci_work_timer, s);
+    s->async_bh = qemu_bh_new(ehci_work_bh, s);
     s->device = dev;
 
     s->vmstate = qemu_add_vm_change_state_handler(usb_ehci_vm_state_change, s);
-- 
2.9.3
