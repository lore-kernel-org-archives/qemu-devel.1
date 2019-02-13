Received: from eggs.gnu.org ([209.51.188.92]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.petazzoni@bootlin.com>) id 1gu1vQ-000782-D6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.petazzoni@bootlin.com>) id 1gu1vP-0002tI-MV
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:18:36 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:40297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thomas.petazzoni@bootlin.com>)
	id 1gu1vP-0002qb-33
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:18:35 -0500
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 13 Feb 2019 22:18:27 +0100
Message-Id: <20190213211827.20300-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: improve usbfs check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

The current check to test if usbfs support should be compiled or not
solely relies on the presence of <linux/usbdevice_fs.h>, without
actually checking that all definition used by Qemu are provided by
this header file.

With sufficiently old kernel headers, <linux/usbdevice_fs.h> may be
present, but some of the definitions needed by Qemu may not be
available.

This commit improves the check by building a small program that
actually tests whether the necessary definitions are available.

In addition, it fixes a bug where have_usbfs was set to "yes"
regardless of the result of the test.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 configure | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3d89870d99..799c8e3b08 100755
--- a/configure
+++ b/configure
@@ -4266,10 +4266,25 @@ fi
 # check for usbfs
 have_usbfs=no
 if test "$linux_user" = "yes"; then
-  if check_include linux/usbdevice_fs.h; then
+  cat > $TMPC << EOF
+#include <linux/usbdevice_fs.h>
+
+#ifndef USBDEVFS_GET_CAPABILITIES
+#error "USBDEVFS_GET_CAPABILITIES undefined"
+#endif
+
+#ifndef USBDEVFS_DISCONNECT_CLAIM
+#error "USBDEVFS_DISCONNECT_CLAIM undefined"
+#endif
+
+int main(void)
+{
+    return 0;
+}
+EOF
+  if compile_prog "" ""; then
     have_usbfs=yes
   fi
-  have_usbfs=yes
 fi
 
 # check for fallocate
-- 
2.20.1
