Received: from eggs.gnu.org ([2001:4830:134:3::10]:60009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8naw-0002rC-7r
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8nau-00009g-N1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d8nau-00009B-GN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61D678123A
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:53:23 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 11 May 2017 14:53:14 +0200
Message-Id: <20170511125314.24549-3-lprosek@redhat.com>
In-Reply-To: <20170511125314.24549-1-lprosek@redhat.com>
References: <20170511125314.24549-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] usb-hub: clear PORT_STAT_SUSPEND on wakeup
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
---
 hw/usb/dev-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 9fe7333..47b7519 100644
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
