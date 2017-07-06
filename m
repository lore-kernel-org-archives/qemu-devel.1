Received: from eggs.gnu.org ([2001:4830:134:3::10]:41044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTDEX-0006vc-SF
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTDEW-00050K-Q0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:18:41 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 6 Jul 2017 13:15:14 -0700
Message-ID: <9307b70e9876c4e9e3c4478524a32a23a3d5dd05.1499368180.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/1] util/aio-win32: Only select on what we
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
Changes in V2:
 - Rebase on master
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
+        long bitmask =3D 0;
=20
         if (node =3D=3D NULL) {
             /* Alloc and insert if it's not already there */
@@ -95,10 +96,16 @@ void aio_set_fd_handler(AioContext *ctx,
         node->io_write =3D io_write;
         node->is_external =3D is_external;
=20
+        if (io_read) {
+            bitmask |=3D FD_READ | FD_ACCEPT | FD_CLOSE;
+        }
+
+        if (io_write) {
+            bitmask |=3D FD_WRITE | FD_CONNECT;
+        }
+
         event =3D event_notifier_get_handle(&ctx->notifier);
-        WSAEventSelect(node->pfd.fd, event,
-                       FD_READ | FD_ACCEPT | FD_CLOSE |
-                       FD_CONNECT | FD_WRITE | FD_OOB);
+        WSAEventSelect(node->pfd.fd, event, bitmask);
     }
=20
     qemu_lockcnt_unlock(&ctx->list_lock);
--=20
2.11.0
