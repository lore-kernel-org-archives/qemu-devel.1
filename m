Received: from eggs.gnu.org ([2001:4830:134:3::10]:57008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgA8V-0002ax-1O
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgA8S-0008Gq-Ul
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:05:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgA8S-0008Gl-PL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:05:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 14:05:32 +0100
Message-Id: <1487682332-29154-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: fix double free issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Reported by Coverity: CID 1371242, 1371243, 1371244.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 62e85ed..51f4b30 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3181,6 +3181,7 @@ static void vnc_display_close(VncDisplay *vd)
     g_free(vd->lsock);
     g_free(vd->lsock_tag);
     vd->lsock = NULL;
+    vd->lsock_tag = NULL;
     vd->nlsock = 0;
 
     for (i = 0; i < vd->nlwebsock; i++) {
@@ -3192,6 +3193,7 @@ static void vnc_display_close(VncDisplay *vd)
     g_free(vd->lwebsock);
     g_free(vd->lwebsock_tag);
     vd->lwebsock = NULL;
+    vd->lwebsock_tag = NULL;
     vd->nlwebsock = 0;
 
     vd->auth = VNC_AUTH_INVALID;
@@ -3204,6 +3206,7 @@ static void vnc_display_close(VncDisplay *vd)
     vd->tlsaclname = NULL;
     if (vd->lock_key_sync) {
         qemu_remove_led_event_handler(vd->led);
+        vd->led = NULL;
     }
 }
 
-- 
1.8.3.1
