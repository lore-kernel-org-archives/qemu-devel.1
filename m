Received: from eggs.gnu.org ([2001:4830:134:3::10]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnxD-0007i9-4M
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnx8-0007lU-Rw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfnx8-0007l6-M4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D894AC05681A
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:24:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 14:24:25 +0100
Message-Id: <1487597065-27023-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487597065-27023-1-git-send-email-kraxel@redhat.com>
References: <1487597065-27023-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] egl-helpers: Support newer MESA versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

According to
https://www.khronos.org/registry/EGL/extensions/MESA/EGL_MESA_platform_gbm.txt
if MESA_platform_gbm is supported display should be initialized
from a GBM handle using eglGetPlatformDisplayEXT.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Message-id: 20170220095055.4234-1-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 417462b..584dd1b 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -223,7 +223,11 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
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
1.8.3.1
