Received: from eggs.gnu.org ([2001:4830:134:3::10]:52005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6W-0003gu-U8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6W-00008W-1R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:44 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 10:16:30 -0700
Message-ID: <ec037b86d3144d26ebdbb943515d2da02725d465.1498756113.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498756113.git.alistair.francis@xilinx.com>
References: <cover.1498756113.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/3] util/aio-win32: Only select on what we
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net, pbonzini@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
Changes since RFC:
 - Include more bitmasks for the select call

 util/aio-win32.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index bca496a47a..d6d5e02f00 100644
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
+            bitmask |= FD_READ | FD_ACCEPT | FD_CLOSE;
+        }
+
+        if (io_write) {
+            bitmask |= FD_WRITE | FD_CONNECT;
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
