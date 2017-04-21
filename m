Received: from eggs.gnu.org ([2001:4830:134:3::10]:35598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exf-0003wp-Ef
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exd-0002ge-Om
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:23 -0400
Received: from mail.kernel.org ([198.145.29.136]:42818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exd-0002gV-Fp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:21 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:50 -0700
Message-Id: <1492805702-19690-9-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 09/21] configure: use pkg-config for obtaining
 xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>

From: Juergen Gross <jgross@suse.com>

Instead of trying to guess the Xen version to use by compiling various
test programs first just ask the system via pkg-config. Only if it
can't return the version fall back to the test program scheme.

If configure is being called with dedicated flags for the Xen libraries
use those instead of the pkg-config output. This will avoid breaking
an in-tree Xen build of an old Xen version while a new Xen version is
installed on the build machine: pkg-config would pick up the installed
Xen config files as the Xen tree wouldn't contain any of them.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Tested-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 configure | 159 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 88 insertions(+), 71 deletions(-)

diff --git a/configure b/configure
index 271bea8..3133ef8 100755
--- a/configure
+++ b/configure
@@ -1975,30 +1975,46 @@ fi
 # xen probe
 
 if test "$xen" != "no" ; then
-  xen_libs="-lxenstore -lxenctrl -lxenguest"
-  xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
+  # Check whether Xen library path is specified via --extra-ldflags to avoid
+  # overriding this setting with pkg-config output. If not, try pkg-config
+  # to obtain all needed flags.
+
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
 
-  # First we test whether Xen headers and libraries are available.
-  # If no, we are done and there is no Xen support.
-  # If yes, more tests are run to detect the Xen version.
+    xen_libs="-lxenstore -lxenctrl -lxenguest"
+    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
 
-  # Xen (any)
-  cat > $TMPC <<EOF
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
@@ -2011,13 +2027,13 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
-    then
-    xen_stable_libs="-lxendevicemodel $xen_stable_libs"
-    xen_ctrl_version=40900
-    xen=yes
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+      then
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+      xen_ctrl_version=40900
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
@@ -2067,12 +2083,12 @@ int main(void) {
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
@@ -2118,12 +2134,12 @@ int main(void) {
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
@@ -2133,14 +2149,14 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40700
-    xen=yes
-
-  # Xen 4.6
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40700
+      xen=yes
+
+    # Xen 4.6
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <stdint.h>
@@ -2161,14 +2177,14 @@ int main(void) {
   return 0;
 }
 EOF
-      compile_prog "" "$xen_libs"
-    then
-    xen_ctrl_version=40600
-    xen=yes
-
-  # Xen 4.5
-  elif
-      cat > $TMPC <<EOF &&
+        compile_prog "" "$xen_libs"
+      then
+      xen_ctrl_version=40600
+      xen=yes
+
+    # Xen 4.5
+    elif
+        cat > $TMPC <<EOF &&
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <stdint.h>
@@ -2188,13 +2204,13 @@ int main(void) {
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
@@ -2213,24 +2229,25 @@ int main(void) {
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
1.9.1
