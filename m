Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumS-000206-LX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumO-0006Y9-Jq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:04 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:58916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumO-0006Wt-A3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:00 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 23 Feb 2017 14:53:54 +0000
Message-ID: <1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] configure: detect presence of
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
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

This patch adds code in configure to set CONFIG_XEN_CTRL_INTERFACE_VERSION
to a new value of 490 if libxendevicemodel is present in the build
environment.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
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
