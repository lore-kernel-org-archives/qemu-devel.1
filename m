Received: from eggs.gnu.org ([2001:4830:134:3::10]:42865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rami.rosen@intel.com>) id 1cQIDH-00020V-LZ
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 13:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rami.rosen@intel.com>) id 1cQIDE-000474-HA
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 13:29:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:23833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rami.rosen@intel.com>)
	id 1cQIDE-00046R-7l
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 13:29:00 -0500
From: Rami Rosen <rami.rosen@intel.com>
Date: Sun,  8 Jan 2017 20:28:43 +0200
Message-Id: <1483900123-7103-1-git-send-email-rami.rosen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] ui: fix format specifier in
 vnc_client_io_error() to avoid break in build.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Rami Rosen <rami.rosen@intel.com>

When building qemu after setting _VNC_DEBUG to 1 (see ui/vnc.h),
we get the following error and the build breaks:
...
ui/vnc.c: In function ‘vnc_client_io_error’:
ui/vnc.c:1262:13: error: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘ssize_t’ [-Werror=format=]
             VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
             ^
cc1: all warnings being treated as errors
make: *** [ui/vnc.o] Error 1
...

This patch solves this issue by fixing the print format specifier
in vnc_client_io_error() to be %ld, which corresponds to the type
of the "ret" variable.

Signed-off-by: Rami Rosen <rami.rosen@intel.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2c28a59..4b0a89c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1259,7 +1259,7 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
         if (ret == 0) {
             VNC_DEBUG("Closing down client sock: EOF\n");
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
-            VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
+            VNC_DEBUG("Closing down client sock: ret %ld (%s)\n",
                       ret, errp ? error_get_pretty(*errp) : "Unknown");
         }
 
-- 
1.9.1
