Received: from eggs.gnu.org ([2001:4830:134:3::10]:42768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchZ-0002jF-QX
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchY-00059Z-9u
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFchY-00057a-5Z
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8558401DEA4
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 09:44:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:44:47 +0200
Message-Id: <20180507094448.32386-3-kraxel@redhat.com>
In-Reply-To: <20180507094448.32386-1-kraxel@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] usb-mtp: Unconditionally check for the
 readonly bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

Currently, it's only being checked if desc is NULL and
so write support breaks upon specifying desc

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180503192028.14353-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 24cff640c0..3d59fe4944 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1948,16 +1948,17 @@ static void usb_mtp_realize(USBDevice *dev, Error **errp)
             return;
         }
         s->desc = strrchr(s->root, '/');
-        /* Mark store as RW */
-        if (!s->readonly) {
-            s->flags |= (1 << MTP_FLAG_WRITABLE);
-        }
         if (s->desc && s->desc[0]) {
             s->desc = g_strdup(s->desc + 1);
         } else {
             s->desc = g_strdup("none");
         }
     }
+    /* Mark store as RW */
+    if (!s->readonly) {
+        s->flags |= (1 << MTP_FLAG_WRITABLE);
+    }
+
 }
 
 static const VMStateDescription vmstate_usb_mtp = {
-- 
2.9.3
