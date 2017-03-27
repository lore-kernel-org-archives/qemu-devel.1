Received: from eggs.gnu.org ([2001:4830:134:3::10]:54830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csPIl-0004eZ-GD
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csPIh-0000je-JJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1csPIh-0000jX-9y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:42:51 -0400
From: Juergen Gross <jgross@suse.com>
Date: Mon, 27 Mar 2017 09:42:45 +0200
Message-Id: <20170327074245.3821-1-jgross@suse.com>
Subject: [Qemu-devel] [PATCH v2] configure: use pkg-config for obtaining xen
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, paul.durrant@citrix.com, Juergen Gross <jgross@suse.com>

Instead of trying to guess the Xen version to use by compiling various
test programs first just ask the system via pkg-config. Only if it
can't return the version fall back to the test program scheme.

If configure is being called with dedicated flags for the Xen libraries
use those instead of the pkg-config output. This will avoid breaking
an in-tree Xen build of an old Xen version while a new Xen version is
installed on the build machine: pkg-config would pick up the installed
Xen config files as the Xen tree wouldn't contain any of them.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: - use pkg-config only if no Xen library paths have been specified via
      --extra-ldflags
    - keep test program for detecting Xen 4.9
---
 configure | 155 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 86 insertions(+), 69 deletions(-)

diff --git a/configure b/configure
index aabf098..c34b025 100755
--- a/configure
+++ b/configure
@@ -1962,30 +1962,46 @@ fi
 # xen probe
 
 if test "$xen" != "no" ; then
-  xen_libs="-lxenstore -lxenctrl -lxenguest"
-  xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
+  # Check whether Xen library path is specified via --extra-ldflags to avoid
+  # overriding this setting with pkg-config output. If not, try pkg-config
+  # to obtain all needed flags.
 
-  # First we test whether Xen headers and libraries are available.
-  # If no, we are done and there is no Xen support.
-  # If yes, more tests are run to detect the Xen version.
+  if ! echo $EXTRA_LDFLAGS | grep tools/libxc > /dev/null && \
+     $pkg_config --exists xencontrol ; then
+    xen_ctrl_version="$(printf '%d%02d%02d' \
+      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
+    xen=yes
+    xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
+    xen_pc="$xen_pc xenevtchn xendevicemodel"
+    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
+    libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
+    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
+  else
 
-  # Xen (any)
-  cat > $TMPC <<EOF
+    xen_libs="-lxenstore -lxenctrl -lxenguest"
+    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
+
+    # First we test whether Xen headers and libraries are available.
+    # If no, we are done and there is no Xen support.
+    # If yes, more tests are run to detect the Xen version.
+
+    # Xen (any)
+    cat > $TMPC <<EOF
 #include <xenctrl.h>
 int main(void) {
   return 0;
 }
 EOF
-  if ! compile_prog "" "$xen_libs" ; then
-    # Xen not found
-    if test "$xen" = "yes" ; then
-      feature_not_found "xen" "Install xen devel"
-    fi
-    xen=no
+    if ! compile_prog "" "$xen_libs" ; then
+      # Xen not found
+      if test "$xen" = "yes" ; then
+        feature_not_found "xen" "Install xen devel"
+      fi
+      xen=no
 
-  # Xen unstable
-  elif
-      cat > $TMPC <<EOF &&
+    # Xen unstable
+    elif
+        cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
 #define __XEN_TOOLS__
 #include <xendevicemodel.h>
@@ -1998,13 +2014,13 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
-    then
-    xen_stable_libs="$xen_stable_libs -lxendevicemodel"
-    xen_ctrl_version=40900
-    xen=yes
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
+      then
+      xen_stable_libs="$xen_stable_libs -lxendevicemodel"
+      xen_ctrl_version=40900
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
@@ -2054,12 +2070,12 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs $xen_stable_libs"
-    then
-    xen_ctrl_version=40800
-    xen=yes
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs $xen_stable_libs"
+      then
+      xen_ctrl_version=40800
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
@@ -2105,12 +2121,12 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs $xen_stable_libs"
-    then
-    xen_ctrl_version=40701
-    xen=yes
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs $xen_stable_libs"
+      then
+      xen_ctrl_version=40701
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <stdint.h>
 int main(void) {
@@ -2120,14 +2136,14 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40700
-    xen=yes
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40700
+      xen=yes
 
-  # Xen 4.6
-  elif
-      cat > $TMPC <<EOF &&
+    # Xen 4.6
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <stdint.h>
@@ -2148,14 +2164,14 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40600
-    xen=yes
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40600
+      xen=yes
 
-  # Xen 4.5
-  elif
-      cat > $TMPC <<EOF &&
+    # Xen 4.5
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <stdint.h>
@@ -2175,13 +2191,13 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40500
-    xen=yes
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40500
+      xen=yes
 
-  elif
-      cat > $TMPC <<EOF &&
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <stdint.h>
@@ -2200,24 +2216,25 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40200
-    xen=yes
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40200
+      xen=yes
 
-  else
-    if test "$xen" = "yes" ; then
-      feature_not_found "xen (unsupported version)" \
-                        "Install a supported xen (xen 4.2 or newer)"
+    else
+      if test "$xen" = "yes" ; then
+        feature_not_found "xen (unsupported version)" \
+                          "Install a supported xen (xen 4.2 or newer)"
+      fi
+      xen=no
     fi
-    xen=no
-  fi
 
-  if test "$xen" = yes; then
-    if test $xen_ctrl_version -ge 40701  ; then
-      libs_softmmu="$xen_stable_libs $libs_softmmu"
+    if test "$xen" = yes; then
+      if test $xen_ctrl_version -ge 40701  ; then
+        libs_softmmu="$xen_stable_libs $libs_softmmu"
+      fi
+      libs_softmmu="$xen_libs $libs_softmmu"
     fi
-    libs_softmmu="$xen_libs $libs_softmmu"
   fi
 fi
 
-- 
2.10.2
