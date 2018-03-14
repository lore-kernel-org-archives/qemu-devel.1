Received: from eggs.gnu.org ([2001:4830:134:3::10]:38349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ew1Ou-0002BB-CL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ew1Or-0002B6-7R
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:04:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ew1Or-0002Am-2d
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:04:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Mar 2018 09:04:39 +0100
Message-Id: <20180314080439.4229-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] gtk: drop pointless code from gd_window_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Unregistering the display change listener looks like a pointless
excercise given we'll exit in a moment.  When exiting qemu via
menu/file/quit this will not happen either.  Just drop the code.

Also return TRUE unconditionally.  This will tell gtk to ignore the
close request, so gtk will not start destroying widgets and causing
warnings due to UI code trying to talk to widgets which are gone.
Just depend on qmp_quit() doing it's job instead.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ef5bc42094..2925c66e0b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -786,21 +786,13 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
 {
     GtkDisplayState *s = opaque;
     bool allow_close = true;
-    int i;
 
     if (s->opts->has_window_close && !s->opts->window_close) {
         allow_close = false;
     }
 
     if (allow_close) {
-        for (i = 0; i < s->nb_vcs; i++) {
-            if (s->vc[i].type != GD_VC_GFX) {
-                continue;
-            }
-            unregister_displaychangelistener(&s->vc[i].gfx.dcl);
-        }
         qmp_quit(NULL);
-        return FALSE;
     }
 
     return TRUE;
-- 
2.9.3
