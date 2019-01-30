Received: from eggs.gnu.org ([209.51.188.92]:58005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0w-0006sN-UN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0w-0001Je-5z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gor0v-0001J2-Tw
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:54 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed, 30 Jan 2019 14:37:01 +0000
Message-Id: <1548859022-3969-2-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 1/2] usb: rearrange usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

There is no need to calculate the 'eps' variable in usb_ep_get()
if 'ep' is the control endpoint.  Instead the calculation should
be done after validating the input and the resulting pointer also
validated before returning an entry indexed on the endpoint 'ep'.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
---
 hw/usb/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66b1505..1aa0051b2b2d 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -720,12 +720,13 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
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
+    assert(eps != NULL);
     return eps + ep - 1;
 }
 
-- 
1.8.3.1
