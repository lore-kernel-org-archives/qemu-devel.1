Received: from eggs.gnu.org ([2001:4830:134:3::10]:44198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVc-0004XN-6v
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVa-0000X9-6P
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVZ-0000WW-Uv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DC0680476
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:28:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:47 +0200
Message-Id: <20181001092848.11082-5-kraxel@redhat.com>
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] usb-hub: clear suspend on detach
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180912114012.6034-1-kraxel@redhat.com
---
 hw/usb/dev-hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 5d9743ef93..dc368179d1 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -191,6 +191,10 @@ static void usb_hub_detach(USBPort *port1)
         port->wPortStatus &= ~PORT_STAT_ENABLE;
         port->wPortChange |= PORT_STAT_C_ENABLE;
     }
+    if (port->wPortStatus & PORT_STAT_SUSPEND) {
+        port->wPortStatus &= ~PORT_STAT_SUSPEND;
+        port->wPortChange |= PORT_STAT_C_SUSPEND;
+    }
     usb_wakeup(s->intr, 0);
 }
 
-- 
2.9.3
