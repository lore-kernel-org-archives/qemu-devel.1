Received: from eggs.gnu.org ([209.51.188.92]:58687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOi-0005SP-Im
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOd-0003rM-8c
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOZ-0003nf-8X
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:44 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:54 +0000
Message-Id: <1549460216-25808-8-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 7/9] usb: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, darren.kenny@oracle.com

In musb_packet(), the call to usb_find_device() can return NULL
if it doesn't find a device matching 'addr' so explicitly check
the return value before passing it to usb_ep_get().  This then
allows the subsequent calculation of 'id' to be streamlined.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-musb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index d70a91a58ce2..85d779655498 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -628,11 +628,11 @@ static void musb_packet(MUSBState *s, MUSBEndPoint *ep,
 
     /* A wild guess on the FADDR semantics... */
     dev = usb_find_device(&s->port, ep->faddr[idx]);
-    uep = usb_ep_get(dev, pid, ep->type[idx] & 0xf);
-    id = pid;
-    if (uep) {
-        id |= (dev->addr << 16) | (uep->nr << 8);
+    if (dev == NULL) {
+        return;
     }
+    uep = usb_ep_get(dev, pid, ep->type[idx] & 0xf);
+    id = pid | (dev->addr << 16) | (uep->nr << 8);
     usb_packet_setup(&ep->packey[dir].p, pid, uep, 0, id, false, true);
     usb_packet_addbuf(&ep->packey[dir].p, ep->buf[idx], len);
     ep->packey[dir].ep = ep;
-- 
1.8.3.1
