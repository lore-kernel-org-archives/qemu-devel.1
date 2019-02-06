Received: from eggs.gnu.org ([209.51.188.92]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNO9-00050T-JF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNO8-0003m3-Ti
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNO8-0003lm-LI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:16 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:48 +0000
Message-Id: <1549460216-25808-2-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 1/9] usb: rearrange usb_ep_get()
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

There is no need to calculate the 'eps' variable in usb_ep_get()
if 'ep' is the control endpoint.  Instead the calculation should
be done after validating the input before returning an entry
indexed by the endpoint 'ep'.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
---
 hw/usb/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66b1505..bfb7ae67bbf0 100644
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
1.8.3.1
