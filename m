Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cfkcd-0005VL-V4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cfkcY-000472-45
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cfkcX-00046n-Um
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:51:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 609B763319
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:51:01 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Mon, 20 Feb 2017 09:50:55 +0000
Message-Id: <20170220095055.4234-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH] egl-helpers: Support newer MESA versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

According to
https://www.khronos.org/registry/EGL/extensions/MESA/EGL_MESA_platform_gbm.txt
if MESA_platform_gbm is supported display should be initialized
from a GBM handle using eglGetPlatformDisplayEXT.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
This should fix
http://www.spinics.net/linux/fedora/libvir/msg142837.html

Tested on Fedora rawhide.
---
 ui/egl-helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index cd24568..964c5a5 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -219,7 +219,11 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
     }
 
     egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
+#ifdef EGL_MESA_platform_gbm
+    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, dpy, NULL);
+#else
     qemu_egl_display = eglGetDisplay(dpy);
+#endif
     if (qemu_egl_display == EGL_NO_DISPLAY) {
         error_report("egl: eglGetDisplay failed");
         return -1;
-- 
2.9.3
