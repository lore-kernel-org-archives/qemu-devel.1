Received: from eggs.gnu.org ([2001:4830:134:3::10]:51095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZn-0005Ta-6I
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZj-0006rB-TE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eeiZj-0006qK-OD
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08227C0567A2
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 14:32:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 15:32:14 +0100
Message-Id: <20180125143218.29528-5-kraxel@redhat.com>
In-Reply-To: <20180125143218.29528-1-kraxel@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] ui: add fix for GTK Pause key handling on
 Win32
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

Versions of GTK prior to 3.22 did not correctly set the keyval
field when VK_PAUSE was received on Windows.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20180117164717.15855-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1217160724..188c40eef5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1206,7 +1206,14 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         return TRUE;
     }
 
-    if (key->keyval == GDK_KEY_Pause) {
+    if (key->keyval == GDK_KEY_Pause
+#ifdef G_OS_WIN32
+        /* for some reason GDK does not fill keyval for VK_PAUSE
+         * See https://bugzilla.gnome.org/show_bug.cgi?id=769214
+         */
+        || key->hardware_keycode == VK_PAUSE
+#endif
+        ) {
         qemu_input_event_send_key_qcode(vc->gfx.dcl.con, Q_KEY_CODE_PAUSE,
                                         key->type == GDK_KEY_PRESS);
         return TRUE;
-- 
2.9.3
