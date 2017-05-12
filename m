Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aE-0000L0-2o
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aB-00056e-0T
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d99aA-000569-Q2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA85E3DBD5
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:22:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 14:21:56 +0200
Message-Id: <20170512122158.32032-5-kraxel@redhat.com>
In-Reply-To: <20170512122158.32032-1-kraxel@redhat.com>
References: <20170512122158.32032-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] usb-hub: clear PORT_STAT_SUSPEND on wakeup
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

The spec says:

  Suspend: (PORT_SUSPEND) This field indicates whether or not the device
  on this port is suspended. Setting this field causes the device to
  suspend by not propagating bus traffic downstream. This field may be
  reset by a request or by resume signaling from the device attached to
  the port.

I can't find any specific statement like "the PORT_SUSPEND field is reset
automatically on remote wakeup", but without this patch, the only way to
reset it is via the ClearPortFeature request so the ".. or by resume
signaling from the device" clause is clearly not implemented on the remote
wakeup path.

The default xhci Windows driver does not issue the ClearPortFeature request
and suspended devices attached to a hub don't properly get out of the
suspended state. Interestingly, the default uhci Windows driver *does*
issue the ClearPortFeature request and does not exhibit this problem.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 20170511125314.24549-3-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 9fe7333946..47b7519910 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -208,6 +208,7 @@ static void usb_hub_wakeup(USBPort *port1)
     USBHubPort *port = &s->ports[port1->index];
 
     if (port->wPortStatus & PORT_STAT_SUSPEND) {
+        port->wPortStatus &= ~PORT_STAT_SUSPEND;
         port->wPortChange |= PORT_STAT_C_SUSPEND;
         usb_wakeup(s->intr, 0);
     }
-- 
2.9.3
