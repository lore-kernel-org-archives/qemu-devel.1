Received: from eggs.gnu.org ([2001:4830:134:3::10]:34648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1dxg7X-0003o7-FQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 17:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1dxg7U-0000lb-AP
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 17:13:23 -0400
Received: from legacy.ddn.com ([64.47.133.206]:9356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1dxg7T-0000jJ-RT
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 17:13:20 -0400
From: Greg Edwards <gedwards@ddn.com>
Date: Thu, 28 Sep 2017 14:52:11 -0600
Message-ID: <20170928205211.15641-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] char: report errors from qio_channel_{read,
 write}v_full
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Greg Edwards <gedwards@ddn.com>
List-ID: <qemu-devel.nongnu.org>

Two callers of qio_channel_{read,write}v_full were not passing in an
Error pointer, missing any error messages from the channel class
io_{read,write}v methods.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 chardev/char-io.c     | 7 ++++++-
 chardev/char-socket.c | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index f81052481a55..7d8287cbfe31 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "chardev/char-io.h"
 
 typedef struct IOWatchPoll {
@@ -152,6 +153,7 @@ int io_channel_send_full(QIOChannel *ioc,
                          int *fds, size_t nfds)
 {
     size_t offset = 0;
+    Error *local_err = NULL;
 
     while (offset < len) {
         ssize_t ret = 0;
@@ -160,7 +162,10 @@ int io_channel_send_full(QIOChannel *ioc,
 
         ret = qio_channel_writev_full(
             ioc, &iov, 1,
-            fds, nfds, NULL);
+            fds, nfds, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             if (offset) {
                 return offset;
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e65148fe973c..4e27370440ff 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -272,15 +272,19 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
     size_t i;
     int *msgfds = NULL;
     size_t msgfds_num = 0;
+    Error *local_err = NULL;
 
     if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
         ret = qio_channel_readv_full(s->ioc, &iov, 1,
                                      &msgfds, &msgfds_num,
-                                     NULL);
+                                     &local_err);
     } else {
         ret = qio_channel_readv_full(s->ioc, &iov, 1,
                                      NULL, NULL,
-                                     NULL);
+                                     &local_err);
+    }
+    if (local_err) {
+        error_report_err(local_err);
     }
 
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
-- 
2.13.5
