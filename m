Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSr6-0007Fd-Pz
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSr2-0001Zr-Fc
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:18:28 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:13687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSr2-0001Ym-95
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:18:24 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 24 Mar 2017 17:18:17 +0000
Message-ID: <1490375897-1181-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen: limit pkg-config to PKG_CONFIG_PATH for
 xen libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.com
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>

The Xen tools Makefile has been modified to set PKG_CONFIG_PATH such that
use of pkg-config in QEMU configure finds the newly built Xen libraries.
However, because older versions of Xen do not set PKG_CONFIG_PATH in the
Makefile, the QEMU configure script will pick up any Xen libraries that may
be installed in the build system rather than the newly built ones. Thus,
if Xen 4.9 is built and installed it becomes impossible to build tools for
an older version of Xen on the same system (without manual de-installtion).

This patch modifies configure to set PKG_CONFIG_LIBDIR to empty when
looking for Xen libraries to ensure the search is limited only to
PKG_CONFIG_PATH. This makes sure that, for versions of Xen prior to 4.9,
pkg-config fails to find the Xen libraries an approriately falls back to
previous methods of probing.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
---
 configure | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index fdf47e4..6ef5980 100755
--- a/configure
+++ b/configure
@@ -1974,6 +1974,10 @@ fi
 ##########################################
 # xen probe
 
+xen_query_pkg_config() {
+    PKG_CONFIG_LIBDIR= ${pkg_config_exe} "$@"
+}
+
 if test "$xen" != "no" ; then
   xen_libs="-lxenstore -lxenctrl -lxenguest"
   xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
@@ -1997,9 +2001,9 @@ EOF
     xen=no
 
   # Xen version via pkg-config (Xen 4.9.0 and newer)
-  elif $pkg_config --exists xencontrol ; then
+  elif xen_query_pkg_config --exists xencontrol; then
     xen_ctrl_version="$(printf '%d%02d%02d' \
-      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
+      $(xen_query_pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
 
   elif
@@ -2216,8 +2220,8 @@ EOF
     if test $xen_ctrl_version -ge 40900 ; then
       xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
       xen_pc="$xen_pc xendevicemodel"
-      xen_libs="$($pkg_config --libs $xen_pc)"
-      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
+      xen_libs="$(xen_query_pkg_config --libs $xen_pc)"
+      QEMU_CFLAGS="$QEMU_CFLAGS $(xen_query_pkg_config --cflags $xen_pc)"
     elif test $xen_ctrl_version -ge 40701 ; then
       libs_softmmu="$xen_stable_libs $libs_softmmu"
     fi
-- 
2.1.4
