Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Po-0004K6-GN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Pj-0003hY-Vc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:04 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 16:57:41 -0700
Message-ID: <dc10d43ceafb859bf568e0ccd3085d7348e114c9.1498607452.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498607452.git.alistair.francis@xilinx.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 1/4] util/aio-win32: Only select on what we
 are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---

 util/aio-win32.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index bca496a47a..949979c2f5 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -71,6 +71,7 @@ void aio_set_fd_handler(AioContext *ctx,
         }
     } else {
         HANDLE event;
+        long bitmask = 0;
 
         if (node == NULL) {
             /* Alloc and insert if it's not already there */
@@ -95,10 +96,16 @@ void aio_set_fd_handler(AioContext *ctx,
         node->io_write = io_write;
         node->is_external = is_external;
 
+        if (io_read) {
+            bitmask |= FD_READ;
+        }
+
+        if (io_write) {
+            bitmask |= FD_WRITE;
+        }
+
         event = event_notifier_get_handle(&ctx->notifier);
-        WSAEventSelect(node->pfd.fd, event,
-                       FD_READ | FD_ACCEPT | FD_CLOSE |
-                       FD_CONNECT | FD_WRITE | FD_OOB);
+        WSAEventSelect(node->pfd.fd, event, bitmask);
     }
 
     qemu_lockcnt_unlock(&ctx->list_lock);
-- 
2.11.0
