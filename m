Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnxD-0007iC-4v
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnx8-0007lL-Lk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfnx8-0007l3-Cv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90C09C04B31F
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:24:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 14:24:24 +0100
Message-Id: <1487597065-27023-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487597065-27023-1-git-send-email-kraxel@redhat.com>
References: <1487597065-27023-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] spice: allow to specify drm rendernode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

When multiple GPU are available, picking the first one isn't always the
best choice. Learn to specify a device rendernode.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170212112118.16044-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  3 +--
 qemu-options.hx          |  6 +++++-
 ui/egl-helpers.c         | 10 +++++++---
 ui/spice-core.c          |  5 ++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 03fcf4b..88a13e8 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -14,8 +14,7 @@ extern int qemu_egl_rn_fd;
 extern struct gbm_device *qemu_egl_rn_gbm_dev;
 extern EGLContext qemu_egl_rn_ctx;
=20
-int qemu_egl_rendernode_open(void);
-int egl_rendernode_init(void);
+int egl_rendernode_init(const char *rendernode);
 int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *four=
cc);
=20
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 5633d39..809b2b0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1066,7 +1066,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,streaming-video=3D[off|all|filter]][,disable-copy-paste]\n=
"
     "       [,disable-agent-file-xfer][,agent-mouse=3D[on|off]]\n"
     "       [,playback-compression=3D[on|off]][,seamless-migration=3D[on=
|off]]\n"
-    "       [,gl=3D[on|off]]\n"
+    "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
     "   enable spice\n"
     "   at least one of {port, tls-port} is mandatory\n",
     QEMU_ARCH_ALL)
@@ -1161,6 +1161,10 @@ Enable/disable spice seamless migration. Default i=
s off.
 @item gl=3D[on|off]
 Enable/disable OpenGL context. Default is off.
=20
+@item rendernode=3D<file>
+DRM render node for OpenGL rendering. If not specified, it will pick
+the first available. (Since 2.9)
+
 @end table
 ETEXI
=20
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index cd24568..417462b 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -44,13 +44,17 @@ int qemu_egl_rn_fd;
 struct gbm_device *qemu_egl_rn_gbm_dev;
 EGLContext qemu_egl_rn_ctx;
=20
-int qemu_egl_rendernode_open(void)
+static int qemu_egl_rendernode_open(const char *rendernode)
 {
     DIR *dir;
     struct dirent *e;
     int r, fd;
     char *p;
=20
+    if (rendernode) {
+        return open(rendernode, O_RDWR | O_CLOEXEC | O_NOCTTY | O_NONBLO=
CK);
+    }
+
     dir =3D opendir("/dev/dri");
     if (!dir) {
         return -1;
@@ -85,11 +89,11 @@ int qemu_egl_rendernode_open(void)
     return fd;
 }
=20
-int egl_rendernode_init(void)
+int egl_rendernode_init(const char *rendernode)
 {
     qemu_egl_rn_fd =3D -1;
=20
-    qemu_egl_rn_fd =3D qemu_egl_rendernode_open();
+    qemu_egl_rn_fd =3D qemu_egl_rendernode_open(rendernode);
     if (qemu_egl_rn_fd =3D=3D -1) {
         error_report("egl: no drm render node available");
         goto err;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 1452e77..39ccab7 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -501,6 +501,9 @@ static QemuOptsList qemu_spice_opts =3D {
         },{
             .name =3D "gl",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "rendernode",
+            .type =3D QEMU_OPT_STRING,
 #endif
         },
         { /* end of list */ }
@@ -833,7 +836,7 @@ void qemu_spice_init(void)
                          "incompatible with -spice port/tls-port");
             exit(1);
         }
-        if (egl_rendernode_init() !=3D 0) {
+        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode")) !=3D 0=
) {
             error_report("Failed to initialize EGL render node for SPICE=
 GL");
             exit(1);
         }
--=20
1.8.3.1
