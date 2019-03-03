Received: from eggs.gnu.org ([209.51.188.92]:39975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0Obm-0005Ah-6P
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0Obl-0000jn-Ag
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:38 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0Obk-0000hr-UG
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 05:44:37 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  3 Mar 2019 11:44:29 +0100
Message-Id: <20190303104430.7692-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] iconv: detect and make curses depend on it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, Eddie Kohler <ekohler@gmail.com>

curses will use it for proper wide output support.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 configure | 40 ++++++++++++++++++++++++++++++++++++++++
 vl.c      |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 540bee19ba..9979ca708d 100755
--- a/configure
+++ b/configure
@@ -1217,6 +1217,10 @@ for opt do
   ;;
   --enable-curses) curses=3D"yes"
   ;;
+  --disable-iconv) iconv=3D"no"
+  ;;
+  --enable-iconv) iconv=3D"yes"
+  ;;
   --disable-curl) curl=3D"no"
   ;;
   --enable-curl) curl=3D"yes"
@@ -1718,6 +1722,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   gtk             gtk UI
   vte             vte support for the gtk UI
   curses          curses UI
+  iconv           font glyph conversion support
   vnc             VNC UI support
   vnc-sasl        SASL encryption for VNC server
   vnc-jpeg        JPEG lossy compression for VNC server
@@ -3398,8 +3403,39 @@ EOF
   fi
 fi
=20
+##########################################
+# iconv probe
+if test "$iconv" !=3D "no" ; then
+  cat > $TMPC << EOF
+#include <iconv.h>
+int main(void) {
+  iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
+  return conv !=3D (iconv_t) -1;
+}
+EOF
+  for iconv_lib in '' -liconv; do
+    if compile_prog "" "$iconv_lib" ; then
+      iconv_found=3Dyes
+      libs_softmmu=3D"$iconv_lib $libs_softmmu"
+      break
+    fi
+  done
+  if test "$iconv_found" =3D "yes" ; then
+    iconv=3Dyes
+  else
+    if test "$iconv" =3D "yes" ; then
+      feature_not_found "iconv" "Install iconv devel"
+    fi
+    iconv=3Dno
+  fi
+fi
+
 ##########################################
 # curses probe
+if test "$iconv" =3D "no" ; then
+  # curses will need iconv
+  curses=3Dno
+fi
 if test "$curses" !=3D "no" ; then
   if test "$mingw32" =3D "yes" ; then
     curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"
@@ -6111,6 +6147,7 @@ echo "libgcrypt         $gcrypt"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
 echo "libtasn1          $tasn1"
 echo "PAM               $auth_pam"
+echo "iconv support     $iconv"
 echo "curses support    $curses"
 echo "virgl support     $virglrenderer $(echo_version $virglrenderer $vi=
rgl_version)"
 echo "curl support      $curl"
@@ -6435,6 +6472,9 @@ fi
 if test "$cocoa" =3D "yes" ; then
   echo "CONFIG_COCOA=3Dy" >> $config_host_mak
 fi
+if test "$iconv" =3D "yes" ; then
+  echo "CONFIG_ICONV=3Dy" >> $config_host_mak
+fi
 if test "$curses" =3D "yes" ; then
   echo "CONFIG_CURSES=3Dm" >> $config_host_mak
   echo "CURSES_CFLAGS=3D$curses_inc" >> $config_host_mak
diff --git a/vl.c b/vl.c
index 502857a176..c8594fc6d5 100644
--- a/vl.c
+++ b/vl.c
@@ -3171,7 +3171,7 @@ int main(int argc, char **argv, char **envp)
 #ifdef CONFIG_CURSES
                 dpy.type =3D DISPLAY_TYPE_CURSES;
 #else
-                error_report("curses support is disabled");
+                error_report("curses or iconv support is disabled");
                 exit(1);
 #endif
                 break;
--=20
2.20.1
