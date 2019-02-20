Received: from eggs.gnu.org ([209.51.188.92]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpP-0008MJ-66
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpO-0008R8-DY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpO-0007cW-3T
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:45 +0100
Message-Id: <20190220111346.13669-9-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] usb: add device checks before redirector
 calls to usb_ep_get()
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

Add an assert and an explicit check before the two callers to
usb_ep_get() in the USB redirector code to ensure the device
passed in is not NULL.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-9-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 18a42d1938..7cb6b120d4 100644
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
2.9.3
