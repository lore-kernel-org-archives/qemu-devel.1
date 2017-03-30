Received: from eggs.gnu.org ([2001:4830:134:3::10]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctU02-0005nn-OK
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctTzy-0005ca-PN
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctTzy-0005ah-6b
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 08:55:31 +0200
Message-Id: <1490856931-21732-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 4/4] [testing] console: remove
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Drop the temporary workaround for the broken display updates.

TODO: before actually merging this we have to fix all the non-vga
      display adapters too ...

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
1.8.3.1
