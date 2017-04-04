Received: from eggs.gnu.org ([2001:4830:134:3::10]:54151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026q-NV
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002D4-T9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002C4-Nx
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:15 +0200
Message-Id: <20170404102315.24923-11-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] [testing] console: remove
 do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Drop the temporary workaround for the broken display updates.

TODO: before actually merging this we have to fix all display
      adapters ...

Converted so far: vga, cg3, tcx.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 419b098..4c70d8b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1575,36 +1575,13 @@ bool dpy_gfx_check_format(QemuConsole *con,
     return true;
 }
 
-/*
- * Safe DPY refresh for TCG guests. We use the exclusive mechanism to
- * ensure the TCG vCPUs are quiescent so we can avoid races between
- * dirty page tracking for direct frame-buffer access by the guest.
- *
- * This is a temporary stopgap until we've fixed the dirty tracking
- * races in display adapters.
- */
-static void do_safe_dpy_refresh(DisplayChangeListener *dcl)
-{
-    qemu_mutex_unlock_iothread();
-    start_exclusive();
-    qemu_mutex_lock_iothread();
-    dcl->ops->dpy_refresh(dcl);
-    qemu_mutex_unlock_iothread();
-    end_exclusive();
-    qemu_mutex_lock_iothread();
-}
-
 static void dpy_refresh(DisplayState *s)
 {
     DisplayChangeListener *dcl;
 
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (dcl->ops->dpy_refresh) {
-            if (tcg_enabled()) {
-                do_safe_dpy_refresh(dcl);
-            } else {
-                dcl->ops->dpy_refresh(dcl);
-            }
+            dcl->ops->dpy_refresh(dcl);
         }
     }
 }
-- 
2.9.3
