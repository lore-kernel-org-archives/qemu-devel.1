Received: from eggs.gnu.org ([2001:4830:134:3::10]:44919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fEJmV-00025S-JE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fEJmR-0000fw-Lp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fEJmR-0000ds-G7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75E5781A327D
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 19:20:36 +0000 (UTC)
From: Bandan <bsd@redhat.com>
Date: Thu,  3 May 2018 15:20:28 -0400
Message-Id: <20180503192028.14353-3-bsd@redhat.com>
In-Reply-To: <20180503192028.14353-1-bsd@redhat.com>
References: <20180503192028.14353-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] usb-mtp: Unconditionally check for the
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
Cc: kraxel@redhat.com

From: Bandan Das <bsd@redhat.com>

Currently, it's only being checked if desc is NULL and
so write support breaks upon specifying desc

Signed-off-by: Bandan Das <bsd@redhat.com>
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
2.11.0
