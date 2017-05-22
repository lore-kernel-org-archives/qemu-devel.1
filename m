Received: from eggs.gnu.org ([2001:4830:134:3::10]:60208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dCmX5-0003Ft-DO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dCmWz-0005Bq-Hm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dCmWz-0005Ar-Bm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 336CE4E4F5
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 12:33:47 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 22 May 2017 14:33:25 +0200
Message-Id: <20170522123325.2199-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] usb-hub: set PORT_STAT_C_SUSPEND on
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
Cc: kraxel@redhat.com

PORT_STAT_C_SUSPEND should be set even on host-initiated wake-up,
i.e. on ClearPortFeature(PORT_SUSPEND). Windows is known to not
work properly otherwise.

Side note, since PORT_ENABLE looks similar and might appear to
have the same issue: According to 11.24.2.7.2.2 C_PORT_ENABLE:

  "This bit is set when the PORT_ENABLE bit changes from one to
  zero as a result of a Port Error condition (see Section 11.8.1).
  This bit is not set on any other changes to PORT_ENABLE."

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---

One more usb-hub bug found with Windows guests. This one seems
to require input devices behind two levels of hubs to reproduce.
When one of the input devices remote-wakes up, Windows kicks the
other ones from suspend state using ClearPortFeature(PORT_SUSPEND).
Then it expects the change flag to be set by the hub.

 hw/usb/dev-hub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 47b7519..e82a6a6 100644
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
