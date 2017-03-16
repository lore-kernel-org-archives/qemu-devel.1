Received: from eggs.gnu.org ([2001:4830:134:3::10]:55458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1coWG7-0002Xj-2Q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1coWG3-0008Ud-Sq
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1coWG3-0008SY-Lp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:03 -0400
From: Juergen Gross <jgross@suse.com>
Date: Thu, 16 Mar 2017 15:19:53 +0100
Message-Id: <20170316141953.16161-3-jgross@suse.com>
In-Reply-To: <20170316141953.16161-1-jgross@suse.com>
References: <20170316141953.16161-1-jgross@suse.com>
Subject: [Qemu-devel] [PATCH 2/2] configure: use pkg-config for obtaining
 xen version
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

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 configure | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index aabf098..b43fbd5 100755
--- a/configure
+++ b/configure
@@ -1983,26 +1983,12 @@ EOF
     fi
     xen=no
 
-  # Xen unstable
-  elif
-      cat > $TMPC <<EOF &&
-#undef XC_WANT_COMPAT_DEVICEMODEL_API
-#define __XEN_TOOLS__
-#include <xendevicemodel.h>
-int main(void) {
-  xendevicemodel_handle *xd;
-
-  xd = xendevicemodel_open(0, 0);
-  xendevicemodel_close(xd);
-
-  return 0;
-}
-EOF
-      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
-    then
-    xen_stable_libs="$xen_stable_libs -lxendevicemodel"
-    xen_ctrl_version=40900
+  # Xen version via pkg-config (Xen 4.9.0 and newer)
+  elif $pkg_config --exists xencontrol ; then
+    xen_ctrl_version="$(printf '%d%02d%02d' \
+      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
+
   elif
       cat > $TMPC <<EOF &&
 /*
@@ -2214,7 +2200,12 @@ EOF
   fi
 
   if test "$xen" = yes; then
-    if test $xen_ctrl_version -ge 40701  ; then
+    if test $xen_ctrl_version -ge 40900 ; then
+      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
+      xen_pc="$xen_pc xendevicemodel"
+      xen_libs="$($pkg_config --libs $xen_pc)"
+      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
+    elif test $xen_ctrl_version -ge 40701 ; then
       libs_softmmu="$xen_stable_libs $libs_softmmu"
     fi
     libs_softmmu="$xen_libs $libs_softmmu"
-- 
2.10.2
