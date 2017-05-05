Received: from eggs.gnu.org ([2001:4830:134:3::10]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6aff-0004gU-Ba
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6afc-000889-6g
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6afc-00087q-0h
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B034E80C04
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:41:06 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 May 2017 12:40:59 +0200
Message-Id: <20170505104101.30589-5-kraxel@redhat.com>
In-Reply-To: <20170505104101.30589-1-kraxel@redhat.com>
References: <20170505104101.30589-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] egl-helpers: add missing error check
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

Code didn't check for qemu_egl_init_dpy_mesa() failures, add it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index ec2e325e21..b50225158b 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -80,6 +80,7 @@ static int qemu_egl_rendernode_open(const char *rendernode)
 int egl_rendernode_init(const char *rendernode)
 {
     qemu_egl_rn_fd = -1;
+    int rc;
 
     qemu_egl_rn_fd = qemu_egl_rendernode_open(rendernode);
     if (qemu_egl_rn_fd == -1) {
@@ -93,7 +94,11 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
 
-    qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    if (rc != 0) {
+        /* qemu_egl_init_dpy_mesa reports error */
+        goto err;
+    }
 
     if (!epoxy_has_egl_extension(qemu_egl_display,
                                  "EGL_KHR_surfaceless_context")) {
-- 
2.9.3
