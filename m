Received: from eggs.gnu.org ([2001:4830:134:3::10]:34197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjOcN-0003ai-Nx
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjOcL-0005PX-DL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:09:55 -0500
Received: from smtp.citrix.com ([66.165.176.89]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjOcL-0005Oc-7v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 06:09:53 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 2 Mar 2017 11:09:45 +0000
Message-ID: <1488452986-24501-5-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/5] configure: detect presence of
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
