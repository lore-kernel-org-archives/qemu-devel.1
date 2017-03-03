Received: from eggs.gnu.org ([2001:4830:134:3::10]:60146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgj-0004J1-JS
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-00016o-Dz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:57 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:28148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-00016H-8J
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:54 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 3 Mar 2017 11:47:50 +0000
Message-ID: <1488541671-26740-5-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1488541671-26740-1-git-send-email-paul.durrant@citrix.com>
References: <1488541671-26740-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/5] configure: detect presence of
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

This patch adds code in configure to set CONFIG_XEN_CTRL_INTERFACE_VERSION
to a new value of 490 if libxendevicemodel is present in the build
environment.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 8e8f18d..fc1e12b 100755
--- a/configure
+++ b/configure
@@ -1980,6 +1980,25 @@ EOF
   # Xen unstable
   elif
       cat > $TMPC <<EOF &&
+#undef XC_WANT_COMPAT_DEVICEMODEL_API
+#define __XEN_TOOLS__
+#include <xendevicemodel.h>
+int main(void) {
+  xendevicemodel_handle *xd;
+
+  xd = xendevicemodel_open(0, 0);
+  xendevicemodel_close(xd);
+
+  return 0;
+}
+EOF
+      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
+    then
+    xen_stable_libs="$xen_stable_libs -lxendevicemodel"
+    xen_ctrl_version=490
+    xen=yes
+  elif
+      cat > $TMPC <<EOF &&
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
-- 
2.1.4
