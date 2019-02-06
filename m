Received: from eggs.gnu.org ([209.51.188.92]:58651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOY-0005Ju-AV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOT-0003pc-Jf
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOM-0003n1-2k
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:33 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:55 +0000
Message-Id: <1549460216-25808-9-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 8/9] usb: add device checks before
 redirector calls to usb_ep_get()
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

Add an assert and an explicit check before the two callers to
usb_ep_get() in the USB redirector code to ensure the device
passed in is not NULL.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/redirect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 18a42d19380e..7cb6b120d4f0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1728,6 +1728,7 @@ static void usbredir_ep_info(void *priv,
     USBRedirDevice *dev = priv;
     int i;
 
+    assert(dev != NULL);
     for (i = 0; i < MAX_ENDPOINTS; i++) {
         dev->endpoint[i].type = ep_info->type[i];
         dev->endpoint[i].interval = ep_info->interval[i];
@@ -2125,7 +2126,7 @@ static int usbredir_post_load(void *priv, int version_id)
 {
     USBRedirDevice *dev = priv;
 
-    if (dev->parser == NULL) {
+    if (dev == NULL || dev->parser == NULL) {
         return 0;
     }
 
-- 
1.8.3.1
