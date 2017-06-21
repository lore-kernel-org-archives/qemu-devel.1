Received: from eggs.gnu.org ([2001:4830:134:3::10]:44407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbg-0005MU-2N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbe-0003Z8-Qt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNfbe-0003Yl-KV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B76A7104D5
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 13:23:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 15:23:39 +0200
Message-Id: <20170621132340.27686-6-kraxel@redhat.com>
In-Reply-To: <20170621132340.27686-1-kraxel@redhat.com>
References: <20170621132340.27686-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/6] console: remove do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Drop the temporary workaround for the broken display updates.
All display adapters are updated, so this should be safe without
causing regressions.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-id: 20170614084538.32480-1-kraxel@redhat.com
---
 ui/console.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index d914cced53..af0c56c600 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1579,36 +1579,13 @@ bool dpy_gfx_check_format(QemuConsole *con,
     return true;
 }
=20
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
=20
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
--=20
2.9.3
