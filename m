Received: from eggs.gnu.org ([2001:4830:134:3::10]:54435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQz-0007v2-No
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQy-0002Go-OA
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKQy-0002EA-Ie
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8E324E4C8
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:10:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:55 +0200
Message-Id: <20170529130956.20297-9-kraxel@redhat.com>
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
References: <20170529130956.20297-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] usb: don't wakeup during coldplug
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1452512
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170523084635.20062-1-kraxel@redhat.com
---
 hw/usb/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 45fa00c517..241ae66b15 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -98,6 +98,14 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream)
     USBDevice *dev = ep->dev;
     USBBus *bus = usb_bus_from_device(dev);
 
+    if (!qdev_hotplug) {
+        /*
+         * This is machine init cold plug.  No need to wakeup anyone,
+         * all devices will be reset anyway.  And trying to wakeup can
+         * cause problems due to hitting uninitialized devices.
+         */
+        return;
+    }
     if (dev->remote_wakeup && dev->port && dev->port->ops->wakeup) {
         dev->port->ops->wakeup(dev->port);
     }
-- 
2.9.3
