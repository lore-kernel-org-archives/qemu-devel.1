Received: from eggs.gnu.org ([2001:4830:134:3::10]:52042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35J6-0007pA-TN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35J5-0005jb-Vt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:24 -0400
Received: from mail.kernel.org ([198.145.29.136]:49668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d35J5-0005jV-QF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:23 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 25 Apr 2017 11:34:56 -0700
Message-Id: <1493145313-31311-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1493145313-31311-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
	<1493145313-31311-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH 04/21] configure: detect presence of
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

This patch adds code in configure to set CONFIG_XEN_CTRL_INTERFACE_VERSION
to a new value of 490 if libxendevicemodel is present in the build
environment.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 configure | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3291603..e333547 100755
--- a/configure
+++ b/configure
@@ -1976,7 +1976,7 @@ fi
 
 if test "$xen" != "no" ; then
   xen_libs="-lxenstore -lxenctrl -lxenguest"
-  xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
+  xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
 
   # First we test whether Xen headers and libraries are available.
   # If no, we are done and there is no Xen support.
@@ -1999,6 +1999,25 @@ EOF
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
+      compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+    then
+    xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+    xen_ctrl_version=490
+    xen=yes
+  elif
+      cat > $TMPC <<EOF &&
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
-- 
1.9.1
