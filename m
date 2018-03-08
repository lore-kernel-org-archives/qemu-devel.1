Received: from eggs.gnu.org ([2001:4830:134:3::10]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0007Q9-3P
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW0-0008Js-0y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
Received: from smtp.citrix.com ([66.165.176.89]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzVz-0008JW-OT
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:39 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:07 +0000
Message-ID: <1520530757-4477-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 01/11] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>

From: Anthony PERARD <anthony.perard@citrix.com>

Xen libraries in 4.10 include a new xentoolcore library.  This
contains the xentoolcore_restrict_all function which we are about to
want to use.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
v5: More truthful commit message.
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 6f3921c..0a8059f 100755
--- a/configure
+++ b/configure
@@ -2179,7 +2179,7 @@ if test "$xen" != "no" ; then
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
-    xen_pc="$xen_pc xenevtchn xendevicemodel"
+    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
@@ -2211,18 +2211,20 @@ EOF
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
 #include <xenforeignmemory.h>
+#include <xentoolcore.h>
 int main(void) {
   xenforeignmemory_handle *xfmem;
 
   xfmem = xenforeignmemory_open(0, 0);
   xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
+  xentoolcore_restrict_all(0);
 
   return 0;
 }
 EOF
-        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxentoolcore"
       then
-      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41000
       xen=yes
     elif
-- 
2.1.4
