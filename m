Received: from eggs.gnu.org ([209.51.188.92]:58069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugZ-0007cu-15
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugY-00031a-1r
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1ugX-00030l-OY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:49 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 16:11:37 +0100
Message-Id: <20190307151141.6483-4-kraxel@redhat.com>
In-Reply-To: <20190307151141.6483-1-kraxel@redhat.com>
References: <20190307151141.6483-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] iconv: detect and make curses depend on it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

curses will use it for proper wide output support.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-Id: <20190304210217.7056-2-samuel.thibault@ens-lyon.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 40 ++++++++++++++++++++++++++++++++++++++++
 vl.c      |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index cefeb8fcce44..c594d2be18c7 100755
--- a/configure
+++ b/configure
@@ -1214,6 +1214,10 @@ for opt do
   ;;
   --enable-curses) curses="yes"
   ;;
+  --disable-iconv) iconv="no"
+  ;;
+  --enable-iconv) iconv="yes"
+  ;;
   --disable-curl) curl="no"
   ;;
   --enable-curl) curl="yes"
@@ -1703,6 +1707,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   gtk             gtk UI
   vte             vte support for the gtk UI
   curses          curses UI
+  iconv           font glyph conversion support
   vnc             VNC UI support
   vnc-sasl        SASL encryption for VNC server
   vnc-jpeg        JPEG lossy compression for VNC server
@@ -3424,8 +3429,39 @@ EOF
   fi
 fi
 
+##########################################
+# iconv probe
+if test "$iconv" != "no" ; then
+  cat > $TMPC << EOF
+#include <iconv.h>
+int main(void) {
+  iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
+  return conv != (iconv_t) -1;
+}
+EOF
+  for iconv_lib in '' -liconv; do
+    if compile_prog "" "$iconv_lib" ; then
+      iconv_found=yes
+      libs_softmmu="$iconv_lib $libs_softmmu"
+      break
+    fi
+  done
+  if test "$iconv_found" = "yes" ; then
+    iconv=yes
+  else
+    if test "$iconv" = "yes" ; then
+      feature_not_found "iconv" "Install iconv devel"
+    fi
+    iconv=no
+  fi
+fi
+
 ##########################################
 # curses probe
+if test "$iconv" = "no" ; then
+  # curses will need iconv
+  curses=no
+fi
 if test "$curses" != "no" ; then
   if test "$mingw32" = "yes" ; then
     curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
@@ -6137,6 +6173,7 @@ echo "libgcrypt         $gcrypt"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
 echo "libtasn1          $tasn1"
 echo "PAM               $auth_pam"
+echo "iconv support     $iconv"
 echo "curses support    $curses"
 echo "virgl support     $virglrenderer $(echo_version $virglrenderer $virgl_version)"
 echo "curl support      $curl"
@@ -6461,6 +6498,9 @@ fi
 if test "$cocoa" = "yes" ; then
   echo "CONFIG_COCOA=y" >> $config_host_mak
 fi
+if test "$iconv" = "yes" ; then
+  echo "CONFIG_ICONV=y" >> $config_host_mak
+fi
 if test "$curses" = "yes" ; then
   echo "CONFIG_CURSES=m" >> $config_host_mak
   echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
diff --git a/vl.c b/vl.c
index 4c5cc0d8ad91..b1eef2b60a03 100644
--- a/vl.c
+++ b/vl.c
@@ -3172,7 +3172,7 @@ int main(int argc, char **argv, char **envp)
 #ifdef CONFIG_CURSES
                 dpy.type = DISPLAY_TYPE_CURSES;
 #else
-                error_report("curses support is disabled");
+                error_report("curses or iconv support is disabled");
                 exit(1);
 #endif
                 break;
-- 
2.18.1
