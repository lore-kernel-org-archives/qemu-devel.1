Received: from eggs.gnu.org ([2001:4830:134:3::10]:34251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWE-0004jo-6R
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWD-0006Vm-4f
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5pWC-0006UT-VM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:49 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Apr 2018 11:24:46 +0200
Message-Id: <20180410092446.26903-5-kraxel@redhat.com>
In-Reply-To: <20180410092446.26903-1-kraxel@redhat.com>
References: <20180410092446.26903-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] configure: don't warn SDL abi if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Peter Xu <peterx@redhat.com>

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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180410054034.20479-1-peterx@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 87 ++++++++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/configure b/configure
index 931d2a07cc..0a19b033bc 100755
--- a/configure
+++ b/configure
@@ -2835,49 +2835,52 @@ fi
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
+
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
+
+  if test "$(basename $sdl_config)" !=3D $sdlconfigname && ! has ${sdl_c=
onfig}; then
+    sdl_config=3D$sdlconfigname
+  fi
+
+  if $pkg_config $sdlname --exists; then
+    sdlconfig=3D"$pkg_config $sdlname"
+    sdlversion=3D$($sdlconfig --modversion 2>/dev/null)
+  elif has ${sdl_config}; then
+    sdlconfig=3D"$sdl_config"
+    sdlversion=3D$($sdlconfig --version)
+  else
+    if test "$sdl" =3D "yes" ; then
+      feature_not_found "sdl" "Install SDL2-devel"
     fi
-fi
-
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
-
-if test "$(basename $sdl_config)" !=3D $sdlconfigname && ! has ${sdl_con=
fig}; then
-  sdl_config=3D$sdlconfigname
-fi
-
-if $pkg_config $sdlname --exists; then
-  sdlconfig=3D"$pkg_config $sdlname"
-  sdlversion=3D$($sdlconfig --modversion 2>/dev/null)
-elif has ${sdl_config}; then
-  sdlconfig=3D"$sdl_config"
-  sdlversion=3D$($sdlconfig --version)
-else
-  if test "$sdl" =3D "yes" ; then
-    feature_not_found "sdl" "Install SDL2-devel"
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
@@ -2919,6 +2922,10 @@ EOF
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
2.9.3
