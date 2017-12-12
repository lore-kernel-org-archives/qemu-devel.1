Received: from eggs.gnu.org ([2001:4830:134:3::10]:35431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlBV-0005PW-7Y
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlBP-00056K-D4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlBP-00055c-6d
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A2BEC070E1F
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 14:05:18 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Dec 2017 14:04:58 +0000
Message-Id: <20171212140459.2234-4-berrange@redhat.com>
In-Reply-To: <20171212140459.2234-1-berrange@redhat.com>
References: <20171212140459.2234-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/4] ui: add fix for GTK Pause key handling
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
 ui/gtk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 749999df44..89cc81b708 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1207,6 +1207,12 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     }
 
     if (key->keyval == GDK_KEY_Pause) {
+#ifdef G_OS_WIN32
+        /* for some reason GDK does not fill keyval for VK_PAUSE
+         * See https://bugzilla.gnome.org/show_bug.cgi?id=769214
+         */
+        || key->hardware_keycode == VK_PAUSE
+#endif
         qemu_input_event_send_key_qcode(vc->gfx.dcl.con, Q_KEY_CODE_PAUSE,
                                         key->type == GDK_KEY_PRESS);
         return TRUE;
-- 
2.14.3
