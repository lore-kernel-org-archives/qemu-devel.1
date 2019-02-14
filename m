Received: from eggs.gnu.org ([209.51.188.92]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYn-0002J6-H2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYk-0002lC-03
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:05 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:17 +0100
Message-Id: <20190214104717.3543-15-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/14] configure: improve usbfs check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190213211827.20300-1-thomas.petazzoni@bootlin.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index c0f278141823..90b9e2fa3c05 100755
--- a/configure
+++ b/configure
@@ -4262,10 +4262,25 @@ fi
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
