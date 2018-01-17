Received: from eggs.gnu.org ([2001:4830:134:3::10]:52274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqsE-0002ic-AT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqsD-0002ez-Nk
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebqsD-0002dC-Io
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C33D2FE544
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:47:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 17 Jan 2018 16:47:17 +0000
Message-Id: <20180117164717.15855-5-berrange@redhat.com>
In-Reply-To: <20180117164717.15855-1-berrange@redhat.com>
References: <20180117164717.15855-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 4/4] ui: ignore hardware keycode 255 on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

It is a reserved value and doesn't have a corresponding
valid scancode.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
2.14.3
