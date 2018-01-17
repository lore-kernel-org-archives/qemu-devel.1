Received: from eggs.gnu.org ([2001:4830:134:3::10]:52260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqsD-0002iE-Sh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqsA-0002XZ-4J
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebqs9-0002WT-UY
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09554C014170
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:47:33 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 17 Jan 2018 16:47:16 +0000
Message-Id: <20180117164717.15855-4-berrange@redhat.com>
In-Reply-To: <20180117164717.15855-1-berrange@redhat.com>
References: <20180117164717.15855-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/4] ui: add fix for GTK Pause key handling
 on Win32
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

Versions of GTK prior to 3.22 did not correctly set the keyval
field when VK_PAUSE was received on Windows.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
2.14.3
