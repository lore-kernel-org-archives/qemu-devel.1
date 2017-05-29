Received: from eggs.gnu.org ([2001:4830:134:3::10]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQz-0007uz-M6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQy-0002GX-J2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKQy-0002Dt-Du
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D07EC049D5D
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:10:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:56 +0200
Message-Id: <20170529130956.20297-10-kraxel@redhat.com>
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
References: <20170529130956.20297-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] ehci: fix frame timer invocation.
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
Message-id: 20170519120428.25981-1-kraxel@redhat.com
---
 hw/usb/hcd-ehci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index d7361e570f..17c572c55f 100644
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
