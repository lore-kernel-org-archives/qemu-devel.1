Received: from eggs.gnu.org ([2001:4830:134:3::10]:35400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlBR-0005Np-Vj
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlBQ-00058O-Or
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlBQ-00057F-Ic
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5FC46A7D0
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 14:05:19 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Dec 2017 14:04:59 +0000
Message-Id: <20171212140459.2234-5-berrange@redhat.com>
In-Reply-To: <20171212140459.2234-1-berrange@redhat.com>
References: <20171212140459.2234-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/4] ui: ignore hardware keycode 255 on win32
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
index 89cc81b708..687560b963 100644
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
     if (key->keyval == GDK_KEY_Pause) {
 #ifdef G_OS_WIN32
         /* for some reason GDK does not fill keyval for VK_PAUSE
-- 
2.14.3
