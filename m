Received: from eggs.gnu.org ([2001:4830:134:3::10]:42164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1M-0008VR-3J
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1H-00059p-Fy
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1H-000591-9i
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:55:01 +0800
Message-Id: <20170908095506.13594-34-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/38] buildsys: Move opengl cflags to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Opengl libs are already moved to per object, do so for the cflags as
well.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907082918.7299-7-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 2 +-
 ui/Makefile.objs | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index df22b14259..385ed51a18 100755
--- a/configure
+++ b/configure
@@ -3627,7 +3627,6 @@ if test "$opengl" !=3D "no" ; then
     if test "$gtk" =3D "yes" && $pkg_config --exists "$gtkpackage >=3D 3=
.16"; then
         gtk_gl=3D"yes"
     fi
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" =3D "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkg=
s: $opengl_pkgs"
@@ -5843,6 +5842,7 @@ fi
=20
 if test "$opengl" =3D "yes" ; then
   echo "CONFIG_OPENGL=3Dy" >> $config_host_mak
+  echo "OPENGL_CFLAGS=3D$opengl_cflags" >> $config_host_mak
   echo "OPENGL_LIBS=3D$opengl_libs" >> $config_host_mak
   if test "$opengl_dmabuf" =3D "yes" ; then
     echo "CONFIG_OPENGL_DMABUF=3Dy" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index e3403b698b..95943d9c33 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -53,10 +53,10 @@ gtk.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
 gtk-egl.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
 gtk-gl-area.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
=20
-gtk-egl.o-libs +=3D $(OPENGL_LIBS)
-shader.o-libs +=3D $(OPENGL_LIBS)
-console-gl.o-libs +=3D $(OPENGL_LIBS)
-egl-helpers.o-libs +=3D $(OPENGL_LIBS)
+$(foreach x, gtk-egl shader console egl-helpers, \
+	$(eval $x.o-libs +=3D $(OPENGL_LIBS)) \
+	$(eval $x.o-cflags +=3D $(OPENGL_CFLAGS)) \
+)
=20
 curses.o-cflags :=3D $(CURSES_CFLAGS)
 curses.o-libs :=3D $(CURSES_LIBS)
--=20
2.13.5
