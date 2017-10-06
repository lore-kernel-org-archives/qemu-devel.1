Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLi-0002UQ-97
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLf-0002vb-4s
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:50 -0400
Received: from smtp.citrix.com ([66.165.176.89]:29347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0XLe-0002uw-Vb
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 14:27:47 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 6 Oct 2017 19:27:17 +0100
Message-ID: <1507314444-30835-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <Ian.Jackson@eu.citrix.com>

From: Anthony PERARD <anthony.perard@citrix.com>

Xen libraries 4.10 will include a new xentoolcore library, without
which xendevicemodel et al will not work.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index fd7e3a5..6f691df 100755
--- a/configure
+++ b/configure
@@ -2072,7 +2072,7 @@ if test "$xen" != "no" ; then
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
-    xen_pc="$xen_pc xenevtchn xendevicemodel"
+    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
@@ -2104,18 +2104,20 @@ EOF
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
