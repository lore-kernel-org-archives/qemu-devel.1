Received: from eggs.gnu.org ([2001:4830:134:3::10]:51053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88W-0006uN-F9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88V-0007kW-IQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX88V-0007it-CW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 16:40:25 +0100
Message-Id: <20170717154026.32697-2-stefanha@redhat.com>
In-Reply-To: <20170717154026.32697-1-stefanha@redhat.com>
References: <20170717154026.32697-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] util/aio-win32: Only select on what we are
 actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 9307b70e9876c4e9e3c4478524a32a23a3d5dd05.1499368180.git.alist=
air.francis@xilinx.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-win32.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index bca496a..d6d5e02 100644
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
2.9.4
