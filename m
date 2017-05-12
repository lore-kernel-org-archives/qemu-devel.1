Received: from eggs.gnu.org ([2001:4830:134:3::10]:60847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-0002t1-5M
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996k-00053w-Mf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996k-00053P-FZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C2B57F4BD
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:51:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:31 +0200
Message-Id: <20170512115135.17379-7-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/10] egl-helpers: add missing error check
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170505104101.30589-5-kraxel@redhat.com
---
 ui/egl-helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index ec2e325e21..b50225158b 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -80,6 +80,7 @@ static int qemu_egl_rendernode_open(const char *rendern=
ode)
 int egl_rendernode_init(const char *rendernode)
 {
     qemu_egl_rn_fd =3D -1;
+    int rc;
=20
     qemu_egl_rn_fd =3D qemu_egl_rendernode_open(rendernode);
     if (qemu_egl_rn_fd =3D=3D -1) {
@@ -93,7 +94,11 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
=20
-    qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    rc =3D qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_=
dev);
+    if (rc !=3D 0) {
+        /* qemu_egl_init_dpy_mesa reports error */
+        goto err;
+    }
=20
     if (!epoxy_has_egl_extension(qemu_egl_display,
                                  "EGL_KHR_surfaceless_context")) {
--=20
2.9.3
