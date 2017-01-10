Received: from eggs.gnu.org ([2001:4830:134:3::10]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rami.rosen@intel.com>) id 1cQsai-0006nW-4E
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rami.rosen@intel.com>) id 1cQsae-0004EG-4Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:19:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:56724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rami.rosen@intel.com>)
	id 1cQsad-0004Bj-9A
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:19:36 -0500
From: Rami Rosen <rami.rosen@intel.com>
Date: Tue, 10 Jan 2017 11:19:25 +0200
Message-Id: <1484039965-25907-1-git-send-email-rami.rosen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] ui: fix format specfier in vnc to avoid
 break in build.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Rami Rosen <rami.rosen@intel.com>

When building qemu after setting _VNC_DEBUG to 1 (see ui/vnc.h),
we get the following error and the build breaks:
...
ui/vnc.c: In function ‘vnc_client_io_error’:
ui/vnc.c:1262:13: error: format ‘%d’ expects argument of type ‘int’, but
             VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
             ^
cc1: all warnings being treated as errors
make: *** [ui/vnc.o] Error 1
...

This patch solves this issue by fixing the print format specifier
in vnc_client_io_error() to be %zd, which corresponds to the type
of the "ret" variable.

Signed-off-by: Rami Rosen <rami.rosen@intel.com>
---
changes v2:
- use %zd instead of %ld for the format sepcifier.

 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2c28a59..6b0672b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1259,7 +1259,7 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
         if (ret == 0) {
             VNC_DEBUG("Closing down client sock: EOF\n");
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
-            VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
+            VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
                       ret, errp ? error_get_pretty(*errp) : "Unknown");
         }
 
-- 
1.9.1
