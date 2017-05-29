Received: from eggs.gnu.org ([2001:4830:134:3::10]:54457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKR3-0007ym-Vm
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQy-0002Gt-OY
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKQy-0002E6-I6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D0C6C056787
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:10:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:54 +0200
Message-Id: <20170529130956.20297-8-kraxel@redhat.com>
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
References: <20170529130956.20297-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] usb-hub: set PORT_STAT_C_SUSPEND on
 host-initiated wake-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

PORT_STAT_C_SUSPEND should be set even on host-initiated wake-up,
i.e. on ClearPortFeature(PORT_SUSPEND). Windows is known to not
work properly otherwise.

Side note, since PORT_ENABLE looks similar and might appear to
have the same issue: According to 11.24.2.7.2.2 C_PORT_ENABLE:

  "This bit is set when the PORT_ENABLE bit changes from one to
  zero as a result of a Port Error condition (see Section 11.8.1).
  This bit is not set on any other changes to PORT_ENABLE."

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 20170522123325.2199-1-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 47b7519910..e82a6a6c44 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -402,7 +402,20 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                 port->wPortChange &= ~PORT_STAT_C_ENABLE;
                 break;
             case PORT_SUSPEND:
-                port->wPortStatus &= ~PORT_STAT_SUSPEND;
+                if (port->wPortStatus & PORT_STAT_SUSPEND) {
+                    port->wPortStatus &= ~PORT_STAT_SUSPEND;
+
+                    /*
+                     * USB Spec rev2.0 11.24.2.7.2.3 C_PORT_SUSPEND
+                     * "This bit is set on the following transitions:
+                     *  - On transition from the Resuming state to the
+                     *    SendEOP [sic] state"
+                     *
+                     * Note that this includes both remote wake-up and
+                     * explicit ClearPortFeature(PORT_SUSPEND).
+                     */
+                    port->wPortChange |= PORT_STAT_C_SUSPEND;
+                }
                 break;
             case PORT_C_SUSPEND:
                 port->wPortChange &= ~PORT_STAT_C_SUSPEND;
-- 
2.9.3
