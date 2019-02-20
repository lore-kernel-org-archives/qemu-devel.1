Received: from eggs.gnu.org ([209.51.188.92]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpN-0008KF-Cx
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpM-0008L6-7w
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpK-0007Ri-RS
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:38 +0100
Message-Id: <20190220111346.13669-2-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] usb: rearrange usb_ep_get()
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

There is no need to calculate the 'eps' variable in usb_ep_get()
if 'ep' is the control endpoint.  Instead the calculation should
be done after validating the input before returning an entry
indexed by the endpoint 'ep'.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Message-id: 1549460216-25808-2-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66b15..bfb7ae67bb 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -720,12 +720,12 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
     if (dev == NULL) {
         return NULL;
     }
-    eps = (pid == USB_TOKEN_IN) ? dev->ep_in : dev->ep_out;
     if (ep == 0) {
         return &dev->ep_ctl;
     }
     assert(pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT);
     assert(ep > 0 && ep <= USB_MAX_ENDPOINTS);
+    eps = (pid == USB_TOKEN_IN) ? dev->ep_in : dev->ep_out;
     return eps + ep - 1;
 }
 
-- 
2.9.3
