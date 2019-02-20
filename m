Received: from eggs.gnu.org ([209.51.188.92]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpJ-0008HE-PE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpG-00085u-Fn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPp6-0007bW-WA
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:44 +0100
Message-Id: <20190220111346.13669-8-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] usb: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Merwick <liam.merwick@oracle.com>

From: Liam Merwick <liam.merwick@oracle.com>

In musb_packet(), the call to usb_find_device() can return NULL
if it doesn't find a device matching 'addr' so explicitly check
the return value before passing it to usb_ep_get().  This then
allows the subsequent calculation of 'id' to be streamlined.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-8-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-musb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index d70a91a58c..85d7796554 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -628,11 +628,11 @@ static void musb_packet(MUSBState *s, MUSBEndPoint *ep,
 
     /* A wild guess on the FADDR semantics... */
     dev = usb_find_device(&s->port, ep->faddr[idx]);
+    if (dev == NULL) {
+        return;
+    }
     uep = usb_ep_get(dev, pid, ep->type[idx] & 0xf);
-    id = pid;
-    if (uep) {
-        id |= (dev->addr << 16) | (uep->nr << 8);
-    }
+    id = pid | (dev->addr << 16) | (uep->nr << 8);
     usb_packet_setup(&ep->packey[dir].p, pid, uep, 0, id, false, true);
     usb_packet_addbuf(&ep->packey[dir].p, ep->buf[idx], len);
     ep->packey[dir].ep = ep;
-- 
2.9.3
