Received: from eggs.gnu.org ([2001:4830:134:3::10]:51099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZn-0005Te-6Y
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZl-0006tJ-8w
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eeiZl-0006s4-40
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73579C0528DC
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 14:32:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 15:32:15 +0100
Message-Id: <20180125143218.29528-6-kraxel@redhat.com>
In-Reply-To: <20180125143218.29528-1-kraxel@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] ui: ignore hardware keycode 255 on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

It is a reserved value and doesn't have a corresponding
valid scancode.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20180117164717.15855-5-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 188c40eef5..f0ad63e431 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1206,6 +1206,12 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         return TRUE;
     }
 
+#ifdef WIN32
+    /* on windows, we ought to ignore the reserved key event? */
+    if (key->hardware_keycode == 0xff)
+        return false;
+#endif
+
     if (key->keyval == GDK_KEY_Pause
 #ifdef G_OS_WIN32
         /* for some reason GDK does not fill keyval for VK_PAUSE
-- 
2.9.3
