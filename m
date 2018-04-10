Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5m1U-0003wV-A9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5m1P-0005iP-SW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:40:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5m1P-0005i3-Me
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:40:47 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Apr 2018 13:40:34 +0800
Message-Id: <20180410054034.20479-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: don't warn SDL abi if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

SDL has the same problem as GTK that we might get warnings on SDL ABI
version even if SDL is disabled.  Fix that by only probing SDL if SDL is
enabled.  Also this should let configure be a little bit faster since we
don't really need to probe SDL stuff when it's off.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Fam Zheng <famz@redhat.com>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 configure | 83 ++++++++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/configure b/configure
index 752dd9ef32..f647026b8d 100755
--- a/configure
+++ b/configure
@@ -2836,49 +2836,52 @@ fi
 # Look for sdl configuration program (pkg-config or sdl-config).  Try
 # sdl-config even without cross prefix, and favour pkg-config over sdl-c=
onfig.
=20
-if test "$sdlabi" =3D ""; then
-    if $pkg_config --exists "sdl2"; then
-        sdlabi=3D2.0
-    elif $pkg_config --exists "sdl"; then
-        sdlabi=3D1.2
-    else
-        sdlabi=3D2.0
-    fi
-fi
+sdl_probe ()
+{
+  sdl_too_old=3Dno
+  if test "$sdlabi" =3D ""; then
+      if $pkg_config --exists "sdl2"; then
+          sdlabi=3D2.0
+      elif $pkg_config --exists "sdl"; then
+          sdlabi=3D1.2
+      else
+          sdlabi=3D2.0
+      fi
+  fi
=20
-if test $sdlabi =3D "2.0"; then
-    sdl_config=3D$sdl2_config
-    sdlname=3Dsdl2
-    sdlconfigname=3Dsdl2_config
-elif test $sdlabi =3D "1.2"; then
-    sdlname=3Dsdl
-    sdlconfigname=3Dsdl_config
-else
-    error_exit "Unknown sdlabi $sdlabi, must be 1.2 or 2.0"
-fi
+  if test $sdlabi =3D "2.0"; then
+      sdl_config=3D$sdl2_config
+      sdlname=3Dsdl2
+      sdlconfigname=3Dsdl2_config
+  elif test $sdlabi =3D "1.2"; then
+      sdlname=3Dsdl
+      sdlconfigname=3Dsdl_config
+  else
+      error_exit "Unknown sdlabi $sdlabi, must be 1.2 or 2.0"
+  fi
=20
-if test "$(basename $sdl_config)" !=3D $sdlconfigname && ! has ${sdl_con=
fig}; then
-  sdl_config=3D$sdlconfigname
-fi
+  if test "$(basename $sdl_config)" !=3D $sdlconfigname && ! has ${sdl_c=
onfig}; then
+    sdl_config=3D$sdlconfigname
+  fi
=20
-if $pkg_config $sdlname --exists; then
-  sdlconfig=3D"$pkg_config $sdlname"
-  sdlversion=3D$($sdlconfig --modversion 2>/dev/null)
-elif has ${sdl_config}; then
-  sdlconfig=3D"$sdl_config"
-  sdlversion=3D$($sdlconfig --version)
-else
-  if test "$sdl" =3D "yes" ; then
-    feature_not_found "sdl" "Install SDL2-devel"
+  if $pkg_config $sdlname --exists; then
+    sdlconfig=3D"$pkg_config $sdlname"
+    sdlversion=3D$($sdlconfig --modversion 2>/dev/null)
+  elif has ${sdl_config}; then
+    sdlconfig=3D"$sdl_config"
+    sdlversion=3D$($sdlconfig --version)
+  else
+    if test "$sdl" =3D "yes" ; then
+      feature_not_found "sdl" "Install SDL2-devel"
+    fi
+    sdl=3Dno
+    # no need to do the rest
+    return
+  fi
+  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" =3D sdl-=
config; then
+    echo warning: using "\"$sdlconfig\"" to detect cross-compiled sdl >&=
2
   fi
-  sdl=3Dno
-fi
-if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" =3D sdl-co=
nfig; then
-  echo warning: using "\"$sdlconfig\"" to detect cross-compiled sdl >&2
-fi
=20
-sdl_too_old=3Dno
-if test "$sdl" !=3D "no" ; then
   cat > $TMPC << EOF
 #include <SDL.h>
 #undef main /* We don't want SDL to override our main() */
@@ -2920,6 +2923,10 @@ EOF
     fi
     sdl=3Dno
   fi # sdl compile test
+}
+
+if test "$sdl" !=3D "no" ; then
+  sdl_probe
 fi
=20
 if test "$sdl" =3D "yes" ; then
--=20
2.14.3
