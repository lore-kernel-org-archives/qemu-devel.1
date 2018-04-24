Received: from eggs.gnu.org ([2001:4830:134:3::10]:36500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DE-0007Ac-9l
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DD-0006wq-FK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:44 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DD-0006on-5S
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:43 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Tue, 24 Apr 2018 18:58:16 +0100
Message-ID: <1524592709-6553-4-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 03/16] xen: link against xentoolcore
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

Xen libraries in 4.10 include a new xentoolcore library.  This
contains the xentoolcore_restrict_all function which we are about to
want to use.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
v8: In pkg-config branch, add xentoolcore conditionally.
    This cope with Xen 4.9 found via pkg-config.
v5: More truthful commit message.
---
 configure | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 0a19b03..5cf9dde 100755
--- a/configure
+++ b/configure
@@ -2189,6 +2189,9 @@ if test "$xen" != "no" ; then
     xen=yes
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
     xen_pc="$xen_pc xenevtchn xendevicemodel"
+    if $pkg_config --exists xentoolcore; then
+      xen_pc="$xen_pc xentoolcore"
+    fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
@@ -2220,18 +2223,20 @@ EOF
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
